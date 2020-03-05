% FUNCTION TO GENERATE THE MZ MATRIX OF THE INPUTS AND OUTPUTS
% function [ MZ, y_real ] = gen_MZ_ln ( x_train, y_train, prev_val, pow, ration, comb_xy , input_bias)
% 
% x_train IS THE INPUT PATTERN, (IF IT DOESN'T EXIST PENT PUT ZERO)
% y_train IS THE OUTPUT PATTERN WITH ALL THE TERMS
% prev_val 	 IS THE NUMBER OF PREVIOUS VALUES FOR THE REGRESSION
%	 prev_val(1)=NUMBER OF PREVIOUS VALUES OF THE INPUT
%	 prev_val(2)=NUMBER OF PREVIOUS VALUES OF THE OUTPUT	
% max_pow 	 MAXIMUM POWER OF THE INPUTS
% ration       RATIONAL USED FOR THE POLYNOMIAL
% MZ 	 IS THE INPUT MATRIX FOR THE LEARNING
%	 DIM(MZ) = number of previous values x number of inputs
% comb_xy		DEFINE THE STRUCTURE OF MZ(x,y)  MZ(x,y)=0 if comb_xy=0
% bias          INPUT BIAS INCLUDED IN THE FIRST COLUMN 1=YES, 0=NO
%
% Author: E. Gomez-Ramirez
%         A. Flores-Mendez  
% Ver 2.0 Release 2.0
% October 2006

function [ MZ, y_real ] = gen_MZ_ln ( x_train, y_train, prev_val, max_pow, ration, comb_xy, input_bias )

% OUTPUT 
if prev_val(2)>0
    [x_train_out,y_real]=gen_MZ_out(y_train,prev_val);
end

% INPUT 
% ROUTINE TO FIX THE SIZE OF x_train_in and x_train_out
if (length(x_train)==1)&(x_train==0)
else
	[x_train_in]=gen_MZ_in(x_train,prev_val);
	if prev_val(2)-prev_val(1)>0,
		[ix,iy]=size(x_train_in);
		x_train_in=x_train_in(1+prev_val(2)-prev_val(1):ix,:);
	else
		if prev_val(1)~=0,
			[ix,iy]=size(x_train_out);
			x_train_out=x_train_out(1+prev_val(1)-prev_val(2):ix,:);
            y_real=y_real(1+prev_val(1)-prev_val(2):length(y_real));
        end
    end
end

% ROUTINE TO BUILD MZ

if (comb_xy==0)
	if (length(x_train)==1)&(x_train==0)
		[MZ]=gen_polinom(x_train_out,1,1);
    else
		if (prev_val(2)~=0)
			[MZ_in]=gen_polinom(x_train_in,1,1);
			[MZ_out]=gen_polinom(x_train_out,1,1);
            MZ=[MZ_in MZ_out];
        else   
  			[MZ]=gen_polinom(x_train_in,1,1);
        end
	end
else	
	if (length(x_train)==1)&(x_train==0)
		[MZ]=gen_polinom(x_train_out,1,1);
	else
		if (prev_val(2)~=0)
			x_train=[x_train_in x_train_out];
			[MZ]=gen_polinom(x_train,1,1);
	    else   
  			[MZ]=gen_polinom(x_train_in,1,1);
        end
	end
end

[m,n]=size(MZ);

for i1=1:maxpower
% for i1=-maxpower:maxpower
    R=zeros(size(MZ));
    for i2=1:n
           R(:,i2)=MZ(:,i2).^(i2/ration).*exp(-MZ(:,i2));
    end
    MZ=[MZ R];
end

if input_bias==1
    MZ=[ones(size(y_real)) MZ];
end