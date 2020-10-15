function [ density ] = computeDensity( numP )

global TP;
global neigh_matrix;
global P;

for i = 1:TP.nSample
    short_edge_id = neigh_matrix(1:numP);
    v = repmat(P.pts(i,:),numP,1) - P.pts(short_edge_id,:);
    d = sqrt(sum(v.*v,2));
    density(i) = sum(d)/(numP - 1);
end
density = (min(density) * ones(size(density))) ./ density;
%density = (min(area_w) * ones(size(density))) ./ area_w;
%density = density / max(density);
l = sum(density)/(TP.nSample*(numP-1));
end

