
clc


save_filename = 'data_1.mat';
% save_filename = [];

figure('Position', [448   237   771   820])
subplot(2, 1, 1)
subplot(2, 1, 2)

freq_list = 10.^linspace(log10(50), log10(300e3), 200);

LCR_dev = KeysightLCR();
LCR_dev.set_speed('m', 1);

freq_arr = [];
Cap_arr = [];
D_arr = [];
Timer = tic;

for i = 1:numel(freq_list)
    disp([num2str(i) '/' num2str(numel(freq_list))]);
    time = toc(Timer);

    freq = LCR_dev.set_freq(freq_list(i));
    [Cap, D] = LCR_dev.get_cap;

    Cap = Cap*1e12; % nF
    freq_arr = [freq_arr freq];
    Cap_arr = [Cap_arr Cap];
    D_arr = [D_arr D];

    subplot(2, 1, 1)
    cla
    plot(freq_arr, Cap_arr);
    xlabel('f, Hz')
    ylabel('C, pF')
%     ylim([0 0.1])
    set(gca,'fontsize', 16)
    set(gca,'xscale', 'log')

    subplot(2, 1, 2)
    cla
    plot(freq_arr, D_arr)
    xlabel('f, Hz')
    ylabel('D, 1')
%     ylim([0 0.1])
    set(gca,'fontsize', 16)
    set(gca,'xscale', 'log')

    drawnow

end


delete(LCR_dev)


if ~isempty(save_filename)
    save(save_filename, "Cap_arr", "D_arr", "freq_arr")
    disp('data saved')
end







