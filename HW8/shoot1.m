function output = shoot1(in,y1i,y1f);

x1 = 0;
x2 = pi / 2;
[X,Y] = ode45('shoot2',[x1 x2],[y1i in]);
siz = size(Y);
output = abs(y1f - Y(siz(1),1));
end