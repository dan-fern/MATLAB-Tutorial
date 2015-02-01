function output = shoot2(x,in)

y1 = in(1);
y2 = in(2);
output(1,1) = y2;
output(2,1) = 2 * exp(-x) - y1;
end