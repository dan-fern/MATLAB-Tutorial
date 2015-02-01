function f = nonlin_ode(t, y, flag, g, l)
% computes the right side of the nonlinear ODE

if(nargin < 4)
    g = 9.81;
end
if(nargin < 5)
    l = 2;
end

f = [y(2); -g/l*sin(y(1))];
