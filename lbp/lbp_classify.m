%perform classification
%load the training images
training1Histograms = [];
im11 = imread('class_1_1.jpg');
im11 = imresize(im11, [200, 200]);
im11 = rgb2gray(im11);
im12 = imread('class_1_2.png');
im12 = imresize(im12, [200, 200]);
im12 = rgb2gray(im12);
im13 = imread('class_1_3.jpg');
im13 = imresize(im13, [200, 200]);
im13 = rgb2gray(im13);
images1 = {};
images1{end + 1} = im11;
images1{end + 1} = im12;
images1{end + 1} = im13;

training2Histograms = [];
im21 = imread('class_2_1.jpg');
im21 = imresize(im21, [200, 200]);
im21 = rgb2gray(im21);
im22 = imread('class_2_2.jpg');
im22 = imresize(im22, [200, 200]);
im22 = rgb2gray(im22);
im23 = imread('class_2_3.jpg');
im23 = imresize(im23, [200, 200]);
im23 = rgb2gray(im23);
images2 = {};
images2{end + 1} = im21;
images2{end + 1} = im22;
images2{end + 1} = im23;
%find the model histograms
model1 = lbp.computeClassHistogram(images1);
model2 = lbp.computeClassHistogram(images2);
models = [model1; model2];

%get the test images
%get their closest class labels
im14 = imread('class_1_4.jpg');
im14 = imresize(im14, [200, 200]);
im14 = rgb2gray(im14);
prediction1 = lbp.findClosestHistogram(im14, models)

im24 = imread('class_2_4.jpg');
im24 = imresize(im24, [200, 200]);
im24 = rgb2gray(im24);
prediction2 = lbp.findClosestHistogram(im24, models)
