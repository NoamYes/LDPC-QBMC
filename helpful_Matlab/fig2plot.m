function [] = fig2plot(fig_name)
%% Usage example: fig2plot("../Second_Meeting/Matlab/Pics/n=2048,dv-dc_4,8_mat=50.fig")
 
fig = openfig(fig_name);
figure;
xObj = findobj(fig,'-property','XData');
yObj = findobj(fig,'-property','YData');
for plot_idx = numel(xObj):-1:1
    xData = xObj(plot_idx).XData;
    yData = yObj(plot_idx).YData;
    plot(xData, yData); hold on;
end

title(fig.Children(2).Title.String);
legend(fig.Children(2).Legend.String);
xlabel(fig.Children(2).XLabel.String);
ylabel(fig.Children(2).YLabel.String);
end