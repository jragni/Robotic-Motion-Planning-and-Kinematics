function [V] = polygonSelectionSort(P)
% input: Polygon (P), n x 2 matrix
% output: vertices sorted from least to greatest(V) for X-coordinate

V = P;
% selection sort
for i = 1:length(P) - 1
    min = i
    for j = i+1:length(P)
        if(P(j,1) < P(min,1))
            min = j;
        end
        
    end
    
    if min ~= i
        % swap V(i,1) with V(min,1)
        spotHolder = V(i,1);
        V(i,1) = V(min,1)
        V(min,1) = spotHolder;
    end
 
end

end    

