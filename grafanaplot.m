format longG
clear all;close all;
stringCSV = 'Scaling Nodes Count-data-as-seriestocolumns-2021-06-05 02_11_20';
bytesDevider = 1000000;
bytesDevider = 1;
dataID = '6';
namespace = 'nodes';
data = readtable(strcat(strcat(strcat('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/data_grafana/',dataID),'/'),strcat(strcat(strcat(namespace,'/'),stringCSV),'.csv')), 'ReadVariableNames', false, 'HeaderLines', 2);

% ini untuk format date seperti halnya di jmeter ya
% x = seconds((datenum(datestr(data.ElapsedTime, 'yyyy-mm-dd hh:MM:ss.fff')) - datenum(datestr(data{1,1}, 'yyyy-mm-dd hh:MM:ss.fff'))) * 100000);
% x.Format = 'hh:mm:ss';

markers = {'+','*','.','o','x','v','d','^','s','>','<','v','p','h','p','v','<','>','s','^','d','v','x','o','.','*'};
% markers = {'.','^'};
colors = {'r','b','m','k',[0 0.7 0],'c','y','r','b','m','k',[0 0.7 0]};
lines = {'-','-.','--',':',':','--'};
line_width = 0.9;
marker_size = 2.8;
%marker_size = 5;
marker_counter = 1;
color_counter = 1;
line_counter = 1;
ylabelspod='Number of pods';
ylabelscpusum='Number of core CPU';
ylabelslat = 'Response latencies (ms)';
ylabels1='Number of threads';
ynodes='Number of nodes';
ylabelsmem='Mega Bytes (MB)';
ylabelstruput='Mega Bytes (MB) per second';
ylabels3='TCP connections';
yredis='Command executed per second';
ythread='Number of active threads';
legend_base_name = 'ingress-pod-';
%legend_base_name = 'Worker-';
% legend_base_name = 'redis-node-';
% legend_base_name = 'iotmyth-cpu-';
%legend_base_name = 'iotmyth-memory-';


% kalo ini format number dalam menit elapsed time
x = (datenum(datestr(data{:,1}, 'yyyy-mm-dd hh:MM:ss.fff')) - datenum(datestr(data{1,1}, 'yyyy-mm-dd hh:MM:ss.fff'))) * 100000/60;
% ini untuk data x yang pure number aja, bukan elapsed time
%x = data{:,1};

hold on
if(size(data,2) == 2)
    markers = {'.'};
    colors = {'r'};
    ylabel(ylabelspod,'FontSize',15);
end

for i=1:size(data,2)-1
            plot(x,data{:,i+1}/bytesDevider,strcat(lines{line_counter},strcat('',markers{marker_counter})),'Color',colors{color_counter},'MarkerSize',marker_size,'LineWidth',line_width,'DisplayName',strcat(legend_base_name,sprintf('%.0f',i)));

      if mod(i,  size(markers,2)) == 0
         marker_counter = 1;
      else
         marker_counter=marker_counter+1;
      end
      
      if mod(i, size(colors,2)) == 0
          color_counter = 1;
      else
          color_counter=color_counter+1;
      end
      
      if mod(i,size(lines,2)) == 0
         line_counter = 1;
      else
         line_counter=line_counter+1;
      end
end


box on;
grid on;

ax = gca;
ax.YAxis.Exponent = 0;
% ax.YAxis.TickLabelFormat = '%.0f';
ax.GridLineStyle = ':';
ax.GridAlpha = 0.3;
ax.LineWidth = 0.9;
set(gca,'FontSize',16);
legend('long unregistered','not started','ready','unready','unregistered');
legend('show');
lgd = legend;
lgd.FontSize=10;
lgd.Location = 'northwest';
% lgd.Location = 'north';


set(gcf,'Units','Inches');

% title({'Pod Count: redis (HTTP 1M Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
% title({'CPU SUM: ingress (HTTP 1M Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
% title({'CPU: ingress (HTTP 1M Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
% title({'Memory: ingress (HTTP 1M Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
% title({'Node Command: redis cluster (HTTP 1M Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
title({'Node scaling (HTTP 1M Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
% title({'Network RX: ingress (HTTP 1M Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
% title({'Network TX: ingress (HTTP 1M Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
%title({'Network Load Balancer (HTTP 1M Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);

% title({'Pod Count: i (MQTT 1M Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
% title({'CPU SUM: ingress (MQTT 1M Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
% title({'CPU: redis (MQTT 1M Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
% title({'Memory: ingress (MQTT 1M Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
% title({'Node Memory: redis cluster (MQTT 1M Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
% title({'Node Command: redis cluster (MQTT 1M Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
% title({'Node scaling (MQTT 1M Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
% title({'Network RX: ingress (MQTT 1M Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
% title({'Network TX: ingress (MQTT 1M Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
%title({'Network Load Balancer (MQTT 1M Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);


xlabel('Elapsed time (minutes)','FontSize',15);
ylabel(ynodes,'FontSize',15);
pos = get(gcf,'Position');
ymax = max(data{:,2});
% ylim([0,ymax(1)*1.2])
% ylim([0,15])
%xlim([min(x),max(x)])
set(findall(gcf,'-property','FontName'),'FontName','Times New Roman');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
print(gcf,'-dpdf',strcat('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/hasilgrafik/',strcat(dataID,stringCSV)),'-r0');
savefig(strcat('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/hasilgrafik/',strcat(dataID,stringCSV)));
% print -dpdf -painters hasilgrafik/1a
hold off;

