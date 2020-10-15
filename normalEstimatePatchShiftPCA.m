function [ normals, knns, noncomputeCount ] = normalEstimatePatchShiftPCA( Pts, knnNei, knnPatch, neiBuildMethod)
%% ----------------------------------------------------------------
%Inputs:Pts:Data of Points. Pts(i,1),Pts(i.2),Pts(i.3) are the X,Y,Z
%          coordinate of point i.
%     :knnNei:Size of domains where we search for certer point.Default as
%     80
%     :knnPatch:Size of Patches. Default as 30
%outputs:normals:Estimated normals
%       :knns:the id of points in selected patches for each point
%       :noncomputeCount:number of noncomputed points
%-------------------------------------------------------------------
if nargin == 1
    knnNei = 80;
    knnPatch = 30;
    neiBuildMethod = 2;
elseif nargin == 2
    knnPatch = 30;
    neiBuildMethod = 2;
elseif nargin == 3 
    neiBuildMethod = 2;
end
originalPath = cd;
path = which('normalEstimatePatchShift');
cd(path(1:end - 26 ));
addpath ('./toolbox/jjcao_io')
addpath ('./toolbox/jjcao_point')
addpath ('./toolbox/jjcao_common')
addpath ('./toolbox/jjcao_interact')
addpath ('./toolbox/kdtree')
addpath ('./toolbox/jjcao_plot')

addpath('./toolbox/zj_fitting')
addpath('./toolbox/zj_deviation')
addpath('./RANSAC_Toolbox_master');
addpath('./toolbox/cvx')
addpath('./sources')
cvx_setup
cvx_setup
global TP;
global neigh_matrix;
global P;
global idFeatures;
%% tunable arguments
TP.debug_data = 0;
TP.debug_taproot = 0 ;
Debug.showKnn = 0;
Debug.plotResult = 1;
% argunments in feature extraction
TP.k_knn_feature = 80; 
TP.k_knn_normals = 30;
TP.k_knn  = 120;
TP.sigma_threshold = 0.05;
% argunments in neighborhood building
TP.knnNei  = knnNei;
TP.knnPatch = knnPatch;
TP.ran_num = 100 ;
TP.neiBuildMethod = neiBuildMethod;

P.pts = Pts;

P.kdtree = kdtree_build(P.pts);
TP.nSample = size(P.pts,1);
nSample = TP.nSample;

bbox = [min(P.pts(:,1)), min(P.pts(:,2)), min(P.pts(:,3)), max(P.pts(:,1)), max(P.pts(:,2)), max(P.pts(:,3))];
bx = bbox(4)-bbox(1);by = bbox(5)-bbox(2);bz = bbox(6)-bbox(3);
rs = bbox(4:6)-bbox(1:3);
diameter = sqrt(dot(rs,rs));
%% construct neighboor matrix
feature_normal_r = 0.042 * diameter ;
neigh_matrix = zeros(TP.nSample, TP.knnNei);
for  i = 1 : TP.nSample
    neis = kdtree_k_nearest_neighbors(P.kdtree, P.pts(i,:), TP.knnNei);
    neigh_matrix(i,:) = neis;
end
%% show the density
TP.density = computeDensity(30);
TP.area_w = TP.density .^ 2 ;

%% compute initial features (a ribbon)
[sigms , normVectors , errs , normals_comW] = compute_points_sigms_normals_two(P.pts, TP.k_knn_feature, P.kdtree, TP.k_knn_normals);
TP.feature_threshold = feature_threshold_selection(sigms,TP);
idFeatures = find(sigms > TP.feature_threshold);
TP.nFeature = length(idFeatures);
TP.featureSign = zeros(TP.nSample,1);
TP.featureSign(idFeatures) = 1;
noncompute_count = 0;
%% compute nomals
[normals, knns, noncomputeCount] = cmptNormalPCA(Debug);
kdtree_delete(P.kdtree);

for i = 1:length(idFeatures)
    normVectors(idFeatures(i),:) = normals(idFeatures(i),:);
end
normals = normVectors;
cd(originalPath);
end

