fprintf('Loading data ...\n');
data = load('dis_record.txt');
X = -data(:, 2);
y = data(:, 1);
m = length(y);
fprintf('First 10 examples from the dataset: \n');
fprintf(' x = [%.2f], y = %.2f \n', [X(:,:) y(:,:)]');
figure;
plot(X(:, 1), y(:, 1), 'xb', 10);
xlabel('time');
ylabel('distance');
title('point plot');
print -dpng 'point plot';
hold on;
%%==============featureNormalize=================
fprintf('Normalizing Features ...\n');
#[X mu sigma] = featureNormalize(X);

X = [ones(m,1),X];
%%================end============================
   
%%===================Gradient Descent================
fprintf('Running gradient descent ...\n');
alpha = 0.01;
num_iters = 150;
theta = zeros(2, 1);
[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);
plot((0.1:0.1:10)', [ones(100,1), (0.1:0.1:10)']*theta, '-r', 5)
print -dpng 'linear regression';
hold off;
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');
title ('Gradient Descent Mulit Cost Plot')
print -dpng 'Gradient Descent Mulit Cost Plot';
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta);
fprintf('\n');
price = [1, (([5].-mu)./sigma)]*theta;
fprintf(['Predicted distance of 5 seconds '... 
         '(using gradient descent):\n $%f\n'], price);

%%=========================end========================

%% ================ Normal Equations ================
data = load('dis_record.txt');
X = -data(:, 2);
y = data(:, 1);
m = length(y);
X = [ones(m, 1) X];
theta = normalEqn(X, y);
fprintf('Theta computed from the normal equations: \n');
fprintf(' %f \n', theta);
fprintf('\n');
price = [1, 5]*theta; 
fprintf(['Predicted distance of 5 seconds ' ...
         '(using normal equations):\n $%f\n'], price);
%%=====================end===========================