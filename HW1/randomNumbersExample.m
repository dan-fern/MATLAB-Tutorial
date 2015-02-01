%% initialize 5 Arrays and respective mins, means, stddev, and max
A1 = randn(10,8);
min1 = min(A1)
mean1 = mean(A1)
stddev1 = std(A1)
max1 = max(A1)
A2 = randn(10,8);
min2 = min(A2)
mean2 = mean(A2)
stddev2 = std(A2)
max2 = max(A2)
A3 = randn(10,8);
min3 = min(A3)
mean3 = mean(A3)
stddev3 = std(A3)
max3 = max(A3)
A4 = randn(10,8);
min4 = min(A4)
mean4 = mean(A4)
stddev4 = std(A4)
max4 = max(A4)
A5 = randn(10,8);
min5 = min(A5)
mean5 = mean(A5)
stddev5 = std(A5)
max5 = max(A5)
figure(1)
%% sets as plot in upper left quadrant
subplot(2,2,1)
%% plots all min values in appropriate columns as y-values using 1-8 as x-values.
plot(1,min1(1),1,min2(1),1,min3(1),1,min4(1),1,min5(1),2,min1(2),2,min2(2),2,min3(2),2,min4(2),2,min5(2),3,min1(3),3,min2(3),3,min3(3),3,min4(3),3,min5(3),4,min1(4),4,min2(4),4,min3(4),4,min4(4),4,min5(4),5,min1(5),5,min2(5),5,min3(5),5,min4(5),5,min5(5),6,min1(6),6,min2(6),6,min3(6),6,min4(6),6,min5(6),7,min1(7),7,min2(7),7,min3(7),7,min4(7),7,min5(7),8,min1(8),8,min2(8),8,min3(8),8,min4(8),8,min5(8),'Marker','+');
%% formatting
title('minimum statistics')
axis([0 9 -5 5])
grid on
set(gca,'XTick',[0 2 4 6 8])
set(gca,'YTick',[-5 0 5])
%% same as above for mean statistics
subplot(2,2,2)
plot(1,mean1(1),1,mean2(1),1,mean3(1),1,mean4(1),1,mean5(1),2,mean1(2),2,mean2(2),2,mean3(2),2,mean4(2),2,mean5(2),3,mean1(3),3,mean2(3),3,mean3(3),3,mean4(3),3,mean5(3),4,mean1(4),4,mean2(4),4,mean3(4),4,mean4(4),4,mean5(4),5,mean1(5),5,mean2(5),5,mean3(5),5,mean4(5),5,mean5(5),6,mean1(6),6,mean2(6),6,mean3(6),6,mean4(6),6,mean5(6),7,mean1(7),7,mean2(7),7,mean3(7),7,mean4(7),7,mean5(7),8,mean1(8),8,mean2(8),8,mean3(8),8,mean4(8),8,mean5(8),'Marker','+');
title('mean statistics')
axis([0 9 -5 5])
grid on
set(gca,'XTick',[0 2 4 6 8])
set(gca,'YTick',[-5 0 5])
%% same as above for stddev statistics
subplot(2,2,3)
plot(1,stddev1(1),1,stddev2(1),1,stddev3(1),1,stddev4(1),1,stddev5(1),2,stddev1(2),2,stddev2(2),2,stddev3(2),2,stddev4(2),2,stddev5(2),3,stddev1(3),3,stddev2(3),3,stddev3(3),3,stddev4(3),3,stddev5(3),4,stddev1(4),4,stddev2(4),4,stddev3(4),4,stddev4(4),4,stddev5(4),5,stddev1(5),5,stddev2(5),5,stddev3(5),5,stddev4(5),5,stddev5(5),6,stddev1(6),6,stddev2(6),6,stddev3(6),6,stddev4(6),6,stddev5(6),7,stddev1(7),7,stddev2(7),7,stddev3(7),7,stddev4(7),7,stddev5(7),8,stddev1(8),8,stddev2(8),8,stddev3(8),8,stddev4(8),8,stddev5(8),'Marker','+');
title('standard deviation statistics')
axis([0 9 -5 5])
grid on
set(gca,'XTick',[0 2 4 6 8])
set(gca,'YTick',[-5 0 5])
%% same as above for max statistics
subplot(2,2,4)
plot(1,max1(1),1,max2(1),1,max3(1),1,max4(1),1,max5(1),2,max1(2),2,max2(2),2,max3(2),2,max4(2),2,max5(2),3,max1(3),3,max2(3),3,max3(3),3,max4(3),3,max5(3),4,max1(4),4,max2(4),4,max3(4),4,max4(4),4,max5(4),5,max1(5),5,max2(5),5,max3(5),5,max4(5),5,max5(5),6,max1(6),6,max2(6),6,max3(6),6,max4(6),6,max5(6),7,max1(7),7,max2(7),7,max3(7),7,max4(7),7,max5(7),8,max1(8),8,max2(8),8,max3(8),8,max4(8),8,max5(8),'Marker','+');
title('maximum statistics')
axis([0 9 -5 5])
grid on
set(gca,'XTick',[0 2 4 6 8])
set(gca,'YTick',[-5 0 5])