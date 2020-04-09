function D = computeDistancePoint2Polygon(q,P)
    % computeDistancePoint2Polygon calculates the normal distance to the normal distance of point q to a polygon P of n vertices. 
    % INPUT: q, P
    % OUTPUT: D
    % This function will calculate the distance of point q to every point
    % of every segment of polygon P and will return the closest normal 
    %distance.
    
    %% verify inputs
    % verify q is a vector 1 x 2 
    if( size(q) ~= [1, 2])
        error('p1 must be a 1 x 2 vector');
        return;
    end
    % verify that each row in P is a 1 x 2 vector
    for ii = 1 : length(P)
        if length(P(ii,:))~=2
            error('P must be a row vector of vectors that are 1 x 2');
            return;
        end
    end
    %% verify if point q is within polygon P
    if(inpolygon(q(1),q(2),P(:,2),P(:,2)))
        error('point q lies within the polygon P');
    end
    
    %% Algorithm
    %  for every segment that makes up P
    %   compute the nearest distance and mode of distance (i.e edge or
    %   vertex).
    %   find minimum distance in segmentDistance
    
    % modified selection sort 
    minDistance = Inf; 
    for i = 1: length(P)-1
      for j = i+1: length(P)
          %current_d is the distance and modeOfDist is whether the normal
          %distance is with respect to the vertex or the line segment
         [current_d, modeOfDist]= computeDistancePoint2Segment(q,P(i,:),P(j,:));
         if(current_d < minDistance)
             minDistance = current_d; 
             minMode = modeOfDist;  % not necessary, but good for visualization
 
         end
      end
    end
   D = minDistance;
end

