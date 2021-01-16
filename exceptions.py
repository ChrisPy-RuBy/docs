

def layer_one():
    return 1 / 0

def layer_two():

    try:
        layer_one()
    except ZeroDivisionError as e:
        raise ValueError

def layer_three():

    try:
        layer_two()
    except ValueError as e:
        print("all the way up")

