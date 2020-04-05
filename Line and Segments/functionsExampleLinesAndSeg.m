%% 
% Author: JhensenSoft
% github: github.com/jragni

clc
clf
clear all

%% initialize points

point1 = [1, 1]; 
point2 = [-2, 5];
q = [5, 6]; 


%% Find the general equation for line made by point1 and point2

[A,B,C]=computeLineThroughTwoPoints(point1,point2);

%% Find the Distance between point q and line the line made by point1& point2
distance = computeDistancePoint2Line(q,point1,point2)

%% Find the Distance between point q to the line segment made by point1 
% & point2
[distance2Segment,mode] = computeDistancePoint2Segment(q,point1,point2)
%% plot points 
plot(point1(1),point1(2),'*')
axis([-10,10,-10,10])
hold on
plot(point2(1),point2(2),'*')
plot(q(1),q(2),'o')

ezplot(@(x,y) A*x+B*y+C,[point1(1),point2(1)],[point1(2),point2(2)])




