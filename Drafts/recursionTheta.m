function[theta] = recursionTheta(beta_1, beta_2, n)
    %assume n=N
    m = [1, 2, 3, 4];
    for i=1:1:n
        theta = ( m(i)*power( (1-(beta_1/beta_2) ), n) )/n;
    end
end