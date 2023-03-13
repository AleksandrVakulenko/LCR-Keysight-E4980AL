


% list = visadevlist;

% dev = visadev('ASRL1::INSTR');

% [tf, status] = visastatus(dev)

% USB0::0x2A8D::0x2F01::MY54305367::INSTR

clc


vias_adr = find_E4980AL()

if vias_adr ~= ""
    
    dev = visadev(vias_adr);
    [tf, status] = visastatus(dev)
    
%     response = writeread(dev, '*IDN?')
    
    disp('start');
    writeline(dev, '*IDN?');
    line = readline(dev);
    disp(line)


else
    disp('No device')
end


% get(dev)
% set(dev, 'Timeout', 1)

%%


% IDN:
response = writeread(dev, '*IDN?');
disp(response);
name_ans = "Keysight Technologies,E4980AL,MY54305367,B.07.01\n";
disp(name_ans);

% voltage:
volt = 1
writeline(dev, [':VOLTage:LEVel ' num2str(volt)]);
response = writeread(dev, ':VOLTage:LEVel?');
disp(response);

% frequency:
freq = 1234
writeline(dev, [':FREQuency:CW ' num2str(freq)]);
response = writeread(dev, ':FREQuency:CW?');
disp(response);

% c_d:
response = writeread(dev, ':FETCh:IMPedance:FORmatted?');
disp(response);

% r_x:
response = writeread(dev, ':FETCh:IMPedance:CORrected?');
disp(response);

%%

clc

lcr_dev = KeysightLCR();

lcr_dev.set_volt(1.2);
lcr_dev.set_freq(1011);

disp('start')
for i = 1:5
lcr_dev.get_res
% lcr_dev.get_cap

end

%%




clc


vias_adr = find_E4980AL()

dev = visadev(vias_adr);
[tf, status] = visastatus(dev)

%%
clc

tic
% writeline(dev, ':FETCh:IMPedance:FORmatted?');
write(dev, ":FETCh:IMPedance:FORmatted?", "string");
toc

% num = 0;
% i = 0;
% while num == 0
%     i = i + 1;
%     num = get(dev, 'NumBytesAvailable')
% end

tic
line = readline(dev);
toc
disp(line)





%%

clc


vias_adr = find_E4980AL()


%%
dev_old = visa('keysight','USB0::0x2A8D::0x2F01::MY54305367::INSTR')




% fprintf(dev_old,'*IDN?')
% idn = fscanf(dev_old)

CMD = ":FETCh:IMPedance:FORmatted?"
function response = query(dev_old, CMD)
    fopen(dev_old)
    fprintf(dev_old, CMD)
    response = fscanf(dev_old)
    fclose(dev_old)
end





































