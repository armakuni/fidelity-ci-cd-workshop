def handler(event, context):
    weight = int(event["queryStringParameters"]["weight"]) or 100
    height = int(event["queryStringParameters"]["height"]) or 150
    bmi = weight / ((height) ** 2)
    return f"Your BMI is {bmi:.1f}"
