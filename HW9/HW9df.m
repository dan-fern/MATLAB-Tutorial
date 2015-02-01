%%% HW9.m
%%% Daniel Fernández
%%% 3 December 2013
%%% HW9.m creates artificial wave data with a basic wave signal, a tidal
%%% signal, an infrgravity wave signal, and random noise all superimposed
%%% upon eachother.  then, it applies three separate buttersworth filters
%%% and plots each signal independently.

clc
home
clear all
close all

f1 = 0.1;
f2 = 0.005;
f3 = 1/45000;
% periods to frequencies
t = [1:0.5:604800];  % time vector
y = 0.5*sin(pi*f1*t) + 0.25*sin(pi*f2*t) + 1.5*sin(pi*f3*t); % create data 
y = y + 0.1 * (randn(size(y)) - 0.25); % noise

figureHandle = figure('Position',[125,155,800,600]);
figure(1)
subplot(4,1,1)
plot(t(1:180000),y(1:180000));
ylabel('Elevation, m'); title('Raw Data'); axis tight;
[B,A] = butter(2,[.05,.11]);
waves = filtfilt(B,A,y);
subplot(4,1,2)
plot(t(1:1000),waves(1:1000))
ylabel('Elevation, m'); title('Wave Signal Data'); axis tight;
[B,A] = butter(2,[.001,.01]);
infragrav = filtfilt(B,A,y);
subplot(4,1,3)
plot(t(1:20000),infragrav(1:20000))
ylabel('Elevation, m'); title('Infragravity Wave Data'); axis tight;
[B,A] = butter(2,[.000001,.0001]);
tides = filtfilt(B,A,y);
subplot(4,1,4)
plot(t(1:360000),tides(1:360000))
ylabel('Elevation, m'); xlabel('Time, seconds'); title('Tide Signal Data'); 
axis tight;
