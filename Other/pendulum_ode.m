% pendulum_ode
% solves the ODE of the simple pendulum and its linearization
% ODE:  y(1)' = y(2)
%       y(2)' = -g/l * sin(y(1)
% solver: ode45

% Immanuel Maier, 29.11.2009


% initial displacement + time span
alpha = 0.7;
T = 20;

% solve ODE's
[t1,y1] = ode45('lin_ode', [0 T], [alpha 0]);
[t2,y2] = ode45('nonlin_ode', [0 T], [alpha 0]);

% plot the time evolution of the displacements
figure();
plot(t1, y1(:,1),'b-','LineWidth',2);
hold on
plot(t2, y2(:,1),'r-','LineWidth',2);
axis([0 T -1 1]);
set(gca,'FontSize',20);
title(['simple pendulum, alpha=' num2str(alpha)]);
legend('linear','nonlinear');
xlabel('time');
ylabel('displacement');
hold off

% start visualization of pendulums
pendulum(t1, y1, t2, y2);