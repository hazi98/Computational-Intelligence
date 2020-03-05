% FUNCTION TO GENERATE THE SYMBOLIC REPRESENTATION OF PANN
% function [phis]=genphisy(ni,va,pot,phiest,comb_xy,input_bias)
% ni 		is the number of inputs
% va 	 IS THE NUMBER OF PREVIOUS VALUES FOR THE REGRESSION
%	 va(1)=NUMBER OF PREVIOUS VALUES OF THE INPUT
%	 va(2)=NUMBER OF PREVIOUS VALUES OF THE OUTPUT	
% pot 	 MAXIMUM POWER OF THE INPUTS
% phis 	 IS THE symbolic representation of PANN
% DIM(phi) = number of previous values x number of inputs
% phiest DEFINE THE STRUCTURE OF PHI(u,y) (phi(u,y)=0 if phiest=0)
% comb_xy		DEFINE THE STRUCTURE OF MZ(x,y)  MZ(x,y)=0 if comb_xy=0
% input_bias          INPUT BIAS INCLUDED IN THE FIRST COLUMN 1=YES, 0=NO

% Author: E. Gomez-Ramírez
% Ver 2.0 Release 1.0
% March 2009

function [phi]=genphisy(ni,prev_val,pot,comb_xy,input_bias);
% GENERATION OF THE SYMBOLIC INPUTS
for j=0:prev_val(1)
   for i=1:ni
      eval(['syms u' num2str(i) 'k' num2str(j) ';'])
   end
end
% GENERATION OF THE SYMBOLIC PREVIOUS VALUES OF THE OUTPUT
for i=1:prev_val(2)
   eval(['syms yk' num2str(i) ';'])
end
for i=1:prev_val(2)
   eval(['psals(i)=yk' num2str(prev_val(2)-i+1) ';'])
end
% GENERATION OF THE SYMBOLIC PREVIOUS VALUES OF THE INPUT
for j=0:prev_val(1)
   for i=1:ni
      eval(['pents((j)*ni+i)=u' num2str(i) 'k' num2str(prev_val(1)-j) ';'])
   end
end

% ROUTINE TO BUILD PHI
if (comb_xy==0)
   if ni==0
      [phisal]=polisy(psals,pot);
		phi=[phisal];
	else
		if (prev_val(2)~=0)
			[phient]=polisy(pents,pot);
			[phisal]=polisy(psals,pot);
			phi=[phient phisal];
		end
	end
else	
   if ni==0;
      [phisal]=polisy(psals,pot);
		phi=[phisal];
	else
		if (prev_val(2)~=0)
			pent=[pents psals];
			[phi]=polisy(pent,pot);
        else
            [phi]=polisy(pents,pot);
		end
	end
end
if input_bias==1
    phi=[1 phi];
end
