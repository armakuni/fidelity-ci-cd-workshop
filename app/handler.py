
INPUT_EXAMPLE = "Example: ?height=X&weight=Y"

def handler(event, context):
    if 'queryStringParameters' not in event:
        return f"Please append your height and weight to the URL\n{INPUT_EXAMPLE}"
    query_dict = event["queryStringParameters"]
    if 'height' not in query_dict:
        return f"Please append the height parameter to the URL\n{INPUT_EXAMPLE}"
    if 'weight' not in query_dict:
        return f"Please append the weight parameter to the URL\n{INPUT_EXAMPLE}"
    
    # Weight in KG
    weight = int(query_dict["weight"])
    # Height in CM
    height = int(query_dict["height"])
    # BMI = kg/m^2
    ## height (given in cm) should be divided by 100 to convert to meters, then squared
    bmi = weight / ((height) ** 2)
    return f"Your BMI is {bmi:.1f}"
