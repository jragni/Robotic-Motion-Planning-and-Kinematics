G = {[2 4],[ 3 5], [], [], []}
vStart = 1

Q = []; % queue 

for i = 1:length(G)
    parent(i) = NaN;
end
% set start node as parent to itself
parent(vStart) = vStart;
% initialize current vertex visited
currentVertex = vStart;
% Queue current vertex
Q = [Q currentVertex]; 
while ~isempty(Q)
   % FIFO Queue 
   currentVertex = Q(1); Q(1) = []
   % for each adjacent vertex u, check if visited, if not, 
   length(G{currentVertex})
   for j = 1:length(G{currentVertex})
       u = G{currentVertex}(j)
       if isnan(parent(u))
           parent(u) = currentVertex
           Q = [Q u]
       end
   end
end


