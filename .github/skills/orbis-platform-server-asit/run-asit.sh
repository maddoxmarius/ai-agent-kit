#!/usr/bin/env bash
# Runs orbis-platform-server Arquillian server integration tests (ASIT) like the
# Jenkins orbis-platform-server_INTEGRATION job (mvn -PASIT-remote), inside WSL.
set -uo pipefail

REGISTRY="registry-nexus.orbis.dedalus.com"
SRC=""
MODULE=""
TESTS=""
WITH_UNIT_TESTS=0
WORK=""
EXTRA=()

usage() {
  cat <<'EOF'
Usage: run-asit.sh --src <checkout> [--module <artifactId>] [--test <pattern>]
                   [--with-unit-tests] [--work <dir>] [-- <extra mvn args>]

  --src              Branch checkout (Windows path like C:\Workspace\... or WSL path).
  --module           Run only this module (artifactId, e.g. orbis-server-commons).
                     Omit to run the ASITs of all modules.
  --test             failsafe -Dit.test pattern, e.g. CatalogSearchServiceASIT,
                     CatalogSearchServiceASIT#testSearchStructure, '*Catalog*ASIT'.
                     Omit to run all ASITs.
  --with-unit-tests  Also run surefire unit tests (skipped by default).
  --work             WSL working copy (default: ~/Workspace/tmp/asit/<branch>).
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --src) SRC="$2"; shift 2 ;;
    --module) MODULE="$2"; shift 2 ;;
    --test) TESTS="$2"; shift 2 ;;
    --with-unit-tests) WITH_UNIT_TESTS=1; shift ;;
    --work) WORK="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    --) shift; EXTRA=("$@"); break ;;
    *) echo "Unknown argument: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$SRC" ]] || { usage; exit 2; }
if [[ "$SRC" =~ ^[A-Za-z]:[\\/] ]]; then
  SRC="$(wslpath -u "$SRC")"
fi
SRC="${SRC%/}"
[[ -f "$SRC/pom.xml" ]] || { echo "No pom.xml in $SRC" >&2; exit 2; }

if [[ -z "$WORK" ]]; then
  WORK="$HOME/Workspace/tmp/asit/$(basename "$(dirname "$SRC")")-$(basename "$SRC")"
fi

# JDK 21 (same as CI)
if [[ -z "${ASIT_JAVA_HOME:-}" ]]; then
  ASIT_JAVA_HOME="$(ls -d "$HOME"/.sdkman/candidates/java/21* 2>/dev/null | sort -V | tail -n 1)"
fi
if [[ -n "$ASIT_JAVA_HOME" ]]; then
  export JAVA_HOME="$ASIT_JAVA_HOME" PATH="$ASIT_JAVA_HOME/bin:$PATH"
fi
JAVA_MAJOR="$(java -version 2>&1 | sed -nE '1s/.*"([0-9]+).*/\1/p')"
[[ "$JAVA_MAJOR" == "21" ]] || { echo "JDK 21 required (found: $JAVA_MAJOR). Set ASIT_JAVA_HOME." >&2; exit 2; }
command -v mvn >/dev/null || { echo "mvn not found" >&2; exit 2; }
docker info >/dev/null 2>&1 || { echo "Docker daemon not reachable" >&2; exit 2; }

echo "== Syncing $SRC -> $WORK"
mkdir -p "$WORK"
rsync -a --delete --exclude target --exclude .idea --exclude .svn --exclude .git "$SRC"/ "$WORK"/ || exit 1

IMAGE_TAG="$(sed -nE 's#.*<version\.asit\.docker\.oasimage>([^<]+)</version\.asit\.docker\.oasimage>.*#\1#p' "$WORK/pom.xml" | head -n 1)"
[[ -n "$IMAGE_TAG" ]] || { echo "version.asit.docker.oasimage not found in pom.xml" >&2; exit 2; }
IMAGE="$REGISTRY/oas-hba-arquillian-test/as-wfly:$IMAGE_TAG"
if ! docker image inspect "$IMAGE" >/dev/null 2>&1; then
  echo "== Pulling $IMAGE"
  docker pull -q "$IMAGE" || exit 1
fi

MVN=(mvn clean verify -B -PASIT-remote "-Ddocker.oasimage=$IMAGE")
[[ -n "$MODULE" ]] && MVN+=(-pl ":$MODULE" -am)
[[ "$WITH_UNIT_TESTS" == 1 ]] || MVN+=(-Dtest=NoUnitTests -Dsurefire.failIfNoSpecifiedTests=false)
[[ -n "$TESTS" ]] && MVN+=("-Dit.test=$TESTS" -Dfailsafe.failIfNoSpecifiedTests=false)
MVN+=("${EXTRA[@]}")

LOG="$WORK/asit-$(date +%Y%m%d-%H%M%S).log"
echo "== JDK $(java -version 2>&1 | head -n 1)"
echo "== ${MVN[*]}"
echo "== Log: $LOG"
cd "$WORK" || exit 1
"${MVN[@]}" > "$LOG" 2>&1
RC=$?

echo "== Summary (mvn exit $RC)"
grep -E '^\[(INFO|WARNING|ERROR)\] Tests run:.* -- in ' "$LOG" | sed -E 's/^\[[A-Z]+\] //'
grep -E '^\[ERROR\] +[A-Za-z0-9_.$]+\.[A-Za-z0-9_]+:[0-9]+|<<< (FAILURE|ERROR)!' "$LOG" | head -n 40
sed -n '/Reactor Summary/,/Total time/p' "$LOG"
grep -E '^\[INFO\] BUILD (SUCCESS|FAILURE)' "$LOG" | tail -n 1
echo "== Reports: $(find "$WORK" -type d -path '*/target/failsafe-reports' | tr '\n' ' ')"
exit $RC
