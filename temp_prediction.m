%This function reads the votlage from the thermistor then calculates the
%rate in change of temperature , dependendent on that rate of change this
%function will check whether its too high, in range or too low which will
%cause an LED to light up respectively. The function also predcits the
%temperature in the next 5 minutes from the current temperature rate of
%change.

function  temp_prediction(a)

 %This is to assign my LEDs to my arduinos digital pin
Green_LED = 'D11';
yellow_LED = 'D10';
red_LED = 'D12';

prev_temp = []; % Stores the previous temperature reading
loop = true; %allowing loop to run
start_time = tic; %Timer starts for measuring elasped time during iterations

while loop==true

    voltage=readVoltage(a,'A0'); % Read voltage from analog pin A0
    temp = (voltage - 0.5)*100; % Equation turning voltage to temperature.

    if isempty(prev_temp) % At rate=0 nothing can be calculated
        rate = 0;
    else
        rate = (temp - prev_temp)/6;
    end
   
    prev_temp = temp; % Update previous temperature for the next iteration
predicted_temp = temp + (rate * 300);
elapsed = toc(start_time);
%Displaying readings and calculations
fprintf('Time: %.2f s\n', elapsed);
fprintf('Current Temperature: %.2f °C\n',  temp)
fprintf('Rate of Change: %.2f °C/min\n',rate);
fprintf('Predicted Temperature (5mins): %.2f °C\n', predicted_temp)

% Control LEDs based on temperature prediction
if rate > (4/60) %If statement for if temperature is rising faster than 4degrees
    writeDigitalPin(a, red_LED, 1); % Turn on red LED
    writeDigitalPin(a, Green_LED, 0); % Turn off green LED
    writeDigitalPin(a, yellow_LED, 0); % Turn off yellow LED
elseif rate < -(4/60) %If statement is dropping faster than -4degrees a minute
    writeDigitalPin(a, yellow_LED, 1); % Turn on yellow LED
    writeDigitalPin(a, Green_LED, 0); % Turn off green LED
    writeDigitalPin(a, red_LED, 0); % Turn off red LED
elseif temp >= 18 && temp<=24 %If temp is between 18 to 24
    writeDigitalPin(a, Green_LED, 1); % Turn on green LED
    writeDigitalPin(a, yellow_LED, 0); % Turn off yellow LED
    writeDigitalPin(a, red_LED, 0); % Turn off red LED

else %NO LEDs turn on
     writeDigitalPin(a, Green_LED, 0); 
    writeDigitalPin(a, yellow_LED, 0); 
    writeDigitalPin(a, red_LED, 0);
end
pause(6)
end
end

