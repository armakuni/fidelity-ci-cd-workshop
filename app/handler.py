
INPUT_EXAMPLE = "Example: ?height=X&weight=Y"

def handler(event, context):
    if 'queryStringParameters' not in event:
        return f"Please append your height and weight to the URL\n{INPUT_EXAMPLE}"
    query_dict = event["queryStringParameters"]
    if 'height' not in query_dict:
        return f"Please append the height parameter to the URL\n{INPUT_EXAMPLE}"
    if 'weight' not in query_dict:
        return f"Please append the weight parameter to the URL\n{INPUT_EXAMPLE}"
    
    weight = int(query_dict["weight"])
    height = int(query_dict["height"])
    bmi = weight / ((height) ** 2)
    return f"Your BMI is {bmi:.1f}"
