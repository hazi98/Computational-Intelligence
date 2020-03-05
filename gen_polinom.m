%function [MZ]=gen_polinom(x_train,max_pow,ration)
% FUNCTION TO OBTAIN THE POLYNOMIAL APPROXIMATION OF THE INPUTS
% x_train  is the input matrix
% max_pow   is the maximum power of the polynomial approximation
% MZ   is the polynomial result


function [MZ]=gen_polinom(x_train,max_pow,ration)

[r_xtrain,c_xtrain]=size(x_train);
[index]=narmaxfn(c_xtrain,max_pow);
[r_index,c_index]=size(index);
MZ=zeros(r_xtrain,r_index-1);
x_train = x_train .^ (1 / ration) ;
for i=2:r_index,
	MZones=ones(r_xtrain,1);
	for j=1:c_index,
		if index(i,j)>0,
			MZones=MZones.*x_train(:,index(i,j));
        end
    end
    MZ(:,i-1)=MZones;
end

