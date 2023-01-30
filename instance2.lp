vertex((1..1,1..4)).
edge((X1,Y1),(X2,Y2)) :- vertex((X1,Y1)), vertex((X2,Y2)), XD = X1 - X2, YD = Y1 - Y2, | XD + YD | = 1.
agent(a1).
agent(a2).
start(a1,(1,1)).
goal(a1,(1,4)).
start(a2,(1,4)).
goal(a2,(1,1)).
spath(a1,(1,1),(1,2),1).
spath(a1,(1,2),(1,3),2).
spath(a1,(1,3),(1,4),3).
spath(a2,(1,4),(1,3),1).
spath(a2,(1,3),(1,2),2).
spath(a2,(1,2),(1,1),3).
#const horizon=5.
