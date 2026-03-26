% Oraibi George-Gudi
% Efyog1@nottingham.ac.uk

%% Prelimanry Task 
clear

a = arduino('COM9','Uno'); % This is to be able to create a arduino

%Creates a loop that makes LED blink for 10 seconds

for t= 1:10

writeDigitalPin(a,'d11',1) %This is to provide the connection with the arduino pin 
%with the LED while applying a 5V tension to the LED
pause(0.5) % Creates a 0.5 second interval after every blink
writeDigitalPin(a,'d11',0') % The connection between arduino pin and LED provide 0 Voltage
pause(0.5) 
end

%% Task 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

clear

a = arduino( 'COM9', 'Uno'); %This should be used for every new taks for arduino connection

duration = 600;
temp_data = zeros(1,duration);
time_data = zeros(1,duration);  
current_time = 0;
Tc = 0.01;
V0 = 0.5;

for t = 1:(duration)

    Voltage = readVoltage(a,"A0");
    %Temperature = (Voltage - zero drgee voltage)/temperature coefficient
    time_data(t) = current_time; % Stores the current time value
    temp_data(t) = (Voltage - V0) / Tc; % Calculate temperature and store
    current_time = current_time+1;
    pause(1) % waits a second for each loop interval
end

%Statistical quantities for min,max and average temperature

min_Temp = min(temp_data);
max_Temp = max(temp_data);
avg_Temp = mean(temp_data);

% Part c plotting temperature/time plot
figure;
plot(time_data,temp_data);
xlabel('Time (s)');
ylabel('Temperature (°C)');
title('Temperature vs Time');
grid on;

% Table 1 format

Startmessage = sprintf('Data logging initiated - 23/03/2026\n');
disp(Startmessage)
Location = sprintf('Location done - George green\n\n');
disp(Location)


for i = 1:(duration/60)
    % Calculate the index for the current minute
    index = i * 60 ; 
    fprintf('Second %-8d Temperature %-7.2f\r\n\n', index, temp_data(index));
end
Max = sprintf('Max temp - %.2f\n',max_Temp);
disp(Max)
Min = sprintf('Min temp - %.2f\n',min_Temp);
disp(Min)
Avg = sprintf('avg temp - %.2f\n',avg_Temp);
disp(Avg)


% Write temperature data to a log file
fileID = fopen('capsule_temperature.txt ', 'w');
fprintf(fileID, '%s\n,',Startmessage);
fprintf(fileID, '%s\n',Location);
for i = 1:(duration/60)
    index = i * 60 ;
     fprintf(fileID, 'Second %-8d %-17.2f\r\n', index, temp_data(index));
end
fprintf(fileID, '%s\n', Max);
fprintf(fileID, '%s\n', Min);
fprintf(fileID, '%s\n', Avg);
fprintf(fileID, 'Data logging terminated');
fclose(fileID);

%% Task 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMETATION

clear


 a = arduino('COM9','Uno');

 temp_monitor(a);


doc temp_monitor % Retrieves documentation from function


%% ALGORITHMS – TEMPERATURE PREDICTION [30 MARKS]

clear


 a = arduino('COM9','Uno');

 temp_monitor(a);


doc temp_monitor % Retrieves documentation from function
