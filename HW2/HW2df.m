%%% MontereyRainfall.m
%%% Daniel Fernández
%%% 15 October 2013
%%% MontereyRainfall.m loads rainfall data from Monterey, CA and plots
%%% several wanted statistics.  These include: a plot of monthly rainfall
%%% for the years of 1969 and 1976, a plot of average rainfall for the
%%% years 1969 - 1974 compared to average rainfall for 1975 - 1979, a
%%% plot of average rainfall per season, and computes the total rainfall
%%% per year.
%%  Block 2.1 - intiate and load data
clear all
close all
home
data = load('monterey.dat');
%%  Block 2.2 - plots monthly rainfall for 1969 and 1976
sixtyNine = data(1, 2:end);     % data for 1969
seventySix = data(8, 2:end);    % data for 1976
date1 = datenum('01-01-1969');
date2 = datenum('12-31-1969');
months = linspace(date1, date2, 12);
%   variable months forms basis of the x-axis by creating 12 iterations
%   between Jan 1 1969 and Dec 31 1969
figure(1)
plot(months, sixtyNine, '-bd', months, seventySix, '-rs', 'linewidth', 2, 'markerSize', 5, 'MarkerFaceColor','auto');
set(gca, 'XTick', months);
datetick('x', 'mmm', 'keepticks');
legend('1969', '1976');
xlabel('Month'); ylabel('Rainfall (mm)'); title('Rainfall per Month: 1969 and 1976, Monterey, CA');
%%  Block 2.3 - plots average rainfall for 1969 - 1974 and 1975 - 1979
first5 = data(1:6, 2:end);      % data for 1969 - 1974
last5 = data(7:11, 2:end);      % data for 1965 - 1969
mean1 = mean(first5);
mean2 = mean(last5);
%   computes means for each column of each set of years
figure(2)
plot(months, mean1, '-bd', months, mean2, '-rs', 'linewidth', 2, 'markerSize', 5, 'MarkerFaceColor','auto');
set(gca, 'XTick', months);
datetick('x', 'mmm', 'keepticks');
legend('1969-1974', '1975-1979');
xlabel('Month'); ylabel('Rainfall (mm)'); title('Average Monthly Rainfall: 1969-1974 and 1975-1979, Monterey, CA');
%%  Block 2.4 - average rainfall per season
seasons = {'Winter', 'Spring', 'Summer', 'Fall'};  % season string
winter = data(1:end,[13 2 3]);  % winter data (dec-feb)
spring = data(1:end,[4 5 6]);   % spring data (mar-may)
summer = data(1:end,[7 8 9]);   % summer data (jun-aug)
fall = data(1:end,[10 11 12]);  % fall data (sep-nov)
seasonMean = [mean(winter(:)), mean(spring(:)), mean(summer(:)), mean(fall(:))]
%   creates an array with 4 values of means per season
xxx = num2str(mean(seasonMean(:)),3);   % for the title
figure(3)
bar(seasonMean);
set(gca, 'XTicklabel', seasons);
ylabel('Rainfall (mm)'); xlabel('Season')
title(strcat('Rainfall by Season: total = ', xxx, ' mm, Monterey, CA'));
%   gives total mean in the title
%%  Block 2.5 - total rainfall per year (no plot)
years = data(1:end, 1);         
monthRain = data(1:end, 2:end); 
yearRain = sum(monthRain, 2);   % takes the sum of each row, or each year
sortedYears = sortrows([years yearRain], 2)
%   creates a 11 x 2 matrix which is sorted by rows in ascending order 
%   according to rainfall per year (2).  returns sorted matrix