function [theta2Goal,thetaError] = calculateHeading(robotPose,goal)
    % given the robots pose (x,y,theta), and the goal with respect to the
    % space frame. The function will output the 

    x = robotPose(1);
    y = robotPose(2);
    theta = atan2(sin(robotPose(3)),cos(robotPose(3)));
    xGoal = goal(1);
    yGoal = goal(2);
    
    x_increment = xGoal - x;
    y_increment = yGoal - y;
    theta2Goal = atan2(y_increment,x_increment);
    thetaError = theta2Goal - theta;
    
end

