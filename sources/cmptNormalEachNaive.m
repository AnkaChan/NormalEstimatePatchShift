function [ normal_out, noncompute, knn ] = cmptNormalEachNaive( can_nei )
global P;
global neigh_matrix;
knn = [];
num = length(can_nei) ;
normal_out = zeros(1 , 3) ;
noncompute = 0 ;
if num == 0
    noncompute = 1 ;
    normal_out = [1 , 0 , 0] ;
    return ;
end
max_plane = 100 ;
for i = 1 : num
    points_temp = P.pts(can_nei{i} , :) ;
    [D,V] = computePCA(points_temp);  % 15s
    fix_normal = V(:,1);
    cur_plane = D(1,1)/(D(1,1) + D(2,2) + D(3,3)); % 15s
    
    if cur_plane < max_plane
        max_plane = cur_plane;
        normal_out = fix_normal' ;
        knn = can_nei{i};
    end
end

if sum(normal_out.*normal_out) == 0
    normal_out = [1,0,0] ;
    noncompute = 1 ;
end

end