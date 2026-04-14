

clc


LCR_dev = KeysightLCR();

err = [];
try

    LCR_dev.set_freq(1234); % Hz
    LCR_dev.set_volt(0.25); % V
    LCR_dev.set_speed('m', 8); % 

    pause(0.5)

    [cap_re, tan_d] = LCR_dev.get_cap;
    [res_re, res_im] = LCR_dev.get_res;

    disp(['|C| = ' num2str(cap_re) ' F'])
    disp(['tanD = ' num2str(tan_d)])
    disp(' ')
    disp(['R_real = ' num2str(res_re) ' Ohm'])
    disp(['R_imag = ' num2str(res_im) ' Ohm'])
    disp(' ')

catch err
    delete(LCR_dev);
    rethrow(err);
end


if isempty(err)
    delete(LCR_dev);
    disp('Finished without errors')
end

