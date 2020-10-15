function [ nei ] = delete1Point( neiID , points, nvlue0, n0)
%从领域最远的十个点中选一个点删掉，使得邻域变平的程度最高
nei = neiID;
global TP;
deleteID = 0;
e = 0;
n = length(neiID);
for i = n0:n
    newPoints = points;
    newPoints(i,:) = [];

    [vlue, ~] = computePCA(newPoints) ;
    nvlue = vlue/max(abs(vlue(:)));
    
    if nvlue0(1,1) - nvlue(1,1) > e
        e = nvlue0(1,1) - nvlue(1,1);
        deleteID = i;
    end
    
end
if deleteID == 0
    return
end
nei(deleteID) = [];
deleteID = 0;
e = 0;
for i = n0:n-1
    newPoints = points;
    newPoints(i,:) = [];

    [vlue, ~] = computePCA(newPoints) ;
    nvlue = vlue/max(abs(vlue(:)));
    
    if nvlue0(1,1) - nvlue(1,1) > e
        e = nvlue0(1,1) - nvlue(1,1);
        deleteID = i;
    end
    
end
if deleteID == 0
    return
end

nei(deleteID) = [];

end

