def solution(s):
    new_str = ''

    if not s.isupper() and not s.islower() and not "":
        for i in range(0, len(s)):
            if (s[i-1].isupper() and s[i].isupper()) or (s[i-1].islower() and s[i].isupper()):
                new_str += " " + s[i]
            else:
                new_str += s[i]
        return new_str
    else:
        if s == "":
            return ""
        else:
            return s


print(solution("camelCasing"))
print(solution("identifier"))
print(solution(""))
print(solution("breakCamelCase"))
print(solution("consecutiveCApitals"))