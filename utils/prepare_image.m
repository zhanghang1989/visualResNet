function crops_data = prepare_image(net, im)
% ------------------------------------------------------------------------%

mean_data = net.meta.normalization.averageImage;
IMAGE_DIM = 256;
CROPPED_DIM = 224; 

% Convert an image returned by Matlab's imread to im_data in caffe's data
% format: W x H x C with BGR channels
im_data = im;
im_data = single(im_data);  
im_data = imresize(im_data, [IMAGE_DIM IMAGE_DIM], 'bilinear');  

% oversample (4 corners, center, and their x-axis flips)
crops_data = zeros(CROPPED_DIM, CROPPED_DIM, 3, 10, 'single');
indices = [0 IMAGE_DIM-CROPPED_DIM] + 1;
n = 1;
for i = indices
  for j = indices
    crops_data(:, :, :, n) = im_data(i:i+CROPPED_DIM-1, j:j+CROPPED_DIM-1, :)-mean_data;
    crops_data(:, :, :, n+5) = crops_data(end:-1:1, :, :, n);
    n = n + 1;
  end
end
center = floor(indices(2) / 2) + 1;
crops_data(:,:,:,5) = ...
  im_data(center:center+CROPPED_DIM-1,center:center+CROPPED_DIM-1,:)-mean_data;
crops_data(:,:,:,10) = crops_data(end:-1:1, :, :, 5);
