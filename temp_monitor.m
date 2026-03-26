function  temp_monitor(a)

Green_LED = 'D11';
yellow_LED = 'D10';
red_LED = 'D12';

%Creates empty arrays to be able to store temp and time data
temp_data =[];
time_data =[];

t = 0;
start_Time = tic;

loop = true;
figure
while loop==true
    Voltage = readVoltage(a,"A0");
    temp = (Voltage-0.5)/0.01;

    time_data = [time_data,t];
    temp_data= [temp_data,temp];

    %Plotting graph
  
    plot(time_data,temp_data);
    xlabel('Time (s)');
    ylabel('Temperature (°C)');
    title('Capsule Temperature Monitoring')
    grid on;
    drawnow;

    if temp>=18 && temp<=24
       writeDigitalPin(a, Green_LED, 1)
        writeDigitalPin(a, yellow_LED, 0);
        writeDigitalPin(a, red_LED, 0);
    elseif temp < 18
        writeDigitalPin(a, Green_LED, 0);
        writeDigitalPin(a, yellow_LED, 1);
        writeDigitalPin(a, red_LED, 0);
    else
        writeDigitalPin(a, Green_LED, 0);
        writeDigitalPin(a, yellow_LED, 0);
        writeDigitalPin(a, red_LED, 1);
    end

    t = t + 1; % Increment time
end
