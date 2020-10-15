function ture_normals = compute_ture_normals_varcube(filename)

[v n]=read_noff(filename);
ture_normals = cell(1,length(v));

for i = 1:length(v)
    id1 = find(v(i,:) < 0.01);
    v(i,id1) = 0;
    id2 = find(v(i,:) > 0.99);
    v(i,id2) = 1;
    id = union(id1,id2);
    for j = 1:length(id)
        if id(j) == 1
            tn = [1 0 0];
            ture_normals{i}(:,j) = tn;
        end
        if id(j) == 2
            tn = [0 1 0];
            ture_normals{i}(:,j) = tn;
        end
        if id(j) == 3
            tn = [0 0 1];
            ture_normals{i}(:,j) = tn;
        end
    end
end
write_noff('../data/var_cube_randm1_edge.off',v,n);
