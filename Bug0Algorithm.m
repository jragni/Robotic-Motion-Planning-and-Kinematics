function path = Bug0Algorithm(start,goal,obstaclesList,stepSize)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

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
            disp('object updated')
        end
    end
    closestObstacle = obstaclesList{closeIndex};
    % move towards goal
    u = vectorPoint2Point(currentPose,goal);
    nextPose = u*stepSize/2 + currentPose;
    
    if(inpolygon(nextPose(1),nextPose(2),closestObstacle(:,1),closestObstacle(:,2)))
        disp('hit')
        clear nextPose
        nextPose = -u*stepSize/2 + currentPose;
        u = vectorTangent2Polygon(currentPose,closestObstacle);
        currentPose = u*stepSize/2 + currentPose;
    else
        currentPose = nextPose;
    end
    
    path = [path;currentPose];
    plot(path(:,1),path(:,2),'*')
    pause(.01)
    
end

end

