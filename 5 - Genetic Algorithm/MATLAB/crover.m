% function [hijos]=crover(padres,nint)
% FUNCION PARA OBTENER LOS HIJOS APARTIR DE COMBINACIONES DE LOS PADRES
% padres MATRIZ DONDE SE ALMACENAN LOS PADRES 
%        DIMENSIONES numero de padres X numero de bits
% hijos  MATRIZ DONDE SE ALMACENAN LOS HIJOS
%	 DIMENSIONES numero de hijos X numero de bits
%	 numero de hijos=numero de padres^numero de intervalos
% nc     NUMERO DE CROMOSOMAS nc=nb/nint
% nint   NUMERO DE INTERVALOS OBTENIDOS
%  	 CONDICIONES nint<=nc
% Ver 1.0 190997

function [hijos]=crover(padres,nint)

[npad,nb]=size(padres);
nc=floor(nb/nint);
nhij=npad^nint;
for j=1:nint,
	for i=1:nhij,
		k=rem(floor((i-1)/npad^(nint-j)),npad)+1;
		hijos(i,nc*(j-1)+1:nc*j)=padres(k,nc*(j-1)+1:nc*j);
	end
end
for i=1:nhij,
	k=rem(i-1,npad)+1;
	hijos(i,nc*(j-1)+1:nb)=padres(k,nc*(j-1)+1:nb);
end

