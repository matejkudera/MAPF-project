# MAPF-project

Authors: <br/>
Matěj Kudera, matej.kudera@uni-potsdam.de <br/>
Eliška Cigánová, eliska.ciganova@uni-potsdam.de

### Encoding

Encoding of the project was based on the research paper "Reduction-based solving of multi agent path finding on large maps using graph pruning" discused in seminar.

First part of the project contains pruning. Pruning cuts of verticies with distance greater then two from any individual shortest path. Fixed number for distance was chosen beacause agents in usual MAPF instances dont need to move that much from their individual shortest paths to get to their goal vertices. We believe that this distance makes more than enough space to solve normal MAPF instances.

Next part contains MAPF solver. We used MAPF solver for ASP presented in above-mentioned research paper which we deemed sufficient enough for this project. Only change from the original algorithm is that we used weak constaint to select paths with shortest lenghts, because otherwise it prints all possible paths.

At the end we generate predicates path/3 and plan/3 from generated paths which are required be the requirements. 

### Usage

Solver requires instances in MIF format presented in project forum and returns optimal paths. Usage can be tested on provided instances with shell command:
```
clingo --opt-mode=optN --quiet=1 solver.lp instanceX.lp 0
```
