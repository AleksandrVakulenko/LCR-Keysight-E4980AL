

figure('Position', [448   237   771   820])
hold on


filename = 'data_SS_bothwires_03.mat';
load(filename);
plot_LCR(freq_arr, Cap_arr, '-g');

filename = 'data_SM_bothwires_02.mat';
load(filename);
plot_LCR(freq_arr, Cap_arr, '-b');

filename = 'data_SL_bothwires_01.mat';
load(filename);
plot_LCR(freq_arr, Cap_arr, '-r');

legend({"SS", "SM", "SL"})

% filename = 'data_SS_01.mat';
% load(filename);
% plot_LCR(freq_arr, Cap_arr, '-g');
% 
% filename = 'data_SM_01.mat';
% load(filename);
% plot_LCR(freq_arr, Cap_arr, '-b');
% 
% filename = 'data_SL_02.mat';
% load(filename);
% plot_LCR(freq_arr, Cap_arr, '-r');



function plot_LCR(freq_arr, Cap_arr, spec)

plot(freq_arr, Cap_arr, spec);
xlabel('f, Hz')
ylabel('C, pF')
ylim([3 4.6])
set(gca,'fontsize', 16)
set(gca,'xscale', 'log')

end