function demo(varargin)
%% Look through ResNet
% Hang Zhang
opts.model = 'imagenet-resnet-50-dag.mat' ; 
opts = vl_argparse(opts, varargin) ;

imgID = 2; % 1 or 2
img = imread(['img' num2str(imgID) '.jpg']);
img = imresize(img, [256 256]);
online = 1; % whether extract features online or load pre-extracted features

% load the CAM model and extract features
net = dagnn.DagNN.loadobj(load(opts.model));
index = net.getLayerIndex('fc1000');
pname = net.layers(index).params{1};
weights_LR = net.getParam(pname).value;

img_prepared = prepare_image(net, img);
net.eval({'data',img_prepared}) ;
scores = net.forward({prepare_image(img)});% extract conv features online
activation_lastconv = net.blobs('CAM_conv').get_data();
scores = scores{1};




topNum = 5; % generate heatmap for top X prediction results
scoresMean = mean(scores,2);
[value_category, IDX_category] = sort(scoresMean,'descend');
[curCAMmapAll] = returnCAMmap(activation_lastconv, weights_LR(:,IDX_category(1:topNum)));

curResult = im2double(img);
curPrediction = '';

for j=1:topNum
    curCAMmap_crops = 	(curCAMmapAll(:,:,j,:));
    curCAMmapLarge_crops = imresize(curCAMmap_crops,[256 256]);
    curCAMLarge = mergeTenCrop(curCAMmapLarge_crops);
    curHeatMap = imresize(im2double(curCAMLarge),[256 256]);
    curHeatMap = im2double(curHeatMap);

    curHeatMap = map2jpg(curHeatMap,[], 'jet');
    curHeatMap = im2double(img)*0.2+curHeatMap*0.7;
    curResult = [curResult ones(size(curHeatMap,1),8,3) curHeatMap];
    curPrediction = [curPrediction ' --top'  num2str(j) ':' categories{IDX_category(j)}];
    
end
figure,imshow(curResult);title(curPrediction)

if online==1
    caffe.reset_all();
end

