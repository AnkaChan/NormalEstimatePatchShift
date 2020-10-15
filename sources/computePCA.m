function [vlue,vctr] = computePCA( X )

X = X/(norm( max(X) ) - norm( min(X) ));
X = X - ones(size(X))*diag(mean(X));
C = X'*X/size(X,1);
[vctr, vlue] = eig(C);
% if isempty(find(C == Inf,1)) && isempty(find(isnan(C),1))
%     [vctr, vlue] = eig(C);
% else
% vctr = diag([1 1 1]);
% vlue = diag([1 1 1]);
% end
end

