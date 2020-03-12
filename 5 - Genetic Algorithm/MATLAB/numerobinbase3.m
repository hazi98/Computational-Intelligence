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
%nobj=200200

% NUMERO DE BITS UTILIZADOS Y VALOR EN BINARIO
%nb=ceil(log(nobj)/log(2))
%[vbin]=decbin(nobj)
%[vbin] = [2 0 1 2 1 2 0 2 0 2 1 2 1] %o algo asi
[vbin]=randi([0,3],[1,18])
nb=length(vbin)

% NUMERO DE PADRES
npad=6
% NUMERO DE INTERVALOS UTILIZADOS
nint=3
% NUMERO DE HIJOS POR GENERACION
nhij=npad^nint
% NUMERO DE GENERACIONES
ngen=10;

% INICIALIZACION DE VARIABLES
padres=zeros(npad,nb)
genef=0%generacion 0
[maximo]=bindec(ones(1,nb))%numero de binario a decimal y su valor max si tiene 1 en todas las posiciones

% GENERO LA POBLACION INICIAL
% Número inicial de hijos
nhijin=10;

pob0=zeros(nhijin,nb);
for i=1:nhijin
    % Generación de la población
    %naleat=round(maximo*rand);%saca un aleatorio que no pase del numero maximo en decimal%creacion de hijo
    %[naleatbin]=decbin(naleat);%pasa el aleatorio decimal a binario
    %tnal=length(naleatbin);%tamaño del aleatorio binario
    %naleatbin0=zeros(1,nb);%vec de 0s del tamaño nb
    %for j=1:tnal%for para pasar los hijos a binario con el valor correcto
    %    %j+(nb-tnal)%j+nb(18)-tamaño del aleatorio binario, por ejemplo si tnal = 17 empieza desde la segunda casilla
    %    %esto es porque como son binarios empiezan de deracha a izq, si no, cambia el valor
    %    naleatbin0(j+(nb-tnal))=naleatbin(j);%pasa de bit por bit
    %end
    [naleatbin]=randi([0,3],[1,18])
    pob0(i,:)=naleatbin;%guarda el hijo en la pob0
    % FUNCION OBJETIVO DISTANCIA DE HAMMING
    for iaux = 1:nb
      errorv(iaux) = abs(vbin(iaux) - pob0(i,iaux));
    end
    %errorv=xor(vbin,pob0(i,:));%calcular el XOR de cada hijo
    fobj(i)=sum(errorv);%guarda la suma del resultado XOR, distancia hamming, para cada hijo
    % FUNCION OBJETIVO DIFERENCIA EN DECIMAL
% 		[h1]=bindec(pob0(i,:));
% 		fobj(i)=abs(nobj-h1);	
end
% SELECCIONO A LOS MEJORES

v_fobj=[fobj' pob0]%indexa la distancia de hamming en la primera columna de una mat con los hijos de la pob0
indobj=sort(v_fobj,1)%los acomoda de mayor a menor por la  
%se podria poner algo así

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

padres=vecPruebapad(1:npad,2:nb+1)%tomo los primeros 6 valores (npadres valores)%aqui creo esta mal pq desacomodo mas del primer renglon

[padres vecPruebapad(1:npad,1)]


gen=1;
%PORCENTAJE DE MUTACION
porcent=0.15;
while gen<ngen,
	% GENERACION DE LOS HIJOS DE LA POBLACION
	[hijos]=crover(padres,nint);%crossover
	% MUTACION EN LOS HIJOS EN UN PORCENTAJE DEL UMBRAL
	[hijosm]=mutabasen3(hijos,porcent);%mutacion
 
	% GENERACION DE LA POBLACION INCLUYENDO A LOS PADRES
	pob=[hijos;hijosm];%pone los hijos e hijos mutados dentro de la poblacion
	[ipx,ipy]=size(pob);
	% FUNCION OBJETIVO
	for j=1:ipx,%432
% FUNCION OBJETIVO DISTANCIA DE HAMMING
    for iaux = 1:nb
      errorv(iaux) = abs(vbin(iaux) - pob(j,iaux));
    end        
    fobj(j)=sum(errorv);%saca la distancia de hamming de los posibles 432
% FUNCION OBJETIVO DIFERENCIA EN DECIMAL
% 		[h1]=bindec(pob(j,:));
% 		fobj(j)=abs(nobj-h1);	
	end
	% SELECCION DE LOS MEJORES HIJOS
	indobj=sort(fobj);%acomodar por dHamming el vec de dHamming de 432
  
	for j=1:npad,%6
		for k=1:ipx,%432
			if indobj(j)==fobj(k)
				padres(j,:)=pob(k,:);%tomo los 6 mejores % preguntar si no hay pedo que se repita
        fobj(k) = 99;
        break
			end
		end
	end
	[padres indobj(1:npad)']
	%pause
	% CONDICION DE LLEGADA A LA MEJOR GENERACION, % se sale si encuentra el valor objetivo
	if indobj(1)==0
		genef=gen;
		gen=ngen-1;
		padres(1,:);%padre que encontro el numero binario objetivo
	end
	gen=gen+1;
end
vbin
% Numero de individuos de la poblacion
ntot=2^nb;%no se que hace
nind=genef*(npad+nhij);%numero de individuos de la poblacion creo, no estoy seguro, solo lo pongo pq lo menciona arriba
%ntot,nind
gen,genef,[padres indobj(1:npad)']%ultimos especimenes