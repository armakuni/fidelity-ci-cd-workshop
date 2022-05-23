import pytest
from app.handler import handler

@pytest.fixture
def lambda_weight_only_payload():
    return {
        "queryStringParameters": {
            "weight": 100
        }
    }

@pytest.fixture
def lambda_height_only_payload():
    return {
        "queryStringParameters": {
            "height": 150
        }
    }

@pytest.fixture
def lambda_full_payload():
    return {
        "queryStringParameters": {
            "height": 150,
            "weight": 100
        }
    }

def test_default_page():
    actual = handler({}, None)
    expected = "Please append your height and weight to the URL\nExample: ?height=X&weight=Y"

    assert expected == actual

def test_missing_height(lambda_weight_only_payload):
    actual = handler(lambda_weight_only_payload, None)
    expected = "Please append the height parameter to the URL\nExample: ?height=X&weight=Y"

    assert expected == actual

def test_missing_weight(lambda_height_only_payload):
    actual = handler(lambda_height_only_payload, None)
    expected = "Please append the weight parameter to the URL\nExample: ?height=X&weight=Y"

    assert expected == actual

def test_bmi(lambda_full_payload):
    actual = handler(lambda_full_payload, None)
    expected = "Your BMI is 44.4"

    assert expected == actual