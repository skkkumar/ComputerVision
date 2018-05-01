classdef LBP
%LBP Local Binary Pattern
% It computes the local binary pattern for image and compares two
% images

properties
end

methods

% Computes the LBP for each pixel in an image
function imLBP = calculateLBP(lbpObject, imGray)
%construct the lbp as a filter bank

%create different filters
filter1 = [1 0 0
0 -1 0
0 0 0];
filter2 = [0 1 0
0 -1 0
0 0 0];
filter3 = [0 0 1
0 -1 0
0 0 0];
filter4 = [0 0 0
0 -1 1
0 0 0];
filter5 = [0 0 0
0 -1 0
0 0 1];
filter6 = [0 0 0
0 -1 0
0 1 0];
filter7 = [0 0 0
0 -1 0
1 0 0];
filter8 = [0 0 0
1 -1 0
0 0 0];

%convolve the filters with the image
convolved1 = conv2(double(imGray), filter1, 'same');
convolved2 = conv2(double(imGray), filter2, 'same');
convolved3 = conv2(double(imGray), filter3, 'same');
convolved4 = conv2(double(imGray), filter4, 'same');
convolved5 = conv2(double(imGray), filter5, 'same');
convolved6 = conv2(double(imGray), filter6, 'same');
convolved7 = conv2(double(imGray), filter7, 'same');
convolved8 = conv2(double(imGray), filter8, 'same');

%threshold the images to 0 or 1 if the values are less than 0 or not
convolved1(find(convolved1 >= 0)) = 1;
convolved1(find(convolved1 < 0)) = 0;
convolved2(find(convolved2 >= 0)) = 1;
convolved2(find(convolved2 < 0)) = 0;
convolved3(find(convolved3 >= 0)) = 1;
convolved3(find(convolved3 < 0)) = 0;
convolved4(find(convolved4 >= 0)) = 1;
convolved4(find(convolved4 < 0)) = 0;
convolved5(find(convolved5 >= 0)) = 1;
convolved5(find(convolved5 < 0)) = 0;
convolved6(find(convolved6 >= 0)) = 1;
convolved6(find(convolved6 < 0)) = 0;
convolved7(find(convolved7 >= 0)) = 1;
convolved7(find(convolved7 < 0)) = 0;
convolved8(find(convolved8 >= 0)) = 1;
convolved8(find(convolved8 < 0)) = 0;

%add the thresholded images
imLBP = uint8(convolved1 + 2 * convolved2 + 4 * convolved3 + 8 * convolved4 + 16 * convolved5 + 32 * convolved6 + 64 * convolved7 + 128 * convolved8);
end


% create histogram of lbp code
function hist = calculateHistogram(lbpObject, imLBP)
hist = zeros(1,256);
for i=1:256
hist(i) = sum(imLBP(:)==(i-1));
end
end


%create histogram of all the samples in one classs
function classHistogram = computeClassHistogram(lbpObject, trainingPatches)
patchCount = length(trainingPatches);
trainingHistograms = zeros(patchCount, 256);
for i=1:patchCount
lbp = transformLBP(trainingPatches{i});
trainingHistograms(i,:) = createHistogram(lbp);
end

classHistogram = mean(trainingHistograms);
end


%calculate the distance between two lbp histograms by finding the
%chi squared distance
function dist = histogramDistance(lbpObject, hist1, hist2)
%find the indexes where none of the values are zero
valid = (hist1+hist2)>0;
%find chi squared distance
dist = sum( (hist1(valid)-hist2(valid)).^2 ./ (hist1(valid)+hist2(valid)) ) / 2;
end


%find the class with minimum distance
function bestClass = findClosestHistogram(lbpObject, patch, classHistograms)
%find the lbp code for the patch
imLBP = lbpObject.calculateLBP(patch);

%find the lbp histogram for the lbp image
hist = lbpObject.calculateHistogram(imLBP);

%find the distance of lbp code to each class histograms
[count, ~] = size(classHistograms);
minDistance = 1000000;
bestClass = -1;
for index = 1 : count
dist = lbpObject.histogramDistance(hist, classHistograms(index, :));
if dist < minDistance
minDistance = dist;
bestClass = index;
end
end
end

end

end
