%This function makes it so that the temperature of the surrounding are
%monitored by reading voltage values which are then converted to
%temperature valuesand depending on these temperature values the LED lights
%will light up if the temperature has satisifed a certain condition. Then
%the function plots a graph of tempeature and constantly updates it each
%second which provides a live graph.

function  temp_monitor(a)
% Assign arduino digital pins for LEDS
Green_LED = 'D11';
yellow_LED = 'D10';
red_LED = 'D12';

%Creates empty arrays to be able to store temp and time data
temp_data =[];
time_data =[];

t = 0;
start_Time = tic;

loop = true; % allows the loop
figure % Creates the figures for live plottings
while loop==true
    Voltage = readVoltage(a,"A0"); 
    temp = (Voltage-0.5)/0.01;
%Both time and temperature values become arrays
    time_data = [time_data,t]; 
    temp_data= [temp_data,temp];

    %Plotting graph
  
    plot(time_data,temp_data);
    xlabel('Time (s)');
    ylabel('Temperature (°C)');
    title('Capsule Temperature Monitoring')
    grid on;
    drawnow; %Makes an immediate plot update

    if temp>=18 && temp<=24 % Temperature for 
       writeDigitalPin(a, Green_LED, 1)
        writeDigitalPin(a, yellow_LED, 0);
        writeDigitalPin(a, red_LED, 0);
    elseif temp < 18
        writeDigitalPin(a, Green_LED, 0);
        writeDigitalPin(a, red_LED, 0);
        writeDigitalPin(a,yellow_LED, 1);
        pause(0.5);
        writeDigitalPin(a,yellow_LED,0)
        pause(0.5)
    else
        writeDigitalPin(a, Green_LED, 0);
        writeDigitalPin(a, yellow_LED, 0);
        writeDigitalPin(a, red_LED, 1);
        pause(0.25)
        writeDigitalPin(a,red_LED,0)
        pause(0.25)
    end

    t = t + 1; % Increment time
end