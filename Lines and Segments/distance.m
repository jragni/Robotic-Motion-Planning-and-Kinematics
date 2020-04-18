function d = distance(p1,p2)
% distance finds the normal euclidean distance from point p1 to point p2 
% Author: Jhensen Agni 
% github: jragni
dx = p1(1)-p2(1);
dy = p1(2)-p2(2);
d = sqrt(dx^2 + dy^2);
end