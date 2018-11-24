n_sampling = 10000;         % the sampling size

for alpha = [0.05, 0.25];       % levels of confidence
    for N = [10, 100, 1000, 10000]; % sizes of each sample from which we build the CI
        hoeffding_ci_test(N, alpha, n_sampling);
    end
end

function hoeffding_ci_test(xn, alpha, yn)

    theta = 0.5;
    y_sample = [];
    epsilon = sqrt((1/(2*xn))*log(2/alpha));
    captured_mean = 0;

    for i = 1:yn
        x_sample = sample_bernoulli(xn, theta);
        x_bar = mean(x_sample);
        y_sample = [y_sample; x_bar];

        if(abs(x_bar - theta) <= epsilon)
            captured_mean = captured_mean + 1;
        end
    end

    fprintf("alpha: %1.3f N: %d ep: %1.3f frac missed: %1.3f\n", alpha, xn, epsilon, 1-(captured_mean/yn));
end 
