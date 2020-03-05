% function [x_train_out,y_real]=gen_MZ_out(y_train,prev_val)
% FUNCTION TO GENERATE THE INPUT WITH PREVIOUS VALUES OF THE OUTPUT
% y_train IS THE OUTPUT PATTERN WITH ALL THE TERMS
% prev_val NUMBER OF PREVIOUS VALUES


function [x_train_out,y_real]=gen_MZ_out(y_train,prev_val)
npoints=length(y_train);
if prev_val(2)>0
	for i=1:prev_val(2)
		for j=1:npoints-prev_val(2)
			x_train_out(j,i)=y_train(j+i-1);
		end
	end
end
y_real(1:npoints-prev_val(2),1)=y_train(1+prev_val(2):npoints);
