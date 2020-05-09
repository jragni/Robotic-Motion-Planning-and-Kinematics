function [P] = extractPath(vGoal,parent)
%EXTRACTPATH find the path to the start node from the goal node.
    
%create an array P = [vGoal]
P = [vGoal]
u = vGoal
while parent(u) ~= -1 
   u = parent(u)
   P = [u P]
end



