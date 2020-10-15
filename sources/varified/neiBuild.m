function [ can_nei ] = neiBuild(curPt)
global TP;
global neigh_matrix;
global P;

can_nei = {};
neighbors =  neigh_matrix(curPt,1:TP.k_knn_feature);
for jj = 2:TP.k_knn_feature
    center = neighbors(jj);
    avliable_neis_nei = [];
    neis_nei = neigh_matrix(center,1:TP.k_knn_normals);
    v1 = P.pts(center,:) - P.pts(curPt,:);
    adapt = TP.density(center);
    if adapt < 0.5
        adapt = 0.5;
    end
    for kk = 1:TP.k_knn_normals * adapt
        v2 = P.pts(center,:) - P.pts(neis_nei(kk),:);
        if  sum(v1.*v2) <= sum(v1.*v1)
            %if norm(v1) >= norm(v2)
            avliable_neis_nei = [avliable_neis_nei neis_nei(kk)];
        end
    end
    if length(avliable_neis_nei) >= 15*TP.density(center) ...
            && length(avliable_neis_nei) >= 10 ...
            && ~isempty( find(avliable_neis_nei == curPt, 1) )
        can_nei = [can_nei avliable_neis_nei];
        
    end
end

end

