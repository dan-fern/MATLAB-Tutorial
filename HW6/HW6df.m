%%% HW6.m
%%% Daniel Fernández
%%% 12 November 2013
%%% HW6.m is used to plot a figure of total precipitation in the state of 
%%% Oregon for 1983 and create a movie of precipitation per each month.
%%% The file reads in all .asc files and creates a 3-D matrix to store all
%%% the yearly data (where the 3rd dimension is the month).  It sets all
%%% values equaling -9999 to NaN before passing them into the graphics.
clear all
close all
home
%%  Block 6.1 - Setting up the 3-D Matrix of Precipitation Data
list = dir('*.asc');
data = zeros(229,407,12);
annual = zeros(229,407);   % for an annual sum per month
fid = fopen(list(6).name);
ncols = cell2mat(textscan(fid,'%*s%d16',1));
nrows = cell2mat(textscan(fid,'%*s%d16',1));
xll = cell2mat(textscan(fid,'%*s%f',1));
yll = cell2mat(textscan(fid,'%*s%f',1));
cell = cell2mat(textscan(fid,'%*s%f',1));
nanval = cell2mat(textscan(fid,'%*s%d16',1));
fclose(fid);
%   creates all the headers
for j = 1:length(list)
    fid = fopen(list(j).name);
    fgetl(fid); fgetl(fid); fgetl(fid); fgetl(fid); fgetl(fid); fgetl(fid);
    tempdata = reshape(cell2mat(textscan(fid,'%d16')),ncols,nrows)';
    data(:,:,j) = tempdata;
    fclose(fid);
end
data(data==nanval) = NaN;
%   populates data and resolves all NaN values
%%  Block 6.2 - Plots a Geographic Chart of Annual Precipitation in Oregon
annual = sum(data(:,:,:),3);
xAxis = linspace(xll,(xll+407*cell),407);
yAxis = linspace((yll+229*cell),yll,229)';
[X,Y] = meshgrid(xAxis,yAxis);
%   creates annual sums and the grid on which to populate data
figure(1)
contourf(X,Y,annual), shading flat, contourcbar;
title('Total Rainfall in Oregon, 1983');
xlabel('Latitude'), ylabel('Longitude');
ylabel(colorbar,'Rainfall, mm');
hold on;
contour(X,Y,annual,5,'k','LineWidth',1);
%%  Block 6.3 - Creates a Exportable Movie for Monthly Precipitation
mo = 1:1:12;
months = datestr(datenum(1983,mo,1),' mmmm');
datMax = max(data(:));
%   creates a monthly date vector and a maximum data value to be used
writerObj = VideoWriter('monthly_precip_OR_1983.avi');
writerObj.FrameRate = 1;
writerObj.Quality = 100;
open(writerObj);
for j = 1:length(list);
    figure(2);
    hold off
    pcolor(X,Y,(data(:,:,j))),shading flat, colorbar;
    hold on
    title('Monthly Rainfall in Oregon, 1983');
    xlabel(months(j,:)); set(gca,'XAxisLocation','top');
    ylabel(colorbar,'Rainfall, mm');
    set(gcf,'Renderer','zbuffer');
    set(gca,'xtick',[]);set(gca,'xticklabel',[]);
    set(gca,'ytick',[]);set(gca,'yticklabel',[]);
    caxis([0, datMax]);
    writeVideo(writerObj,getframe(gcf));
end
close(writerObj);