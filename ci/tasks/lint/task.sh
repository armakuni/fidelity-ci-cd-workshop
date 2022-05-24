#!/bin/sh

# Install dependencies
poetry install

# Check code formatting
poetry run black --check .

# Check import formatting 
poetry run isort --profile black --check .