   % verify if p1 and p2 are 1 x 2 vectors
    if( size(p1) ~= 2)
        error('p1 must be a 1 x 2 vector');
        return;
    end
    if(size(p2) ~= 2)
        error('p2 must be a 1 x 2 vector');
        return;
    end
    
    
    % find slope