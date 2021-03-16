print("generating array")

digits = ["0", "1", "2", "3", "4", "5", "6",
          "7", "8", "9", "a", "b", "c", "d", "e", "f"]

numbers = list(range(1, 287))
unicodes = []
# 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, a, b, c, d, e, f
#["\ufc00", "\ufd1d"]

d0 = 12
d1 = 0
d2 = 0
for i in range(0, len(numbers)):
    unicodes.append("\\uf" + digits[d0] + digits[d1] + digits[d2])
    d2 += 1
    if d2 == 16:
        d1 += 1
        d2 = 0
    if d1 == 16:
        d0 += 1
        d1 = 0

numString = "["
codString = "["

for i in range(0, len(unicodes)):
    codString += "\"" + str(unicodes[i]) + "\", "

codString += "]"

print(codString)
