
clear
close all
 
RGB = imread('../images/test010.png');
gray = double(rgb2gray(RGB));
 
figure(1);
subplot(211), imshow(RGB), title('Original');
 
h1 = fspecial('sobel');
h2 = h1';
igh = imfilter(gray, h1);
igv = imfilter(gray, h2);
sobel = abs(igh) + abs(igv);
subplot(212), imshow(sobel, []), title('Sobel');
 
sobel_thresholded = sobel(5:end - 5, 5:end - 5) > 90;
[MI, xy, R] = RandomHoughCircles(sobel_thresholded, 4, 200000, [15 22]);
 
figure(2);
imshow(sobel_thresholded, []), title('Sobel thresholded');
hold on
points = 50;
t = linspace(0, 2 * pi, points);
for i = 1:size(xy, 2)
    x = xy(1, i);
    y = xy(2, i);
    r = R(i);
    x_unit = r * cos(t) + x;
    y_unit = r * sin(t) + y;
    plot(y_unit, x_unit, 'ro');
end
hold off
axis equal
 
%figure(3);
%imshow(MI, []), title('Erased points');
