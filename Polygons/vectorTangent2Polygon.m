function [u] = vectorTangent2Polygon(q,P)
% vectorTangent2Polygon calculates the unit vectors of from a point on polygon p to q.
% AUTHOR: Jhensen Agni
% GITHUB: jragni

% get closest distance from point q to P
[d,w,ii,jj]=distancePoint2Polygon(q,P);
if jj ==4
    jj = 1;  % the first point is appended to the end of the Polygon list
end
vertex1 = P(ii,:);
vertex2 = P(jj,:);
% if closest to segment, vector is the slope of the segment, otherwise the
% tangent line is perpendicular to the line created by the vertex and the
% point q
    if w == 2    
            [a,b,c] = lineThrough2Points(q,vertex2);
            ux = b/sqrt(a^2 + b^2);
            uy = -a/sqrt(a^2 + b^2);
    elseif w == 1 
            [a,b,c] = lineThrough2Points(q,vertex1);
            ux = b/sqrt(a^2 + b^2);
            uy = -a/sqrt(a^2 + b^2);
    else
         [a,b,c] = lineThrough2Points(vertex1,vertex2);
           ux = b/sqrt(a^2+b^2);
           uy = -a/sqrt(a^2+b^2);
    end
u = [ux uy];


end