% function [x_train_in]=gen_MZ_in(x_train,prev_val)
% FUNCTION TO GENERATE THE INPUT WITH PREVIOUS VALUES OF THE INPUTS
% prev_val NUMBER OF PREVIOUS VALUES
% x_train     INPUT PATTERN 
% r_xtrain NUMBER OF POINTS
% c_xtrain NUMBER OF INPUTS

function [x_train_in]=gen_MZ_in(x_train,prev_val)

[r_xtrain,c_xtrain]=size(x_train);
if (length(x_train)==1)&(x_train==0)
else
    x_train_in=zeros(r_xtrain-prev_val(1),prev_val(1)+(c_xtrain-1)*(prev_val(1)+1));
	if prev_val(1)~=0
		for k=0:c_xtrain-1
			for i=1:prev_val(1)+1
				for j=1:r_xtrain-prev_val(1)
						x_train_in(j,i+k*(prev_val(1)+1))=x_train(j+i-1,k+1);
				end
            end
        end
	else
		x_train_in=x_train;
	end
end