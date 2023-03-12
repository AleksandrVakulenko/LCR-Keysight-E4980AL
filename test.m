


% list = visadevlist;

% dev = visadev('ASRL1::INSTR');

% [tf, status] = visastatus(dev)



%%


% IDN:
writeline(dev, '*IDN?');
name_ans = "Keysight Technologies,E4980AL,MY54305367,B.07.01\n";

% voltage:
writeline(dev, [':VOLTage:LEVel ' num2str(volt)]);
response = writeread(dev, ':VOLTage:LEVel?');
disp(response);

% frequency:
writeline(dev, [':FREQuency:CW ' num2str(freq)]);
response = writeread(dev, ':FREQuency:CW?');
disp(response);

% c_d:
response = writeread(dev, ':FETCh:IMPedance:FORmatted?');
disp(response);

% r_x:
response = writeread(dev, ':FETCh:IMPedance:CORrected?');
disp(response);








