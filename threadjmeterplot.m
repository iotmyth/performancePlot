format longG
clear all;close all;
stringCSV = 'thread9';
dataID = '9';
data = readtable(strcat('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/data_jmeter/',dataID,'/',strcat(stringCSV,'.csv')), 'ReadVariableNames', false, 'HeaderLines', 1);

% ini untuk format date seperti halnya di jmeter ya
% x = seconds((datenum(datestr(data.ElapsedTime, 'yyyy-mm-dd hh:MM:ss.fff')) - datenum(datestr(data{1,1}, 'yyyy-mm-dd hh:MM:ss.fff'))) * 100000);
% x.Format = 'hh:mm:ss';

% markers = {'.','*','.','o','x','v','d','^','s','>','<','v','p','h','p','v','<','>','s','^','d','v','x','o','.','*'};
colors = {'r','b','m','k','y','c',[0 0.7 0],'r','b','m','k','y'};
markers = {''};
lines = {'-'};
line_width = 0.9;
marker_size = 5;
marker_counter = 1;
color_counter = 1;
line_counter = 1;
ylabels='Response times (ms)';
ylabelslat = 'Number of active threads';
ylabels1='Number of threads';
ylabels2='Mega Bytes (MB)';
ylabelstruput='Mega Bytes (MB) per second';
ylabels3='TCP connections';
ythread='Number of active threads';
%legend_base_name = 'Worker-';
legend_base_name = 'All workers';


% kalo ini format number dalam menit elapsed time
x = (datenum(datestr(data{:,1}, 'yyyy-mm-dd hh:MM:ss.fff')) - datenum(datestr(data{1,1}, 'yyyy-mm-dd hh:MM:ss.fff'))) * 100000/60;
% ini untuk data x yang pure number aja, bukan elapsed time
%x = data{:,1};

% REMOVE FIRST COLUMN AND SUM ALL ROW
   temp_data = data;
     temp_data(:,1) = [];
   A = table2array(temp_data);
% A = rand(1000, 4);  % Test data
B = [A, sum(A, 2)];
B(isnan(B))=0;

disp(B(:,size(B,2)));

hold on
if(size(data,2) == 2)
    markers = {'.'};
    colors = {'r'};
    ylabel(ylabels,'FontSize',14);
end

plot(x,B(:,size(B,2)),strcat(lines{line_counter},strcat('',markers{marker_counter})),'Color',colors{color_counter},'MarkerSize',marker_size,'LineWidth',line_width,'DisplayName',strcat(legend_base_name,''));

box on;
grid on;

ax = gca;
ax.YAxis.Exponent = 0;
ax.YAxis.TickLabelFormat = '%.0f';
ax.GridLineStyle = ':';
ax.GridAlpha = 0.3;
ax.LineWidth = 0.9;
set(gca,'FontSize',16)

if(strcmp(stringCSV, 'BytesThroughputOverTime') || strcmp(stringCSV,'ResponseCodesPerSecond'))
    legend('Bytes received per second','Bytes sent per second');
end
legend('show');
lgd = legend;
lgd.FontSize=10;
%lgd.Location = 'northWest';

set(gcf,'Units','Inches');

% title({'SUM Threads State over Time (50K Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
title({'SUM Threads State over Time (1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
%title({'HTTP Response Times over Time (50K RPS)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
%title({'HTTP Latencies over Time (50K RPS)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
%title({'Bytes Throughput over Time (50K RPS)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',15);

xlabel('Elapsed time (minutes), Granulation: 500 ms','FontSize',15);
ylabel(ylabelslat,'FontSize',15);
% ylim([0,max(B(:,5))*1.2])
% xlim([min(x),max(x)])
pos = get(gcf,'Position');
set(findall(gcf,'-property','FontName'),'FontName','Times New Roman');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
print(gcf,'-dpdf',strcat('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/hasilgrafik/',strcat(dataID,'SUM',stringCSV)),'-r0');
savefig(strcat('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/hasilgrafik/',strcat(dataID,'SUM',stringCSV)));
% print -dpdf -painters hasilgrafik/1a
hold off;

