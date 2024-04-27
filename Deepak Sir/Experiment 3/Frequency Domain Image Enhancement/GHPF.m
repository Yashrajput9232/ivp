% Clearing previous variables and command window
clear all;
clc;

% Read the input image
original_image = imread('cameraman.tif');
original_image = double(original_image);

% Get the size of the image
image_size = size(original_image);
N = image_size(1);

% Prompt user to enter the cut-off frequency/standard deviation
D0 = input('Enter the cut-off frequency/standard deviation: ');

% Initialize the filter H(u,v)
for u = 1:image_size(1)
    for v = 1:image_size(2)
        Dx = sqrt((u - (N/2))^2 + (v - (N/2))^2);
        D = Dx^2; % Square of the distance
        % Calculate the Gaussian high pass filter response
    H(u,v) = 1 - exp(-D / (2 * D0^2));
    end
end

% Perform FFT on the input image
fft_image = fft2(original_image);
fft_shifted_image = fftshift(fft_image);

% Apply the filter in the frequency domain
filtered_image_fft = fft_shifted_image .* H;

% Perform inverse FFT to get the filtered image
filtered_image = abs(ifft2(filtered_image_fft));

% Displaying the original image, filter, frequency response, and filtered image
figure(1)
subplot(221)
imshow(uint8(original_image))
title('Original Image')
subplot(222)
imagesc(H), colormap(gray)
title('2-D Gaussian High Pass Filter')
subplot(223)
mesh(H)
title('Gaussian High Pass Filter Frequency Response')
subplot(224)
imshow(uint8(filtered_image))
title('Filtered Image')
