function path = Bug0Algorithm(start,goal,obstaclesList,stepSize)
%Bug0Algorithm implements the Bug 0 algorithm and plots the path taken.
%returns the path.

% initialize variables
currentPose = start;
path = [currentPose];
success = false;
closeIndex = 1;
closestObstacle = obstaclesList{1};
closestObsDist = distancePoint2Polygon(currentPose,closestObstacle);

% plot setup
plot(currentPose(1),currentPose(2),'^')
hold on
plot(goal(1),goal(2),'^')
grid on
for j = 1 : length(obstaclesList)
    fill(obstaclesList{j}(:,1), obstaclesList{j}(:,2),[1 0 0]);
end

while ~success
    
    % check for end condition
    if distance(currentPose,goal) < stepSize
        success = true;
        break;
    end
    
    % find closest Polygon.
    for i = 1:length(obstaclesList)
        currentObstacle = obstaclesList{i};
        obsCheckDist = distancePoint2Polygon(currentPose,currentObstacle);
        if obsCheckDist < closestObsDist
            closeIndex = i;
            closestObstacle = obstaclesList{closeIndex};
        end
    end
    closestObstacle = obstaclesList{closeIndex};
    
    % move towards goal
    u = vectorPoint2Point(currentPose,goal);
    nextPose = u*stepSize/2 + currentPose;
    
    % if line between current pose goal lies in obstacle, follow tangent
    % of polygon
    if(inpolygon(nextPose(1),nextPose(2),closestObstacle(:,1),closestObstacle(:,2)))
        clear nextPose
        nextPose = -u*stepSize + currentPose; % move back from boundary
        u = vectorTangent2Polygon(currentPose,closestObstacle);
        currentPose = u*stepSize/2 + currentPose;
    else
        currentPose = nextPose;
    end
    
    % update path and plot
    path = [path;currentPose];
    plot(path(:,1),path(:,2),'.-')
    pause(.01)
    
end

end

