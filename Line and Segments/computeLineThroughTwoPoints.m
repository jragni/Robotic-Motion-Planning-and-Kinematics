function [a, b, c] = computeLineThroughTwoPoints(p1,p2)
%computeLineThroughTwoPoints takes inputs of two distinct points on a plane
%and returns outputs a, b, c which define the line ax + by + c = 0
%normalizing to a^2 + b^2 = 1


    % verify if p1 and p2 are 1 x 2 vectors
    if( size(p1) ~= 2)
        error('p1 must be a 1 x 2 vector');
        return;
    end
    if(size(p2) ~= 2)
        error('p2 must be a 1 x 2 vector');
        return;
    end
    % initialize consants
    x1 = p1(1);
    x2 = p2(1);
    y1 = p1(2);
    y2 = p2(2);
    % Y-y1 = m * (X - x1)
    % solve for slope m 
    m = (y2 - y1)/(x2 - x1);
    
    % Y - y1 = (y2-y1)/(x2-x1) * ( X - x1)
    % => Y/(y2-y1) - y1/(y2-y1) = (X - x1) / (x2 -x1) 
    % => X / (x2 - x1) - Y/(y2-y1) - x1/(x2 - x1) + y1/(y2-y1) = 0
    
    
    % => A = 1/(x2-x1)
    A = 1/ (x2 - x1);
    % => B = -1/(y2-y1)
    B = -1/(y2 - y1);
    % => C = -x1/(x2 - x1) + y1/(y2-y1)
    C = (y1/(y2-y1)) - (x1/(x2-x1))
    % normalize to A^2 + B^2 = 1
    norm_factor = sqrt(A^2 + B^2);
     a = A / norm_factor;
     b = B / norm_factor;
     c = C / norm_factor;
    
    
   
end

