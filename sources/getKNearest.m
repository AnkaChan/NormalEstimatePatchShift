function [ Affinity ] = getKNearest( Points, k )
%����k���ڣ����ع�ϵ����
    num = size(Points,2);
    Affinity = zeros( num );
    for idx = 1:num
        distance = zeros(1, num);
        for idx2 = 1:num
            distance(idx2) = norm( Points(:,idx2)-Points(:,idx) );
        end
        [sortedDstce adress] = sort(distance);
        adress = adress(2:k+2);
        %�ų�����һλ��0���õ����Լ��ľ��룩���õ�k���ڵ������       
        for idx3 =1:k
            Affinity(idx,adress(idx3)) = (k+1-idx3)/k;
        end  
    end

end

