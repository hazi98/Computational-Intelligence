% function [vdec]=bindec(vbin)
% FUNCTION TO CONVERT A BINARY NUMBER TO DECIMAL
% vdec DECIMAL NUMBER
% vbin BINARY NUMBER 
% Date 010997

function [vdec]=bindec(vbin)

vdec=0;
nb=length(vbin);
for i=0:nb-1,
	vdec=vdec+2^(i)*vbin(nb-i);
end

