n_sampling = 10000;         % the sampling size

for alpha = [0.05, 0.25];       % levels of confidence
    for N = [10, 100, 1000, 10000]; % sizes of each sample from which we build the CI
        asymptic_ci_test(N, alpha, n_sampling);
    end
end

function asymptic_ci_test(xn, alpha, yn)

    if (alpha == 0.05)
        ep0 = 1.95996;
    elseif (alpha == 0.25)
        ep0 = 1.15034;
    else
        error('no value for this alpha');
    end
    
    theta = 0.5;
    mean_epsilon = 0;
    captured_mean = 0;

    for i = 1:yn
        x_sample = sample_bernoulli(xn, theta);
        x_bar = mean(x_sample);
        sigma = std(x_sample);
        
        epsilon = sigma * ep0/sqrt(xn);
        mean_epsilon = mean_epsilon + epsilon/yn;

        if(abs(x_bar - theta) <= epsilon)
            captured_mean = captured_mean + 1;
        end
    end

    fprintf("alpha: %1.3f N: %d ep: %1.3f frac missed: %1.3f\n", alpha, xn, mean_epsilon, 1-(captured_mean/yn));
end 
