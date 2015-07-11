-- En utilisant uniquement les fonction de base de Haskell (sans aucun 'import' de librairies), ecrivez les codes suivants:
-- Les fonctions doivent respecter le typage mentionné
module TP1 where
import Data.List

-- 1- Donnez une fonction "verif_n" qui prend deux chaînes de caractères et un entier n en paramètre, et détermine si le n-ième caractère des deux chaînes de caractères est identique (sans utiliser de if)
verif_n ::  String->String->Int->Bool
verif_n x y n 
	| (n < length x || n < length y) = x !!n == y !!n 
	| otherwise = False

-- 2- Donnez une fonction recursive "position" qui retourne la valeur n si le n-ième caracteres des deux chaines s1 et s2 est identique, sinon la fonction retourne la valeur -1
-- exemple
	-- position "wajdi" "idjaw" 0 => 2
	-- position "waajdi" "idja" 0 => -1
position :: String->String->Int->Int
position x y n  = if x == "" && y == "" then -1
				  else if x /= "" && y == "" then -1
				  else if x == "" && y /= "" then -1	
				  else if head x == head y then n
				  else position (tail x) (tail y) (n+1)
-- 3- Ecrire la fonction "inverse_chaine" qui donne l'inverse d'une chaine de caractères (sans utiliser la fonction 'reverse')
-- exemple	inverse_chaine "wajdi" => "idjaw"
inverse_chaine :: String->String
inverse_chaine x 
	| x == "" = ""
	| otherwise = inverse_chaine (tail x) ++ [head x]

-- 4- Ecrire la fonction "partie_palyndrome" qui utilise la fonction "inverse_chaine" qui retourne la partie palydrome d'une chaine
-- exemple:	partie_palyndrome "wajdijaw" => "waj"
-- partie_palyndrome "wajdidjaw" => "wajdi"
-- partie_palyndrome "wajddjaw" => "wajd"
partie_palyndrome :: String->String
partie_palyndrome "" = ""
partie_palyndrome x
	| length x == 1 = x
	|head x /= head (inverse_chaine x ) = ""
	| head x == head (inverse_chaine x ) = [head x] ++ partie_palyndrome(tail(init x))
	| otherwise = partie_palyndrome(tail(init x))

-- 5- Ecrire la fonction recursive "impaire" qui prend une liste d'entier et retourne une liste contenant uniquement les impaires
-- exemple impaire [1,3,4,2] => [1,3]
impaire ::[Int]->[Int]
impaire x = if x == [] then []
			else if odd (head x) then [head(x)] ++  impaire (tail x) 
			else impaire (tail x)

-- 6- Ecrire la fonction recursive "impaire_paire" qui prend une liste d'entier et retourne une liste contenant les elements impaires a gauche et les elements paires a droite (NB: le rang n'est pas important)
-- exemple impaire_paire [1,2,3,4,5] => [1,3,5,4,2]
impaire_paire ::[Int]->[Int]
impaire_paire x = if x == [] then []
				  else if odd (head x)
        		  then [head x] ++ impaire_paire (tail x)
		          else impaire_paire (tail x) ++ [head x]

-- 7- Le criptage d'un message texte est le fait de le transformer de son format lisible et comprehensible a un format incomprehensible.
-- Une facon simple de faire un criptage est de transformer les caracteres du message en code ascii puis changer la valeur de chaque code ascii en utilisant une fonction de criptage definie, puis remettre le message cripté en format texte (qui est devenu incomprehensible).
-- exemple d'une pseudo-fonction simple (cripter x = caractere ((code_ascii x) + y)) ou y est la clé du criptage utilisée. Etant donnée une clé = 2, le criptage du caractere "a" va etre: caractere (code_ascii "a" + 2) = caractere (97 + 2) = "c". Le decriptage ce fait en applicant la fonction inverse sur le message cripté, en utilisant la meme clé de criptage. (decripter x = caractere ((code_ascii x) - y)). caractere (code_ascii "c" - 2) = caractere (99 - 2) = "a"

-- Créez l'application "cript_decript" qui fait le criptage et le decriptage des messages texto. L'application necessite :
	-- - le type "Transfert" qui est composé d'une clé de criptage/décriptage de type numérique et du message a transmettre
data Transfert = Transfert (Int, String)
	-- une fonction recursive "cript" qui prend un parametre de type "Transfert" et retourne le message criptépté
cript :: Transfert -> String
cript (Transfert x)
	| snd x == "" = ""
	| otherwise = [toEnum(fromEnum(head(snd x)) + (fst x))] ++ cript (Transfert((fst x), (tail (snd x))))
	-- une fonction recursive "decript" qui prend un parametre de type "Transfert" et retourne le message criptéipté
decript :: Transfert -> String
decript (Transfert x)
	| snd x == "" = ""
	| otherwise = [toEnum(fromEnum(head(snd x)) - (fst x))] ++ decript (Transfert((fst x), (tail (snd x))))
-- L'application "cript_decript" prend en parametre un couple de type (String, Transfert):
		-- 1er cas : si la partie "String" est "E" alors l'application "cript_decript" considere que c'est un envoie de message et par consequence lance le cryptage du message enregistré dans la partie "Transfert" en utilisant la clé correspondante
		-- 2eme cas : si la partie "String" est "R" alors l'application "cript_decript" considere que c'est une reception de message et par consequence lance le decryptage du message enregistré dans la partie "Transfert" en utilisant la clé correspondante
		-- 3 eme cas : autrement l'application affiche "Operation non autorisee"
cript_decript :: (String, Transfert) -> String
cript_decript (ch,(Transfert x))
	| ch == "E" = cript(Transfert x)
	| ch == "R" = decript(Transfert x)
	| otherwise = "Operation non autorisee"