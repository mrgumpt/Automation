def narcissistic( value ):
    total = 0
    digits = str(value)

    for digit in digits:
        total+=int(digit)**len(digits)
        i=+1
        print(total)
    if total == value:
        return True
    else:
        return False

print(narcissistic(1652))