alpha = 0.05;        % level of confidence
n_sampling = 1000;   % the sampling size

N = 10;              % size of each sample from which we build the CI
hoeffding_ci_test(N, alpha, n_sampling);

N = 100;             % size of each sample from which we build the CI
hoeffding_ci_test(N, alpha, n_sampling);

N = 1000;             % size of each sample from which we build the CI
hoeffding_ci_test(N, alpha, n_sampling);

N = 10000;             % size of each sample from which we build the CI
hoeffding_ci_test(N, alpha, n_sampling);

function hoeffding_ci_test(xn, alpha, yn)

    theta = 0.5;
    y_sample = [];
    epsilon = sqrt((1/(2*xn))*log(2/alpha));
    captured_mean = 0;
    
    figure; hold on;

    for i = 1:yn
        x_sample = sample_bernoulli(xn, theta);
        x_bar = mean(x_sample);
        y_sample = [y_sample; x_bar];
        
        if(abs(x_bar - theta) <= epsilon)
            captured_mean = captured_mean + 1;
            plot([i, i], [x_bar-epsilon, x_bar+epsilon], 'black')
        else
            plot([i, i], [x_bar-epsilon, x_bar+epsilon], 'red','LineWidth',2)
        end
    end

    plot([0,yn], [mean(y_sample), mean(y_sample)], 'blue')
    plot([0,yn], [theta, theta], 'green')
    
    title(sprintf("alpha: %1.3f N: %d ep: %1.3f frac missed: %1.3f\n", alpha, xn, epsilon, 1-(captured_mean/yn)));
end 
