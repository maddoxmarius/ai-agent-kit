# Python Instructions

These instructions apply when working with Python files (`**/*.py`).

## Code Style

### PEP 8 Compliance

- Follow PEP 8 style guide
- Use 4 spaces for indentation (no tabs)
- Maximum line length: 88 characters (Black formatter default)
- Use snake_case for variables and functions
- Use PascalCase for classes
- Use UPPER_CASE for constants

```python
# ✅ GOOD
def calculate_total(price: float, tax_rate: float) -> float:
    """Calculate total price including tax."""
    return price * (1 + tax_rate)

class UserService:
    MAX_RETRIES = 3
    
    def get_user(self, user_id: str) -> User:
        """Retrieve user by ID."""
        pass

# ❌ BAD
def CalculateTotal(price, taxRate):
    return price*(1+taxRate)
```

### Type Hints

- Use type hints for function signatures
- Use `typing` module for complex types
- Use `Optional` for nullable values
- Use `Union` for multiple possible types

```python
from typing import Optional, List, Dict

# ✅ GOOD
def get_user(user_id: str) -> Optional[User]:
    """Get user by ID, returns None if not found."""
    pass

def process_users(users: List[User]) -> Dict[str, User]:
    """Process list of users, return dictionary keyed by ID."""
    pass

# ❌ BAD
def get_user(user_id):
    pass
```

## Error Handling

### Exception Handling

- Use specific exception types
- Create custom exceptions for domain errors
- Provide meaningful error messages
- Use context managers for resource management

```python
# ✅ GOOD
class UserNotFoundError(Exception):
    """Raised when user is not found."""
    pass

def get_user(user_id: str) -> User:
    user = db.find_user(user_id)
    if not user:
        raise UserNotFoundError(f"User {user_id} not found")
    return user

# ✅ GOOD - Context manager
with open('file.txt', 'r') as f:
    content = f.read()

# ❌ BAD
def get_user(user_id):
    user = db.find_user(user_id)
    return user  # Returns None if not found, no error handling
```

### Error Messages

- Use f-strings for string formatting
- Include context in error messages
- Log errors with appropriate level

```python
# ✅ GOOD
logger.error(f"Failed to process user {user_id}: {error}", exc_info=True)

# ❌ BAD
logger.error("Error")
```

## Modern Python Features

### Use Python 3.8+ Features

- Use f-strings for string formatting
- Use dataclasses for simple data containers
- Use type hints throughout
- Use `pathlib` for file paths
- Use `enum` for constants

```python
from dataclasses import dataclass
from enum import Enum
from pathlib import Path

# ✅ GOOD
class Status(Enum):
    PENDING = "pending"
    APPROVED = "approved"
    REJECTED = "rejected"

@dataclass
class User:
    id: str
    email: str
    name: str
    status: Status

file_path = Path("data/users.json")
```

## Code Organization

### Imports

- Group imports: standard library, third-party, local
- Use absolute imports
- Avoid wildcard imports (`from module import *`)

```python
# ✅ GOOD
import os
from pathlib import Path
from typing import List, Optional

import requests
from flask import Flask

from app.models import User
from app.services import UserService

# ❌ BAD
from app import *
```

### Function and Class Design

- Keep functions small and focused
- Use docstrings for public functions and classes
- Follow single responsibility principle
- Use descriptive names

```python
# ✅ GOOD
def validate_email(email: str) -> bool:
    """Validate email format.
    
    Args:
        email: Email address to validate
        
    Returns:
        True if email is valid, False otherwise
    """
    import re
    pattern = r'^[^\s@]+@[^\s@]+\.[^\s@]+$'
    return bool(re.match(pattern, email))

# ❌ BAD
def check(e):
    return '@' in e
```

## Testing

### Use pytest

- Write tests using pytest
- Use descriptive test function names
- Use fixtures for test setup
- Use parametrize for multiple test cases

```python
# ✅ GOOD
import pytest

@pytest.fixture
def sample_user():
    return User(id="123", email="test@example.com", name="Test User")

def test_get_user_returns_user(sample_user):
    service = UserService()
    result = service.get_user("123")
    assert result == sample_user

@pytest.mark.parametrize("email,expected", [
    ("test@example.com", True),
    ("invalid", False),
    ("", False),
])
def test_validate_email(email, expected):
    assert validate_email(email) == expected
```

## Best Practices

- Use virtual environments for dependencies
- Keep dependencies in `requirements.txt` or `pyproject.toml`
- Use `black` for code formatting
- Use `mypy` for type checking
- Use `pylint` or `ruff` for linting
- Document public APIs with docstrings
- Use `__init__.py` files appropriately
- Prefer list comprehensions over loops when readable
- Use context managers for resource management
