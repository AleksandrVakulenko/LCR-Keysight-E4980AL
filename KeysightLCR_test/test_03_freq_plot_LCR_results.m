
% NOTE: run after test_02_freq_plot

figure('Position', [448   237   771   820])
hold on


filename = 'data_1.mat';
load(filename);
plot_LCR(freq_arr, Cap_arr, '-g');

% filename = 'data_2.mat';
% load(filename);
% plot_LCR(freq_arr, Cap_arr, '-b');




function plot_LCR(freq_arr, Cap_arr, spec)

plot(freq_arr, Cap_arr, spec);
xlabel('f, Hz')
ylabel('C, pF')
set(gca,'fontsize', 16)
set(gca,'xscale', 'log')

end