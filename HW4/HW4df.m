%%% HW4.m
%%% Daniel Fernández
%%% 29 October 2013
%%% HW4.m is broken into four parts.  Block 4.1 creates a timesheet for a
%%% simulated group of paid grad students.  It does not use any loops.
%%% Block 4.2 does the same task but with for and switch loops.  Block 4.2
%%% is not built as a standalone.  Block 4.3 examines the probability of a
%%% group of 23 random people having a shared birthday amongst them.  It
%%% iterates over 10000 trials.  Block 4.4 extends the logic further by
%%% plotting the likelihood of shared birthdays among a group of random
%%% people as the size of that group grows.  Calculation time for Block 4.4
%%% is considerable.
clear all
close all
home
%%  Block 4.1 - simulated timesheet without any loops
firstDate = datenum('11-01-2005'); lastDate = datenum('11-30-2005');
days =  linspace(firstDate,lastDate,eomday(2005,11));
hours = ceil(randi(16,30,3));
[dayNum,dayName] = weekday(days);
dayOfWeek = reshape(dayNum,eomday(2005,11),1);
timesheet = [dayOfWeek hours];
%   creates a 30 x 4 matrix with days of weeks and hours worked
weekends = find(dayOfWeek==1 | dayOfWeek==7);
weekdays = find(dayOfWeek~=1 & dayOfWeek~=7);
%   these two column vectors are created to pass to the timesheet
format BANK
frankPay = 5 * (sum(timesheet(weekdays, 2)) + 1.5 * sum(timesheet(weekends, 2)))
annePay = 7.5 * (sum(timesheet(weekdays, 3)) + 1.5 * sum(timesheet(weekends, 3)))
robPay = 15 * (sum(timesheet(weekdays, 4)) + 1.5 * sum(timesheet(weekends, 4)))
%   pay = pay rate * (sum of weekday hours + (1.5 * sum of weekend hours))
%%  Block 4.2 - simulated timesheet using for and switch loops
payFrank = 0;
payAnne = 0;
payRob = 0;
%   I initially had the setup matrices from  4.1 because I prefer blocks to 
%   function as standalone sets of code, but I decided against 
%   re-initializing variables so that the difference in values between 
%   Block 4.1 and 4.2 can be noticed.
for k = 1:eomday(2005,11)
    switch timesheet(k,1)
        case {1,7}
            payFrank = timesheet(k,2)* 5 * 1.5 + payFrank;
            payAnne = timesheet(k,3)* 7.5 * 1.5 + payAnne;
            payRob = timesheet(k,4)* 15 * 1.5 + payRob;
        case {2,3,4,5,6}
            payFrank = timesheet(k,2)* 5 + payFrank;
            payAnne = timesheet(k,3)* 7.5 + payAnne;
            payRob = timesheet(k,4)* 15 + payRob;
    end
end
%   creates two cases where a sum is added depending on day of week
payFrank
payAnne
payRob
%%  BREAK - to clear unneeded variables.  skip as required.
clear all
close all
home
%%  Block 4.3 - probability of duplicate birthdays among 23 random people
people = 23; 
trials = 10000; 
match = 0;
bdays = ceil(randi(365,people,trials));
for j = 1:trials 
    if numel(bdays(:,j)) - numel(unique(bdays(:,j))) > 0 
        match = match + 1; 
    end 
end 
%   loop finds any matching values by subtracting unique values out and 
%   increasing an iterative counter
percent = 100 - 100*(match / trials);
xxx = num2str(percent);
disp(strcat('Percentage of trials with no duplicates is:', ' ', xxx, '%.'));
disp('This is about half.');
%% Block 4.4 - Duplicate birthday probability for 10 - 50 random people
people2 = 10:1:50;
percent2 = zeros(1,size(people2,2));
trials = 10000; 
for n = 10:50
    match = 0;
    bdays = ceil(randi(365,n,trials));
     for j = 1:trials 
        if numel(bdays(:,j))-numel(unique(bdays(:,j))) > 0 
            match = match + 1; 
        end 
    end
    percent2(1,n) = 100 * (match / trials); 
end
%   loop uses similar logic from Block 4.3 except adds another for loop to
%   iterate 10000 trials over cases with 10 to 50 random people.
%   computation time is considerable.
xxx = num2str(min(find(percent2>=95)));
disp('Number of people for 95% Probability of Matching Birthdays is:')
disp(xxx) 
%   displays # of people to achieve a 95% probability.
x = 1:50;
figure(1)
plot(x,percent2)
title('Probability of a Duplicate Birthday in a Group of Random People');
xlabel('Number of Random People');
ylabel('Percent Likelihood');
grid ('on');
xlim([10 50]);