function y = echo_response(x)
    Fs = 8000;  
    
    % sample count me echo delay
    delay_samples = round([10, 30, 60, 80] * Fs / 1000);
    
    % iske anusar amplitude
    echo_amplitudes = [0.65, -0.25, 0.05, -0.05];
    
    % maximum delay nikalna
    max_delay = max(delay_samples);
    
    % impluse response ke bare me btana
    h = zeros(1, max_delay + 1);
    h(1) = 1; % Direct signal
    
    % impluse response ko echo values dena
    for i = 1:length(delay_samples)
        h(delay_samples(i) + 1) = echo_amplitudes(i);
    end
    
    % buffer and o/p signal ke bare me btana
    buffer = zeros(max_delay + 1, 1);
    y = zeros(length(x), 1);
    
    for i = 1:length(x)
        % Shift buffer aur  new input sample dalna
        buffer = [buffer(2:end); x(i)];
        
        % Compute convolution sum using delayed samples
        sum_val = 0;
        for j = 1:length(delay_samples)
            sum_val = sum_val + buffer(max_delay - delay_samples(j) + 1) * echo_amplitudes(j);
        end
        y(i) = sum_val;
    end
end
