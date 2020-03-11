%function [phi]=polisy(pent,pot)
% FUNCTION TO OBTAIN THE POLYNOMIAL APPROXIMATION OF THE INPUTS
% pent  is the input matrix
% pot   is the maximum power of the polynomial approximation
% phi   is the polynomial result

function [phi]=polisy(pent,pot)

[ipentx,ipenty]=size(pent);
[indices]=narmaxfn(ipenty,pot);
[indx,indy]=size(indices);
phi=[pent zeros(1,indx-1-ipenty)];

for i=2:indx,
	phiones=ones(ipentx,1);
	for j=1:indy,
		if indices(i,j)>0,
			phiones=phiones.*pent(:,indices(i,j));
        end
    end
    phi(:,i-1)=phiones;
end

%for i=ipenty+1:indx,
%	phiones=ones(ipentx,1);
%    for j=1:indy,
%		if indices(i,j)>0,
%            phiones=phiones*pent(indices(i,j));
%		end
%	end
%   phi(i-1)=phiones;
%end
