%% ======================= initializeGradientDescentParaments =======================
iterations = 1500;%%��������
alpha = 0.01;%%ѧϰ��
%%====================end=============================

%%=====================plotting========================
printf('Plotting Data ...\n');
data = load('ex1data1.txt');
x = data(: , 1);%��ȡ��һ�е�����
y = data(: , 2);%��ȡ�ڶ��е�����
m = length(y);
plotData(x,y);

x = [ones(m,1),x];%����λ������������������x
theta = zeros(2,1);%����Theta����������Theta�ĳ�ʼֵΪ0
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
hold on; %%����figure1��������
plot(x(:,2), x*theta, '-');%%����X*theta-x_1��ͼ��
legend('Training data', 'Linear regression');
print -dpng 'Linear regression.png';
hold off; %%������figure�ϸ����κ�ͼ�Σ��رձ��ֻ�������

%%�������theta�󣬻ع鷽�̾͵õ���y = theta_0*x_0+theta_1*x_1+theta_2*x_2+...+theta_n*x_n(x_0Ϊ1�����㿪ʼǰ����x�в���ĵ�λ������������ )
predict1 = [1, 3.5] *theta;%�˴���predict1���ǻع鷽���е�y��[1, 3.5]��ָȡx_0 = 1,x_1 = 3.5
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
J_vals = J_vals';%surf������ȡtheta0_vals��ֵ��ȡ���ͺ���ȡtheta1_vals�ĵڶ���ֵ����Ϊ������ֻ��һ�У�����ȡ����x��y˳������J_vals�е���ֵ��Ӧ��
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