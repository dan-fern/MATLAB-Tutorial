%%% multGauss.m
%%% Daniel Fernández
%%% 22 October 2013
%%% multGauss.m is a function that receives a 4 x 3 matrix (Gauss) and a
%%% 1 x 191 matrix (domain, x) and performs the gaussmf function on the
%%% data, summing all the results.  It then plots the sum over the domain.
%%% Prior to any operations, it verifies the input matrix, Gauss is of the
%%% correct size.
function multGauss(x,Gauss)
if size(Gauss,2)~=3
    error('Input Matrix must be 3 Columns')
end
%   error checking
g = zeros(size(Gauss,1),size(x,2));
%   g will serve as an aiding 4 x 191 matrix.
for n=1:size(Gauss,1)
    g(n,:) = Gauss(n,3) * gaussmf(x,[Gauss(n,1) Gauss(n,2)]);
end
%   With g populated, the sum of each column can now be taken.  This matrix
%   called y is a 1 x 191 matrix and is plotted against the domain, x.
y = sum(g);
figure(2);
plot(x,y);
end
