format longG

stringCSV = 'Network TX-data-as-seriestocolumns-2021-06-05 01_33_45';
bytesDevider = 1000000;
% bytesDevider = 1;
dataID = '10';
namespace = 'emqx';
data = readtable(strcat('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/data_grafana/',dataID,'/',namespace,'/',strcat(stringCSV,'.csv')), 'ReadVariableNames', false, 'HeaderLines', 2);


% ini untuk format date seperti halnya di jmeter ya
% x = seconds((datenum(datestr(data.ElapsedTime, 'yyyy-mm-dd hh:MM:ss.fff')) - datenum(datestr(data{1,1}, 'yyyy-mm-dd hh:MM:ss.fff'))) * 100000);
% x.Format = 'hh:mm:ss';

markers = {'.','*','.','o','x','v','d','^','s','>','<','v','p','h','p','v','<','>','s','^','d','v','x','o','.','*'};
colors = {'r','b','m','k','y','c','g','r','b','m','k','y'};
lines = {'-','--',':','-.',':','--'};
line_width = 0.9;
marker_size = 5;
marker_counter = 1;
color_counter = 1;
line_counter = 1;
ylabels='Response times (ms)';
ylabelslat = 'Mega Bytes (MB)';
ylabelscpu='Number of core CPU';
ylabels1='Number of threads';
ylabelsmem='Mega Bytes (MB)';
yredis = 'Command executed per second';
ylabelstruput='Mega Bytes (MB) per second';
ylabels3='TCP connections';
ythread='Number of active threads';
%legend_base_name = 'Worker-';
legend_base_name = 'All pods';


% kalo ini format number dalam menit elapsed time
x = (datenum(datestr(data{:,1}, 'yyyy-mm-dd hh:MM:ss.fff')) - datenum(datestr(data{1,1}, 'yyyy-mm-dd hh:MM:ss.fff'))) * 100000/60;
% ini untuk data x yang pure number aja, bukan elapsed time
%x = data{:,1};

% REMOVE FIRST COLUMN AND SUM ALL ROW
   temp_data = data;
     temp_data(:,1) = [];
   A = table2array(temp_data);
   A(isnan(A))=0;
% A = rand(1000, 4);  % Test data
B = [A, sum(A, 2)/bytesDevider]; %1000000
B(isnan(B))=0;

% disp(B(:,16));
% disp(size(B,2));

hold on
if(size(data,2) == 2)
    markers = {'.'};
    colors = {'r'};
    ylabel(ylabels,'FontSize',14);
end

plot(x,B(:,size(B,2)),strcat(lines{line_counter},strcat(colors{color_counter},markers{marker_counter})),'MarkerSize',marker_size,'LineWidth',line_width,'DisplayName',strcat(legend_base_name,''));

box on;
grid on;

ax = gca;
ax.YAxis.Exponent = 0;
ax.GridLineStyle = ':';
ax.GridAlpha = 0.3;
ax.LineWidth = 0.9;
set(gca,'FontSize',16)

if(strcmp(stringCSV, 'BytesThroughputOverTime') || strcmp(stringCSV,'ResponseCodesPerSecond'))
    legend('Bytes received per second','Bytes sent per second');
end
legend('show');
lgd = legend;
%lgd.FontSize=7;
%lgd.Location = 'northWest';

set(gcf,'Units','Inches');

% title({'Node Memory SUM: redis cluster (HTTP 1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
%title({'Node Command SUM: redis cluster (HTTP 1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
% title({'CPU SUM: iotmyth (HTTP 1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
% title({'Memory SUM: iotmyth (HTTP 1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
% title({'Network RX SUM: iotmyth (HTTP 1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
% title({'Network TX SUM: iotmyth (HTTP 1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);

% title({'Node Memory SUM: redis cluster (MQTT 1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
%title({'Node Command SUM: redis cluster (MQTT 1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
% title({'CPU SUM: emqx (MQTT 1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
% title({'Memory SUM: emqx (MQTT 1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
% title({'Network RX SUM: emqx (MQTT 1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
title({'Network TX SUM: emqx (MQTT 1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);


xlabel('Elapsed time (minutes)','FontSize',15);
ylabel(ylabelstruput,'FontSize',15);
% ylim([0,max(B(:,size(B,2)))*1.2])
% xlim([min(x),max(x)])
pos = get(gcf,'Position');
set(findall(gcf,'-property','FontName'),'FontName','Times New Roman');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
print(gcf,'-dpdf',strcat('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/hasilgrafik/',strcat(dataID,'SUM',stringCSV)),'-r0');
savefig(strcat('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/hasilgrafik/',strcat(dataID,'SUM',stringCSV)));
% print -dpdf -painters hasilgrafik/1a
hold off;

