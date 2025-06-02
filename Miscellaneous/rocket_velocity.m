function v = rocket_velocity(t)
    %compute rocket velocity as a piecewise function
    if t >= 0 && t <= 8
        v = 10*t^2 - 5*t;  %for 0 <= t <= 8
    elseif t > 8 && t <= 16
        v = 624 - 3*t;   %for 8 < t <= 16
    elseif t > 16 && t <= 26
        v = 36*t + 12*(t - 16)^2;  %for 16 < t <= 26
    elseif t > 26
        v = 2136 * exp(-0.1 * (t - 26));  %for t > 26
    else
        v = 0;  % Otherwise (when t < 0)
    end
end