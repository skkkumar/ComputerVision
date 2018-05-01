%read image
im = imread('photo.jpg');

%convert to grey
lbp = LBP();
imGray = rgb2gray(im);

%get the lbp code for image
imLBP = lbp.calculateLBP(imGray);
figure;
imshow(imLBP);
title('LBP');

%get the histogram of the image lbp
hist = lbp.calculateHistogram(imLBP);
figure;
bar(hist);
xlim([0-margin,255+margin]);
title('Histogram');
