from mazelib import Maze
from mazelib.generate.BacktrackingGenerator import BacktrackingGenerator
from mazelib.generate.Kruskal import Kruskal
from mazelib.generate.Prims import Prims
from mazelib.generate.AldousBroder import AldousBroder
from mazelib.generate.Wilsons import Wilsons
from mazelib.generate.Ellers import Ellers
from mazelib.generate.Sidewinder import Sidewinder
from mazelib.generate.BinaryTree import BinaryTree
from mazelib.generate.Division import Division
from mazelib.solve.BacktrackingSolver import BacktrackingSolver
from mazelib.solve.ShortestPath import ShortestPath
import matplotlib.pyplot as plt
import sys, math, random, numpy, sys
import time

# BFS-based solver
def solve(grid, size):
    queue = [((1, 1), 1)]
    visited = set()
    while len(queue) != 0:
        (x, y), cnt = queue.pop(0)
        if x == 2*size-1 and y == 2*size-1:
            break
        if (x, y) in visited:
            continue
        visited.add((x, y))
        # Up
        if x - 1 > 0 and grid[x-1][y] == 0:
            queue.append(((x-2, y), cnt+2))
        # Down
        if x + 1 < 2*size and grid[x+1][y] == 0:
            queue.append(((x+2, y), cnt+2))
        # Left
        if y - 1 > 0 and grid[x][y-1] == 0:
            queue.append(((x, y-2), cnt+2))
        # Right
        if y + 1 < 2*size and grid[x][y+1] == 0:
            queue.append(((x, y+2), cnt+2))
    return cnt

algorithm = sys.argv[1]
max_iter = int(sys.argv[2])
size = 30
seed = 1
index = 1

if seed == "NONE":
    m = Maze()
else:
    m = Maze(int (seed))

# generator chosen based on argument passed in
if algorithm == "Backtracking":
    m.generator = BacktrackingGenerator(size, size)
elif algorithm == "Kruskal":
    m.generator = Kruskal(size, size)
elif algorithm == "Prims":
    m.generator = Prims(size, size)
elif algorithm == "AldousBroder":
    m.generator = AldousBroder(size, size)
elif algorithm == "Wilsons":
    m.generator = Wilsons(size, size)
elif algorithm == "Ellers":
    m.generator = Ellers(size, size)
elif algorithm == "Sidewinder":
    m.generator = Sidewinder(size, size)
elif algorithm == "BinaryTree":
    m.generator = BinaryTree(size, size)
elif algorithm == "Division":
    m.generator = Division(size, size)
else:
    print("No such algorithm supported")
    exit(1)

solutions = []
for i in range(max_iter):
    if i % 1000 == 0:
        print(i)
    m.generate()
    sol_len = solve(m.grid, size)
    solutions.append(sol_len)

with open('./dist_%s_%d.csv' % (algorithm, max_iter), 'w') as f:
    for sol in solutions:
        f.write('%d\n' % sol)
