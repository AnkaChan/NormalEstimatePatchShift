function [ nei ] = neiGrowth( curPt )

global TP;
global neigh_matrix;
global P;

n0 = 15;
nei = neigh_matrix(curPt, 1:n0);
[vlue, ~] = computePCA(P.pts(nei,:)) ;
nvlue0 = vlue/max(abs(vlue(:)));

for i = n0+1:TP.knnNei
    newCenter = neigh_matrix(curPt, i);  

    if isempty(find(nei == newCenter, 1))
        [newNei,~,~] = unique([nei newCenter neigh_matrix(newCenter, 1:5)], 'stable');
        [vlue, ~] = computePCA(P.pts(newNei,:)) ;
        nvlue = vlue/max(abs(vlue(:)));
        if nvlue(1,1) <= nvlue0(1,1)
            nei = newNei;
            nvlue0 = nvlue;
        end
        
        if length( nei ) > TP.knnPatch+10  || ( nvlue0(1,1) < 0.1 && length( nei ) > TP.knnPatch-5)
            return;
        end
        
        if mod(i,2) && length( nei ) > TP.knnPatch
           nei = delete1Point(nei, P.pts(nei,:), nvlue0, n0);
        end
    end
end

end
