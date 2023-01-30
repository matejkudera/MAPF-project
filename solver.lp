% MAPF_solver.lp
% MAPF project, MAPF solver with pruning 30.1.2023
% Authors: Matej Kudera (kudera@uni-potsdam.de), Eliska Ciganova (ciganova@uni-potsdam.de)
% Main file for MAPF project

% Calculate shortest individual paths
% TBA

%%%%%%%%%%%%%%% Prune original graph %%%%%%%%%%%%%%%%%
% Get vertices with given distance from individual optimal paths.
vertex_pruned((X1,Y1)) :- vertex((X1,Y1)), spath(_,_,(X2,Y2),_), D = |X1 - X2| + |Y1 - Y2|, D <= 2.

%%%%%%%%%%%%% Calculate MAPF %%%%%%%%%%%%%%%%%%%
% MAPF parameters
time(1 .. horizon).
direction((X,Y)) :- X = -1..1, Y = -1..1, | X + Y | = 1.

% Get neighboring vertices
nextto((X1,Y1), (DX,DY), (X2,Y2)) :- direction((DX,DY)), vertex_pruned((X1,Y1)), vertex_pruned((X2,Y2)), (X1,Y1) = (X2 - DX, Y2 - DY), (X2,Y2) = (X1 + DX, Y1 + DY).

% Generate moves for every agent and timestep
{move(R,D,T) : direction(D)} 1 :- agent(R) , time(T).

% Generate paths for agents and remove paths with unreachable vertices
position(R,C,0) :- start(R,C).
position(R,C1,T) :- move(R,D,T), position(R,C2,T - 1), nextto(C2,D,C1).
:- move(R,D,T), position(R,C,T -1), not nextto(C,D,_).

% Generate wait actions
position(R,C,T) :- position(R,C,T - 1), not move(R,_,T), agent(R), time(T).

% Check edge conflicts
moveto(C2,C1,T) :- nextto(C2,D,C1), position(R,C2,T - 1), move(R,D,T).
:- moveto(C2,C1,T), moveto(C1,C2,T), C1 < C2.

% Check vertex conflict
:- {position(R,C,T) : agent(R)} > 1, vertex_pruned(C), time(T).

% Check if goal reached
:- position(R,C,horizon), agent(R), not goal(R,C). 

% Pick smallest plans
#minimize { T,R : position(R,C,T), not goal(R,C)}.

%%%%%%%%%%%%%%%%%%% Generate output predicates %%%%%%%%%%%%%%%
path(R,C1,C2) :- position(R,C1,T), position(R,C2,T+1).
plan(R,D,T) :- move(R,D,T).

#show path/3.
#show plan/3.

% END MAPF_solver.lp