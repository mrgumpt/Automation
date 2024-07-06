def filter_list(l):
    'return a new list with the strings filtered out'

    new_list = []
    for i in range(len(l)):
        string = ''
        if type(l[i]) != type(string):
            new_list.append(l[i])
    return new_list



list = [1,2,'a','b']
print(filter_list(list))