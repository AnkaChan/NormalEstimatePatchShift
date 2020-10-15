function [normal_out noncompute knn] = compute_normal_jjcao_EACH2(points , can_nei , orientation , area_w , mp, distances)

num = length(can_nei) ;
normal_out = zeros(1 , 3) ;
noncompute = 0 ;
if num == 0
    noncompute = 1 ;
    normal_out = [1 , 0 , 0] ;
    return ;
end
max_plane1 = 1000 ;
max_plane2 = 1000 ;
for i = 1 : num
    neigh_num = size(can_nei{i} , 1) - 1;
    normal_one = ones(1 , neigh_num) ;
    
    curr_area_w = area_w(can_nei{i}) ;
%     curr_area_w(1) = [] ;
    
    points_temp = points(can_nei{i} , :) ;
    %mp = (normal_one * points_temp) ./ neigh_num; % 26s
    
%     mp = points_temp(1 , :) ;
%     points_temp(1 , :) = [];
    tmp1 = (points_temp - repmat(mp,size(points_temp , 1),1)) ;
    C1 = tmp1'*tmp1./size(points_temp , 1); % 12s
    [V1,D1] = eig(C1);  % 15s
    fix_normal1 = V1(:,1);
    cur_plane1 = D1(1,1)/(D1(1,1) + D1(2,2) + D1(3,3)); % 15s
    abs(orientation*fix_normal1);
    %     figure('Name','tmp1'); set(gcf,'color','white');set(gcf,'Renderer','OpenGL');
    %     movegui('northeast');
    %     scatter3(tmp1(:,1),tmp1(:,2),tmp1(:,3),30,'.','MarkerEdgeColor',GS.CLASS_COLOR1);  hold on;
    %     %axis off;
    %     axis equal;
    %     view3d rot;
    
    %     if cur_plane < max_plane
    %         max_plane = cur_plane;
    %         normal_out = fix_normal' ;
    %     end
    tmp2 = ((points_temp - repmat(mp,size(points_temp , 1),1)) .* repmat(curr_area_w' , 1 , 3)) / max(curr_area_w); % 37s
    C2 = tmp2'*tmp2./size(points_temp , 1); % 12s
    [V2,D2] = eig(C2);  % 15s
    fix_normal2 = V2(:,1);
    cur_plane2 = D2(1,1)/(D2(1,1) + D2(2,2) + D2(3,3)) ;%* distances(i);% 15s
    abs(orientation*fix_normal2);
%     figure('Name','tmp2'); set(gcf,'color','white');set(gcf,'Renderer','OpenGL');
%     movegui('northeast');
%     scatter3(tmp1(:,1),tmp1(:,2),tmp1(:,3),30,'.','MarkerEdgeColor',GS.CLASS_COLOR3);  hold on;
%     scatter3(tmp2(:,1),tmp2(:,2),tmp2(:,3),30,'.','MarkerEdgeColor',GS.CLASS_COLOR1);
%     x = [[0 , 0 ,0] ; 1/4*fix_normal1'] ;
%     plot3(x(:, 1),x(:,2),x(:,3) ,'LineWidth' , 1) ;
%     y = [[0 , 0 ,0] ;  1/4*fix_normal2'] ;
%     plot3(y(:, 1),y(:,2),y(:,3) , 'r' , 'LineWidth' , 1) ;
%     z = [[0 , 0 ,0] ;  1/4*orientation] ;
%     plot3(z(:, 1),z(:,2),z(:,3) , 'g' ,'LineWidth' , 1) ;
%     %axis off;
%     axis equal;
%     view3d rot;
%     
%     close all
    
    if cur_plane1 < max_plane1
        max_plane1 = cur_plane1;
        normal_out1 = fix_normal1' ;
        neigh_best1 = tmp1 ;
    end
    if cur_plane2 < max_plane2
        max_plane2 = cur_plane2;
        normal_out2 = fix_normal2' ;
        neigh_best2 = tmp2 ;
        knn = can_nei{i};
        centre_chosen = i;
    end
end
%centre_chosen
%distances(centre_chosen)
%normal_out = normal_out1 ;
normal_out = normal_out2 / norm(normal_out2) ;

if sum(normal_out.*normal_out) == 0
    normal_out = [1,0,0] ;
    noncompute = 1 ;
end

if orientation*normal_out' < 0
    normal_out = -normal_out;
end

% figure('Name','tmp2'); set(gcf,'color','white');set(gcf,'Renderer','OpenGL');
% movegui('northeast');
% scatter3(neigh_best1(:,1),neigh_best1(:,2),neigh_best1(:,3),30,'.','MarkerEdgeColor',GS.CLASS_COLOR3);  hold on;
% scatter3(neigh_best2(:,1),neigh_best2(:,2),neigh_best2(:,3),30,'.','MarkerEdgeColor',GS.CLASS_COLOR1);
% x = [[0 , 0 ,0] ; 1/4*normal_out1] ;
% plot3(x(:, 1),x(:,2),x(:,3) ,'LineWidth' , 1) ;
% y = [[0 , 0 ,0] ;  1/4*normal_out2] ;
% plot3(y(:, 1),y(:,2),y(:,3) , 'r' , 'LineWidth' , 1) ;
% z = [[0 , 0 ,0] ;  1/4*orientation] ;
% plot3(z(:, 1),z(:,2),z(:,3) , 'g' ,'LineWidth' , 1) ;
% 
% close all