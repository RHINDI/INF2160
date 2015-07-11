% RHINDI YOUSSEF
% RHIY20087605
% INF2160-Paradigmes de programmation: hiver 2015
% TP PROLOG
% Chargé de cours : Wajdi DHIFLI  

/* Ce programme PROLOG  réalise des fonctionnalités pour une application d’un réseau
social. Il permet de créer un graphe d’amis avec les contraintes suivantes :
1. Chaque personne est représentée par un nœud dans le graphe « noeud(Index, Label) »
2. Le graphe est étiqueté avec un nom d’une personne sur chaque nœud
3. Deux nœuds adjacents dans le graphe ne peuvent pas avoir une même étiquette */


%Predicat dynamique noeud representant les noeuds de l’arbre et ayant 2 comme arite.

:- dynamic(noeud/2).

%Predicat dynamique noeud representant les liens entre les noeuds de l’arbre et ayant 2 comme arite.

:- dynamic(lien/2).

%Regle de TEST pour afficher la base de donnee de noeud
affichn(X):-noeud(Y,Z),X=(Y,Z).
affichl(X):-lien(Y,Z),X=(Y,Z).

/* 1. Le prédicat « ajouter_noeud »  permet à l’utilisateur de donner la liste des nœuds
      du graph, au lancement le prédicat affiche « Donnez la liste des nœuds »,
      puis d’une façon répétitive, il demande « donnez l’index du nœud : »
      et l’utilisateur doit saisir l’index du nœud.
      Le prédicat lit l’index puis demande « Donnez le nom de la personne : »
      après lecture du nom de la personne le prédicat ajoute le nœud dans la base des faits sous la
      forme noeud(Index, Label).
      Par la suite, le prédicat demande « Voulez-vous continuer (oui\/non)? »
      si la réponse saisie est « non » le prédicat se termine.
      Si la réponse est « oui »,le prédicat continue la boucle et redemande l’index du nouveau nœud */


ajouter_noeud:-
    writeln('Donnez la liste des noeuds'),
    repeat,
     write('Donnez l\'index du noeud: '),
     read(Index), 
        (   
                (   noeud(Index,_),
                    writeln('Erreur! Noeud deja existant.'),fail
                )
            ;(
                not(noeud(Index,_)),
                write('Donnez le nom de la personne: '),
                read(Nom),
                assert(noeud(Index,Nom)),
                write('Insertion de '),
                write(noeud(Index,Nom)),
                writeln(' effectuee.'),
		        write('Voulez-vous continuer (oui/non)? '),
		        read(R), 
		            (   (R==non,!)
		                ; ( R\==oui,
		                    R\==non, 
		                    writeln('Erreur! Vous devez entrez oui ou non.'),
		                    !
		                  )
		            )
		     )
	    ).


/* 2. le prédicat « supprimer_noeud » 
      permet de supprimer un nœud de la base des faits.
      Le prédicat demande l’index du nœud à supprimer, l’utilisateur saisi l’index,
      puis le programme supprime le nœud correspondant 
      et affiche « nœud(Index,Label) supprimé »
      (il faut afficher l’Index et le Label correspondants).
      Sinon il affiche « noeud introuvable » */

supprimer_noeud:-
    write('Veuillez saisir l\'index du noeud a supprimer: '),
    read(Index), 
    (
        (
            noeud(Index,Name), retract(noeud(Index,Name)),
            write('Operation effectuee: '),
            write(noeud(Index,Name)),
            writeln(' supprimer.'),
            retractall(lien(Index,_)),
            retractall(lien(_,Index))
        )
        ; (
            not(noeud(Index,_)),
            writeln('Noeud introuvable')
          )
    ),
    !.


/* 3. le prédicat « ajouter_lien »  permet de saisir la liste des liens entre les nœuds du graph,
      au lancement le prédicat affiche  « Donnez la liste des liens », puis d’une façon répétitive, 
      il demande « donnez l’index du nœud 1 : » et l’utilisateur doit saisir l’index du nœud 1.
      Par la suite, il fait similairement pour nœud 2.
      Après lecture des indexes le prédicat ajoute le lien dans la base des faits sous la forme 
      lien(Index1, Index2).
      Par la suite, le prédicat demande « Voulez-vous continuer (oui\/non)? »
      si la réponse saisie est « non » le prédicat se termine.
      Si la réponse est « oui », le prédicat continue la boucle 
      et redemande les nouveaux index des nœuds. */

ajouter_lien:-
    writeln('Donnez la liste des liens'),
    repeat,
    write('Donnez l\'index du noeud 1: '),
    read(Index1), 
    (
        (
            not(noeud(Index1,_)),
            writeln('Erreur! Noeud inexistant.'),
            fail
        )
        ;
    		(   noeud(Index1,_),
    		    write('Donnez l\'index du noeud 2: '),
    		    read(Index2),
    		     (
    		        (
    		            not(noeud(Index2,_)),
    		            writeln('Erreur! Noeud inexistant.'),
    		            fail
    	          )
    	          ;
        			  (   
        			    noeud(Index2,_),
        			    (
        			        (
        			            (   lien(Index1,Index2)
    			                ;   lien(Index2,Index1)
        			            ),
        			            writeln('Erreur! Lien deja existant.'),
        			            fail
        			        )
        			        ;
        			        (   not( lien(Index1,Index2))
    		                ;   lien(Index2,Index1)
    		              ),
        			        assert(lien(Index1,Index2)),
        			        write('Insertion de '),
        			        write(lien(Index1,Index2)),
        			        writeln(' effectuee.'),
    	                write('Voulez-vous continuer (oui/non)? '),
    	                read(Rep),
    		                    (   (Rep==non,!)
    		                    ; 
    		                    (   Rep\==oui,
		                            Rep\==non,
		                            writeln('Erreur! Vous devez entrez oui ou non.'),
		                            !
    	                      )
                  )
                )
              )
        )
    )
).


