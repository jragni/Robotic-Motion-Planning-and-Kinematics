function [ u ] = computeTangentVector2Polygon(q,P)
%COMPUTETANGENTVECTOR2POLYGON determines the vector u from point q
% tangent to polygon P.

% Input: a polygon P and a point q.
% Output: the unit-length vector u tangent at point q to the polygon P 
% in the following sense: 
% (i) if q is closest to a segment of the polygon, then u should be 
%  parallel to the segment, 
% (ii) if q is closest to a vertex, then u should be tangent to a circle 
%  centered at the vertex that passes through q
% (iii) the tangent should lie in the counter-clockwise direction.
% Author: JhensenSoft 
% Github: github.com/jragni

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
    
    %% verify if point q is not within polygon P
    if(inpolygon(q(1),q(2),P(:,1),P(:,2)))
        error('point q lies within the polygon P');
    end
    
    %% Algorithm 
    %  for every segment that makes up P
    %   compute the nearest distance and mode of distance (i.e edge or
    %   vertex).
    %   find minimum distance in segmentDistance
    
    %% modified selection sort 
    minDistance = Inf; 
    for i = 1: length(P)-1
         for j=i+1: length(P)
              %current_d is the distance and modeOfDist is whether the normal
              %distance is with respect to the vertex or the line segment
             [current_d, modeOfDist]= computeDistancePoint2Segment(q,P(i,:),P(j,:));
             if(current_d < minDistance)
                 minDistance = current_d;  % shortest path from point q to polygon P
                 vertex1= P(i,:);  % vertex that makes the edge of shortest path on P
                 vertex2= P(j,:); % vertex that makes the edge of shortest path on P
                 minMode = modeOfDist % determines if point of shortest distance 
                                       % is vertex or edge       
             end
         end
    end
    
    %% Determine closest point from segment
    switch(minMode)
        case 0  % closest point is an edge, u is parallel to this line 
           % get equation of line from vertices    
           [a,b,c] = computeLineThroughTwoPoints(vertex1,vertex2);           
           Y = -a/b*(vertex1(1))  - c/b; 
           X = -b/a*vertex2(2) - c/a; 
           if isnan(X)
               % Vertical Line
               ux = 1;
               uy = 0;
           elseif isnan(Y)
               % horizontal line
               ux = 0;
               uy = 1;
           else
              % parallel to line
              ux = (vertex1(1)-vertex2(1))/ sqrt( (vertex1(1)-vertex2(1))^2 + (vertex1(2)-vertex2(2))^2)
              uy = (vertex1(2)-vertex2(2))/ sqrt( (vertex1(1)-vertex2(1))^2 + (vertex1(2)-vertex2(2))^2)

           end
           
        case 1 % closest point1 is vertex 1 
            [a,b,c] = computeLineThroughTwoPoints(q,vertex1);
            ux = a/sqrt(a^2+b^2);  % x component of u normalized
            uy = b/sqrt(a^2+b^2);  % y component of u normalized
            disp('pop')
        case 2 % closest point is vertex 2
            [a,b,c] = computeLineThroughTwoPoints(q,vertex2);
            ux = a/sqrt(a^2+b^2);  % x component of u normalized
            uy = b/sqrt(a^2+b^2);  % y component of u normalized
            disp('crackle')
    end
    
    
    
    %% solution 
   
    u = [ux uy];

end


