%%% HW3_1.m
%%% Daniel Fernández
%%% 22 October 2013
%%% HW3_1.m rewrites the statistics portion of HW1 using loops and 3-D 
%%% matrices.  It creates a random 10 x 8 x 5 matrix and passes values
%%% from it by way of a while loop.  The while loop populates four 5 x 8
%%% submatrices which return the minimum, mean, standard deviation, and
%%% maximum values from the original data set.
clear all
close all
home
%%  Block 3.1 - Review of Assignment 1
A = randn(10,8,5);
Min = zeros(5,8);
Mean = zeros(5,8);
StdDev = zeros(5,8);
Max = zeros(5,8);
%   Creates 4 separate 5 x 8 matrices which will be populated with the min,
%   mean, standard deviation, and max of the original data set, A.
figure(1)
i = 1;
while i <= 8
    j = 1;    
    while j <= 5
        Min(j,i) = min(A(:,i,j));
        Mean(j,i) = mean(A(:,i,j));
        StdDev(j,i) = std(A(:,i,j));
        Max(j,i) = max(A(:,i,j));
        j = j + 1;
    end
    i = i + 1;    
end
%   All data populated, now plots the data against a row vector, xAxis.
xAxis = (1:1:8);
subplot(2,2,1)
plot(xAxis,Min,'+');
title('minimum statistics')
axis([0 9 -5 5])
grid on
set(gca,'XTick',[0 2 4 6 8])
set(gca,'YTick',[-5 0 5])
subplot(2,2,2)
plot(xAxis,Mean,'+');
title('mean statistics')
axis([0 9 -5 5])
grid on
set(gca,'XTick',[0 2 4 6 8])
set(gca,'YTick',[-5 0 5])
subplot(2,2,3)
plot(xAxis,StdDev,'+');
title('standard deviation statistics')
axis([0 9 -5 5])
grid on
set(gca,'XTick',[0 2 4 6 8])
set(gca,'YTick',[-5 0 5])
subplot(2,2,4)
plot(xAxis,Max,'+');
title('maximum statistics')
axis([0 9 -5 5])
grid on
set(gca,'XTick',[0 2 4 6 8])
set(gca,'YTick',[-5 0 5])
%%  Block 3.2.temp - asdfjklaslkdfjasjkldf
sig = [.5;1;2;3];
a = [.1;.5;1;2];
c = [2;4;6;8];
Gauss = [sig,c,a];
x = 1:.1:20;
multGauss(x,Gauss);
%%  Block 3.4.1 - mean with old school programming
data = rand(10000,10);
tic
oldMean = (1:1:10);
for i=1:size(oldMean,2)
    sum = 0;
    for j=1:size(data,1)
        sum = data(j,i) + sum;
    end
    oldMean(1,i) = sum/size(data,1);
end
oldMean
toc
%%  Block 3.4.2 - variance with old school programming
tic
oldVar = (1:1:10);
meanVar = (1:1:10);
for i=1:size(meanVar,2)
    sum1 = 0;
    sum2 = 0;
    for j=1:size(data,1)
        sum1 = data(j,i) + sum1;
    end
    meanVar(1,i) = sum1/size(data,1);
    for k=1:size(data,1)
        sum2 = (data(k,i) - meanVar(1,i)).^2 + sum2;
    end
    oldVar(1,i) = sum2/size(data,1);
end
oldVar
toc
%%  Block 3.4.3 - standard deviation with old school programming
tic
oldSD = (1:1:10);
VarSD = (1:1:10);
meanSD = (1:1:10);
for i=1:size(meanSD,2)
    sum1 = 0;
    sum2 = 0;
    for j=1:size(data,1)
        sum1 = data(j,i) + sum1;
    end
    meanSD(1,i) = sum1/size(data,1);
    for k=1:size(data,1)
        sum2 = (data(k,i) - meanSD(1,i)).^2 + sum2;
    end
    VarSD(1,i) = sum2/size(data,1);
    oldSD(1,i) = sqrt(VarSD(1,i));
end
oldSD
toc
%%  Block 3.4.4 - all statistics with MATLAB functions
tic
newMean = mean(data)
toc
tic
newVar = var(data)
toc
tic
newSD = std(data)
toc
%%  Block 3.5.1 - Mean, Old School, sorting out values < 0.5
data = rand(10000,10);
tic
oldMean2 = (1:1:10);
for i=1:size(data,2)
    sum = 0;
    tick = size(data,1);
    for j=1:size(data,1)
        if data(j,i) > 0.5
            sum = data(j,i) + sum;
        else
            tick = tick - 1;
        end
    end
    oldMean2(1,i) = sum/tick;
end
oldMean2
toc
%%  Block 3.5.2 - Variance, Old School, sorting out values < 0.5
tic
oldVar2 = (1:1:10);
meanVar = (1:1:10);
for i=1:size(data,2)
    sum1 = 0;
    sum2 = 0;
    tick = size(data,1);
    for j=1:size(data,1)
        if data(j,i) > 0.5
            sum1 = data(j,i) + sum1;
        else
            tick = tick - 1;
        end
    end
    meanVar(1,i) = sum1/tick;
    for k=1:size(data,1)
        if data(k,i) > 0.5
            sum2 = (data(k,i) - meanVar(1,i)).^2 + sum2;
        else
        end
    end
    oldVar2(1,i) = sum2/tick;
end
oldVar2
toc
%%  Block 3.5.3 - Standard Deviation, Old School, sorting out values < 0.5
tic
oldSD2 = (1:1:10);
VarSD = (1:1:10);
meanSD = (1:1:10);
for i=1:size(data,2)
    sum1 = 0;
    sum2 = 0;
    tick = size(data,1);
    for j=1:size(data,1)
        if data(j,i) > 0.5
            sum1 = data(j,i) + sum1;
        else
            tick = tick - 1;
        end
    end
    meanSD(1,i) = sum1/tick;
    for k=1:size(data,1)
        if data(k,i) > 0.5
            sum2 = (data(k,i) - meanSD(1,i)).^2 + sum2;
        else
        end
    end
    VarSD(1,i) = sum2/tick;
    oldSD2(1,i) = sqrt(VarSD(1,i));
end
oldSD2
toc
%%  Block 3.5.4 - All statistics sorted appropriately using MATLAB code
tic
nans = find(data<0.5);
data(nans) = NaN;
newMean2 = nanmean(data)
newVar2 = nanvar(data)
newSD2 = nanstd(data)
toc