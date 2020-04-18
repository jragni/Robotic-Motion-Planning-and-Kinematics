function [ u ] = vectorPoint2Point(p1,p2)
%VECTORPOINT2POINT returns the unit vectors from p1 to p2
% Author: Jhensen Agni
% github: jragni

    % calculate modulus of vector
    L = sqrt( (p1(1)-p2(1))^2 + (p1(2)-p2(2))^2 );
    if L < 10^-7
        u =[ 0 0];
    else
        ux = (p2(1)- p1(1))/ L;
        uy = (p2(2) - p1(2))/ L;
        u = [ux uy];
    end
end

