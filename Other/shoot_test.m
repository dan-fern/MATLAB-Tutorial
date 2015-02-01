function out=shoot_test(in,y1i,y1f);

x1 = 0;
x2 = pi / 2;
[X,Y] = ode45('shoot_test_2',[x1 x2],[y1i in]);
size = size(Y);
out = abs(y1f - Y(size(1),1));