function pendulum(t1, y1, t2, y2, l)
% visualizes the solutions of the simple pendulum ODE
% pendulum 1 is the linear case
% pendulum 2 is the nonlinear case

% Immanuel Maier, 29.11.2009

if(nargin < 5)
    l = 2;
end

figure();
% plot initial states
% pendulum 1
plot([0 l*sin(y1(1,1))],[0 -l*cos(y1(1,1))],'b-','LineWidth',2);
hold on;
plot(l*sin(y1(1,1)),-l*cos(y1(1,1)),'b.','MarkerSize',30);

% pendulum 2
plot([0 l*sin(y2(1,1))],[-3 -3-l*cos(y2(1,1))],'r-','LineWidth',2);
plot(l*sin(y2(1,1)),-3-l*cos(y2(1,1)),'r.','Markersize',30);
axis([-3 3 -6 0]);

pause;
hold off;
% plot the intermediate states
for i = 1:min([length(t1) length(t2)])
    % pendulum 1
    plot([0 l*sin(y1(i,1))],[0 -l*cos(y1(i,1))],'b-','LineWidth',2);
    hold on;
    plot(l*sin(y1(i,1)),-l*cos(y1(i,1)),'b.','MarkerSize',30);
    % pendulum 2
    plot([0 l*sin(y2(i,1))],[-3 -3-l*cos(y2(i,1))],'r-','LineWidth',2);
    plot(l*sin(y2(i,1)),-3-l*cos(y2(i,1)),'r.','MarkerSize',30); 
    axis([-3 3 -6 0]);
    
    pause(0.02);
    hold off;
end

    