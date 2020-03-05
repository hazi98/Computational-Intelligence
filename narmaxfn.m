function [V]=narmaxfn(N,pow)
% 
% Encuentra una matriz de índices para construir las funciones de un modelo NARMAX
% de máxima potencia pow .
%
%	 function narmaxfn(N,pow)
%
%	N : Número de variables del modelo.
%	pow : Potencia máxima de los términos.
%     V : Vector de indices.

cadena0='';
cadena1='';
cadena2='';
k=1;
i0=0;
for(I=1:pow)
  cadena0=[cadena0 'i' int2str(I) '  ']; 
  cadena1=[cadena1 'for(i' int2str(I) '=i' int2str(I-1) ':N);'];
  cadena2=[cadena2 'end; '];
end
cadena=[cadena1 'V(k,:)=[ ' cadena0 ' ]; k=k+1;' cadena2 ];
if(pow~=0)
  eval(cadena);
else
  V=0;
end 
 