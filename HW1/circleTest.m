%% intiate radius variables
r1 = 1;
r2 = 2;
r3 = 8;
r4 = 20;
%% compute circumference
C1 = 2 * pi * r1
C2 = 2 * pi * r2
C3 = 2 * pi * r3
C4 = 2 * pi * r4
%% compute area
A1 = pi * r1 ^ 2
A2 = pi * r2 ^ 2
A3 = pi * r3 ^ 2
A4 = pi * r4 ^ 2
%% plot radius vs circumference
%% could not figure out increase MarkerSize command, used 'marker','.' instead
figure(1)
plot(r1,C1,r2,C2,r3,C3,r4,C4,'Marker','.')
axis([1 24 0 150])
set(gca,'YTick',[0 25 50 75 100 125 150])
xlabel('Radius')
ylabel('Circumference')
grid on
% plot radius vs Area
figure(2)
plot(r1,A1,r2,A2,r3,A3,r4,A4,'Marker','.')
axis([1 24 0 1500])
set(gca,'YTick',[0 250 500 750 1000 1250 1500])
xlabel('Radius')
ylabel('Area')
grid on