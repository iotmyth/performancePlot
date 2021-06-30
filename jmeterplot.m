format longG
clear all;close all;
stringCSV = 'ResponseTimesPercentiles';
dataID = '9';
bytesDevider=1000000;
bytesDevider=1;
data = readtable(strcat('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/data_jmeter/',dataID,'/', stringCSV,'.csv'), 'ReadVariableNames', false, 'HeaderLines', 1);

% ini untuk format date seperti halnya di jmeter ya
% x = seconds((datenum(datestr(data.ElapsedTime, 'yyyy-mm-dd hh:MM:ss.fff')) - datenum(datestr(data{1,1}, 'yyyy-mm-dd hh:MM:ss.fff'))) * 100000);
% x.Format = 'hh:mm:ss';

markers = {'+','*','.','o','x','v','d','^','s','>','<','v','p','h','p','v','<','>','s','^','d','v','x','o','.','*'};
colors = {'r','b','m','k','y','c',[0 0.7 0],'r','b','m','k','y'};
lines = {'-','--',':','-.',':','--'};
line_width = 0.9;
marker_size = 5;
marker_counter = 1;
color_counter = 1;
line_counter = 1;
ylabels='Response times (ms)';
ylabelslat = 'Response latencies (ms)';
ytrans= 'Number of transactions per second';
ylabelsrescode = 'Number of responses per second ';
ylabels2='Mega Bytes (MB)';
ylabelstruput='Mega Bytes (MB) per second';
ylabels3='TCP connections';
ythread='Number of active threads';
% legend_base_name = 'Worker-';
legend_base_name = 'HTTP Request-';

% set(gca, 'YScale', 'log')

% kalo ini format number dalam menit elapsed time
% x = (datenum(datestr(data{:,1}, 'yyyy-mm-dd hh:MM:ss.fff')) - datenum(datestr(data{1,1}, 'yyyy-mm-dd hh:MM:ss.fff'))) * 100000/60;
% ini untuk data x yang pure number aja, bukan elapsed time
x = data{:,1};

hold on
if(size(data,2) == 2)
    markers = {'.'};
    colors = {'r'};
    ylabel(ylabels,'FontSize',14);
end

for i=1:size(data,2)-1
    if(size(data,2) > 2)
        % ini untuk khusus yang 1 kolom saja
        scatter(x,data{:,i+1},strcat(colors{color_counter},markers{marker_counter}),'DisplayName',strcat(legend_base_name,sprintf('%.0f',i)));
    else
        if(strcmp(stringCSV, 'BytesThroughputOverTime') || strcmp(stringCSV,'ResponseCodesPerSecond') || strcmp(stringCSV,'TransactionsPerSecond'))
            marker_size = 12;
            markers = {'.'};
%             colors = {'b','r'};
%             colors = {'r','b',[0 0.7 0],'m'};
 colors = {'r','b',[0 0.7 0],'m','cyan','k',[0.1 0.6 0.6]};
%             colors = {'r','b','k','m'};
% colors = {'k','r','b','c','m',[0 0.7 0]};
            ylabel(ylabels,'FontSize',14);
          plt(i) = plot(x,data{:,i+1}/bytesDevider,strcat(markers{marker_counter}),'MarkerSize',marker_size,'Color',colors{color_counter});
        else
            
       
             markers = {''};
             lines = {'-','-.','-'};
            plot(x,data{:,i+1},strcat(lines{line_counter},strcat('',markers{marker_counter})),'Color',colors{color_counter},'MarkerSize',marker_size,'LineWidth',line_width,'DisplayName',strcat(legend_base_name,sprintf('%.0f',i)));

% UNTUK MQTT YANG DATA RANGE JAUH
% marker_size = 8;
%     markers = {'.'};
%     colors = {'r',[0 0.7 0],'b'};
%         plot(x,data{:,i+1},markers{marker_counter},'MarkerSize',marker_size,'Color',colors{color_counter});
        end
    end  

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
ax.YAxis.TickLabelFormat = '%.0f';
ax.GridLineStyle = ':';
ax.GridAlpha = 0.3;
ax.LineWidth = 0.9;
set(gca,'FontSize',16);


if(strcmp(stringCSV, 'BytesThroughputOverTime') || strcmp(stringCSV,'ResponseCodesPerSecond') || strcmp(stringCSV,'TransactionsPerSecond'))
%    legend('Bytes received per second','Bytes sent per second');
%     legend('HTTP failure','HTTP success');
%    legend('200 OK','502 Bad Gateway','504 Gateway Timeout','Non HTTP: java','Non HTTP: socket','Non HTTP Timeout','timeout');
%  legend('200 OK','500 Internal Server Error','501 Not Implemented','502 Bad Gateway');
% legend('MQTT Connect (failure)','MQTT Connect (success)','MQTT Disconnect (failure)','MQTT Disconnect (success)','MQTT Publish (failure)','MQTT Publish (success)','box','on');
% gridLegend(plt,1,'location','north');
% columnlegend(2,{'MQTT Connect (failure)','MQTT Connect (success)','MQTT Disconnect (failure)','MQTT Disconnect (success)','MQTT Publish (failure)','MQTT Publish (success)'},'Location','north');

end
% legend('MQTT Connect','MQTT Disconnect','MQTT Publish');
legend('show');
lgd = legend;

% lgd.FontSize=5;
% lgd.Orientation='Horizontal';
% lgd.Location = 'northwest';
% lgd.Location = 'south';
set(gcf,'Units','Inches');

% title({'Threads State over Time (1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
% title({'HTTP Response Times over Time (1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
% title({'HTTP Latencies over Time (1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);

% title({'Threads State over Time (1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
% title({'MQTT Response Times over Time (1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
% title({'MQTT Latencies over Time (1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);

title({'Response Times Percentile (1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
% title({'Transactions per second (1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
% title({'Bytes Throughput over Time (1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',15);
% title({'Response Codes per second (1M Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);

xlabel('Elapsed time (minutes), Granulation: 500 ms','FontSize',15);
xlabel('Percentiles (%)','FontSize',15);
ylabel({ylabels},'FontSize',15);
pos = get(gcf,'Position');
set(findall(gcf,'-property','FontName'),'FontName','Times New Roman');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);

% breakyaxis([20000 179000]);

print(gcf,'-dpdf',strcat('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/hasilgrafik/',strcat(dataID,stringCSV)),'-r0');
savefig(strcat('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/hasilgrafik/',strcat(dataID,stringCSV)));
% print -dpdf -painters hasilgrafik/1a
hold off;


