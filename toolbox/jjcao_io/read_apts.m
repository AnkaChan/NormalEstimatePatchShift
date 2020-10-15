%¶ÁÈ¡NOFFÎÄ¼þ
function [verts,normals,colors,radius, protys]=read_apts(filename)
fid=fopen(filename,'r');
if(fid==-1)
    error('can''t open the file');
    return;
end
for i = 1:5
    str = fgetl(fid);
end
a = fscanf(fid,'nofpoints %d\n');
str = fgetl(fid);
for i=1:a
verts(i,:)= fscanf(fid,['%f' ',' '%f' ',' '%f' ' ; '],[1,3]);
radius(i,:) = fscanf(fid,['%f' ' ; '],1);
normals(i,:)=fscanf(fid,['%f' ',' '%f' ',' '%f' ' ; '],[1,3]);
colors(i,:) = fscanf(fid,['%f' ',' '%f' ',' '%f' ',' '%f' ' ; '],[1,4]);
protys(i,:) = fscanf(fid,['%f\n'],[1,1]);
end
fclose(fid);