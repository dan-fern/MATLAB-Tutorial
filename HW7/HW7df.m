%%% HW7.m
%%% Daniel Fernández
%%% 19 November 2013
%%% HW7.m is broken into two parts.  Block 7.1 reads in a file of tide
%%% elevation and plots it over 5 years.  It also uses a line fitting
%%% function to determine amplitude and phase parameters from given NOAA
%%% values.  The difference between the two is then plotted.  Block 7.2
%%% uses a law of boundary layer flow for a known pressure gradient.  Using
%%% similar logic as in Block 7.1.2, a fitted line is then compared to the
%%% given data.
clear all
close all
home
%%  Block 7.1.1 - Reads in Data and plots Elevation per Year
list = dir('*.txt');
data = [];
figureHandle = figure('Position',[25,55,1200,900]); % bigger plot figure
for j = 1:length(list)
    fid = fopen(list(j).name);
    headers = textscan(fid,'%s%s%11c%s%s%s',1); % headers not used
    temp = textscan(fid,'%s%s%f%f%f%f'); % temp data in a string array
    fclose(fid);
    dated = strcat(temp{1},'/',temp{2}); % concatenates date numbers
    date = datenum(dated,'mm/dd/yy/HH:MM'); % date values in double format
    yeardata = horzcat(date,temp{3}); 
    data = vertcat(data,yeardata); % adds all data through loop on top
    figure(1);
    hold on
    subplot(5,1,j); % plots the year vs date
    plot(yeardata(:,1),yeardata(:,2));
    set(gca,'XTick',date); datetick('x', 'mmm'); ylabel('Elevation, m');
    axis tight;  
    hold off
    title(['Tide Elevation at South Beach, OR: ',datestr(date(1),10)]);
end
%%  Block 7.1.2 - Fits Data to a Curve Fit for Unknown Parameters
%   1	M2	0.902	231.1	28.9841042	Principal lunar semidiurnal constituent
%   2	S2	0.244	258.6	30.0    	Principal solar semidiurnal constituent
%   3	N2	0.187	207.2	28.4397295	Larger lunar elliptic semidiurnal constituent
%   4	K1	0.443	237.7	15.0410686	Lunar diurnal constituent
%   6	O1	0.269	221.0	13.9430356	Lunar diurnal constituent
%   22	SA	0.123	281.6	0.0410686	Solar annual constituent
%   30	P1	0.137	234.2	14.9589314	Solar diurnal constituent
con = {'M2'; 'S2'; 'N2'; 'K1'; 'O1'; 'SA'; 'P1'}; % constituent names
amp = [0.902;0.244;0.187;0.443;0.269;0.123;0.137]; Amp = zeros(7,1); 
phi = [231.1;258.6;207.2;237.7;221.0;281.6;234.2]; Phi = zeros(7,1);
cel = [28.98;30.00;28.44;15.04;13.94;0.041;14.96]; cel = cel * 2*pi / 360; 
x = data(1:26304,1); y = data(1:26304,2); t = (1:length(x))';
%   known values and initialized matrices
f=@(C,t) C(1) * cos(cel(1) * t + C(2))... 
       + C(3) * cos(cel(2) * t + C(4)) + C(5) * cos(cel(3) * t + C(6))...
       + C(7) * cos(cel(4) * t + C(8)) + C(9) * cos(cel(5) * t + C(10))...
       + C(11) * cos(cel(6) * t + C(12)) + C(13) * cos(cel(7) * t + C(14));
%   anonymous function   
N = nlinfit(t, y, f, [1,1,1,1,1,1,1,1,1,1,1,1,1,1]);
%   populates a matrix N with curve fitted unknowns
yFit = N(1) * cos(cel(1) * t + N(2))... 
     + N(3) * cos(cel(2) * t + N(4)) + N(5) * cos(cel(3) * t + N(6))...
     + N(7) * cos(cel(4) * t + N(8)) + N(9) * cos(cel(5) * t + N(10))...
     + N(11) * cos(cel(6) * t + N(12)) + N(13) * cos(cel(7) * t + N(14));
%   creates a y function with fitted parameters 
for j = 1:length(con)
    Amp(j) = N(2*j-1);
    Phi(j) = N(2*j)* 360 / 2 / pi; % populates the Fitted Amp and Phi
end

ampDiff = Amp - amp; phiDiff = Phi - phi; % populates difference
disp(table(Amp,amp,ampDiff,'RowNames',con));
disp(table(Phi,phi,phiDiff,'RowNames',con));
%   shows the differences between the two
figure(2);
plot(data(1:3625,1),data(1:3625,2),'r-')
hold on
plot(x(1:3625),yFit(1:3625),'b-');
legend('Data','Model','Location','SouthEast'); datetick('x','mmm');
title('Fitted Tide Elevation South Beach, OR: Jan - May 1971')
ylabel('Elevation, m'); xlabel('Month'); axis tight

%%  Block 7.2.1 - Cole's Law of the Wake
clear all
close all
home

K = 0.4;
B = 5;    
v = 1e-6; 
%   constants
fid = fopen('fr3_crest_data.dat'); 
fgetl(fid); fgetl(fid); fgetl(fid);
data = cell2mat(textscan(fid,'%f%f%*f%*f'));    
u = data(:,1); y = data(:,2);
fclose(fid);
%   populates data matrices 
%   u / uS == 1 / K * ln(y * uS / v) + B + (2 * Pi / K) * f
%   f == 3 * eta^.2 - 2 * eta^.3
%   eta == y / del;
%   unknown uS, Pi, del; use resolved Cole's Law
g = @(C,y) ((1 / K) * log(y * C(1) / v) + B + (2 * C(2) / K) ...
          * 3 * (y / C(3)).^2 - 2 * (y / C(3)).^3) * C(1);
%   sets up anonymous function
N = nlinfit(y, u, g, [1 1 1]);
%   line fitted data matix N populated
yFit = ((1 / K) * log(y * N(1) / v) + B + (2 * N(2) / K) ...
       * 3 * (y / N(3)).^2 - 2 * (y / N(3)).^3) * N(1);
%   fitted line with estimated parameters
figure(3);
plot(u,y,'b+'); hold on; plot(yFit,y,'r-');
legend('Data','Model','Location','SouthEast'); axis tight; 
title('Fitted Hydraulic Jump Model using Cole''s Law of the Wake')
xlabel('Streamwise Velocity, cm/s'); ylabel('Vertical Coordinate, cm')