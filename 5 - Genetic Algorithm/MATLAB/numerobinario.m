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
%nobj=200200;

% NUMERO DE BITS UTILIZADOS Y VALOR EN BINARIO
%nb=ceil(log(nobj)/log(2));
%[vbin]=decbin(nobj);

% Base del numero
nbase = 10;
ntvec = 18;
[vbin]=randi([0,nbase],[1,ntvec])
nb=length(vbin)

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
% N�mero inicial de hijos
nhijin=10;

pob0=zeros(nhijin,nb);
for i=1:nhijin
    % Generar enterp aleatorio
    [naleatbin]=randi([0,nbase],[1,nb])
    % Guarda el hijo generado en la fila i de pob0
    pob0(i,:)=naleatbin;
    % FUNCION OBJETIVO DISTANCIA Euclideana 1D
    for iaux = 1:nb
      errorv(iaux) = abs(vbin(iaux) - pob0(i,iaux));
    end
    % Guardar la distancia de hamming
    fobj(i)=sum(errorv);
end
% SELECCIONO A LOS MEJORES
% Matriz con columnas de [Distancia de Hamming, Poblacion]
v_fobj=[fobj' pob0];
% Ordenar de mayor a menor por la Distancia de Hamming [1]
indobj=sort(v_fobj,1);

for i=1:nhijin
  for j=1:nhijin
    if(indobj(i,1) == v_fobj(j,1) )
       vecPruebapad(i,:) = v_fobj(j,:);
       v_fobj(j,1) = 99;
       break
    endif
  endfor
endfor

vecPruebapad

padres=vecPruebapad(1:npad,2:nb+1)
%tomo los primeros 6 valores (npadres valores)%aqui creo esta mal pq desacomodo mas del primer renglon

[padres vecPruebapad(1:npad,1)]

gen=1;
%PORCENTAJE DE MUTACION
porcent=0.15;
% Ciclo de mutaci�n
while gen<ngen,
	% GENERACION DE LOS HIJOS DE LA POBLACION (Crossover)
	[hijos]=crover(padres,nint);
	% MUTACION EN LOS HIJOS EN UN PORCENTAJE DEL UMBRAL
	[hijosm]=mutabasen(hijos,porcent,nbase);
	% GENERACION DE LA POBLACION INCLUYENDO A LOS PADRES
	% Concatena las matrices de hijos normales e hijos mutados en la poblaci�n
  pob=[hijos;hijosm];
	[ipx,ipy]=size(pob);
	% FUNCION OBJETIVO
	for j=1:ipx,
        % FUNCION OBJETIVO DISTANCIA Euclideana
        for iaux = 1:nb
          errorv(iaux) = abs(vbin(iaux) - pob(j,iaux));
        end    
        fobj(j)=sum(errorv);
        % FUNCION OBJETIVO DIFERENCIA EN DECIMAL
        % [h1]=bindec(pob(j,:));
        % fobj(j)=abs(nobj-h1);	
	end
	% SELECCION DE LOS MEJORES HIJOS
  % Ordenar por distancia de Hamming la poblaci�n
	indobj=sort(fobj);
	for j=1:npad,
		for k=1:ipx,
			if indobj(j)==fobj(k)
        % Se eligen a los mejores hijos
				padres(j,:)=pob(k,:);
        fobj(k) = 99;
			end
		end
	end
  % Impresi�n de datos
	[padres indobj(1:npad)']
	%pause
	% CONDICION DE LLEGADA A LA MEJOR GENERACION
  % Si encontramos el valor objetivo, hemos terminado
	if indobj(1)==0
		genef=gen;
		gen=ngen-1;
    % Padre que logr� encontrar el n�mero objetivo
		padres(1,:);
	end
	gen=gen+1;
end
vbin
% Numero de individuos de la poblacion
ntot=2^nb;
nind=genef*(npad+nhij);
gen,genef,[padres indobj(1:npad)']
