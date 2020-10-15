function []=write_apts(filename,verts,normals)

%   write_apts(filename, vertex, normals);
%
%   vertex must be of size [n,3]
%   normals must be of size [p,3]
%
fid=fopen(filename,'wt');
if(fid==-1)
    error('can''t open the file');
    return;
end
%header
fprintf(fid,'[Expe/PointSet/Ascii/0.2]\n');
fprintf(fid,'property position 3 r32\n');
fprintf(fid,'property radius 1 r32\n');
fprintf(fid,'property normal 3 r32\n');
fprintf(fid,'property color 4 ui8\n');
fprintf(fid,'nofpoints %d\n', size(verts,1));
fprintf(fid,'data\n');
%write the points & normals
radius = ones(size(verts,1),1)*0.6;
colors = ones(size(verts,1),4);
protys = zeros(size(verts,1),1);
verts=[verts radius normals colors protys];
fprintf(fid,'%f,%f,%f ; %f ; %f,%f,%f ; %d,%d,%d,%d ; %d\n',verts');
fclose(fid);