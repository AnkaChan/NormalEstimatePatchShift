function [normal_out noncompute knn] = compute_normal_jjcao_EACH1Naive(points , can_nei , orientation , area_w , mp)
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
    points_temp = points(can_nei{i} , :) ;
    tmp = points_temp - repmat(mp,size(points_temp , 1),1); % 37s
    C = tmp'*tmp;%./size(points_temp , 1); % 12s
    [V,D] = eig(C);  % 15s
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

if orientation*normal_out' < 0
    normal_out = -normal_out;
end