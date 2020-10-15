function noff2apts(filename)

dot_id = strfind(filename , '.');
apts_name = [filename(1:dot_id(end)) 'apts'] ;

[pts normals] = read_noff(filename);

write_apts(apts_name,pts,normals) ;
