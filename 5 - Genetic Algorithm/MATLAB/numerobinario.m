% PROGRAMA PARA GENERAR UNA SECUENCIA BINARIA POR ALGORITMO GENETICO
% EL PROGRAMA ENCUENTRA UN NUMERO EN BINARIO UTILIZANDO 
% MUTACION Y CROSSOVER
% LA FUNCION OBJETIVO ES LA DIFERENCIA EN VALOR ABSOLUTO 
% DE LOS HIJOS CON EL NUMERO OBJETIVO
% Ver 2.0 06/03/2020

clear all
clc
rand('seed',sum(100*clock))
% NUMERO OBJETIVO
nobj=200200;
% NUMERO DE BITS UTILIZADOS Y VALOR EN BINARIO
nb=ceil(log(nobj)/log(2));
[vbin]=decbin(nobj);

% NUMERO DE PADRES
npad=6;
% NUMERO DE INTERVALOS UTILIZADOS
nint=3;
% NUMERO DE HIJOS POR GENERACION
nhij=npad^nint;
% NUMERO DE GENERACIONES
ngen=10;

% INICIALIZACION DE VARIABLES
padres=zeros(npad,nb);
genef=0;
[maximo]=bindec(ones(1,nb));	

% GENERO LA POBLACION INICIAL
% Número inicial de hijos
nhijin=10;

pob0=zeros(nhijin,nb);
for i=1:nhijin
    % Generación de la población
    naleat=round(maximo*rand);
    [naleatbin]=decbin(naleat);
    tnal=length(naleatbin);
    naleatbin0=zeros(1,nb);
    for j=1:tnal
        naleatbin0(j+(nb-tnal))=naleatbin(j);
    end
    pob0(i,:)=naleatbin0;
    % FUNCION OBJETIVO DISTANCIA DE HAMMING
    errorv=xor(vbin,pob0(i,:));
    fobj(i)=sum(errorv);
    % FUNCION OBJETIVO DIFERENCIA EN DECIMAL
% 		[h1]=bindec(pob0(i,:));
% 		fobj(i)=abs(nobj-h1);	
end
% SELECCIONO A LOS MEJORES

v_fobj=[fobj' pob0];
indobj=sort(v_fobj,1);
padres=indobj(1:npad,2:nb+1);

[padres v_fobj(1:npad,1)]


gen=1;
%PORCENTAJE DE MUTACION
porcent=0.15;
while gen<ngen,
	% GENERACION DE LOS HIJOS DE LA POBLACION
	[hijos]=crover(padres,nint);
	% MUTACION EN LOS HIJOS EN UN PORCENTAJE DEL UMBRAL
	[hijosm]=muta(hijos,porcent);
	% GENERACION DE LA POBLACION INCLUYENDO A LOS PADRES
	pob=[hijos;hijosm];
	[ipx,ipy]=size(pob);
	% FUNCION OBJETIVO
	for j=1:ipx,
% FUNCION OBJETIVO DISTANCIA DE HAMMING
        errorv=xor(vbin,pob(j,:));
        fobj(j)=sum(errorv);
% FUNCION OBJETIVO DIFERENCIA EN DECIMAL
% 		[h1]=bindec(pob(j,:));
% 		fobj(j)=abs(nobj-h1);	
	end
	% SELECCION DE LOS MEJORES HIJOS
	indobj=sort(fobj);
	for j=1:npad,
		for k=1:ipx,
			if indobj(j)==fobj(k)
				padres(j,:)=pob(k,:);
			end
		end
	end
	[padres indobj(1:npad)']
	%pause
	% CONDICION DE LLEGADA A LA MEJOR GENERACION
	if indobj(1)==0
		genef=gen;
		gen=ngen-1;
		padres(1,:);
	end
	gen=gen+1;
end
[vbin]=decbin(nobj);
% Numero de individuos de la poblacion
ntot=2^nb;
nind=genef*(npad+nhij);
%ntot,nind
gen,genef,[padres indobj(1:npad)']

	



			