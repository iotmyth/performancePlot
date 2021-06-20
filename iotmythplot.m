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
h = figure;
figure('DefaultTextFontName', 'Goethe', 'DefaultAxesFontName', 'Goethe','DefaultAxesFontSize',16);
axes;
if(size(data,2) == 2)
    markers = {'.'};
    colors = {'r'};
    ylabel(ylabels,'FontSize',12);

end

for i=1:size(data,2)-1
    if(size(data,2) <= 2)
        % ini untuk khusus yang 1 kolom saja
        

        scatter(x,data{:,i+1},strcat(colors{color_counter},markers{marker_counter}),'DisplayName',strcat(legend_base_name,sprintf('%.0f',i)));
        
    else
        plot(x,data{:,i+1},strcat(lines{line_counter},strcat(colors{color_counter},markers{marker_counter})),'MarkerSize',marker_size,'LineWidth',line_width,'DisplayName',strcat(legend_base_name,sprintf('%.0f',i)));
    end  
    
%  
% %       disp(i)

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
legend('show');
set(h,'Units','Inches');
title('HTTP Response Times over Time','FontSize',16);
xlabel('Elapsed time (minutes), Granulation: 500 ms','FontSize',16);
ylabel(ylabels,'FontSize',16);
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'hasilgrafik/1a','-dpdf','-r0')
hold off;

