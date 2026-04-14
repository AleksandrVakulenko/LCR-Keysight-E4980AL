
clc




figure('Position', [448   237   771   820])
subplot(2, 1, 1)
subplot(2, 1, 2)


dev = KeysightLCR();
dev.set_speed('s', 2);

Period = 60; % s
Time_arr = [];
Cap_arr = [];
D_arr = [];
Timer = tic;
stop = false;
while ~stop

    time = toc(Timer);
    if time > Period
        stop = true;
    end
    [Cap, D] = dev.get_cap;

    Cap = Cap*1e9; % nF

    Time_arr = [Time_arr time];
    Cap_arr = [Cap_arr Cap];
    D_arr = [D_arr D];

    subplot(2, 1, 1)
    cla
    plot(Time_arr, Cap_arr);
    xlabel('t, s')
    ylabel('C, nF')
    set(gca,'fontsize', 16)

    subplot(2, 1, 2)
    cla
    plot(Time_arr, D_arr)
    xlabel('t, s')
    ylabel('D, 1')
    set(gca,'fontsize', 16)

    drawnow

end


delete(dev)




%%





