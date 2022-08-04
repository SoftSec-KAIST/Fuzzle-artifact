import sys

txt = sys.argv[1]
size = int(sys.argv[2])

with open(txt) as f:
    lines = f.readlines()
    lines = list(map(lambda x: x.strip(), lines))

branches = 0
for x in range(size):
    for y in range(size):
        xx = 2*x-1
        yy = 2*y-1
        if xx-1 >= 1 and lines[xx-1][yy] == '0':
            branches += 1
        if xx+1 <= 2*size-1 and lines[xx+1][yy] == '0':
            branches += 1
        if yy-1 >= 1 and lines[xx][yy-1] == '0':
            branches += 1
        if yy+1 <= 2*size-1 and lines[xx][yy+1] == '0':
            branches += 1
print(branches)
