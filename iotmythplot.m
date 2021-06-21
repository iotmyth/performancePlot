format longG

data = readtable('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/data_jmeter/4/ResponseTimesOverTime.csv', 'ReadVariableNames', false, 'HeaderLines', 1);

% ini untuk format date seperti halnya di jmeter ya
% x = seconds((datenum(datestr(data.ElapsedTime, 'yyyy-mm-dd hh:MM:ss.fff')) - datenum(datestr(data{1,1}, 'yyyy-mm-dd hh:MM:ss.fff'))) * 100000);
% x.Format = 'hh:mm:ss';

markers = {'+','*','.','o','x','v','d','^','s','>','<','v','p','h','p','v','<','>','s','^','d','v','x','o','.','*'};
colors = {'r','b','m','k','y','c','g','c','y','k','m','b'};
lines = {'-','--',':','-.',':','--'};
line_width = 0.9;
marker_size = 5;
marker_counter = 1;
color_counter = 1;
line_counter = 1;
ylabels='Response times (ms)';
ylabels1='Number of threads';
ylabels2='Mega Bytes (MB)';
ylabels3='TCP connections';
legend_base_name = 'HTTP Request-';

% kalo ini format number dalam menit elapsed time
x = (datenum(datestr(data{:,1}, 'yyyy-mm-dd hh:MM:ss.fff')) - datenum(datestr(data{1,1}, 'yyyy-mm-dd hh:MM:ss.fff'))) * 100000/60;
% ini untuk data x yang pure number aja, bukan elapsed time
%x = data{:,1};

hold on
% h = figure('DefaultTextFontName', 'Goethe', 'DefaultAxesFontName', 'Goethe','DefaultAxesFontSize',16);
if(size(data,2) == 2)
    markers = {'.'};
    colors = {'r'};
    ylabel(ylabels,'FontSize',14);
end

for i=1:size(data,2)-1
    if(size(data,2) <= 2)
        % ini untuk khusus yang 1 kolom saja
        scatter(x,data{:,i+1},strcat(colors{color_counter},markers{marker_counter}),'DisplayName',strcat(legend_base_name,sprintf('%.0f',i)));
    else
        plot(x,data{:,i+1},strcat(lines{line_counter},strcat(colors{color_counter},markers{marker_counter})),'MarkerSize',marker_size,'LineWidth',line_width,'DisplayName',strcat(legend_base_name,sprintf('%.0f',i)));
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
ax.GridLineStyle = ':';
ax.GridAlpha = 0.3;
ax.LineWidth = 0.9;
legend('show');
set(gcf,'Units','Inches');

title({'HTTP Response Times over Time (50K RPS)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
xlabel('Elapsed time (minutes), Granulation: 500 ms','FontSize',14);
ylabel(ylabels,'FontSize',14);
pos = get(gcf,'Position');
set(findall(gcf,'-property','FontName'),'FontName','Times New Roman');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
% print(h,'-dpdf','hasilgrafik/1a','-r0');
print -dpdf -painters hasilgrafik/1a
hold off;

