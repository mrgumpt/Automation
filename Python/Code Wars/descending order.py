def descending_order(num):
    num = str(num)
    list = []
    final_string = ''
    for n in num:
        list.append(int(n))
        list.sort(reverse=True)
    for i in list:
        final_string = final_string + str(i)
    return int(final_string)

print(descending_order(123456789))
