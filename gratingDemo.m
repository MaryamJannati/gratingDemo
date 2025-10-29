clc;
close all;
% ----------
cd '/Users/nip-maryam/Documents/';

    
% -----experiment parameters-----

% sf = [1 2 4 8 16 32]; % cycles per degree
sf = 2;
contrast = 0.5;
screen_inch = 13.6;
size_grating = 1024; % height and width in pixels
vd = 5; % visual degrees
totcycle = sf * vd; % total cycles in the grating
ppc = size_grating / totcycle; % for the whole grating
cpp = 1 / ppc;

mean_lum = 0.5;
amplitude = mean_lum * contrast;   

% -----calculating the viewing distance-----

screenNumber = max(Screen('Screens')); 
[screenWidthPixels, screenHeightPixels] = Screen('WindowSize', screenNumber);

% Calculate DPI (PPI) of the screen

dpi     = sqrt(screenWidthPixels^2 + screenHeightPixels^2) / screen_inch;

size_cm = (size_grating /dpi) * 2.54; % size of the width (or height in a square patch) grating in cm
 
vdis = size_cm/2 / tan (deg2rad(vd/2)); % viewing distance

x_grating = -size_grating/2 : size_grating/2-1; 
y_grating = x_grating;
% y_grating               = -screenHeightPixels/2 : screenHeightPixels/2-1;


[xp, yp]  = meshgrid(x_grating, y_grating);

mask   = gaussian_mask(xp, yp, size_grating); % gaussian mask
% -----how the stimulus looks like?-----

grating1 = mean_lum + mean_lum * 0.5 * sin(2 * pi * xp * cpp + 0); 

grating2 = mean_lum + mean_lum * 1 * sin(2 * pi * xp * cpp + 0); 

masked_grating =  (grating1 .* mask) + 0.5 .*(1-mask);
masked_grating2 =  (grating2 .* mask) + 0.5 .*(1-mask);

twoAFC = [masked_grating masked_grating2];

% % --plotting the grating + mask (to see what mask does)--
% oneRow = round(size(masked_grating, 1));
% luminanceRange = masked_grating(oneRow, :);   
% positions = 1:length(luminanceRange);  
% 
% figure;        
% plot(positions, luminanceRange, 'blue', 'LineWidth', 2);       
% grid on;

imshow(twoAFC);

