% disco(artista, nombreDelDisco, cantidad, año).
disco(floydRosa, elLadoBrillanteDeLaLuna, 1000000, 1973).
disco(tablasDeCanada, autopistaTransargentina, 500, 2006).
disco(rodrigoMalo, elCaballo, 5000000, 1999).
disco(rodrigoMalo, loPeorDelAmor, 50000000, 1996).
disco(rodrigoMalo, loMejorDe, 50000000, 2018).
disco(losOportunistasDelConurbano, ginobili, 5, 2018).
disco(losOportunistasDelConurbano, messiMessiMessi, 5, 2018).
disco(losOportunistasDelConurbano, marthaArgerich, 15, 2019).

%manager(artista, manager).
manager(floydRosa, normal(15)).
manager(tablasDeCanada, buenaOnda(cachito, canada)).
manager(rodrigoMalo, estafador(tito)).

% Punto 1



clasico(Artista) :- 
    disco(Artista,loMejorDe,_,_). 

clasico(Artista) :- 
    disco(Artista,_,CantCopias,_),
    CantCopias > 100000. 

% Punto 2
artista(Artista) :-
    disco(Artista,_,_,_). 

cantidadesVendidas(Artista, CopiasHistoricas) :- 
    unidadesTotales(Artista, ListaDeCopias), 
    sum_list(ListaDeCopias, CopiasHistoricas). 

unidadesTotales(Artista, ListaDeCopias) :- 
    artista(Artista), 
    findall(Copias, disco(Artista,_,Copias,_), ListaDeCopias).

% Punto 3 
derechosDeAutor(Artista, ImporteDerechos) :- 
    cantidadesVendidas(Artista, Cantidad),
    ImporteNeto is Cantidad * 100,  
    importeTotal(Artista,ImporteNeto,ImporteDerechos). 

importeTotal(Artista, ImporteNeto, ImporteDerechos) :- 
    manager(Artista, Manager),
    tipoDeDescuento(Manager, Porcentage),
    ImporteDerechos is ImporteNeto - ImporteNeto * Porcentage / 100. 

tipoDeDescuento(normal(Porcentage), Porcentage).
tipoDeDescuento(buenaOnda(_, Lugar), Porcentage) :- 
    lugar(Lugar, Porcentage). 
tipoDeDescuento(estafador(_), 100). 

lugar(canada, 5).
lugar(mexico, 15). 

% Punto 4

namberuan(Artista, Anio) :- 
    sinManager(Artista), 
    cantCopiasAnio(Artista, Anio, Copias),
    forall(cantCopiasAnio(_,Anio,OtrasCopias), Copias > OtrasCopias).

cantCopiasAnio(Artista, Anio, Copias) :-
    sinManager(Artista),
    disco(Artista,_,Copias,Anio). 


sinManager(Artista) :- 
    disco(Artista,_,_,_),
    not(manager(Artista,_)). 
    
    