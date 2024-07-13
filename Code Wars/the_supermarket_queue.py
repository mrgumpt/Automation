def queue_time(customers, n):
    tills = [0]*n
    for i in customers:
        tills[0]+=i
        tills.sort()
    return max(tills)



customers = [3, 2, 1]

print(queue_time(customers, 2))


