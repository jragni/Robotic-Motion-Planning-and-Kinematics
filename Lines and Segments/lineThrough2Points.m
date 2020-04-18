function [a,b,c] = lineThrough2Points(p1,p2)
%LINETHROUGH2POINTS returns the coefficients of the general formula of a
%line that intercepts points p1 and p2. 

% Author: Jhensen Agni
% github: jragni

% general equation of a line
%  Ax + By + C = 0

% point slope form
%  y - y1 = (y2-y1)/(x2-x1) * (x - x1)

% proof
% => (x2 - x1) * y - (x2 - x1)*y1 - (x2 - x1)*y1 + (y2 - y1)*x1 = 0
% => -(y1 - y2) * x + (x2 - x1)*y -(x2y1 - y1x1) + (y2x1 - y1x1) = 0
% => A = y1 - y2 ; B = x2 - x1; C =  y2x1 - y1x2; 

A = p1(2) - p2(2);
B = p2(1) - p1(1);
C = p2(2)*p1(1) - p1(2)*p2(1);    
% normalize coeefficients
dist = sqrt(A^2+B^2);  
% solution
a = A/dist;
b = B/dist;
c = C/dist; 
end

