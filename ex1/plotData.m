function plotData(x, y)
figure; % 新建一个绘图窗口
plot(x, y, 'rx', 'MarkerSize',10);%%'rx',以红色 xx显示;'MarkerSize',10,通过数值调整xx的大小
xlabel('population');
ylabel('profit');
endfunction
