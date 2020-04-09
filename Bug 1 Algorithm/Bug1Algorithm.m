function [path ] = Bug1Algorithm(start, goal, obstacles, stepsize)
    %BUG1ALGORITHM outputs the set of points that make up the path from the
    % point start to the goal point avoiding the obstacles by implementing, 
    % Bug 1 Algorithm.

    % Input: Two locations start and goal in Wfree, a list of polygonal obstacles
    % obstaclesList, and a length step-size
    % Output: A sequence, denoted path, of points from start to the first obstacle between
    % start and goal (or from start to goal if no obstacle lies between them).
    % Successive points are separated by no more than step-size.
    
    %% input verification
    % verify start and goal are a 1 x 2 vectors
    [mstart,nstart] = size(start);
    if(  mstart~= 1 || nstart ~=2)
        error('q must be a 1 x 2 vector')
        return;
    end
    [mgoal,ngoal] = size(goal);
    if(  mgoal~= 1 || ngoal ~=2)
        error('q must be a 1 x 2 vector')
        return;
    end
    % verify Obstacles 
    for ii = 1 : length(obstacles)
        if size(obstacles(ii,:))~=[1 , 2]
            error('P must be a row vector of vectors that are 1 x 2');
            return;
        end
    end
    
    
    %% begin plot 
    fill(obstacles(:,1),obstacles(:,2),[1,0,0])
    hold on; 
    plot(start(1),start(2),'*')
    plot(goal(1),goal(2),'*')
    axis([-3,3,-3,3]);

    %% Algorithm
    % initialize position and path variables
    success = false;  % boolean to check if robot is at goal
    current_pose = start;   % initialize current position
    path = start; % add starting point to current path
  
    
   
    fill(obstacles(:,1),obstacles(:,2),[1,0,0])
    hold on; 
    plot(start(1),start(2),'*')
    plot(goal(1),goal(2),'*')
    plot(path(:,1),path(:,2),'o')
    axis([-1,3,-1,3]);
    
    
end

