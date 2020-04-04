function [D] = computeDistancePoint2Line(q, p1, p2)
    % computeDistancePoint2Line calculates the normal distance of point q 
    % to the line passing through p1 and p2.
    % Input: a point q and two distinct points p1 = (x1; y1) and p2 = (x2; y2) 
    % defining a line.
    % Output: the distance from q to the line dened by p1 and p2.
    % Author: JhensenSoft

    % verify if q is a 1 x 2 vectors
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

    % law of sines to find D
    if isnan(sin(theta))
        D = d_qp2*sin(phi);
    else
        D = d_qp1*sin(theta);
    end
    
    % prevent arithmetic underflow
    if abs(D) < .0000001
        D = 0;
    end
end