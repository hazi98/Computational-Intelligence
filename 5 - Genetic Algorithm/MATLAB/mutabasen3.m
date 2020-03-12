% function [hijosm]=muta(hijos,porcent)
% FUNCION PARA MUTAR UNA MATRIZ {1,0} EN UN PORCENTAJE [0,1]
% hijos   REPRESENTA LA MATRIZ A SER MUTADA
% porcent REPRESENTA EL PORCENTAJE A SER MUTADO
% hijosm  REPRESENTA LA MATRIZ MUTADA
% Ver 1.0 190997

function [hijosm]=mutabasen3(hijos,porcent)
[ix,iy]=size(hijos);
for i=1:ix,
	for j=1:iy,
		w=rand;
		if w<porcent
			hijosm(i,j)=randi([0,3]); %si entra en el porciento, mete NOT (~), MUTO

		else
			hijosm(i,j)=hijos(i,j); %copia el bit normal, NO MUTA
		end
		
	end
end