/* 4. Créez le prédicat « supprimer_lien » qui permet de supprimer 
      un lien de la base des faits.
      Le prédicat demande les indexes (l’index du nœud1, il le lit 
      puis il demande celui du noeud2 et il le lit) du lien à supprimer,
      l’utilisateur saisi les indexes, puis le programme supprime le nœud
      correspondant et affiche « lien(Index1,Index2) supprimé » 
      (il faut afficher les Index correspondants).
      Sinon il affiche « lien introuvable ». */

supprimer_lien:-
    write('Veuillez saisir l\'index du noeud 1 du lien a supprimer: '),
    read(Index1),
    write('Veuillez saisir l\'index du noeud 2 du lien a supprimer: '),
    read(Index2), 
	(
	    (
	        (
	            lien(Index1,Index2)
	            ;lien(Index2,Index1)
            ),
            (
                retract(lien(Index1,Index2))
                ;retract(lien(Index2,Index1))
            ),
            write('Operation effectuee: '),
            write(lien(Index1,Index2)),
            writeln(' supprimer.')
        )
        ;
        (   not(    lien(Index1,Index2)
                    ;lien(Index2,Index1)
               ),
               writeln('Lien introuvable.')
        )
    ),
    !.


/* 5. Le prédicat « verifier » permet de vérifier la validité 
      du graphe selon les contraintes données au début (il est interdit
      qu’une personne ait un lien d’amitié direct avec une autre personne
      ayant le même nom).
      Le prédicat affiche « graphe valide » ou « graphe non valide ». */

verifier:- 
    (
        (
            lien(Index1,Index2),
            noeud(Index1,Nom),
            noeud(Index2,Nom),
            writeln('Graphe non valide.'),
            !
        )
        ;
        ( 
            writeln('Graphe valide.')
        )
    ).


/* 6. Le prédicat « amitie » retourne « true » si les deux personnes
      en paramètres ont un lien d’amitié : que ce soit direct ou à travers 
      d’autres amis intermédiaires. */

amitie(X,Y):- 
            noeud(Index1,X),
            noeud(Index2,Y),
            (
                lien(Index1,Index2),
                !
                ;
                lien(Index2,Index1),
                !
            ).
amitie(X,Y):- 
            noeud(Index1,X),
            noeud(Index2,Z),
            lien(Index1,Index2),
            amitie(Z,Y),
            !. 
amitie(X,Y):- amitie(Y,X).


/* 7. Le prédicat « commun » (commun(X,Y,Z)) qui prend en paramètre
      deux noms(X,Y) et retourne dans son troisième paramètre (Z) 
      les noms de tous les amis directs communs entre deux personnes.
      (exemple x1 amis avec x2, x2 avec x3, la requête commun(x1,x3,Z)
      donne Z=x2.) */

commun(X,Y,Z):-
            noeud(Index1,X),
            noeud(Index2,Y),
            noeud(Index3,Z),
            lien(Index1,Index3),
            lien(Index2,Index3).


/* 8. Le prédicat « intermediaires » (intermediaires(X,Y,N))
       permet de compter (dans N) le nombre d’amis intermédiaires 
      entre deux personnes (X et Y). */

intermediaires(X,Y,0):- 
                    noeud(Index1,X),
                    noeud(Index2,Y),
                    lien(Index1,Index2). 
intermediaires(X,Y,N):- 
                    noeud(Index1,X),
                    noeud(Index2,Z),
                    lien(Index1,Index2),
                    intermediaires(Z,Y,N1),
                    N is N1+1. 


/* 9. Le prédicat « suggestion » permet de suggérer des amis
      à la personne en paramètre.
      Ce prédicat utilise le prédicat « intermediaires » pour déterminer
      le nombre d’amis intermédiaires (la distance).
      Les amis suggérés sont ceux ayant une distance >1 et <= 3.
      (exemple x1 amis avec x2, x2 avec x3, la requête suggestion(x1,Y) 
      donne Y=x3.) */

suggestion(X,Y):- 
                (
                  intermediaires(X,Y,N),
                  noeud(Index1,X),
                  noeud(Index2,Y),
                  not(lien(Index1,Index2)),
                  not(lien(Index2,Index1)),
                  N >= 1, 
                  N < 3 
                )
                ;
                (
                  intermediaires(Y,X,N),
                  noeud(Index1,X),
                  noeud(Index2,Y),
                  not(lien(Index1,Index2)),
                  not(lien(Index2,Index1)),
                  N >= 1,
                  N < 3
                )
                .


/* Prendre en consideration qu\'il y a des amis intermediaire et l\'autre cas? (8)
Cas de faux apres bon resultat (7 6)
Commutativite
Coupure */
