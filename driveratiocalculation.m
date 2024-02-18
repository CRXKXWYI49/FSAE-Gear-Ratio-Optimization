clc, clearvars, close all

accelerationtest = readtable('accelerationtest.csv');
germany2012 = readtable('germany2012.csv');
nebraska2013 = readtable('nebraska2013.csv');
michigan2012 = readtable('michigan2012.csv');

atest = accelerationtest{6,2:end}
g2012 = germany2012{6,2:end}
n2013 = nebraska2013{6,2:end}
m2012 = michigan2012{6,2:end}

atestweight = 0.2
enduranceweight = 0.8

driveratio = linspace(0.9,7,21)

endurancetest = (g2012+n2013+m2012)/3;

endurancetest = (endurancetest - min(endurancetest))/(max(endurancetest)-min(endurancetest));
atest = (atest - min(atest))/(max(atest)-min(atest));

score = atest*atestweight + endurancetest*enduranceweight

subplot(1,3,1)
plot(driveratio,score)
title('Score vs Driveratio')
subplot(1,3,2)
plot(driveratio,atest)
title('Acceleration Time vs Driveratio') 
subplot(1,3,3)
plot(driveratio,endurancetest)
title('Endurance Lap Time vs Driveratio')

% Generate high-resolution dataset
x_interp = linspace(driveratio(1), driveratio(end), 10000);
y_interp = spline(driveratio, score, x_interp);

% Find the minimum value and its index
[min_value, min_index] = min(y_interp);


% Plot original and interpolated data
figure;
plot(driveratio, score, 'ro', 'MarkerSize', 8); % Original data points
hold on;
plot(x_interp, y_interp, 'b-', 'LineWidth', 1.5); % Interpolated data
legend('Original Data', 'Interpolated Data');
xlabel('driveratio');
ylabel('score');
title('Driveratio vs Score');


[m,i] = min(y_interp);
driveratio = x_interp(i)



