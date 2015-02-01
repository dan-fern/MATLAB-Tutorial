%%% HW5.m
%%% Daniel Fernández
%%% 5 November 2013
%%% HW5.m is broken into three parts.  Block 5.1 creates imports buoy data 
%%% and plots air temperatures vs wave statistics. It also removes any
%%% unusable data.  Block 5.2 selects certain data from Block 5.1, formats
%%% it and outputs a .txt file (couldn't figure out ascii!!).  Block 5.3
%%% inputs a data chunk with many unusable data points, filters out the
%%% noise and plots data for monthly CPF data against temperature.  It also
%%% uses percentile information as a comparison.  
clear all
close all
home
%%  Block 5.1 - Import data and plot Air Temperature and Wave Statistics
fid = fopen('sep_2013_buoy_data.txt');
headers = textscan(fid,'%3c%2c%2c%2c%2c%4c%4c%3c%4c%3c%3c%3c%4c%4c%4c%4c%3c%4c',1);
units = textscan(fid,'%3c%2c%2c%2c%2c%4c%3c%3c%c%3c%3c%3c%3c%4c%4c%4c%3c%2c',1);
fclose(fid);
fid = fopen('sep_2013_buoy_data.txt');
fgetl(fid);
fgetl(fid);
fgetl(fid);
data = fscanf(fid,'%f');
data = reshape(data,18,713);
data = data';
fclose(fid);
%   imputs, creates headers, closes, reopens, removes lines, and reshapes a
%   matrix of usable data, and closes again.
for(j = 1:713)
    for(k = 1:18)
        if data(j,k) == 99 || data(j,k) == 999
           data(j,k) = NaN;
        end
    end
end
%   sets NaN values
sec = zeros(713,1);
time = datenum(data(:,1),data(:,2),data(:,3),data(:,4),data(:,5),sec);

figure (1)
plot(time,data(:,14))
datetick('x',6,'keepticks')
axis([time(1) time(end) 11 19])
xlabel('Dates in Sep 2013')
ylabel('Air Temperature (degC)')
title('Air Temperature Measurements for November 2013')
figure (2)
scatter(data(:,9),data(:,7),'.')
xlabel('Waveheight (m)')
ylabel('Wind Speed (m/s)')
title('Waveheight vs Wind Speed')
%%  Block 5.2 - Output data with averaged values per day
rig = [data(:,1:3) data(:,6:15)];
buoy = zeros(30,13);
counter = 0;
for j = 1:30  
    counter = 0;
    for k = 2:size(rig(:,1))
        if rig(k,3) == j
            counter = counter + 1;
            daily(k,:) = rig(k,1:13); 
        elseif rig(k,3) < j
            continue
        else
            buoy(j,:) = nanmean(daily((k-counter):k-1,:)); 
            break
        end
    end
end
buoy(j,:) = nanmean(daily((k-counter):k-1,:)); 
buoy(end,3) = 30;
%   populates a matrix of mean values per column.  
cols = [headers(1) headers(2) headers(3) headers(6) headers(7) headers(8) headers(9) headers(10) headers(11) headers(12) headers(13) headers(14) headers(15)];
buoy = buoy';
%   more matrix formating
fid=fopen('sep_2013_daily.txt','w');
fprintf(fid,'\r\n%7s%7s%7s%7s%7s%7s%7s%7s%7s%7s%7s%7s%7s',cols{:})
fprintf(fid,'\r\n%7.0f%7.0f%7.0f%7.0f%7.1f%7.1f%7.2f%7.2f%7.2f%7.0f%7.1f%7.1f%7.1f',buoy)
fclose(fid)
%   outputs a .txt file and couldn't figure out the .ascii format.
%%  Block 5.3 - January, July, Annual CPF compared
clear all
close all
home

fid = fopen('air_temp_distributions.txt');
fgetl(fid); fgetl(fid); fgetl(fid); fgetl(fid); fgetl(fid); 
fgetl(fid); fgetl(fid); fgetl(fid); fgetl(fid); fgetl(fid);
data1 = textscan(fid,'%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n',23,'treatAsEmpty',{'#','-','*'});
data2 = textscan(fid,'%s%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n',3,'treatAsEmpty',{'#','-','*'}); 
data3 = textscan(fid,'%s%n%n%n%n%n%n%n%n%n%n%n%n%n',10);
fclose(fid);
%  segregates data and creates percentile data
jan = [data1{3};data2{3}];     % january cpf
jul = [data1{15};data2{15}];   % july cpf
year = [data1{27};data2{27}];  % yearly cpf
temp = [data1{1};str2num(char(data2{1}))]; % changes negatives to numbers
bigData = [data3{2} data3{8} data3{14}]; % combine jan, july, and yearly pct

figure(3)
subplot(3,1,1)
plot(temp,jan,'-b')
hold on
plot(bigData(3,1),250,'xr')
hold on
plot(bigData(2,1),500,'xr')
hold on
plot(bigData(1,1),750,'xr')
title('January CPF vs Temperature')
axis([0 20 0 1000])
%xlabel('Temperature (degC)')
ylabel('January CPF')
subplot(3,1,2)
plot(temp,jul,'-b')
hold on
plot(bigData(3,2),250,'xr')
hold on
plot(bigData(2,2),500,'xr')
hold on
plot(bigData(1,2),750,'xr')
title('July CPF vs Temperature')
axis([0 20 0 1000])
%xlabel('Temperature (degC)')
ylabel('July CPF')
subplot(3,1,3)
plot(temp,year,'-b')
hold on
plot(bigData(3,3),250,'xr')
hold on
plot(bigData(2,3),500,'xr')
hold on
plot(bigData(1,3),750,'xr')
title('Annual CPF vs Temperature')
axis([0 20 0 1000])
xlabel('Temperature (degC)')
ylabel('Annual CPF')

%   On the charts, I removed the xlabel for the first two ones to make the
%   data look less cluttered.