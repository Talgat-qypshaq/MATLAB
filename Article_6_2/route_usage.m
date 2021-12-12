function result = route_usage()    
    route_id = 'route_1';
    fprintf('route name = %s\n',route_id);
    path = strcat('Article_6_2/',route_id);
    path = strcat(path,'.txt');
    data = load(path);
    X = data(:,(1:8));
    y = data(:, 9);
    [m, n] = size(X);    
    X = [ones(m, 1) X];
    initial_theta = zeros(n + 1, 1);    
    %[cost, grad] = costFunction(initial_theta, X, y);
    %fprintf('Cost at initial theta (zeros): %f\n', cost);
    %fprintf('Gradient at initial theta (zeros) %f \n', grad);    
    options = optimset('GradObj', 'on', 'MaxIter', 400);
    [theta, cost] = fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);
    fprintf('Cost at theta found by fminunc: %f\n', cost);
    %theta = initial_theta;    
    parameters = [1 17 4 2019001 1 3 23 3 1];    
    result = sigmoid(parameters * theta);
    p = predict(theta, X);
    train_accuracy = mean(double(p == y)) * 100;
    fprintf('Train Accuracy: %f\n',train_accuracy);   
end