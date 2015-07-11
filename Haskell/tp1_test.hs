-- (C) 2014 Wajdi DHIFLI <dhifli.wajdi@uqam.ca>
-- Une série de tests pour le TP1.

-- Ce fichier contient quelques tests pour vous aider à vérifier votre TP. Ces tests ne sont
-- en aucune mesure complets ou exhaustifs. Vous devez vous assurer de bien remplir les exigences
-- de l'énoncé.

-- Le fichier contenant votre TP1 devrait s'appeler "tp1.hs" et contenir
-- un module de nom TP1.
import TP1

---------Testes pour Ex1
test1 = verif_n "abcba" "abcba" 5
test2 = verif_n "abcba" "abcba" 0
test3 = verif_n "Amine" "enimA" 3
test4 = verif_n "abcba" "abcba" 4

-------Testes pour Ex2
test5 = position "wajdi" "idjaw" 0
test6 = position "waajdi" "idja" 0
test7 = position "abcba" "abcba" 0
test8 = position "quebec" "Quebec" 0
-------Testes pour Ex3
test9 = inverse_chaine "12345"
test10 = inverse_chaine "abcba"
test11 = inverse_chaine ""
test12 = inverse_chaine "a"

-------Testes pour Ex4
test13 = partie_palyndrome ""
test14 = partie_palyndrome "wajdidjaw"
test15 = partie_palyndrome "wajddjaw"
test16 = partie_palyndrome "wajddjaw1"

-------Testes pour Ex5
test17 = impaire [1,3,4,2]
test18 = impaire [0,4,2]
test19 = impaire []
test20 = impaire [111]

-------Testes pour Ex6
test21 = impaire_paire [1,2,3,4,5]
test22 = impaire_paire [2]
test23 = impaire_paire []
test24 = impaire_paire [2,6,8,4,1,11,33,53,95,110]

-------Testes pour Ex7
key = 3
x = Transfert (key,"The quick brown fox jumps over the lazy dog")
y = Transfert (0,"Just a simple test")
z = Transfert (key, cript_decript ("E", x))

--test25 = cript_decript ("E", x)
--test26 = cript_decript ("R", x)
--test27 = cript_decript ("E", y)
--test28 = cript_decript ("R", y)
--test29 = cript_decript ("E", Transfert (key,"The quick brown fox jumps over the lazy dog"))
--test30 = cript_decript ("E", x) == cript_decript ("E", Transfert (key,"The quick brown fox jumps over the lazy dog"))

test31 = cript x
test32 = decript z
test33 = decript(Transfert (key, cript x))

--test34 = cript_decript ("F", x)
--test35 = cript_decript ("R", Transfert (key,cript_decript ("E", Transfert (key,"The quick brown fox jumps over the lazy dog"))))

main = do putStr "1 -- "; print test1
          putStr "2 -- "; print test2
          putStr "3 -- "; print test3
          putStr "4 -- "; print test4
          putStr "5 -- "; print test5
          putStr "6 -- "; print test6
          putStr "7 -- "; print test7
          putStr "8 -- "; print test8
          putStr "9 -- "; print test9
          putStr "10 -- "; print test10
          putStr "11 -- "; print test11
          putStr "12 -- "; print test12
          putStr "13 -- "; print test13
          putStr "14 -- "; print test14
          putStr "15 -- "; print test15
          putStr "16 -- "; print test16
          putStr "17 -- "; print test17
          putStr "18 -- "; print test18
          putStr "19 -- "; print test19
          putStr "20 -- "; print test20
          putStr "21 -- "; print test21
          putStr "22 -- "; print test22
          putStr "23 -- "; print test23
          putStr "24 -- "; print test24
          --putStr "25 -- "; print test25
          --putStr "26 -- "; print test26
          --putStr "27 -- "; print test27
          --putStr "28 -- "; print test28
          --putStr "29 -- "; print test29
          --putStr "30 -- "; print test30
          putStr "31 -- "; print test31
          putStr "32 -- "; print test32
          putStr "33 -- "; print test33
          putStr "34 -- "; print test34
          putStr "35 -- "; print test35
