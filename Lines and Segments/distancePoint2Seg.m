function [d,w] = distancePoint2Seg(q,p1,p2)
%DISTANCEPOINT2SEG returns the distance d and mode of distance w from point q and the line segment made by point 1 and point 2. If w = 0,
%the closest distance to point q lies on the segment of the line p1 and p2.
% w = 1 if the point q is closer to the vertex of the semgent made by point
% p1 and w = 2 if the point q is closer to the vertext of the segment p2.
% AUTHOR: Jhensen Agni
% GITHUB: jragni

    % calculate equation of line
    [a,b,c] = lineThrough2Points(p1,p2);
    % calculate perpendicular line passes through q and line p1-p2
    % ax + by + c = 0
    % => perpendicular line: -bx + ay + c2 = 0 
    C = q(2)*a - q(1)*b ;
    % get point intercepting the line passing through q that is on the line
    % perpendicular to p1-p2 

    % a*x + b*y = -c
    % -b*x + a*y = -C
    A = [ a b; -b a];
    const = [-c;C];
    
    % solve for x and y 
    projPoint = A\const;
    xP = projPoint(1);
    yP = projPoint(2);
    
    %get distances of point to verices and projection
     d_qp1 =  distance(q,p1);
     d_qp2 = distance(q,p2);
     d_proj = distance(q,projPoint);

    % check for location of q with respect to line p1-p2
    X = [p1(1) p2(1)]; 
    Y = [p1(2) p2(2)];
    % find the extremes of the line segments, and indices
    [xRight, indexRight] = min(X); % right most point of segment
    [xLeft, indexLeft] = max(X); % left most point of segment
    [yTop, indexTop] = max(Y); % top most point of segment
    [yBot, indexBot] = min(Y); % bottom most segment of point

    if xRight ~= xLeft
        % line is not vertical
        if(xP > xLeft)
            % point is to the left
             closest = [X(indexLeft),Y(indexLeft)];
             d = distance(q,closest);
        elseif(xP < xRight)
            % point is to the right
             closest = [X(indexRight),Y(indexRight)];
             d = distance(q,closest);      
        else 
            % point is near segment 
            d =  d_proj;
        end
    else
        % line is vertical 
        if( yP > yTop)
            % point is above segment 
            closest = [X(indexTop),Y(indexTop)];
            d = distance(q,closest);
        elseif( yP < yBot)
            % point is below segment
            closest = [X(indexBot),Y(indexBot)];
            d = distance(q,closest);
        else
            % point is near the segment 
             d =  d_proj;
        end
    end

    % solve for the mode w 
    if d == d_qp1
        w = 1;
    elseif d == d_qp2 
        w = 2;
    else
        w = 0;
    end

end