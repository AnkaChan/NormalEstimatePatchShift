function [ can_nei ] = neiBuildGrowth( curPt )

global TP;
global neigh_matrix;
%global P;

sizeNei = 0;
can_nei = cell(TP.knnNei,1);
neighbors =  neigh_matrix(curPt,1:TP.knnNei);
for jj = 1:TP.knnNei 
    center = neighbors(jj);
    if ~isempty( find(neigh_matrix(center, 1:30) == curPt, 1) )
        %当前点必须在种子点的初始邻域中
        neis_nei = neiGrowth(center);
        sizeNei = sizeNei + 1;
        can_nei{sizeNei} = neis_nei;        
    end
end
can_nei = can_nei(1:sizeNei);
if isempty(can_nei)
    can_nei = { neigh_matrix(curPt,1:20) };
end
end

