function [d,distanceMode,ii,jj] = distancePoint2Polygon(q,P)
%DISTANCEPOINT2POLYGON returns the distance (d), mode of distance, and the
%indices of the points of the two vertices that make the edge closest to point q of the polygon.
% Author: Jhensen Agni
% github: jragni

    d = Inf; % initialize d
    % ensure loop closure so every edge is checked
    P = [P;P(1,:)]; % append first point to last to get the edge made by first and last
        
    % for every segment in polygon P. get distance
    for i = 1 : length(P) - 1
        j = i + 1;
        [currentDist,w]= distancePoint2Seg(q,P(i,:),P(j,:));
        
        if(currentDist < d)
            % calculate closest distance, and their indices
            d = currentDist;
            distanceMode = w;
            ii = i;
            jj = j;
        end

    end


end

