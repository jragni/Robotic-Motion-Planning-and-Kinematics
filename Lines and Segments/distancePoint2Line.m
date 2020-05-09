function [d] = distancePoint2Line(q,p1,p2)
% distancePoint2Line returns the normal distance of point q to the line made by points p1 and p2
% Author: Jhensen Agni
% github: jragni

% get equation of line p1-p2
[a,b,c] = lineThrough2Points(p1,p2);
% get projection of point q onto line p1-p2

% ax + by + c = 0 
d = abs(( q(1)*a + q(2)*b + c)/sqrt(a^2+b^2));

end

