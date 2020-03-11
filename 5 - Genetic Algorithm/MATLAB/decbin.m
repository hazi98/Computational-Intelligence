% function [vbin]=decbin(vdec)
% FUNCTION TO CONVERT A DECIMAL NUMBER TO BINARY 
% vdec DECIMAL NUMBER
% vbin BINARY NUMBER vbin(1) more significant bit
%  Ver 1.0 Date 190997

function [vbin]=decbin(vdec)
i=0;
p=floor(log(vdec)/log(2))+1;
while vdec>1,
	vbin(p-i)=rem(vdec,2);
	vdec=fix(vdec/2);
	i=i+1;
end
vbin(1)=1;
