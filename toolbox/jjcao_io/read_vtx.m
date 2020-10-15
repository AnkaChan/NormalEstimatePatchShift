function [verts,normals]=read_vtx(filename)
fid=fopen(filename,'r');
if(fid==-1)
    error('can''t open the file');
    return;
end
a=fscanf(fid,'%d\n',[1,1])
verts = zeros(a , 3) ;
for i=1:a
verts(i,:)=fscanf(fid,'%f %f %f',[1,3]);
end
fclose(fid);