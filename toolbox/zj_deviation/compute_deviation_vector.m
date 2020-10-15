function deviation_vector = compute_deviation_vector(ture_normals, estimate_normals,tal_degree)

nSample = length(ture_normals);
if nargin <3
    tal_degree  = 90;
end
% if (length(estimate_normals) ~= nSample)
%     war
% end
tal = (tal_degree/360)*2*pi;
for i = 1:nSample
    simi = ture_normals(i,:) * estimate_normals(i,:)';
    tdeviation = acos(abs(simi));
    if tdeviation > tal
        deviation_vector(i) = pi/2;
    else
        deviation_vector(i) = tdeviation;
    end
        
end