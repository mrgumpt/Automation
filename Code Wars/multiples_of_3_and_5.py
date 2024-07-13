def solution(number):
    counter = 0
    for i in range(1,number):
        if number < 0:
            return 0
        elif i%3==0 or i%5==0:
            counter+=i
            print("the number:", i)
    print("the sum is:", counter)


solution(4)