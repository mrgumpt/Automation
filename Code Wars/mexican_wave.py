def wave(people):
    list = []
    word = ''
    for i in range(0, len(people)):
        if people[i] == ' ':
            i+=1
            pass
        elif i == 0:
            word = people[i].upper() + people[i+1:]
            list.append(word)
        elif i != 0:
            word = people[:i] + people[i].upper() + people[i + 1:]
            list.append(word)

    return list

print(wave("wave"))