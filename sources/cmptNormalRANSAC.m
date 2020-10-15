function [ normals, knns, noncomputeCount ] = cmptNormal( Debug )
global TP;
global neigh_matrix;
global P;
global idFeatures;

options.epsilon = 1e-6;
options.P_inlier = 0.99;
options.sigma = 0.01;
options.est_fun = @estimate_plane;
options.man_fun = @error_plane;
options.mode = 'MSAC';
options.Ps = [];
options.notify_iters = [];
options.min_iters = 500;
options.fix_seed = false;
options.reestimate = true;
options.stabilize = false;

knns = cell(TP.nSample,1);
for i=1:TP.nSample
    knns{i} = neigh_matrix(i,1:30);
end

wrongPts = [];
normals = zeros(TP.nSample,3);
noncomputeCount = 0;
for i = 1 : TP.nFeature
    %
    if ~mod(i,100)
       i
    end
    curPt =  idFeatures(i);
    
%     figure('Name','Input'); set(gcf,'color','white');set(gcf,'Renderer','OpenGL');
%     movegui('northeast');
%     scatter3(P.pts(:,1),P.pts(:,2),P.pts(:,3),10,'.','MarkerEdgeColor',GS.CLASS_COLOR5);  hold on;
%     scatter3(P.pts(neigh_matrix{curPt},1),P.pts(neigh_matrix{curPt},2),P.pts(neigh_matrix{curPt},3),30,'.','MarkerEdgeColor',GS.CLASS_COLOR1);  
%     axis off;axis equal;
%     view3d rot; % vidw3d zoom; % r for rot; z for zoom;
%% Determine the type of the feature point and choose method to build neighborhood
    nFeatureType1 = 0;
    nFeatureType2 = 0;

    neis = neigh_matrix(curPt,1:TP.knnPatch);
    [vlue, ~] = computePCA(P.pts(neis,:)) ;
    nvlue = vlue/max(abs(vlue(:)));
    
    switch TP.neiBuildMethod
        case 1
            can_nei = neiBuildVecConstrain(curPt);
        otherwise
            if nvlue(1,1) <= 0.35
                can_nei = neiBuildVecConstrain(curPt);
                nFeatureType1 = nFeatureType1 + 1; 
                %disp('Type 1');
            else
                can_nei = neiBuildGrowth(curPt);
                nFeatureType2 = nFeatureType2 + 2;
                %disp( 'Type 2');
            end
    end
    
    %mp = mean(P.pts(neigh_matrix(curPt,1:7),:));
    [normals(curPt,:), noncompute, knn]= cmptNormalEach(can_nei);
    if ~noncompute
        result = RANSAC(P.pts(knn,:)',options);
        normals(curPt,:) = result.Theta(1:3);
    end
    noncomputeCount = noncomputeCount + noncompute ;
    knns{curPt} = knn;
%     if normals(curPt,:) * trueNormals(curPt,:)' < cos(10*pi/180) ...
%        %&& ~(normals(curPt,:) * trueNormals(curPt,:)' < 0.35 && normals(curPt,:) * trueNormals(curPt,:)' > 0.31)
%          if Debug.showKnn 
%              disp(normals(curPt,:) * trueNormals(curPt,:)');
%              figure('Name',num2str(curPt)); set(gcf,'color','white');set(gcf,'Renderer','OpenGL');
%              movegui('northeast');
%              neighbors = neigh_matrix(curPt,:);
%              scatter3(P.pts(:,1),P.pts(:,2),P.pts(:,3),10,'.','MarkerEdgeColor',GS.CLASS_COLOR5);  hold on;
%              scatter3(P.pts(neighbors,1),P.pts(neighbors,2),P.pts(neighbors,3),30,'.','MarkerEdgeColor',GS.CLASS_COLOR3);  hold on;
%              scatter3(P.pts(knn,1),P.pts(knn,2),P.pts(knn,3),30,'.','MarkerEdgeColor',GS.CLASS_COLOR1);  hold on;
%              x = [P.pts(curPt,:) ; P.pts(curPt,:) + normals(curPt,:)] ;
%              plot3(x(:, 1),x(:,2),x(:,3) ,'r', 'LineWidth' , 2) ; hold on
%              y = [P.pts(curPt,:) ; P.pts(curPt,:) + trueNormals(curPt,:)] ;
%              plot3(y(:, 1),y(:,2),y(:,3) , 'b' , 'LineWidth' , 2) ; hold on
%              axis off;axis equal;
%              view3d rot; % vidw3d zoom; % r for rot; z for zoom;
%              pause
%              close all
%          end
%          wrongPts = [wrongPts curPt];
%     end         
end

end

