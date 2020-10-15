function [ Affinity ] = getKNearest( Points, k )
%计算k阶邻，返回关系矩阵
    num = size(Points,2);
    Affinity = zeros( num );
    for idx = 1:num
        distance = zeros(1, num);
        for idx2 = 1:num
            distance(idx2) = norm( Points(:,idx2)-Points(:,idx) );
        end
        [sortedDstce adress] = sort(distance);
        adress = adress(2:k+2);
        %排除掉第一位的0（该点与自己的距离），得到k阶邻点的索引       
        for idx3 =1:k
            Affinity(idx,adress(idx3)) = (k+1-idx3)/k;
        end  
    end

end

