%primero se definen los tipos de perfil que habran
tipo(inventor).
tipo(astronauta).

%luego de acuerdo a los perfiles se listaran las personas
perfil(inventor,oscar).
perfil(inventor,dywen).
perfil(astronauta, jair).

%1 proyectos personales del personaje
proyectos_personales(oscar,10). %se mide en horas por dia
proyectos_personales(dywen,15).
proyectos_personales(jair,5).

%2 tiempo que le dedicaban a sus proyectos
tiempo_proyectos(oscar,20). %promedio
tiempo_proyectos(dywen,30).
tiempo_proyectos(jair,10).

%mejor tiempo
% si regreso el nombre del usuario significa que tiene mas proyectos que
% los que estan en la base de conocimiento, dar un consejo como que el
% que muchp abarca poco aprieta
% esto devuelve todas las incidencias , entonces deberiamos agrupar
% podriamos devolverle algo como tal personaje tuvo estas calificaciones
% pero hubieron otros mejores
datos_pp(D,N,R,P):-perfil(P,N), proyectos_personales(N,R),D =< R.
datos_tp(D,N,R,P):-perfil(P,N), tiempo_proyectos(N,R), D =< R.
datos_te(D,N,R,P):-perfil(P,N), trabajo_equipo(N,R), R == D.
datos_adap(D,N,R,P):-perfil(P,N), adaptacion(N,R), R == D.
datos_agm(D,N,R,P):-perfil(P,N), agilidad_mental(N,R), R == D.
datos_ra(D,N,R,P):-perfil(P,N), razonamiento(N,R), R == D.
datos_mf(D,N,R,P):-perfil(P,N), miedo_fracaso(N,R), R == D.

%3 si estaban dispuestos a trabajar en equipo
trabajo_equipo(oscar,si). %si no a veces
trabajo_equipo(dywen,si).
trabajo_equipo(jair,si).

%4 el nivel de exito que alcanzaron
nivel_exito(oscar,medio).
nivel_exito(dywen,alta).
nivel_exito(jair,alta).

%5 la adaptacion que tenian
adaptacion(oscar,no). %si no a veces
adaptacion(dywen,no).
adaptacion(jair,si).

%6 su agilidad mental
agilidad_mental(oscar,medio). %baja media alta
agilidad_mental(dywen,alta).
agilidad_mental(jair,alta).

%7 su razonamiento
razonamiento(oscar,alta). %baja media alta
razonamiento(dywen,alta).
razonamiento(jair,alta).

%8 si tenian miedo al fracaso
miedo_fracaso(oscar,no). %si no a veces
miedo_fracaso(dywen,no).
miedo_fracaso(jair,no).


% aqui se listan los consejos para los problemas que se encuentren en
% los datos que el usuario proveera
consejouno('Consejo 1').
consejodos('Consejo 2').
consejotres('Consejo 3').
consejocuatro('Consejo 4').
consejocinco('Consejo 5').
consejoseis('Consejo 6').
consejosiete('Consejo 7').
consejoocho('Consejo 8').

consejouno2('Consejo 1').
consejodos2('Consejo 2').
consejotres2('Consejo 3').
consejocuatro2('Consejo 4').
consejocinco2('Consejo 5').
consejoseis2('Consejo 6').
consejosiete2('Consejo 7').
consejoocho2('Consejo 8').



% problemas: aqui es para mas o menos encontrar los problemas segun los
% datos que ingresara el usuario
problema(X, R):-X = 'no', R is 2; X = 'a veces', R is 1.
problema_dos(X, R):-X = 'baja', R is 2; X = 'media', R is 1.
problema_inverso(X,R):-X = 'si', R is 1; X = 'a veces', R is 2.
problema_proyecto(X,R):-X =< 10, X > 3, R is 2;X =< 3, R is 1.
problema_tiempo(X,R):-X < 5, X > 2, R is 2; R is 1.

% soluciones: de acuerdo a los problemas que se hayan encontrado se
% plantearan determinadas soluciones, dependiendo del caso
solucion_letra(X,R,C):-(problema(X,RE), ((RE = 1, C = 3, consejotres(R));(RE = 2, C = 3, consejotres2(R))));
(problema(X,RE), ((RE = 1, C = 5, consejocinco(R));(RE = 2, C = 5, consejocinco2(R))));
(problema(X,RE), ((RE = 1, C = 4, consejoocho(R));(RE = 2, C = 4, consejoocho2(R))));
(problema_dos(X,RE), ((RE = 1, C = 6, consejoseis(R));(RE = 2, C = 6, consejoseis2(R))));
(problema_dos(X,RE), ((RE = 1, C = 7, consejosiete(R));(RE = 2, C = 7, consejosiete2(R))));
(problema_inverso(X,RE), ((RE = 1, C = 8, consejoocho(R));(RE = 2, C = 8, consejoocho2(R)))).

solucion_num(X,R,C):-(problema_proyecto(X,RE), ((RE = 1, C = 1, consejouno(R));(RE = 2, C = 1, consejouno(R))));
(problema_tiempo(X,RE), ((RE = 1, C = 2, consejodos(R));(RE = 2, C = 2, consejodos(R)))).


%funciones para ayudar a sacar el peso de los personajes
resultado_proyectos(D,R):-D >= 15,R is 2;D < 15, R is 1.
resultado_tiempo(D,R):-D >= 10,R is 2;D < 10, R is 1.
sumar(A,B,R):-R is A + B.
resultado_si_no_aveces(D,R):-(D == 'si', R is 2);
    (D == 'no', R is 0);(D == 'a veces', R is 1).
resultado_si_no_aveces_inverso(D,R):-(D == 'si', R is 0);
    (D == 'no', R is 2);(D == 'a veces', R is 1).
resultado_bajo_medio_alto(D,R):-(D == 'bajo', R is 0);
    (D == 'medio', R is 1);(D == 'alta', R is 2).

%obtener los datos de los personajes segun categorias
datos_perfil(N,P,DP,DT,DE,DA,DM,DR,MF,NE):-
    perfil(P,N), proyectos_personales(N,DP), tiempo_proyectos(N,DT),
    trabajo_equipo(N,DE), adaptacion(N, DA), agilidad_mental(N,DM),
    razonamiento(N,DR), miedo_fracaso(N,MF), nivel_exito(N,NE).

%obtener el peso del personaje
peso_persona(N,P,PESO):- datos_perfil(N,P,DP,DT,DE,DA,DM,DR,MF,NE),
   (resultado_tiempo(DP,RTI), sumar(0,RTI,NS),
   resultado_proyectos(DT,RT), sumar(NS,RT,NS1),
   (resultado_si_no_aveces(DE, R), sumar(NS1, R, NS2)),
   (resultado_si_no_aveces(DA, RA), sumar(NS2,RA,NS3)),
   (resultado_bajo_medio_alto(DM, RM), sumar(NS3,RM,NS4)),
   (resultado_bajo_medio_alto(DR, RR), sumar(NS4,RR,NS5)),
   (resultado_si_no_aveces_inverso(MF, RF), sumar(NS5,RF,NS6)),
   (resultado_bajo_medio_alto(NE, RE), sumar(NS6,RE,NS7))),
   PESO is NS7.


% aun faltan varias cosas como comparar al usuario con determinado
% personaje, se comparara con el personaje que tenga mayor peso y se le
% dira al usuario con quien se lo a comparado dandole las
% recomendacciones respectivas














