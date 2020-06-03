
function mobilePathFollower(waypoints)
%% mobile Path Follower
% Given a set of waypoints, the robot will move to each waypoint in a pure
% pursuit. Must have turtlebot3_gazebo launched through ros 
%% Author: Jhensen Ray Agni

%% global variables
% waypoints =[0.5 0; 1 0; 1.5 0;2 0;2 0.5; 2 1; 2 1.5; 2 2;1.5 2; 1 2; 0.5 2; 0 2; 0 1.5; 0 1; 0 0.5; 0 0];
goalTolerance=0.1;
angTolerance = 0.1;
%% controller variables
KpA = .35;
KiA = 1/3000;
KdA = 1.5;
oldAngError = 0;
angularI = 0;
KpL = 0.35;
KiL = 3; 
linearI = 0;
%% initialize new ROS 
rosshutdown;
URI = 'http://localhost:11311/';

% iniatilize nodes and ROS
%% initialize ROS
rosinit(URI);

%initialize publisher for cmdvel, twist
velPub = rospublisher('/cmd_vel','geometry_msgs/Twist');
velMsg = rosmessage(velPub);

% initilize subscriber for scan topic, laser messages 
laserSub = rossubscriber('/scan','sensor_msgs/LaserScan');

% initialize subscriber for pose 
poseSub = rossubscriber('/odom','nav_msgs/Odometry');

%% initial state 
% get initial position
currentPoseBodyFrame = getWorldCurrentPose(poseSub);
x = currentPoseBodyFrame(1);
y = currentPoseBodyFrame(2);
theta = currentPoseBodyFrame(3);

% waypoint heading
for i = 1:length(waypoints)
    dist2waypoint = norm( [x y]- waypoints(i,:)) ;
    while dist2waypoint > goalTolerance
        %% get current pose
        currentPoseBodyFrame = getWorldCurrentPose(poseSub);
        x = currentPoseBodyFrame(1);
        y = currentPoseBodyFrame(2);
        theta = currentPoseBodyFrame(3);
        % get heading 
        theta_goal = calculateHeading(currentPoseBodyFrame,waypoints(i,:));
        dist2waypoint = norm( [x y]- waypoints(i,:)) ;

        % angular control
        angError = atan2(sin(theta_goal - theta),cos(theta_goal-theta));
        angP = KpA*angError;
        angD = KdA*(angError - oldAngError);
        oldAngError = angError;
        angularI = KiA*angError + angularI;
        w = angP + angularI + angD;
        velMsg.Angular.Z = w;
        %
        % linear Control
        linError = dist2waypoint;
        linP = KpA*linError;
        linearI = KiA*linError + linearI;
        v = linP + linearI;
        velMsg.Linear.X= v;
        %steer first model
        if abs(angError) > angTolerance
            velMsg.Linear.X = .65*v;
            velMsg.Angular.Z = 3*w;
        end
        send(velPub,velMsg);
       
    end

end
velMsg.Linear.X = 0;
velMsg.Angular.Y = 0;
send(velPub,velMsg);
pause(1)
end
disp('complete')
