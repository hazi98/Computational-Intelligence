% function [cn]=mincua(phi,y)
% Release 1.0 Date 221196
% LEAST MEAN SQUARE FUNCTION
% cn parameters to be identified
% om model order
% np number of points
% phi regresor   number of points x number of inputs 
% y function to be identified

function [cn]=mincua(phi,y)
[np,om]=size(phi);
Pn=100000*eye(om);
cn=zeros(om,1);
for i=1:np
	Pn=Pn-Pn*phi(i,:)'*phi(i,:)*Pn/(1+phi(i,:)*Pn*phi(i,:)');
	cn=cn+Pn*phi(i,:)'*(y(i)-phi(i,:)*cn);
end
