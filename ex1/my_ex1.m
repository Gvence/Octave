%% ======================= initializeGradientDescentParaments =======================
iterations = 1500;%%迭代次数
alpha = 0.01;%%学习率
%%====================end=============================

%%=====================plotting========================
printf('Plotting Data ...\n');
data = load('ex1data1.txt');
x = data(: , 1);%调取第一列的向量
y = data(: , 2);%调取第二列的向量
m = length(y);
plotData(x,y);

x = [ones(m,1),x];%将单位列向量插入特征矩阵x
theta = zeros(2,1);%创建Theta向量，各个Theta的初始值为0
fprintf('Program paused. Press enter to continue.\n');
pause;
%%=====================end===============================


%%=====================computeCost============================
fprintf('\nTesting the cost function ...\n');
J = computeCost(x, y, theta);
fprintf('With theta = [0 ; 0]\nCost computed = %f\n', J);
fprintf('Expected cost value (approx) 32.07\n');
J = computeCost(x, y, [-1 ; 2]);
fprintf('\nWith theta = [-1 ; 2]\nCost computed = %f\n', J);
fprintf('Expected cost value (approx) 54.24\n');
fprintf('Program paused. Press enter to continue.\n');
pause;
%%======================end=========================

%%=================gradientDescentOperation===========
fprintf('\nRunning Gradient Descent ...\n');
theta = gradientDescent(x, y, theta, alpha, iterations)(: , 1);
fprintf('Theta found by gradient descent:\n');
fprintf('%f\n', theta);
fprintf('Expected theta values (approx)\n');
fprintf(' -3.6303\n  1.1664\n\n');
hold on; %%保持figure1画布不变
plot(x(:,2), x*theta, '-');%%绘制X*theta-x_1的图像
legend('Training data', 'Linear regression');
print -dpng 'Linear regression.png';
hold off; %%不再在figure上覆盖任何图形，关闭保持画布不变

%%求出最优theta后，回归方程就得到了y = theta_0*x_0+theta_1*x_1+theta_2*x_2+...+theta_n*x_n(x_0为1，计算开始前，向x中插入的单位列向量产生的 )
predict1 = [1, 3.5] *theta;%此处的predict1就是回归方程中的y，[1, 3.5]是指取x_0 = 1,x_1 = 3.5
fprintf('For population = 35,000, we predict a profit of %f\n',...
    predict1*10000);
predict2 = [1, 7] * theta;
fprintf('For population = 70,000, we predict a profit of %f\n',...
    predict2*10000);
fprintf('Program paused. Press enter to continue.\n');
pause;
%%=====================end============================
fprintf('Visualizing J(theta_0, theta_1) ...\n')

% Grid over which we will calculate J
theta0_vals = linspace(-10, 10, 100);
theta1_vals = linspace(-1, 4, 100);

% initialize J_vals to a matrix of 0's
J_vals = zeros(length(theta0_vals), length(theta1_vals));

% Fill out J_vals
for i = 1:length(theta0_vals)
    for j = 1:length(theta1_vals)
	  t = [theta0_vals(i); theta1_vals(j)];
	  J_vals(i,j) = computeCost(x, y, t);
    end
end


% Because of the way meshgrids work in the surf command, we need to
% transpose J_vals before calling surf, or else the axes will be flipped
J_vals = J_vals';%surf先依次取theta0_vals的值，取到低后在取theta1_vals的第二个值，因为两个都只有一行，最终取出的x，y顺序是与J_vals中的列值对应的
% Surface plot
figure;
surf(theta0_vals, theta1_vals, J_vals);
xlabel('\theta_0'); ylabel('\theta_1');
% Contour plot
figure;
% Plot J_vals as 15 contours spaced logarithmically between 0.01 and 100
contour(theta0_vals, theta1_vals, J_vals, logspace(-2, 3, 20));
xlabel('\theta_0'); ylabel('\theta_1');
hold on;
plot(theta(1), theta(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
print -dpng 'Contour plot.png';
hold off;