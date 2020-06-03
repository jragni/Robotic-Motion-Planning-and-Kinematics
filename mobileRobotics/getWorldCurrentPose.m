function [xytheta] = getCurrentWorldPose(poseSub)
%GETCURRENTPOSE outputs the x,y,theta pose from odometry node
%   Author: Jhensen Ray Agni


poseMsg = receive(poseSub);
xPosition = poseMsg.Pose.Pose.Position.X;
yPosition = poseMsg.Pose.Pose.Position.Y;
xy=[xPosition, yPosition];
x_quat = poseMsg.Pose.Pose.Orientation.X;
y_quat = poseMsg.Pose.Pose.Orientation.Y;
z_quat = poseMsg.Pose.Pose.Orientation.Z;
w_quat = poseMsg.Pose.Pose.Orientation.W;
eul = quat2eul([x_quat,y_quat,z_quat,w_quat]);
yaw = eul(3);
poseMsg.Pose.Pose.Orientation.Z;
xytheta = [xy,yaw];
end

