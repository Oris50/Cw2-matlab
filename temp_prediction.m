function  temp_prediction(a)
  
Green_LED = 'D11';
yellow_LED = 'D10';
red_LED = 'D12';

prev_temp = [];
loop = true;
start_time = tic;

while loop==true

    voltage=readVoltage(a,'A0');
    temp = (voltage - 0.5)*100;

    if isempty(prev_temp)
        rate = 0;
    else
        rate = (temp - prev_temp)/6;
    end
   
    prev_temp = temp; % Update previous temperature for the next iteration
predicted_temp = temp + (rate * 300);
elapsed = toc(start_time);

fprintf('Time: %.2f s\n', elapsed);
fprintf('Current Temperature: %.2f °C\n',  temp)
fprintf('Rate of Change: %.2f °C/min\n',rate);
fprintf('Predicted Temperature (5mins): %.2f °C\n', predicted_temp)

% Control LEDs based on temperature prediction
if rate > (4/60)
    writeDigitalPin(a, red_LED, 1); % Turn on red LED
    writeDigitalPin(a, Green_LED, 0); % Turn off green LED
    writeDigitalPin(a, yellow_LED, 0); % Turn off yellow LED
elseif rate < -(4/60)
    writeDigitalPin(a, yellow_LED, 1); % Turn on yellow LED
    writeDigitalPin(a, Green_LED, 0); % Turn off green LED
    writeDigitalPin(a, red_LED, 0); % Turn off red LED
elseif temp >= 18 && temp<=24
    writeDigitalPin(a, Green_LED, 1); % Turn on green LED
    writeDigitalPin(a, yellow_LED, 0); % Turn off yellow LED
    writeDigitalPin(a, red_LED, 0); % Turn off red LED

else
     writeDigitalPin(a, Green_LED, 0); 
    writeDigitalPin(a, yellow_LED, 0); 
    writeDigitalPin(a, red_LED, 0);
end
pause(6)
end
end

