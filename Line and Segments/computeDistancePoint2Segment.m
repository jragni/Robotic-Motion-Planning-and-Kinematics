function [ D , w ] = computeDistancePoint2Segment(q,p1,p2 )
    %   COMPUTEDISTANCEPOINT2SEGMENT calculates the distance of a point q
    %   from the line segment created by points p1 and p2. 
    %
    % Input: (q,p1,p2)
    % Output: (d;w), where d is the distance from q to the segment with extreme 
    % points (p1; p2) and w has the following meaning: 
    % w = 0 if the segment point closest to q is strictly inside the segment, 
    % w = 1 if the closest point is p1
    % w = 2 if the closest point is p2.
    
    %verify if q is a 1 x 2 vectors
    if( size(q) ~= 2)
        error('q must be a 1 x 2 vector')
        return;
    end
    % verify if p1 and p2 are 1 x 2 vectors
    if( size(p1) ~= 2)
        error('p1 must be a 1 x 2 vector');
        return;
    end
    if(size(p2) ~= 2)
        error('p2 must be a 1 x 2 vector');
        return;
    end
    
    % gather input coordinates
    q_x = q(1);  % x coordinate of point q
    q_y = q(2);  % y coordinate of point q
    x1 = p1(1);  % x coordinate of p1
    x2 = p2(1);  % y coordinate of p1
    y1 = p1(2);  % x coordinate of p2
    y2 = p2(2);  % y coordinate of p2
    
    % get the distance of point p1 to p2
    d_p1p2 = sqrt((x1-x2)^2 + (y1-y2)^2);
    % get the distance of q to p1
    d_qp1 = sqrt((q_x-x1)^2 + (q_y-y1)^2);
    % get the distance of q to p2
    d_qp2 = sqrt((q_x-x2)^2 + (q_y-y2)^2);
    
    % use law of cosines to find theta = angle between d_qp1 and d_p1p2
    theta = acos( (d_qp2^2 - d_qp1^2 -d_p1p2^2)/(-2*d_qp1*d_p1p2) );
    % phi = angle between d_qp2 and d_p1p2, used to find as a redundancy
    phi = acos( (d_qp1^2 - d_qp2^2 -d_p1p2^2)/(-2*d_qp2*d_p1p2) );
    % gamma = angle between d_qp1 and d_p2
    gamma = acos((d_p1p2^2 - d_qp1^2 - d_qp2^2)/(-2*d_qp1*d_qp2));
    
   
    if(theta >= pi/2)
        % if theta >= pi/2, q is closest to p1
        D = sqrt( (x1 - q_x)^2 + (y1 - q_y)^2 );
        w = 1;
        % take distance with respect to p1
    elseif(phi >= pi/2)
        % if phi is >= p1/2, q is closest to p2
        w = 2;
        D = sqrt( (x2 - q_x)^2 + (y2 - q_y)^2 ); 
    else
        % the point on closest to q is strictly on the segment
        D = computeDistancePoint2Line(q,p1,p2);
        w = 0;
    end
             
end

