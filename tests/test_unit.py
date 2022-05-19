import pytest
from app.handler import handler

@pytest.fixture
def lambda_payload():
    return {
        "queryStringParameters": {
            "height": 150,
            "weight": 100
        }
    }

def test_bmi(lambda_payload):
    actual = handler(lambda_payload, None)
    expected = "Your BMI is 44.4"

    assert expected == actual