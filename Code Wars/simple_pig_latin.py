def pig_it(text):
    words = text.split()
    sentence = ''
    list = []
    for word in words:
        first_letter = word[0]
        if first_letter.isalpha():
            ay = 'ay'
            new_word = word[1:] + first_letter + ay
            list.append(new_word)
        else:
            list.append(word)
    for i in list:
        sentence = sentence + i + " "
    sentence = sentence.strip()

    return sentence



print(pig_it('Quis custodiet ipsos custodes ?'))