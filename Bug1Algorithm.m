function [path] = Bug1Algorithm(start,goal,obstaclesList,stepSize)
%BUG1ALGORITHM implements Bug 1 algorithm and returns the path.
clf
% initialize constants
currentPose = start;
path = [currentPose];
isCollision = 0; 
success = false;
closeIndex = 1;
closestObstacle = obstaclesList{1};
closestObsDist = distancePoint2Polygon(currentPose,closestObstacle);
obstacleNavigationAndDistance = [];  % the points around the obstacle and distance to goal


% plot setup
plot(currentPose(1),currentPose(2),'^')
hold on
plot(goal(1),goal(2),'^')
grid on
for j = 1 : length(obstaclesList)
    fill(obstaclesList{j}(:,1), obstaclesList{j}(:,2),[1 0 0]);
end

% while not at goal
    % move towards goal
    % if obstacle hit,
    % take distance from each point around obstacle
    % if point of hit is reached, travel to point of minimal distance
    % between obtacle and goal
    
%% algorithm
    while ~success
        % end condition 
        if(distance(currentPose,goal)<stepSize)
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
        nextPose = u*stepSize + currentPose;
        
        if isCollision == 0
            
            % if line between current pose goal lies in obstacle, follow tangent
            % of polygon taking measurements of each step
            if(inpolygon(nextPose(1),nextPose(2),closestObstacle(:,1),closestObstacle(:,2)))
                clear nextPose
                isCollision = 1;
                % get the location of hit
                pHit = currentPose;
                dist2goal = distance(currentPose,goal);
                obstacleNavigationAndDistance = [currentPose,dist2goal];  % coordinate and distance

                % searching phase
                while isCollision == 1;
                    u = vectorTangent2Polygon(currentPose,closestObstacle);
                    currentPose = u*stepSize + currentPose;
                    dist2goal = distance(currentPose,goal);
                    obstacleNavigationAndDistance =[obstacleNavigationAndDistance ;currentPose,dist2goal];
                    path = [path;currentPose];
                    plot(path(:,1),path(:,2),'.-b')
                    pause(.1)
                    if distance(currentPose,pHit) < stepSize
                        isCollision = 2;
                        % exit phase
                        % find the coordinate with the shortest path to goal
                        [~,leaveIndex]= min(obstacleNavigationAndDistance(:,3))
                    end
                end

                disp('leaving obstacle')
            else
                currentPose = nextPose;
            end

            % update path and plot
            path = [path;currentPose];
            plot(path(:,1),path(:,2),'.-g')
            pause(.01)

        elseif isCollision == 2
            for kk = 1 : leaveIndex + 1
                u = vectorTangent2Polygon(currentPose,closestObstacle);
                currentPose = u*stepSize + currentPose;
                path = [path;currentPose];
                plot(path(:,1),path(:,2),'.-g')
                pause(.01)
            end
            isCollision = 0;
        end
        

        path = [path;currentPose];
        plot(path(:,1),path(:,2),'.-g')
        pause(.01)
    end
    
end

