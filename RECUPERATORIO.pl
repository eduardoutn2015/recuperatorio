%banda(Nombre, AnioDeFormacion, Localidad, Integrantes).
banda(finta, 2007, haedo, [ale, juli, gabo, ludo, anuk]).
banda(aloeVera, 2007, cordoba, [lula, bren, gaby]).
banda(losEscarabajos, 1960, losPiletones, [juan, pablo, jorge, ricardo]).
banda(plastica, 1983, palermoHollywood, [jaime, kirk, rober, lars]).
banda(oceania, 1978, lasHeras, [jose, juanito, juancito, mic, ian]).
banda(brazoFuerte, 1914, nuevaOrleans, [luis]).



%genero(NombreBanda, Genero).
genero(finta, pop(20, 7)).
genero(losEscarabajos, rock(mixto ,60)).
genero(plastica, rock(heavy, 80)).
genero(oceania, rock(glam, 80)).
genero(brazofuerte, jazz([trompeta, corneta])).

%pop(CantidadDeHits, CantidadDeDiscos)
%rock(TipoDeRock, Decada)
%jazz(Instrumentos)

festival(mangueraMusmanoRockFestival, cordoba).
festival(nueveAuxilios, haedo).

bandasConfirmadas(mangueraMusmanoRockFestival, [finta, aloeVera, mariaLaCuerda, reyesDeLaEraDelHielo]).
bandasConfirmadas(nueveAuxilios,[cantoRodado, lasLiendres, juanPrincipe, fluidoVerde]).
%--------------------------------------------------------------------

esExitosa(Banda):-genero(Banda, pop(CantidadDeHits, CantidadDeDiscos)), (CantidadDeHits /CantidadDeDiscos) > 4.
esExitosa(Banda):-genero(Banda, rock(mixto, _)).
esExitosa(Banda):-genero(Banda, rock(mixto, 80)). %no haria falta, porque entra en el anterior.
esExitosa(Banda):-genero(Banda, jazz(Instrumentos)), member(trompeta, Instrumentos).

%---------------------------------------------------------------------------

seraEterna(Banda):-banda(Banda, _, _, Integrantes), length(Integrantes, Cantidad), Cantidad > 4.

seraEterna(Banda):-banda(Banda, AnioDeFormacion, _, _), AnioDeFormacion < 1980, AnioDeFormacion > 1960.


%---------------------------------------------------------------------------

leConvieneParticipar(Banda, Festival):-banda(Banda, _, _, _),
										festival(Festival,_),
										bandasConfirmadas(Festival,BandasConfirmadas), 
										not(member(Banda, BandasConfirmadas)),
										festival(Festival, Localidad), 
										banda(Banda, _, Localidad, _).

%--------------------------------------------------------------------------------


seGraba(Festival):-festival(Festival,_), forall((bandasConfirmadas(Festival,BandasConfirmadas)),
					(member(Banda,BandasConfirmadas), seraEterna(Banda))).


%----------------------------------------------------------------------------------

anioHistorico(Anio):-mismoAnio(BandasConMismoAnio, Anio),
					 length(BandasConMismoAnio, Cantidad), Cantidad > 10.


mismoAnio(BandasConMismoAnio, AnioDeFormacion):- banda(Banda, _, _, _), 
				findall(Banda, (banda(Banda, AnioDeFormacion, _, _),banda(Banda2, AnioDeFormacion2, _, _),
					Banda \= Banda2,
						AnioDeFormacion = AnioDeFormacion2), BandasConMismoAnio).

%-----------------------------------------------------------------------------------


bandaConMasIntegrantesEnFestival(Festival, Banda):-forall(bandasConfirmadas(Festival,BandasConfirmadas),
							(member(Banda, BandasConfirmadas),bandaConMasIntegrantes(Banda, _))).

bandaConMasIntegrantes(Banda, Integrantes):-banda(Banda, _, _, Integrantes), 
								forall((banda(OtraBanda, _, _, Integrantes), Banda \= OtraBanda),
									(banda(OtraBanda, _, _, OtrosIntegrantes), length(Integrantes,CantidadIntegrantes), length(OtrosIntegrantes,CantidadOtrosIntegrantes),
									CantidadIntegrantes > CantidadOtrosIntegrantes)).			 






