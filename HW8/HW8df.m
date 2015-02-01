%%% HW8.m
%%% Daniel Fernández
%%% 26 November 2013
%%% HW8.m computes several differential equations and plots requested data.
%%% In block 8.1, the equations of motion are used to plot the trajectory
%%% of an unknown mass with various drag constants.  In Block 8.2, a
%%% similar analysis is made for a standard oscillating pendulum and a plot
%%% is then displayed.  
clear all
close all
home

%%  Block 8.1 - Equations of Motion used to plot Projectile Path with Drag
clear all
close all
home

iAngle = 40;  % projecting launch angle (degrees)
iSpeed = 180; % projectile starting velocity (m/s)
g = 9.81;     % gravitation constant (m/s^2)
IC = [0 0 iSpeed*cosd(iAngle) iSpeed*sind(iAngle)];
%   starting x-position, y-position, initial x-velocity, and y-velocity
gamma = [0,0.1,0.2,0.3];
distance = [0 25];
figureHandle = figure('Position',[125,155,800,600]);
col = [1,0,0;0,1,0;0,0,1];
f = @(t,y) [y(3); y(4); -gamma(1)*sqrt(y(3)^2+y(4)^2)*y(3); 
            -gamma(1)*sqrt(y(3)^2+y(4)^2)*y(4)-g];  % governing equation
[t,y] = ode45(f,distance,IC); % gives trajectory vectors
subplot(2,1,1)
plot(y(:,1),y(:,2),'-r'); ylabel('Height, m'); xlabel('Distance, m');
title('Projectile Trajectory with No Drag'); 
axis([0 max(y(:,1)) 0 max(y(:,2))+1]); 
for i = 2:length(gamma);
    f = @(t,y) [y(3); y(4); 
        -gamma(i)*sqrt(y(3)^2+y(4)^2)*y(3); 
        -gamma(i)*sqrt(y(3)^2+y(4)^2)*y(4)-g];  % governing equation
    [t,y] = ode45(f,distance,IC); % gives trajectory vectors
    subplot(2,1,2)
    plot(y(:,1),y(:,2),'color',col(:,i-1));
    title('Projectile Trajectory with Variable Drag');
    ylabel('Height, m'); xlabel('Distance, m');
    axis([0 35 0 20]);
    hold on
end
legend('0.1','0.2','0.3','Location','NorthEast');
%%  Block 8.2 - Pendulum Oscillation
clear all 
close all
home

%y1' = y2
%y2' = -w*sin(theta)

displacement = [0.1 0.25 0.4]; % initial displacement in radians
l = 4.9;                       % pendulum length in meters
g = 9.81; 
w = sqrt(l * g);               % omega value
z = 2 * pi / w;
t = [0 z];                     % range
col = [1,0,0;0,1,0;0,0,1];
figureHandle = figure('Position',[125,155,800,600]);
for i=1:length(displacement)
    IC = [displacement(i) 0];
    f = @(disp,y) [y(2); -w^2*sin(y(1))];  % governing equation
    [t,y] = ode45(f,t,IC);
    plot(t,y(:,1),'color',col(:,i))
    title('Pendulum Oscillation'); xlabel('Time, s'); ylabel('Position')
    axis([0 .9 -.5 .5]);  
    hold on
end
legend('0.10','0.25','0.40','Location','SouthEast');

%%  Block 8.3 - Boundary Value Problem with Missing IC and Relaxation

%   ERROR....  for whatever reason, my 'size' function in the shoot1.m file
%   stopped working.  It was producing charts and then stopped this
%   morning.  I have attempted troubleshooting but with no luck.  The code
%   worked and then stopped for whatever reason.  sigh... matlab...
%   Therefore, I have no attached figures.  

%y''+y = 2e^(-x)   y(0) = 0   y(pi/2) = 0
%y = -e^(-pi/2)*sin(x) - cos(x) + e^(-x)

x1 = 0; x2 = pi/2;
x = linspace(x1,x2,1000);
y1i = 0; y1f = 0;
y2guess = [-10 10]; %range of values
y2i = fminbnd('shoot1',y2guess(1),y2guess(2),[],y1i,y1f);
[X,Y] = ode45('shoot2',[x1 x2],[y1i y2i]);
yTrue = -exp(-pi/2) * sin(x) - cos(x) + exp(-x);

figure(4)
subplot(2,1,1)
plot(x,yTrue,'-r');
hold on
plot(X,Y(:,1),'ob');
axis tight

% Relaxation....... y'' + y = 0;   y(0) = 0; y(pi/2) = 0 
% compare to above general form; P = 0, Q = 1, F = 2e^-x
% [1 - dx/2 * P_(n)]y_(n-1) + [-2 + dx^2 * Q_(n)]y_(n) + [1 + dx/2 *
% P_(n)]y_(n+1) = dx^2 * F_(n)
% Since P, Q constant we find:
% y_(n-1) + (-2 + dx^2)y_(n) + y_(n+1) = dx^2Fn.
% Ay = b --> matrix system of equations

A = zeros(9,9);
x = linspace(x1,x2,11); 
dx = x(1) - x(2);
d = -2 + dx^2;
for i = 2:9
    A(i,i-1:i+1) = [1 d 1];
end
A(1,1) = d; A(1,2) = 1; A(:,10)=[];
b = [dx^2. * 2 * exp(-x(2:length(x)-1))]';
y = A \ b;
y1 = [0; y; 0];
y2 = -exp(-pi/2) * sin(x) - cos(x) + exp(-x);

figure(4)
subplot(2,1,2)
plot(x,y2,'-r');
hold on
plot(x,y1,'ob');
axis tight