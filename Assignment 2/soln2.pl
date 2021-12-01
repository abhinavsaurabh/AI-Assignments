% Reading the data from csv in the knowledge base
% Reading the Distance without Heuristics
knowledgebase :-  csv_read_file('/Users/abhinavsaurabh/Desktop/IIIT-DELHI/Semester 3/2. Artificial Intelligence/Assignment 2/DFS/distance.csv', Distances, [functor(distance)]),
maplist(assert,Distances),
% Reading the Distance with Heuristics
csv_read_file('/Users/abhinavsaurabh/Desktop/IIIT-DELHI/Semester 3/2. Artificial Intelligence/Assignment 2/BFS/dheur.csv', DisHeuristics,[functor(heuristic)]),
maplist(assert,DisHeuristics).


% To locate next node in case of DFS
next_node(Current, Next, Path) :-
% Getting distance between current node and next node
    distance(Current, Next,Dist),
    not(member(Next, Path)),
    assert(cost(Dist)).

% Depth First Search
% DFS Search for path to be found
depth_first_search(Initial_city,Target_city) :- depth_first(Initial_city, Target_city, [Initial_city]).
% Intial city is the current starting point
% Target city is the goal of the algorithm
depth_first(Target_city, Target_city, _) :- assert(cities(Target_city)),distance_list_conversion(List),nl,write("Path Discovered with DFS is "),nl,write(List), cost_list_conversion(CostList),cost_summation(CostList,TotalCost),nl,nl,write("Total cost of the path is :"),nl,write(TotalCost).
% TotalCost stores the cost of entire path then it is printed
depth_first(Initial_city, Target_city, Visited) :-
  % DFS takes input with intial node and the goal node
    next_node(Initial_city, Next_node, Visited),assert(cities(Initial_city)),assert(cities(" --> ")),
    % Moves further after printing intial nodes
    depth_first(Next_node, Target_city, [Next_node|Visited]).

% DFS exploits the path simultaneous recursively to node it encounters. Its an exhaustive search.

% further converting distances into the list format.
 distance_list_conversion([Px|Tail]):- retract(cities(Px)), distance_list_conversion(Tail).
 distance_list_conversion([]).

% further converting costs into the list format.
 cost_list_conversion([Px|Tail]):- retract(cost(Px)),  cost_list_conversion(Tail).
  cost_list_conversion([]).

% further converting costs for bfs into the list format.
 cost_list_conversion_bfs([Px|Tail]):- retract(cost_bfs(Px)),  cost_list_conversion_bfs(Tail).
  cost_list_conversion_bfs([]).

% cost summation on each of the steps is store in following variables.
cost_summation([],0).
cost_summation([T|R],M) :- cost_summation(R,S), M is T+S.



% Best First Search
% BFS search for path
best_first(Initial_city,Target_city) :- heuristic(Initial_city,Target_city,Value),write("Path Discovered with Best First Search is"),nl,write(Initial_city),bestFirstSearch(Initial_city,Target_city,[Value-Initial_city],[]).
% Intial city is the current starting point
% Target city is the goal of the algorithm
bestFirstSearch(X,X,_,_) :- nl,write("The total cost of discovered path: "),nl,cost_list_conversion_bfs(CostListBfs),cost_summation(CostListBfs,NetCost),write(NetCost).
% NetCost stores the cost of entire path then it is printed for bfs
bestFirstSearch(_,_,[],_):- write("No element left in the Open List").
% BFS takes intial city and target i.e goal state as input
bestFirstSearch(Initial_city,Target,OpenList,ClosedList) :-
% Further BFS exploits the lists.
[Head1 | Tail] = OpenList,
% intial city is initialized
_-Initial_cityNode = Head1,
% Finding all the values next
findall(Value-NextNode,(distance(Initial_cityNode,NextNode,_), Initial_cityNode \== NextNode, not(member(NextNode,ClosedList)),heuristic(NextNode,Target,Value)),NN),
% BFS does its search with  heuristic way here and tries to find the best path to the targets
append(NN,Tail,UpdatedOpenList),
keysort(UpdatedOpenList,SortedOpenList),
[HeadNode|_] = SortedOpenList,
_-BestNextNode = HeadNode,

% Further best path is printed here
write(" --> "),write(BestNextNode),
% Then again next best node is printed
distance(Initial_city,BestNextNode,Dist),
% Further cost is taken into the account
assert(cost_bfs(Dist)),
bestFirstSearch(BestNextNode,Target,SortedOpenList,[Initial_city|ClosedList]).
