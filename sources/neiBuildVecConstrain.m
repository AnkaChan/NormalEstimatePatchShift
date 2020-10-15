function [ can_nei ] = neiBuildVecConstrain(curPt)
global TP;
global neigh_matrix;
global P;
global idFeatures;

sizeNei = 0;
can_nei = cell(TP.knnNei,1);
neighbors =  neigh_matrix(curPt,1:TP.knnNei);
for jj = 2:TP.knnNei
    center = neighbors(jj);
    neis_nei = neigh_matrix(center,1:TP.knnNei);
    v1 = P.pts(center,:) - P.pts(curPt,:);
    adapt = TP.density(center);
    if adapt < 0.3
        adapt = 0.3;
    end
    
    sizeNeisNei = 0;
    avliable_neis_nei = zeros(TP.knnNei,1);
    for kk = 1:TP.knnNei * adapt
        v2 = P.pts(center,:) - P.pts(neis_nei(kk),:);
        %if  v1*v2' <= v1*v1'
        if  v1*v2' > 0
            if norm(v1) >= norm(v2)
                sizeNeisNei = sizeNeisNei + 1;
                avliable_neis_nei(sizeNeisNei) = neis_nei(kk);
            end
        else
            %if isempty(find(idFeatures == neis_nei(kk),1))
                sizeNeisNei = sizeNeisNei + 1;
                avliable_neis_nei(sizeNeisNei) = neis_nei(kk);
            %end
        end
    end
    avliable_neis_nei = avliable_neis_nei(1:sizeNeisNei);
    if  sizeNeisNei >= 20 ...
            && ~isempty( find(avliable_neis_nei == curPt, 1) )... 
            && sum( TP.featureSign(avliable_neis_nei) ) < length(avliable_neis_nei)
        sizeNei = sizeNei + 1;
        can_nei{sizeNei} = avliable_neis_nei;        
    end
end
can_nei = can_nei(1:sizeNei);
if isempty(can_nei)
    can_nei = { neigh_matrix(curPt,1:20) };
end
end

