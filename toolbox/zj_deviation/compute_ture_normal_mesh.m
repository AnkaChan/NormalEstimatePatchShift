function ture_normals = compute_ture_normal_mesh(filename)

[v, f] = read_mesh(filename);
[normal,normalf] = compute_normal(v, f);
ring = compute_vertex_face_ring(f);
ture_normals = cell(1,length(ring));

for i = 1:length(ring)
    ture_normals{i} = normalf(:,ring{i});
end