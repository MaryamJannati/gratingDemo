function mask = gaussian_mask(xp, yp, size_patch)
%   mask = gaussian_mask(size_patch, xp, yp, sigma)
%
%   size_patch : size of the patch (in same units as xp, yp)
%   xp, yp     : coordinate grids (from meshgrid)
%   sigma      : standard deviation of Gaussian (in same units as xp, yp)
%
%   Output: mask with values between 0 and 1

    sigma = size_patch / 6;
    % Distance from center
    radius_sq = xp.^2 + yp.^2;
    
    % Gaussian formula
    mask = exp(-radius_sq / (2 * sigma^2));

end
