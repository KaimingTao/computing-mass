% plot
plot(x, y)

% plot argument
%% no line
plot(x, y 'r*')

% control panel
hold on
hold off
close all

% plot vector
plot(v)

% plot properties
plot(y, 'LineWidth', 5)
plot(x,y,'ro-','LineWidth',5)

% annotating
title('Plot title')
ylabel('Density (g/cm^3)')