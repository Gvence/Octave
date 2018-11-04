function J = computeCost(X, y, theta)

m = length(y);
J = 0;
J = sum((X*theta - y).^2)/(2*m);%X*theta- y的平方，再加和除以2m
endfunction
