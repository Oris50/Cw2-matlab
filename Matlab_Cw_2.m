% Oraibi George-Gudi
% Efyog1@nottingham.ac.uk

%% Prelimanry Task 
clear

a = arduino('COM9','Uno') % This is to be able to create a arduino

%Creates a loop that makes LED blink for 10 seconds

for t= 1:10

writeDigitalPin(a,'d11',1) %This is to provide the connection with the arduino pin 
%with the LED while applying a 5V tension to the LED
pause(0.5)
writeDigitalPin(a,'d11,0')
pause(0.5)
end
