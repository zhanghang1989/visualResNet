function visual(varargin)
%% Look through ResNet
% Hang Zhang
addpath utils
run dependencies/matconvnet/matlab/vl_setupnn.m
run dependencies/vlfeat/toolbox/vl_setup.m

opts.model = 50;
opts.data = 'data/val';
opts.topN = 1;
opts.num = 30;
opts = vl_argparse(opts, varargin) ;

%% prepare image and the model
switch opts.model
    case {50, 101, 152}, 
        modelpath = sprintf('imagenet-resnet-%d-dag.mat', opts.model) ; 
        url = sprintf('http://www.vlfeat.org/matconvnet/models/imagenet-resnet-%d-dag.mat', opts.model) ;
    otherwise, error('Model not support!')
end

if ~exist(modelpath, 'file')
  fprintf('downloading from %s\n', modelpath) ;
  urlwrite(url, modelpath) ;
end

net = dagnn.DagNN.loadobj(load(modelpath));
net2 = dagnn.DagNN.loadobj(load(modelpath));
net.mode = 'test' ;
net2.mode = 'test' ;
for i=1:3
    net2.removeLayer(net2.layers(end).name);
end

index = net.getLayerIndex('fc1000');
pname = net.layers(index).params{1};
weights_LR = squeeze(net.getParam(pname).value);

ims = dir(fullfile(opts.data, '*JPEG')) ;
ims = ims(randperm(length(ims)));

for idx = 1:opts.num
    img = imread(fullfile(opts.data, ims(idx).name)) ;
    if size(img,3) == 1
        img = cat(3, img, img, img);
    end
    img = imresize(img, [256 256]);
    img_prepared = prepare_image(net, img);
    
    net.eval({'data',img_prepared}) ;
    scores = net.vars(net.getVarIndex('prob')).value ;
    scores = squeeze(gather(scores)) ;
    scores = mean(scores,2);
    categories = net.meta.classes.description;
    
    net2.eval({'data',img_prepared}) ;
    activation_lastconv = net2.vars(end).value;
    
    topNum = opts.topN; % generate heatmap for top X prediction results
    
    [value_category, IDX_category] = sort(scores,'descend');
    
    value_category = value_category(1:topNum);
    IDX_category = IDX_category(1:topNum);
    
    [curCAMmapAll] = returnCAMmap(activation_lastconv, weights_LR(:,IDX_category));
    
    curResult = im2double(img);
    curPrediction = '';
    
    for j=1:topNum
        curCAMmap_crops = 	(curCAMmapAll(:,:,j,:));
        curCAMmapLarge_crops = imresize(curCAMmap_crops,[256 256]);
        curCAMLarge = mergeTenCrop(curCAMmapLarge_crops);
        curHeatMap = imresize(im2double(curCAMLarge),[256 256]);
        curHeatMap = im2double(curHeatMap);
        
        curHeatMap = map2jpg(curHeatMap,[], 'jet');
        curHeatMap = im2double(img)*0.3+curHeatMap*0.6;
        curResult = [curResult ones(size(curHeatMap,1),8,3) curHeatMap];
        curPrediction = [curPrediction ' --top'  num2str(j) ':' categories{IDX_category(j)}];
        
    end
    switchFigure(1) ; clf ;
    imshow(curResult);
    title(curPrediction)
    drawnow ;
    savePath = fullfile('data', sprintf('%d.pdf', idx));
    print(savePath, '-dpdf') ;
end

% -------------------------------------------------------------------------
function switchFigure(n)
% -------------------------------------------------------------------------
if get(0,'CurrentFigure') ~= n
  try
    set(0,'CurrentFigure',n) ;
  catch
    figure(n) ;
  end
end
