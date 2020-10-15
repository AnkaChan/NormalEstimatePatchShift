function modify_normals = direction_normal(ture_normals, estimate_normals)
%5 输入的为行向量

nSample = length(ture_normals);
for i = 1:nSample
    simi = ture_normals(i,:) * estimate_normals(i,:)';
    if simi > 0
        modify_normals(i,:) = estimate_normals(i,:);
    else
        modify_normals(i,:) = -estimate_normals(i,:);
    end 
end