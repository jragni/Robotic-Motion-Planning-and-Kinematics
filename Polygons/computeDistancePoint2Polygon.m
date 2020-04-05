function [D] = computeDistancePoint2Polygon(q,P)
    % computeDistancePoint2Polygon calculates the normal distance to the
    % normal distance of point q to a polygon P of n vertices. 
    % INPUT: q, P
    % OUTPUT: D
    
    %% verify inputs
    % verify q is a vector 1 x 2 
    if( size(q) ~= [1, 2])
        error('p1 must be a 1 x 2 vector');
        return;
    end
    % verify that each row in P is a 1 x 2 vector
    for ii = 1 : length(P)
        if size(P(ii,:))~=[1 , 2]
            error('P must be a row vector of vectors that are 1 x 2');
            return;
        end
    end
    
    % for each vertex in P
    %   find the distance between vertice of P and point q
    %   store in array pointDist2Vertex
    for jj = 1 : length(P)
        pointDist2Vertex(jj) = computeDistancePoint2Segment(q, P(jj,:))
    end
    
end
