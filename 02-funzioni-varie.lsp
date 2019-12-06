================

 FUNZIONI VARIE

================

In questo capitolo definiremo alcune funzioni che operano sulle liste e altre funzioni di carattere generale. Alcune di queste ci serviranno successivamente per risolvere i problemi che andremo ad affrontare.
Poichè newLISP permette sia lo stile funzionale che quello imperativo, le funzioni sono implementate in modo personale e possono essere sicuramente migliorate.

-------------
Tabella ASCII
-------------

ASCII (acronimo di American Standard Code for Information Interchange, Codice Standard Americano per lo Scambio di Informazioni) è un codice per la codifica di caratteri. Lo standard ASCII è stato pubblicato dall'American National Standards Institute (ANSI) nel 1968. Il codice era composto originariamente da 7 bit (2^7 = 128 caratteri).
I caratteri del codice ASCII sono di due tipi: stampabili e non stampabili (caratteri di controllo).
I caratteri stampabili sono 95 (da 32 a 126), mentre quelli non stampabili sono 33 (da 0 a 31 e il 127). Quindi il totale dei caratteri vale 95 + 33 = 128.
Scriviamo una funzione che crea una lista dei caratteri ASCII stmapabili.

(define (asciiTable)
  (let (out '())
    (for (i 32 126)
      (push (list i (char i)) out -1)
    )
    out
  )
)

(asciiTable)
;-> ((32 " ")  (33 "!")  (34 "\"") (35 "#")  (36 "$")  (37 "%")  (38 "&")
;->  (39 "'")  (40 "(")  (41 ")")  (42 "*")  (43 "+")  (44 ",")  (45 "-")
;->  (46 ".")  (47 "/")  (48 "0")  (49 "1")  (50 "2")  (51 "3")  (52 "4")
;->  (53 "5")  (54 "6")  (55 "7")  (56 "8")  (57 "9")  (58 ":")  (59 ";")
;->  (60 "<")  (61 "=")  (62 ">")  (63 "?")  (64 "@")  (65 "A")  (66 "B")
;->  (67 "C")  (68 "D")  (69 "E")  (70 "F")  (71 "G")  (72 "H")  (73 "I")
;->  (74 "J")  (75 "K")  (76 "L")  (77 "M")  (78 "N")  (79 "O")  (80 "P")
;->  (81 "Q")  (82 "R")  (83 "S")  (84 "T")  (85 "U")  (86 "V")  (87 "W")
;->  (88 "X")  (89 "Y")  (90 "Z")  (91 "[")  (92 "\\") (93 "]")  (94 "^")
;->  (95 "_")  (96 "`")  (97 "a")  (98 "b")  (99 "c")  (100 "d") (101 "e")
;->  (102 "f") (103 "g") (104 "h") (105 "i") (106 "j") (107 "k") (108 "l")
;->  (109 "m") (110 "n") (111 "o") (112 "p") (113 "q") (114 "r") (115 "s")
;->  (116 "t") (117 "u") (118 "v") (119 "w") (120 "x") (121 "y") (122 "z")
;->  (123 "{") (124 "|") (125 "}") (126 "~"))

In newLISP i caratteri numero 34 (doppi apici) e numero 92 (backslash) sono preceduti dal carattere di controllo '\' quando vengono stampati.

Altro metodo, applico (con "map") la funzione (list x (char(x))) ad ogni elemento della lista di numeri che va da 32 a 126 (sequence 32 126):

(define (ascii-list)
  (map (fn(x) (list x (char x))) (sequence 32 126)))

--------------
Pari o dispari
--------------

Definiamo le funzioni "pari" e "dispari":

(define (pari n) (if (= n 0) true (dispari (- n 1))))

(define (dispari n) (if (= n 0) nil (pari (- n 1))))

(pari 5)
;-> nil
(pari 0)
;-> true
(dispari 0)
;-> nil
(dispari 5)
;-> true

Altro metodo (più veloce) per definire le funzioni "pari " e "dispari":

(define (pari n) (if (= (% n 2) 0) true nil))

(define (dispari n) (if (= (% n 2) 0) nil true))


-----
Crono
-----

Definiamo una funzione che prende un numero n come argomento e costruisce una lista con tutti i numeri da n fino a 1 in ordine decrescente:

(define (crono n)
  (if (<= n 0)
      '()
      (cons n (crono (- n 1)))
  )
)

; Nota: '() rappresenta la lista vuota

(crono 10)
;-> (10 9 8 7 6 5 4 3 2 1)


------------------------------
Cambiare di segno ad un numero
------------------------------

Primo metodo (sottrazione)
(setq n -1.24)
;-> -1.24
(setq n (sub 0 n))
;-> 1.24
(setq n (sub 0 n))
;-> -1.24

Secondo metodo (moltiplicazione)
(setq n -1.24)
;-> -1.24
(setq n (mul -1 n))
;-> 12.4
(setq n (mul -1 n))
;-> -1.24

Vediamo quale metodo è più veloce:

(map (lambda (x) (sub 0 x))  (sequence 1 10))
;-> (-1 -2 -3 -4 -5 -6 -7 -8 -9 -10)

(map (lambda (x) (mul -1 x)) (sequence 1 10))
;-> (map (lambda (x) (mul -1 x)) (sequence 1 10))

Test primo metodo:
(time (map (lambda (x) (sub 0 x))  (sequence 1 1000000)) 10)
;-> 906.196

Test secondo metodo:
(time (map (lambda (x) (mul -1 x)) (sequence 1 1000000)) 10)
;-> 906.343

I due metodi hanno la stessa velocità.

Terzo metodo (bitwise not "~") (valido solo per numeri interi)
(setq n -10)
;-> -10
(setq n (add (~ n) 1))
;-> 10
(setq n (add (~ n) 1))
;-> -10

Test terzo metodo:
(time (map (lambda (x) (add (~ n) 1)) (sequence 1 1000000)) 10)
;-> 1207.781

Questo metodo è più lento.

Quarto metodo (segno meno "-")
(setq n -10)
;-> 10
(setq n (- n))
;-> 10
(setq n (- n))
;-> -10

Test quarto metodo:
(time (map (lambda (x) (- n)) (sequence 1 1000000)) 10)
;-> 914.067

Stessa velocità dei primi due metodi, ma quest'ultimo è più leggibile.


----------------------------------
Moltiplicazione solo con addizioni
----------------------------------

Moltiplicare due numeri naturali (interi positivi)

(define (moltiplica n m)
  (local (p)
    (setq p 0)
    (while (> n 0)
      (setq p (+ p m))
      (-- n)
    )
    p
  )
)

(moltiplica 1 12)
;-> 12

(moltiplica 20 30)
;-> 600


------------------------------
Divisione solo con sottrazioni
------------------------------

Dividere due numeri naturali (interi positivi)

(define (dividi n m)
  (local (q r)
    (setq r n)
    (setq q 0)
    (while (>= r m)
      (++ q)
      (setq r (- r m))
    )
    (list q r)
  )
)

(dividi 10 3)
;-> (3 1)

(dividi 121 11)
;-> (11 0)


----------------------
Distanza tra due punti
----------------------

P1 = (x1, y1)
P2 = (x2, y2)

Distanza al quadrato (piano cartesiano):

(define (dist2 x1 y1 x2 y2)
  (add (mul (sub x1 x2) (sub x1 x2))
       (mul (sub y1 y2) (sub y1 y2)))
)

Distanza (piano cartesiano):

(define (dist x1 y1 x2 y2)
  (sqrt (add (mul (sub x1 x2) (sub x1 x2))
             (mul (sub y1 y2) (sub y1 y2))))
)

Distanza griglia manhattan (4 movimenti - esempio: torre):

(define (distM4 x1 y1 x2 y2)
  (add (abs (sub x1 x2)) (abs (sub y1 y2)))
)

Distanza griglia manhattan (8 movimenti - esempio: regina):

(define (distM8 x1 y1 x2 y2)
  (max (abs (sub x1 x2)) (abs (sub y1 y2)))
)

(dist 1 2 5 5)
;-> 5
(distM4 1 2 5 5)
;-> 7
(distM8 1 2 5 5)
;-> 4


---------------------------------
Conversione decimale <--> binario
---------------------------------

Questa funzione converte un numero decimale in un numero binario (lista):

(define (decimale2binario n)
  (reverse (d2b n)))

(define (d2b n)
  (if (zero? n) '(0)
      (cons (% n 2) (d2b (/ n 2)))
  )
)

(decimale2binario 1133)
;-> (1 0 0 0 1 1 0 1 1 0 1)

(decimale2binario 1233)
;-> (1 0 0 1 1 0 1 0 0 0 1)

(decimale2binario 2)
;-> (1 0)

(decimale2binario 0)
;-> (0)

Questa funzione converte un numero binario (lista) in un numero decimale:

(define (binario2decimale n)
  (b2d (reverse n)))

(define (b2d n)
    (if (null? n) 0
        (+ (first n) (* 2 (b2d (rest n))))
    )
)

(binario2decimale '(1 0 0 0 1 0 1 1 0 0 1))
;-> 1133

(binario2decimale '(1 0 0 1 1 0 1 0 0 0 1))
;-> 1233

(binario2decimale '(0))
;-> 0

Queste funzione converte un numero binario in un numero intero:

(define (bin2dec n)
  (if (zero? n) n
      (+ (% n 10) (* 2 (bin2dec (/ n 10))))))

(bin2dec 10001011001)
;-> 1113

(bin2dec 10011010001)
;-> 1233

(bin2dec 0)
;-> 0

Queste funzione converte un numero intero in un numero binario:

(define (dec2bin n)
   (if (zero? n) n
       (+ (% n 2) (* 10 (dec2bin(/ n 2))))
   )
)

(dec2bin 1133)
;-> 10001101101

(dec2bin 1233)
;-> 10011010001

(dec2bin 0)
;-> 0

(bin2dec (dec2bin 1133))
;-> 1133

(dec2bin (bin2dec 10011010001))
;-> 10011010001

Possiamo scrivere una funzione generale che converte un numero da una base (b1) ad un'altra base (b2):

(define (b1-b2 n b1 b2)
  (if (zero? n) n
      (+ (% n b2) (* b1 (b1-b2 (/ n b2) b1 b2)))))

(b1-b2 1133 10 2)
;-> 10001101101

(b1-b2 10001101101 2 10)
;-> 1133

Anche le funzioni predefinite "int" e "bits" di newLISP servono per convertire numeri da una base all'altra.

Vediamo alcuni esempi:

Converte una stringa esadecimale in decimale (il parametro 0 è il valore predefinito che viene restituito quando la conversione genera un errore):

(int "0xdecaff" 0 16)
;-> 14600959

Converte una stringa binaria nel numero decimale corrispondente:

(int "10101010" 0 2)
;-> 170

Converte un numero in una stringa o in una lista (1 -> true, 0 -> nil) che contiene il numero binario corrispondente:

(bits 170)
;-> "10101010"

(bits 170 true)
;-> (nil true nil true nil true nil true)

(int (bits 1234) 0 2)
;-> 1234


-------------------------------------
Conversione decimale <--> esadecimale
-------------------------------------

Questa funzione converte un numero intero positivo in una stringa esadecimale:

(define (d2h n)
  (local (digit x y)
    (setq digit "0123456789ABCDEF")
    (setq x (% n 16))
    (setq y (/ n 16))
    (if (= y 0) (nth x digit)
        (cons (nth x digit) (d2h y))
    )
  )
)

(define (dec2hex n)
  (if (= n 0) "0"
      (join (reverse(d2h n)))
  )
)

(dec2hex 16)
;-> "10"
(dec2hex 0)
;-> "0"
(dec2hex 100001)
;-> "186A1"

Questa funzione converte una stringa esadecimale in un numero intero positivo:

(define (hex2dec s)
  (local (digit val)
    (setq digit "0123456789ABCDEF")
    (setq val 0L)
    (dostring (c s)
      (setq val (+ (* val 16) (find (char c) digit)))
      ; la seguente istruzione converte la variabile val in un numero intero,
      ; quindi genera un risultato sbagliato quando superiamo il limite.
      ; Ponendo val prima del numero 16 forza newLISP a considerare big integer
      ; il risultato dell'operazione di moltiplicazione.
      ;(setq val (+ (* 16 val) (find (char c) digit)))
      ; Comunque usando 16L al posto di 16 tutto funziona:
      ;(setq val (+ (* 16L val) (find (char c) digit)))
    )
  )
)

(hex2dec "0")
;-> 0L

(hex2dec "FF")
;-> 255L

(hex2dec "0123456789ABCDEF")
;-> 81985529216486895L


(hex2dec "FFFFFFFFFFFFFFFFFFFF")
;-> 1208925819614629174706175L

Nota:
Se il numero esadecimale non è intero per trasformarlo in numero decimale bisogna:
- convertire la parte intera scrivendo la somma dei prodotti delle cifre del numero, per le potenze decrescenti del 16.
- convertire la parte frazionaria scrivendo la somma dei prodotti delle cifre del numero, per le potenze crescenti negative del 16.


-------------------------------
Conversione decimale --> romano
-------------------------------

; roman.lsp
; Sam Cox December 8, 2003
;
; LM 2003/12/12: took out type checking of n
;
;
; This function constructs a roman numeral representation from its positive
; integer argument, N.  For example,
;
;     (roman 1988) --> MCMLXXXVIII
;
; The Roman method of writing numbers uses two kinds of symbols: the basic
; symbols are I=1, X=10, C=100 and M=1000; the auxiliary symbols are V=5,
; L=50 and D=500. A rule prescribes that the symbol for the larger number
; always stands to the left of that for the smaller number. An exception
; is motivated by the desire to use as few symbols as possible. For
; example, the number nine can be represented as VIIII (5+4) or IX (10-1);
; the latter is preferred.  Therefore, if the symbol of a smaller number
; stands at the left, the corresponding number has to be subtracted, not
; added.  It is not permitted to place several basic symbols or an
; auxiliary symbol in front.  For example, use CML for 950 instead of LM.
; ---
; The VNR Encyclopedia of Mathematics, W. Gellert, H. Kustner, M. Hellwich,
; and H. Kastner, eds., Van Nostrand Reinhold Company, New York, 1975.

(define (roman n)
        (roman-aux "" n (first *ROMAN*) (rest *ROMAN*)))

(define (roman-aux result n pair remaining)
    (roman-aux-2 result n (first pair) (second pair) remaining))

(define (roman-aux-2 result n val rep remaining)
    (if
        (= n 0)
            result
        (< n val)
            (roman-aux result n (first remaining) (rest remaining))
        ;else
            (roman-aux-2 (append result rep) (- n val) val rep remaining)))

(define (second x) (nth 1 x))

(setq *ROMAN*
         '(( 1000  "M" )
           (  999 "IM" )
           (  990 "XM" )
           (  900 "CM" )
           (  500  "D" )
           (  499 "ID" )
           (  490 "XD" )
           (  400 "CD" )
           (  100  "C" )
           (   99 "IC" )
           (   90 "XC" )
           (   50  "L" )
           (   49 "IL" )
           (   40 "XL" )
           (   10  "X" )
           (    9 "IX" )
           (    5  "V" )
           (    4 "IV" )
           (    1  "I" )))


------------------------------------
Conversione numero intero <--> lista
------------------------------------

Da numero intero a lista:

(define (int2list n)
  (let (out '())
    (while (!= n 0)
      (push (% n 10) out)
      (setq n (/ n 10))
    )
    out
  )
)

(int2list 1234567890)
;-> (1 2 3 4 5 6 7 8 9 0)

(define (int2list2 n)
  (map int (explode (string n))))

(int2list2 1234567890)
;-> (1 2 3 4 5 6 7 8 9 0)

Vediamo quale delle due è più veloce:

(time (int2list 9223372036854775807) 100000)
;-> 332.671

(time (int2list2 9223372036854775807) 100000)
;-> 442.561

Da lista a numero intero:

(define (list2int lst)
  (let (n 0)
    (for (i 0 (- (length lst) 1))
      (setq n (+ n (* (lst i) (pow 10 (- (length lst) i 1)))))
    )
  )
)

(list2int '(1 2 3 4 5 6 7 8 9 0))
;-> 1234567890

(define (list2int2 lst)
  (int (join (map string lst))))

(list2int2 '(1 2 3 4 5 6 7 8 9 0))
;-> 1234567890

Vediamo quale delle due è più veloce:

(time (list2int '(9 2 2 3 3 7 2 0 3 6 8 5 4 7 7 5 8 0 7)) 100000)
;-> 622.365

(time (list2int2 '(9 2 2 3 3 7 2 0 3 6 8 5 4 7 7 5 8 0 7)) 100000)
;-> 855.138

Ricapitoliamo:

(define (int2list n)
  (let (out '())
    (while (!= n 0)
      (push (% n 10) out)
      (setq n (/ n 10))) out))

(int2list 1282738374847)
;-> (1 2 8 2 7 3 8 3 7 4 8 4 7)

(define (int2list2 n) (map sym (explode (string n))))

(int2list2 1282738374847)
;-> (1 2 8 2 7 3 8 3 7 4 8 4 7)

(time (dotimes (x 1e7) (int2list x)))
;-> 1107.929
(time (dotimes (x 1e7) (int2list x)))
;-> 12721.02

(time (dotimes (x 1e6) (int2list2 x)))
;-> 1544.137
(time (dotimes (x 1e7) (int2list2 x)))
;-> 17760.076


-------------------------------
Numeri casuali in un intervallo
-------------------------------

Generare un numero casuale n tale che: a <= n <= b

(define (rand-range a b)
  (if (> a b) (swap a b))
  (+ a (rand (+ (- b a) 1)))
)

(rand-range 1 10)
;-> 1

Facciamo un test sulla distribuzione dei risultati:

(define (test n a b)
  (local (vec r)
    (setq vec (array 10 '(0)))
    (for (i 0 n)
      (setq r (rand-range a b))
      (++ (vec r))
    )
    vec
  )
)

(test 100000 1 5)
;-> (0 19828 20179 20076 20263 19655 0 0 0 0)

(test 100000 0 9)
;-> (9855 9809 9951 10199 9978 10006 9934 10110 10058 10101)


-------------------
Calcolo proporzione
-------------------

Calcolare il valore ignoto (che viene rappresentato con il numero zero) di una proporzione: A/B = C/D

(define (proporzione a b c d)
  (cond ((= a 0) (div (mul b c) d))
        ((= b 0) (div (mul a d) c))
        ((= c 0) (div (mul a d) b))
        ((= d 0) (div (mul b c) a))
  )
)

(proporzione 4 2 10 0)
;-> 5
(proporzione 0 2 10 5)
;-> 4
(proporzione 4 2 0 5)
;-> 10
(proporzione 4 0 10 5)
;-> 2


----------------------------------------
Estrarre l'elemento n-esimo da una lista
----------------------------------------

; ======================================
; (n-esimo n lst)
; Estrae l'elemento n-esimo da una lista
; ======================================

(define (n-esimo n lst)
  (if (= lst '()) '()
    (if (= n 0)
        (first lst)
        (n-esimo (- n 1) (rest lst))
    )
  )
)

(n-esimo 1 '(1 (2 3) 4))
;-> (2 3)

(n-esimo 0 '(1 (2 3) 4))
;-> 1

(n-esimo 5 '(1 (2 3) 4))
;-> ()


------------------------------------
Verificare se una lista è palindroma
------------------------------------

; ======================================
; (palindroma? lst)
; Controlla se la lista lst è palindroma
; ======================================
(define (palindroma? lst)
  (= lst (reverse (copy lst))))

Nota: senza la funzione "copy", la condizione (= lst (reverse lst)) è sempre vera (perchè (reverse lst) è una funzione distruttiva.

(palindroma? '(n e w L I S P))
;-> nil

(palindroma? '(e p r e s a l a s e r p e))
;-> true


--------------------------------------
Verificare se una stringa è palindroma
--------------------------------------

(define (palindroma? str)
  (= str (reverse (copy str))))

(palindroma? "ababa")
;-> true

Vediamo una soluzione con gli indici:

(define (palindroma? str)
  (catch
    (local (start end)
      (setq start 0)
      (setq end (- (length str) 1))
        (while (< start end)
          (if (!= (str start) (str end)) (throw nil))
          (++ start)
          (-- end)
        )
      true
    );local
  );catch
)

(palindroma? "epresalaserpe")
;-> true

(palindroma? "abbai")
;-> nil


------------------------------------
Verificare se un numero è palindromo
------------------------------------

(define (palindromo? num)
  (let (str (string num))
    (= str (reverse (copy str)))))

(palindromo? 1234321)
;-> true

(define (palinum? num)
  (let ((val 0) (copia num))
    (until (null? num)
      (setq val (+ (* 10 val) (% num 10)))
      (setq num (/ num 10))
    )
    (= val copia)
  )
)

(palinum? 1234321)
;-> true

(time (map palindromo? (sequence 100000 110000)) 200)
;-> 1535.427

(time (map palinum? (sequence 100000 110000)) 200)
;-> 2778.158


---------------
Zippare N liste
---------------

La funzione "zip" prende due liste e raggruppa in coppie gli elementi delle due liste che hanno lo stesso indice.
Il risultato è una lista costituita da sottoliste con due elementi ciascuna.La lunghezza della lista è uguale a quella della lista più corta (cioè, la funzione deve fermarsi quando termina una delle due liste).

; zippa due liste
(define (zip l1 l2)
  (if (or (null? l1) (null? l2))
      '()
      (cons (list (first l1) (first l2))
            (zip (rest l1) (rest l2)))))

Se una delle due liste è vuota, allora ritorna la lista vuota. Altrimenti, formiamo una lista dei primi elementi di ciascuna lista e la associamo alla versione zippata delle parti rimanenti di ciascuna lista. Il risultato è la nostra lista formata da sottoliste di due elementi.

(zip '(1 2 3) '(a b c))
;-> ((1 a) (2 b) (3 c))

(zip '(1 2 3) '(a))
;-> ((1 a))

(zip '(1) '(a b c))
;-> ((1 a))

(zip '(1 3 5) '(2 4 6))
;-> ((1 2) (3 4) (5 6))

Possiamo scrivere la funzione "zip" utilizzando "map" e "apply":

; zip due liste
(define (zip l1 l2) (map list l1 l2))

(zip '(1 2 3) '(a b c))
;-> ((1 a) (2 b) (3 c))

(zip '(1 2 3) '(a))
;-> ((1 a) (2) (3))

(zip '(1) '(a b c))
;-> ((1 a))

Questa ultima funzione può essere facilmente estesa per trattare N liste:

; zippa N liste
(define (zip lst)
  (apply map (cons list lst)))

(zip '((1 a x) (2 b y)))
;-> ((1 2) (a b) (x y))

(zip '((1 2) (a b) (x y)))
;-> (1 a x) (2 b y))

Calcoliamo il tempo di esecuzione:

(time (zip '((1 a x) (2 b y))) 100000)
;-> 78.116 msec

La funzione "zip" è uguale alla funzione che traspone una matrice (scambia le righe con le colonne). Poichè newLISP fornisce la funzione "transpose" possiamo scrivere:

(transpose '((1 2 3) (a b c)))
;-> ((1 a) (2 b) (3 c))

Quindi la funzione che zippa N liste diventa:

; =============================================
; (zip lst)
; Zippa (traspone) una lista di liste (matrice)
; =============================================
; zippa N liste
(define (zip lst)
  (transpose lst))

(zip '((1 a x) (2 b y)))
;-> ((1 2) (a b) (x y))

Calcoliamo il tempo di esecuzione e notiamo che è più veloce della funzione iniziale:

(time (zip '((1 a x) (2 b y))) 100000)
;-> 31.87 msec


--------------------------------------------------------------
Sostituire gli elementi di una lista con un determinato valore
--------------------------------------------------------------

Si tratta di sostituire tutti gli elementi di una lista con un determinato valore con un altro valore.

La funzione è la seguente:

(define (sostituisci x y lst)
    (if (null? lst) '()
      (if (= x (first lst))
        (cons y (sostituisci x y (rest lst)))
        (cons (first lst) (sostituisci x y (rest lst)))
      )
    )
)

(sostituisci 'd 'K '(a b c d 1 2 3 d))
;-> (a b c K 1 2 3 K)

Per rimpiazzare tutti gli elementi di una lista che hanno un determinato valore possiamo utilizzare la funzione built-in "replace":

(setq lst '(a b c d 1 2 3 d))
(replace 'd lst 'K)
;-> (a b c K 1 2 3 K)

(setq lst '((a b) (c d) (1 2 (3 d))))
(replace '(c d) lst 'K)
;-> ((a b) K (1 2 (3 d)))

Purtroppo "replace" non funziona quando vogliamo modificare un atomo che si trova all'interno di una lista nidificata:

(setq lst '((a b) (c d) (1 2 (3 d))))
(replace 'd lst 'K)
;-> ((a b) (c d) (1 2 (3 d)))

In questo caso dobbiamo utilizzare la funzione "set-ref-all":

(setq lst '((a b) (c d) (1 2 (3 d))))
(set-ref-all 'd lst 'K)
;-> ((a b) K (1 2 (3 K)))


-------------------------------------
Raggruppare gli elementi di una lista
-------------------------------------

La funzione "raggruppa" utilizza la ricorsione, prima raggruppiamo la prima parte della lista (presa con la funzione "take"), poi richiamiamo la stessa funzione "raggruppa" sulla lista rimanente (presa con la funzione "drop").

La funzione "take" restituisce i primi n elementi di una lista:

(define (take n lst) (slice lst 0 n))

La funzione "drop" restituisce tutti gli elementi di una lista tranne i primi n (cioè vengono esclusi dalla lista risultante i primi n elementi della lista passata:

(define (drop n lst) (slice lst n))

Adesso possiamo scrivere la funzione "raggruppa":

(define (raggruppa n lst)
   (if (null? lst) '()
      (cons (take n lst) (raggruppa n (drop n lst)))
   )
)

(setq lst '(0 1 2 3 4 5 6 7 8 9))
(raggruppa 2 lst)
;-> ((0 1) (2 3) (4 5) (6 7) (8 9))
(raggruppa 3 lst)
;-> ((0 1 2) (3 4 5) (6 7 8) (9))

(setq lst '(1 2 3 4 5 6 7 8 9 10 11 12))
(raggruppa 2 (raggruppa 2 lst))
;-> (((1 2) (3 4)) ((5 6) (7 8)) ((9 10) (11 12)))

Con newLISP possiamo utilizzare la funzione "explode".


-----------------------------------
Enumerare gli elementi di una lista
-----------------------------------

; =====================================================
; (emumera lst)
; Crea una nuova lista numerando gli elementi di lst
; =====================================================
(define (enumera lst)
  (local (out)
    (cond ((null? lst) '())
          (true (setq out '())
                (dolist (el lst)
                  ;(push (list $idx el) _out)
                  ;(push (list $idx el) _out -1)
                  (extend out (list(list $idx el)))
                )
                ;(reverse _out)
          )
    )
  )
)

(enumera '(a b c))
;-> ((0 a) (1 b) (2 c))

(enumera '((a b) (c d) e))
;-> ((0 (a b)) (1 (c d)) (2 e))

Oppure:

(define (enumera lst)
  (map list (sequence 0 (sub (length lst) 1)) lst))

(enumera '(a b c))
;-> ((0 a) (1 b) (2 c))

(enumera '((a b) (c d) e))
;-> ((0 (a b)) (1 (c d)) (2 e))

Oppure:

(map (fn (x) (list $idx x)) '((a b) (c d) e))
;-> ((0 (a b)) (1 (c d)) (2 e))


-----------------------------------------------------------
Creare una stringa come ripetizione di un carattere/stringa
-----------------------------------------------------------

newLISP possiede la funzione "dup" che funzione anche con i simboli:

(dup "A" 6)       → "AAAAAA"
(dup "A" 6 true)  → ("A" "A" "A" "A" "A" "A")
(dup "A" 0)       → ""
(dup "AB" 5)      → "ABABABABAB"
(dup 9 7)         → (9 9 9 9 9 9 9)
(dup 9 0)         → ()
(dup 'x 8)        → (x x x x x x x x)
(dup '(1 2) 3)    → ((1 2) (1 2) (1 2))
(dup "\000" 4)    → "\000\000\000\000"
(dup "*")         → "**"

Proviamo a scrivere la nostra funzione:

; =====================================================
; (duplica str num)
; Duplica la stringa str per num volte
; =====================================================

(define (duplica str num , newstr)
  (local (newstr)
    (setq newstr "")
    (dotimes (x num)
      (extend newstr str)
    )
   )
)

(duplica "prova" 4)
;-> "provaprovaprovaprova"


--------------------------------------------------
Massimo annidamento di una lista ("s-espressione")
--------------------------------------------------

La seguente funzione calcola il livello massimo di annidamento di una lista:

(define (annidamento lst)
  (cond ((null? lst) 0)
        ((atom? lst) 0)
        (true (max (+ 1 (annidamento (first lst)))
                   (annidamento (rest lst))))
  )
)

Il trucco sta nell'utilizzare la funzione "max" per scoprire quale ramo della ricorsione è il più profondo, notando che ogni volta che ricorraimo su first aggiungiamo un altro livello.

(annidamento '())
;-> 0
(annidamento '(a b))
;-> 1
(annidamento '((a)))
;-> 2
(annidamento '(a (b) ((c)) d e f))
;-> 3
(annidamento '(a (((b c d))) (e) ((f)) g))
;-> 4
(annidamento '(a (((b c (d)))) (e) ((f)) g))
;-> 5

rickyboy:

(define (nesting lst)
  (if (null? lst) 0
      (atom? lst) 0
      (+ 1 (apply max (map nesting lst)))))

fdb:

(define (nesting lst prev (t 0))
   (if (= lst prev)
      t
     (nesting (flat lst 1) lst (inc t))))

(nesting '(a (((b c (d)))) (e) ((f)) g))
;-> 5


-------------------------------
Run Length Encode di una lista
-------------------------------

Esempio: (rle '(a a a b b c c a d d))
;-> ((3 a) (2 b) (2 c) (1 a) (2 d))

Implementiamo il metodo di compressione Run Length Encoding ad una lista. Gli elementi consecutivi duplicati sono codificati come liste (N E) dove N è il numero di duplicati dell'elemento E.

; =====================================================
; (rle-encode lst)
; Codifica una lista con il metodo Run Length Encoding
; =====================================================
(define (rle-encode lst)
  (local (palo conta out)
    (cond ((= lst '()) '())
          (true
           (setq out '())
           (setq palo (first lst))
           (setq conta 0)
           (dolist (el lst)
              ; se l'elemento è uguale al precedente aumentiamo il suo conteggio
              (if (= el palo) (++ conta)
                  ; altrimenti costruiamo la coppia (conta el) e la aggiungiamo al risultato
                  (begin (push (list conta palo) out -1)
                         (setq conta 1)
                         (setq palo el)
                  )
              )
           )
           (push (list conta palo) out -1)
          )
    )
    out
  )
)

(rle-encode '(a a a a b c c a a d e e e e f))
;-> ((4 a) (1 b) (2 c) (2 a) (1 d) (4 e) (1 f))


------------------------------
Run Length Decode di una lista
------------------------------

Esempio: (rle-decode '((3 a) (2 b) (2 c) (1 a) (2 d)))
;-> (a a a b b c c a d d))

; =====================================================
; (rle-decode lst)
; Decodifica una lista compressa con il metodo Run Length Encoding
; =====================================================
(define (rle-decode lst)
  (local (out)
    (cond ((= lst '()) '())
          (true
           (setq out '())
           (dolist (el lst)
              (extend out (dup (last el) (first el)))
           )
          )
    )
    out
  )
)

(rle-decode '((3 a) (2 b) (2 c) (1 a) (2 d)))
;-> (a a a b b c c a d d))

(rle-decode '((4 a) (1 b) (2 c) (2 a) (1 d) (4 e) (1 f)))
;-> (a a a a b c c a a d e e e e f)

(rle-decode (rle-encode '(a a a a b c c a a d e e e e f)))
;-> (a a a a b c c a a d e e e e f)


-----------------------------------------------
Massimo Comun Divisore e Minimo Comune Multiplo
-----------------------------------------------

In inglese:
GCD -> Greatest Common Divisor
LCM -> Least Common Multiple

; =============================================
; (my-gcd x1 x2 x3 ... xn)
; Calcola il massimo comun divisore di N numeri
; =============================================
(define (gcd_ a b) ; gcd funzione ausiliaria
  (let (r (% b a))
    (if (= r 0) a (gcd_ r a))))

(gcd_ 12 30)
;-> 6

(define-macro (my-gcd)
  ; ritorna il massimo comun divisore di tutti i numeri interi passati
  (apply gcd_ (args) 2))

(my-gcd 12 30 4)
;-> 2

; =============================================
; (my-lcm x1 x2 x3 ... xn)
; Calcola il minimo comune multiplo di N numeri
; =============================================
(define (lcm_ a b)
  ; lcm funzione ausiliaria
  (/ (* a b) (gcd_ a b)))

(lcm_ 12 30)
;-> 60

(define-macro (my-lcm)
  ; ritorna il minimo comune multiplo di tutti i numeri interi passati
  (apply lcm_ (args) 2))

(my-lcm 12 60 130)
;-> 780

Possiamo anche utilizzare una funzione lambda al posto della funzione ausiliaria:

(define-macro (lcm)
  (apply (fn (x y) (/ (* x y) (gcd_ x y))) (args) 2))

(lcm 12 60 130)
;-> 780


-----------------
Funzioni booleane
-----------------

; =====================================================
; Funzioni booleane e bitwise
; nand, nor, xor xnor
; =====================================================

;; boolean functions
(define (nand a b) (not (and a b)))
(define (nor a b) (not (or a b)))
(define (xor a b) (if (nand a b) (or a b) nil))
(define (xnor a b) (not (xor a b)))

;; bitwise versions:
(define (~& a b) (~ (& a b))) ; nand, bitwise
(define (~| a b) (~ (| a b))) ; nor, bitwise
;; xor is already in the language as ^
(define (~^ a b) (~ (^ a b))) ; xnor, bitwise


-------------------------------
Estrazione dei bit di un numero
-------------------------------

; Restituisce il bit n-esimo del numero intero positivo x
; indice zero
(define (bit n x)
    (if (< x 0) (setq x (sub 0 x))) ; solo numeri positivi
    (& (>> x (- n 1)) 1)
)

(bits 123)
;-> 1111011

(bit 1 123) ;-> 1
(bit 2 123) ;-> 1
(bit 3 123) ;-> 0
(bit 4 123) ;-> 1
(bit 5 123) ;-> 1
(bit 6 123) ;-> 1
(bit 7 123) ;-> 1


---------------------------------------------------
Conversione gradi decimali <--> gradi sessagesimali
---------------------------------------------------

; =====================================================
; (dd-to-dms degrees)
; Converte gradi decimali in gradi, minuti, secondi
; =====================================================

(define (dd-to-dms degrees)
  (local (udegree d m s)
    (if (> 0.0 degrees)
        (setq udegree (abs degrees))
        (setq udegree degrees)
    )
    (setq d (int udegree))
    (setq m (int (mul 60.0 (sub udegree d))))
    (setq s (mul 3600.0 (sub udegree d (div m 60.0))))
    (if (> 0.0 degrees) (set 'd (sub d 0)))
    ;(println d { } m { } s { })
    (list d m s)
    ;result d m s
  )
)

(dd-to-dms 30.263888889)
;-> 30 15 50.00000040000145

; =====================================================
; (dms-to-decimal degrees minutes seconds)
; Converte gradi, minuti, secondi in gradi decimali
; =====================================================

(define (dms-to-dd degrees minutes seconds)
  (local (dd)
    (if (< 0.0 degrees)
        (setq dd (add degrees (div minutes 60.0) (div seconds 3600.0)))
        (setq dd (add degrees (- 0.0 (div minutes 60.0)) (- 0.0 (div seconds 3600.0))))
    )
    result dd
  )
)

(dms-to-dd 30.0 15.0 50.0)
;-> 30.26388888888889


------------------------
Conversione RGB <--> HSV
------------------------

Conversione di un colore dallo spazio RGB (Red, Green, Blu) allo spazio HSV (Hue Saturation Value) e viceversa. Per ulteriori informazioni consultare il sito:

http://www.easyrgb.com/en/math.php

Conversione RGB -> HSV:

(define (rgb2hsv r g b)
  (local (h s v var-r var-g var-b var-min var-max del-max del-r del-g del-b)
    (setq var-r (div r 255))
    (setq var-g (div g 255))
    (setq var-b (div b 255))
    (setq var-min (min var-r var-g var-b)) ; valore minimo di RGB
    (setq var-max (max var-r var-g var-b)) ; valore massimo di RGB
    (setq del-max (sub var-max var-min))   ; delta RGB
    (setq v var-max)
    (cond ((= 0 del-max) (setq h 0) (setq s 0)) ; tono di grigio
           (true ; colore
              (setq s (div del-max var-max))
              (setq del-r (div (add (div (sub var-max var-r) 6) (div del-max 2)) del-max))
              (setq del-g (div (add (div (sub var-max var-g) 6) (div del-max 2)) del-max))
              (setq del-b (div (add (div (sub var-max var-b) 6) (div del-max 2)) del-max))
              (cond ((= var-r var-max) (setq h (sub del-b del-g)))
                    ((= var-g var-max) (setq h (add (div 1 3) (sub del-r del-b))))
                    ((= var-b var-max) (setq h (add (div 2 3) (sub del-g del-r))))
                    (true println "errore")
              )
              (if (< h 0) (setq h (add 1 h)))
              (if (> h 1) (setq h (sub 1 h)))
           );end true
    )
    (list h s v)
  );end local
)

(rgb2hsv 255 255 255)
;-> (0 0 1)

(rgb2hsv 0 0 0)
;-> (0 0 0)

(rgb2hsv 80 80 80)
;-> (0 0 0.3137254901960784)

(rgb2hsv 155 55 20)
;-> (0.04320987654320985 0.8709677419354838 0.6078431372549019)

Conversione HSV -> RGB:

(define (hsv2rgb h s v)
  (local (r g b var-h var-i var-1 var-2 var-3 var-4 var-r var-g var-b)
    (cond ((= 0 s) (setq r (mul v 255)) (setq g (mul v 255)) (setq b (mul v 255)))
          (true
             (setq var-h (mul h 6))
             (if (= var-h 6) (setq var-h 0)) ; h deve essere minore di 1
             (setq var-i (floor var-h))
             (setq var-1 (mul v (sub 1 s)))
             (setq var-2 (mul v (sub 1 (mul s (sub var-h var-i)))))
             (setq var-3 (mul v (sub 1 (mul s (sub 1 (sub var-h var-i))))))
             (cond ((= 0 var-i) (setq var-r v)     (setq var-g var-3) (setq var-b var-1))
                   ((= 1 var-i) (setq var-r var-2) (setq var-g v)     (setq var-b var-1))
                   ((= 2 var-i) (setq var-r var-1) (setq var-g v)     (setq var-b var-3))
                   ((= 3 var-i) (setq var-r var-1) (setq var-g var-2) (setq var-b v))
                   ((= 4 var-i) (setq var-r var-3) (setq var-g var-1) (setq var-b v))
                   (true        (setq var-r v    ) (setq var-g var-1) (setq var-b var-2))
             )
             (setq r (mul var-r 255))
             (setq g (mul var-g 255))
             (setq b (mul var-b 255))
          )
    );end cond
    (list r g b)
  );end local
)

(hsv2rgb 0 0 1)
;-> (255 255 255)

(hsv2rgb 0 0 0)
;-> (0 0 0)

(hsv2rgb 0 0 0.3137254901960784)
;-> (80 80 80)

(hsv2rgb 0.04320987654320985 0.8709677419354838 0.6078431372549019)
;-> (155 54.99999999999998 20.00000000000001)

(hsv2rgb 0.5 0.5 0.5)
;-> (63.75 127.5 127.5)

(rgb2hsv 63.75 127.5 127.5)
;-> (0.4999999999999999 0.5 0.5)


-------------------------------
Calcolo della media di n numeri
-------------------------------

; =====================================================
; (media lst) oppure (media x1 x2 ... xn)
; Calcola la media di n numeri
; =====================================================

(define (media)
  (if (or (= (args) '()) (= (args) '(()) )) nil
    (if (= (length (args)) 1) ;controlla se args è una lista o una serie di numeri
        (div (apply add (first (args))) (length (first (args))))
        (div (apply add (args)) (length (args)))
    )
  )
)

(media)
;-> nil

(media '())
;-> nil

(media 1 2 3)
;-> 2

(media '(1 2 3 4 5 6 7 8 9))
;-> 5

(media (sequence 1 9999))
;-> 5000

(setq lst '(1 2 3 4 5 6))
(media lst)
;-> 3.5


----------
Istogramma
----------

Data una lista disegnare l'istogramma dei valori.
Deve essere possibile passare un parametro che indica che la lista passata non è una lista di frequenze, ma una lista di valori: in tal taso occorre calcolare la lista delle frequenze prima di disegnare l'istogramma.

Le seguenti espressioni creano una lista di valori con 1000 elementi ("res"):

(setq res '())
(for (i 0 999)
  (push (rand 11) res -1)
)
(length res)

Le seguenti espressioni creano la lista delle frquenzze della lista "res":

(setq f (array 11 '(0)))
(dolist (el res)
  (println el)
  (++ (f (- el 1)))
)

f
;-> (80 98 86 83 86 99 90 106 80 84 108)

La seguente funzione disegna l'istogramma, se il parametro "calc" vale true, allora calcola la lista delle frequenze dalla lista passata:

(define (istogramma lst hmax (calc nil))
  (local (unici linee hm scala f-lst)
    (if calc
      ;calcolo la lista delle frequenze partendo da lst
      (begin
        ;trovo quanti numeri diversi ci sono nella lista
        (setq unici (length (unique lst)))
        ;creo la lista delle frequenze
        (setq f-lst (array unici '(0)))
        ; calcolo dei valori delle frequenze
        (dolist (el lst)
          (++ (f-lst (- el 1)))
        )
      )
      ;else
      ;lst è la lista delle frequenze
      (begin (setq f-lst lst))
    )
    (setq hm (apply max f-lst))
    (setq scala (div hm hmax))
    (setq linee (map (fn (x) (round (div x scala))) f-lst))
    (dolist (el linee)
      ;(println (format "%3d %s %0.2f" (add $idx 1) (dup "*" el) (f-lst $idx)))
      (println (format "%3d %s %4d" $idx (dup "*" el) (f-lst $idx)))
    )
  );local
)

(istogramma f 20)
;->   0 ***************   80
;->   1 ******************   98
;->   2 ****************   86
;->   3 ***************   83
;->   4 ****************   86
;->   5 ******************   99
;->   6 *****************   90
;->   7 ********************  106
;->   8 ***************   80
;->   9 ****************   84
;->  10 ********************  108

(istogramma res 20 true)
;->   0 ***************   80
;->   1 ******************   98
;->   2 ****************   86
;->   3 ***************   83
;->   4 ****************   86
;->   5 ******************   99
;->   6 *****************   90
;->   7 ********************  106
;->   8 ***************   80
;->   9 ****************   84
;->  10 ********************  108


--------------------
Stampare una matrice
--------------------

(define (print-matrix matrix)
  (local (row col nmax nmin digit fmtstr)
    ; converto matrice in lista ?
    (if (array? matrix) (setq matrix  (array-list matrix)))
    ; righe della matrice
    (setq row (length matrix))
    ; colonne della matrice (da rivedere)
    (setq col (length (first matrix)))
    ; valore massimo
    (setq nmax (string (apply max (flat matrix))))
    ; valore minimo
    (setq nmin (string (apply min (flat matrix))))
    ; calcolo spazio per i numeri
    (setq digit (add 1 (max (length nmax) (length nmin))))
    ; creo stringa di formattazione
    (setq fmtstr (append "%" (string digit) "d"))
    ; stampa
    (for (i 0 (sub row 1))
      (for (j 0 (sub col 1))
        (print (format fmtstr (matrix i j)))
      )
      (println)
    )
  )
)


----------------------------
Retta passante per due punti
----------------------------

(define (retta2p x1 y1 x2 y2)
  (local (m q)
    (cond ((zero? (sub x1 x2))
              (setq m (div 1 0))
              (setq q 0)
          )
          ((zero? (sub y1 y2))
              (setq m 0)
              (setq q y1)
          )
          (true
              (setq m (div (sub y1 y2) (sub x1 x2)))
              (setq q (sub y1 (mul m x1)))
          )
    )
    (list m q)
  )
)

(retta2p 2 -3 3 -1)
;-> (2 -7)

(retta2p 2 2 3 3)
;-> (1 0)

;retta verticale
(retta2p 2 4 2 3)
;-> (1.#INF 0)

;retta orizzontale
(retta2p 1 4 2 4)
;-> (0 4)


------------------------------------
Coordinate dei punti di una funzione
------------------------------------

Supponiamo di avere la seguente funzione e di voler ottenere una serie di coordinate (x,y):

y = f(x) = (3*x^2 - 4*x + 6)

Definiamo la funzione:

(define (fx x) (add (mul 3 (mul x x)) (- (mul 4 x)) 6))

Vogliamo calcolare 5 coppie di coordinate con x che va da 10 a 20.

Prima generiamo i valori delle x:

(setq l (sequence 10 20 2))
;-> (10 12 14 16 18 20)

Poi generiamo i valori delle y:

(setq k (map fx l))
;-> (266 390 538 710 906 1126)

Poi uniamo le due liste:

(transpose (list l k))
;-> ((10 266) (12 390) (14 538) (16 710) (18 906) (20 1126))

Possiamo scrivere una funzione che restituisce le coppie di coordinate:

(define (coordFX funzione xi xf passo)
  (local (lstX lstY)
    (setq lstX (sequence xi xf passo))
    (setq lstY (map funzione lstX))
    (transpose (list lstX lstY))
  )
)

(coordFX fx 10 20 2)
;-> ((10 266) (12 390) (14 538) (16 710) (18 906) (20 1126))

Definiamo la funzionde quadrato:

(define (gx x) (mul x x))

(coordFX gx 1 10 1)
;-> ((1 1) (2 4) (3 9) (4 16) (5 25) (6 36) (7 49) (8 64) (9 81) (10 100))


-----------------------------------
Leggere e stampare un file di testo
-----------------------------------

;==================================
; (stampa file)
; Legge e stampa un file di testo
; Il parametro "file" è una stringa
;==================================

(define (stampa file)
  (local (afile linea)
    (setq afile (open file "read"))
    (while (read-line afile)
      (setq linea (current-line))
      (println linea)
    )
    (close afile)
  )
)

(stampa "stampa.txt")
;-> riga 1 del file da stampare
;-> riga 2 del file da stampare
;-> fine del file
;-> true


--------------------------------------
Criptazione e decriptazione di un file
--------------------------------------

La funzione "encrypt" di newLISP funziona in modo biunivoco:
(encrypt (encrypt "testo")) = "testo".
In altre parole una doppia criptazione restituisce il file originale, quindi possiamo scrivere una funzione unica:

;========================================
; Cripta/Decripta un file con buffer read
;========================================
(define (cripta inputfile outputfile key)
  (local (infile outfile crypt)
    (setq infile (open inputfile "read"))
    (setq outfile (open outputfile "write"))
    (while (!= (read infile buffer 256) nil)
        (setq crypt (encrypt buffer key))
        (write outfile crypt 256)
        ;(print (encrypt buffer key))
    )
    (close infile)
    (close outfile)
  )
)

Per criptare un file:
(cripta "testo.txt" "testo.enc" "chiave")

Per decriptare un file:
(cripta "testo.enc" "testo.out" "chiave")


-------------------------
Funzioni per input utente
-------------------------

*********************
>>>funzione READ-KEY
*********************
sintassi: (read-key)

Legge un tasto dalla tastiera e restituisce un valore intero. Per i tasti di navigazione, è necessario effettuare più di una chiamata read-key. Per i tasti che rappresentano i caratteri ASCII, il valore di ritorno è lo stesso su tutti i Sistemi Operativi, ad eccezione dei tasti di navigazione e di altre sequenze di controllo come i tasti funzione, nel qual caso i valori di ritorno possono variare in base ai diversi SO e alle configurazioni.

(read-key)  → 97  ; after hitting the A key
(read-key)  → 65  ; after hitting the shifted A key
(read-key)  → 10  ; after hitting [enter] on Linux
(read-key)  → 13  ; after hitting [enter] on Windows

(while (!= (set 'c (read-key)) 1) (println c))

L'ultimo esempio può essere utilizzato per verificare le sequenze di ritorno dalla navigazione e dai tasti funzione. Per interrompere il ciclo, premere Ctrl-A.

Nota che read-key funziona solo quando newLISP è in esecuzione in una shell Unix o nella shell dei comandi di Windows. Non funziona nelle gui Java newLISP-GS e Tcl/Tk newLISP-Tk. Non funziona neanche nelle shared library newwLISP di UNIX o nella DLL newLISP di Windows (Dynamic Link Library).

; =====================================================
; yes-no
; Ask user to input "Y" or "N" (all other keys)
; =====================================================

(define (yes-no message)
  (print message)
  (if (= "Y" (upper-case (read-line)))
    true
    nil
  )
)

(yes-no "Do you want to exit (y/n)? ")

; =====================================================
; input-symbol
; Ask user to input a symbol
; read-line function return a string
; =====================================================

(define (input-symbol message)
  (print message)
  ; a symbol can't begin with number
  (while (number? (int (read-line)))
    (print message)
  )
  (sym (current-line))
)

(input-symbol "Insert a symbol: ")


; =====================================================
; input-string
; Ask user to input a string
; read-line function return a string
; =====================================================

(define (input-string message)
  (print message)
  (while (not (string? (read-line)))
    (print message)
  )
  (current-line)
)

(input-string "Insert a string: ")

; =====================================================
; input-number
; Ask user to input a number (float)
; =====================================================

(define (input-number message)
  (print message)
  (while (not (number? (float (read-line))))
    (print message)
  )
  (float (current-line))
)

(input-number "Insert a number: ")

; =====================================================
; input-integer
; Ask user to input a number
; =====================================================

(define (input-integer message)
  (print message)
  (while (not (integer? (int (read-line))))
    (print message)
  )
  (int (current-line))
)

(input-integer "Insert an integer: ")


----------------
Emettere un beep
----------------

newLISP emette un suono/beep quando si stampa il carattere 'bell':

(println (char 7))
;-> "\007"

; =============================================
; (beep)
; Emette un beep
; =============================================
(define (beep)
  (silent (print (char 7))))

La funzione "silent" sopprime l'output sulla console, quindi non compare "\007".

(beep)

Può essere utile per segnalare il termine delle operazioni.


---------------------------------------
Disabilitare l'output delle espressioni
---------------------------------------

La funzione "silent" è simile a "begin": valuta una sequenza di espressioni sopprimendo l'output e il prompt. Per ritornare al prompt occorre premere "invio" due volte.

(silent (setq a 10) (println a))
;-> 10 ; premere "invio" due volte per ritornare al prompt

Un modo elegante per ritornare al prompt senza intervento dell'utente è il seguente:

; funzione che ritorna al prompt dopo una chiamata a "silence"
(define (resume) (print "\r\n> "))

; funzione generica
(define (myfunction) "valore di ritorno")

; Come utilizzare il metodo:
(silent (myfunction) (print "Fatto") (resume))


-----------------------------------------------------
Trasformare una lista di stringhe in lista di simboli
-----------------------------------------------------

(setq str "Questa è la stringa da convertire")
;-> "Questa è la stringa da convertire"

(setq lst (parse str))
;-> ("Questa" "è" "la" "stringa" "da" "convertire")

(map sym lst)
;-> (Questa è la stringa da convertire)


--------------------------
Simboli creati dall'utente
--------------------------

Per vedere quali simboli crea la nostra funzione possiamo utilizzare il seguente procedimento:
1) lanciare una nuova REPL
2) impostare i simboli attuali su una variabile:
   (setq prima (symbols))
3) Lanciare la funzione
4) impostare i nuovi simboli su una variabile:
   (setq dopo (symbols))
5) Effettuare la differenza tra le due variabili:
   (difference dopo prima)

Esempio:
1) lancio una nuova REPL
2) creo una lista con i simboli attuali:
  (setq prima (symbols))
3) Scrivo la funzione:
  (define (doppio x) (mul x x))
4) creo una lista con i nuovi simboli:
  (setq dopo (symbols))
5) calcolo la differenza tra le due liste di simboli:
  (difference dopo prima)
;-> (dopo doppio x)

La seguente funzione restituisce una lista con due sottoliste, la prima sottolista contiene i nomi delle funzioni definite dall'utente (lambda), mentra la seconda sottolista contiene tutti gli altri simboli definiti dall'utente.

Definite la seguente funzione in una nuova sessione di newLISP (una nuova REPL) e poi eseguitela:

(define (user-symbols)
  (local (func other)
    (setq func '())
    (setq other '())
    (dolist (el (symbols))
      (if (lambda? (eval el))  (push el func -1))
      (if (and (not (lambda? (eval el)))
               (not (primitive? (eval el)))
               (not (protected? el))
               (not (global? el)))
          (push el other -1))
    )
    (list func other)
  )
)

(user-symbols)
;-> ((module user-symbols) (el func other))


-------------------------------------------------
Il programma è in esecuzione ? (progress display)
-------------------------------------------------

Qualche volta abbiamo bisogno di sapere se un programma è in esecuzione (e a che punto si trova) oppure si è bloccato in qualche parte del nostro codice. Ci sono due metodi per questo:
il primo metodo stampa ciclicamente una serie di simboli sulla console per dimostrare che il programma sta girando:

(define (controllo)
    (setq i 1)
    (dotimes (x 100000)
      (case i
        (1 (print "wait... |\r"))
        (2 (print "wait... /\r"))
        (3 (print "wait... -\r"))
        (4 (print "wait... \\\r"))
        (true "errore")
      )
      (inc i)
      (if (> i 4) (setq i 1))
    )
    (println "Programma terminato")
)

Il programma stampa ciclicamente un carattere della serie "|", "/". "-", "\\".
Poichè ad ogni print stampiamo anche un "carriage return" (\r) stampiamo sempre sulla stessa linea a partire dalla colonna zero. Questo genera la semplice animazione che vedete quando eseguite la funzione.

(controllo)
;-> wait... (animazione dei caratteri)
;-> Programma terminato
;-> "Programma terminato"

Per migliorare l'output possiamo scrivere:

(define (resume) (print "\r\n> "))

(silent (controllo) (resume))
;-> Programma terminato

Possiamo diminuire il numero dei caratteri nell'animazione scegliendo due caratteri ":" e "-":

(define (controllo)
    (setq i 0)
    (dotimes (x 100000)
      (if (= 0 i) (print "wait... :\r")
                  (print "wait... -\r")
      )
      (inc i)
      (if (> i 1) (setq i 0))
    )
    (println "Programma terminato")
)

(silent (controllo) (resume))
;-> wait... (animazione dei caratteri)
;-> Programma terminato

Il secondo metodo è più informativo, poichè visualizza il valore della iterazione corrente:

(define (controllo)
    (setq iter 10000000)
    (dotimes (x 100000000)
      ; ogni iter iterazioni stampiamo il valore
      (if (= 0 (mod x iter)) (print "Iter: " x "\r"))
    )
    (println "Programma terminato")
)

(silent (controllo) (resume))
;-> Iter: 0 ... ;-> Iter: 900000000
;-> Programma terminato

Da notare che entrambi i metodi rallentano leggermente l'esecuzione del programma.


-----------------------------
Ispezionare una cella newLISP
-----------------------------

Per conoscere il contenuto (tipo) di una cella lisp possiamo utilizzare la funzione "dump".

****************
>>>funzione DUMP
****************
sintassi: (dump [exp])

Mostra i contenuti binari di una nuova cella LISP. Senza argomenti, questa funzione restituisce un elenco di tutte le celle Lisp. Quando viene fornito exp, viene valutato e il contenuto della cella Lisp viene restituito in una lista.

(dump 'a)
;-> (9586996 5 9578692 9578692 9759280)

(dump 999)
;-> (9586996 130 9578692 9578692 999)

L'elenco contiene i seguenti indirizzi di memoria e informazioni:

offset  descrizione
0       indirizzo di memoria della cella Lisp
1       cella->tipo: maggiore/minore, vedi newLISP.h per i dettagli
2       cella->successivo: puntatore alla linked list
3       cella->aux:
           lunghezza della stringa + 1 o
           low (little endian) o high (big endian) word di numero intero a 64 bit o
           low word di double float IEEE 754
4       cella->contenuto:
           indirizzo della stringa/simbolo o
           high (little endian) o low (big endian) word di numero intero a 64 bit o
           high di double float IEEE 754

Questa funzione è utile per modificare i bit di tipo nelle celle o per hackerare altre parti dei nuovi interni di LISP.

La seguente funzione estrae il tipo di dato contenuto in una cella newLISP:

(define (type x) (& 15 (nth 1 (dump x))))

(type nil)
;-> 0            ;; nil
(type true)
;-> 1            ;; true
(type 123)
;-> 2            ;; integer
(type 1.23)
;-> 3            ;; float
(type "abcd")
;-> 4            ;; string
(type 'asymbol)
;-> 5            ;; symbol
(type MAIN)
;-> 6            ;; context
(type +)
;-> 7            ;; primitive
;; 8             ;; imports cdecl, dll
;; 9             ;; imports ffi
(type ''asym)
;-> 10           ;; quote
(type '(1 2 3))
;-> 11           ;; list expression
(type type)
;-> 12           ;; lambda
;; 13            ;; fexpr
;; 14            ;; array
;; 15            ;; dynamic symbol

Vedere il file newLISP.h nel programma sorgente per conoscere i bit superiori e il loro significato (e anche altre cose).

Un altro metodo simile:

(define types '("nil" "true" "int" "float" "string" "symbol" "context"
    "primitive" "import" "ffi" "quote" "expression" "lambda" "fexpr" "array"
    "dyn_symbol"))

(define (typeof v)
    (types (& 0xf ((dump v) 1))))


-----------------------------------
Informazioni sul sistema (sys-info)
-----------------------------------

Possiamo ottenere diverse informazioni sul sistema in uso utilizzando la funzione "sys-info".

********************
>>>funzione SYS-INFO
********************
sintassi: (sys-info [int-idx])

Chiamando sys-info senza int-idx viene restituito un elenco di informazioni sulle risorse. Dieci valori interi che hanno il seguente significato:

valore descrizione
  0     Numero di celle Lisp
  1     Numero massimo di celle Lisp (costante)
  2     Numero di simboli
  3     Livello di valutazione / ricorsione dell'ambiente
  4     Livello di stack dell'ambiente
  5     Numero massimo di chiamate allo stack (costante)
  6     Pid del processo genitore oppure 0
  7     Pid del processo newLISP
  8     Numero della versione come costante intera
  9     Costanti del sistema operativo:
        linux = 1, bsd = 2, osx = 3, solaris = 4, windows = 6, os/2 = 7, cygwin = 8, tru64 unix = 9, aix = 10, android = 11
        il bit 11 è impostato per le versioni ffilib (Extended Import / Callback API) (aggiungere 1024)
        il bit 10 è impostato per le versioni IPv6 (aggiungere 512)
        il bit  9 è impostato per le versioni a 64 bit (modificabili a runtime) (aggiungere 256)
        il bit  8 è impostato per le versioni UTF-8 (aggiungere 128)
        il bit  7 è aggiunto per le versioni di libreria (aggiungere 64)

I numeri da 0 a 9 indicano il valore l'indice int-idx (opzionale) nella lista restituita.

Si consiglia di utilizzare gli indici da 0 a 5 (includendo) "Numero massimo di chiamate allo stack costante") e utilizzare gli offset negativi da -1 a -4 per accedere alle ultime quattro voci nella lista delle informazioni di sistema. Le future nuove voci verranno inserite dopo l'indice 5. In questo modo i programmi scritti precedentemente non dovranno essere modificati.

Quando si usa int-idx, verrà restituito un solo elemento della lista.

(sys-info) → (429 268435456 402 1 0 2048 0 19453 10406 ​​1155)
(sys-info 3) → 1
(sys-info -2) → 10406 ​​;; versione 10.4.6

Il numero relativo al massimo di celle Lisp può essere modificato tramite l'opzione della riga di comando -m. Per ogni megabyte di memoria di celle Lisp, è possibile allocare 64k celle Lisp. La profondità massima dello stack di chiamata può essere modificata utilizzando l'opzione della riga di comando -s.

(bits (sys-info -1))
;-> "10110000110"
1 --> ffilib ON
0 --> IPv6 OFF
1 --> 64bit ON
1 --> UTF-8 ON
0 --> library OFF
0 --> (free)
0 --> (free)
0110 --> 6 = windows

Per rendere più leggibili le informazioni scriviamo la funzione "sysinfo":

(define (sysinfo)
  (local (info num num$ so)
    (setq info (sys-info))
    (println "Number of Lisp cells: " (info 0))
    (println "Maximum number of Lisp cells constant: " (info 1))
    (println "Number of symbols: " (info 2))
    (println "Evaluation/recursion level: " (info 3))
    (println "Environment stack level: " (info 4))
    (println "Maximum call stack constant: " (info 5))
    (println "Pid of the parent process or 0: " (info -4))
    (println "Pid of running newLISP process: " (info -3))
    (println "Version number as an integer constant: " (info -2))
    (setq num (sys-info -1))
    (setq num$ (bits num))
    (setq so (int (slice num$ (- (length num$) 4)) 0 2))
    (print "Operating System: ")
    (case so
        (1  (println "linux"))
        (2  (println "bsd"))
        (3  (println "osx"))
        (4  (println "solaris"))
        (5  (println "nil"))
        (6  (println "windows"))
        (7  (println "os/2"))
        (8  (println "cygwin"))
        (9  (println "tru64 unix"))
        (10 (println "aix"))
        (11 (println "android"))
        (true (println so))
    );case
    ; ffilib -> bit 11
    (print "ffilib: ")
    (if (zero? (& (>> num 10) 1)) (println "no") (println "yes"))
    ; IPV6 -> bit 10
    (print "IPV6: ")
    (if (zero? (& (>> num 9) 1)) (println "no") (println "yes"))
    ; 64 bit -> bit 9
    (print "64 bit: ")
    (if (zero? (& (>> num 8) 1)) (println "no") (println "yes"))
    ; library -> bit 8
    (print "UTF-8: ")
    (if (zero? (& (>> num 7) 1)) (println "no") (println "yes"))
    ; library -> bit 6
    (print "library: ")
    (if (zero? (& (>> num 6) 1)) (println "no") (println "yes"))
    info
  )
)

(sysinfo)
;-> Number of Lisp cells: 983
;-> Maximum number of Lisp cells constant: 576460752303423488
;-> Number of symbols: 425
;-> Evaluation/recursion level: 4
;-> Environment stack level: 1
;-> Maximum call stack constant: 2048
;-> Pid of the parent process or 0: 0
;-> Pid of running newLISP process: 6884
;-> Version number as an integer constant: 10705
;-> Operating System: windows
;-> ffilib: yes
;-> IPV6: no
;-> 64 bit: yes
;-> UTF-8: yes
;-> library: no
;-> (959 576460752303423488 425 2 0 2048 0 6884 10705 1414)


------------------------------------
Valutazione di elementi di una lista
------------------------------------

Supponiamo di aver creato la seguente lista:

(setq lst '( ((+ 6 2) (a) 2) ((- 2 5) (b) 5) ))
;-> (((+ 6 2) (a) 2) ((- 2 5) (b) 5))

La lista ha due elementi ((+ 6 2) (a) 2) e ((- 2 5) (b) 5).

Adesso vogliamo valutare il primo elemento di ogni sottolista: (+ 6 2) e (- 2 5).

Aggiorniamo questo elemento con la sua valutazione:

(dolist (el lst) (setf (first (lst $idx)) (eval (first el))))

Vediamo il risultato:

lst
;-> ((8 (a) 2) (-3 (b) 5))


---------------------------------------
Download tutti i file da una pagina web
---------------------------------------

La seguente funzione permette di scaricare tutti i file da una pagina web.

; get-all.lsp
; cameyo 2019
; scarica tutti i file da una pagina web
; get all downloadable files from a webpage

; get the page
(setq page (get-url "http://newlisp.digidep.net/"))
(setq page (get-url "http://landoflisp.com/source.html"))

; find files (*.lsp)
(setq filesA (find-all {href="(.*\.lsp)"} page $1))

; find files (*.jpg)
(setq filesB (find-all {href="(.*\.jpg)"} page $1))

(setq allfiles (union filesA filesB))

(dolist (file allfiles)
        (write-file file (get-url (string "http://newlisp.digidep.net/scripts/" file)))
        (println "->" file))

Esempio:

(change-dir "c:/temp")
(setq page (get-url "http://landoflisp.com/source.html"))
(setq allfiles (find-all {href="(.*\.lisp)"} page $1))
(dolist (file allfiles)
        (write-file file (get-url (string "http://landoflisp.com/source.html" file)))
        (println "-> " file))
;-> -> guess.lisp
;-> -> wizards_game.lisp
;-> -> graph-util.lisp
;-> -> wumpus.lisp
;-> -> orc-battle.lisp
;-> -> evolution.lisp
;-> -> robots.lisp
;-> -> webserver.lisp
;-> -> dice_of_doom_v1.lisp
;-> -> svg.lisp
;-> -> wizard_special_actions.
;-> -> lazy.lisp
;-> -> dice_of_doom_v2.lisp
;-> -> dice_of_doom_v3.lisp
;-> -> dice_of_doom_v4.lisp


-------------------------------------
Conversione numero da cifre a lettere
-------------------------------------

Vogliamo convertire un numero da cifre a lettere, ad esempio:

10421 -> diecimilaquattrocentoventuno

Questo problema è più difficile da risolvere per la lingua italiana che per quella inglese a causa delle cifre 1 ("uno") e 8 ("otto") che modifica la lettura del numero (es. ventuno e non ventiuno, trentotto e non trantaotto).

Come prima cosa definiamo alcune liste:

  ; la cifra 1
  (setq un "Un")
  ; le dieci cifre - codeA
  (setq cifre '("Zero" "Uno" "Due" "Tre" "Quattro" "Cinque" "Sei" "Sette"
    "Otto" "Nove"))
  ; i primi venti numeri - code
  (setq venti '("Zero" "Uno" "Due" "Tre" "Quattro" "Cinque" "Sei" "Sette"
    "Otto" "Nove" "Dieci" "Undici" "Dodici" "Tredici" "Quattordici"
    "Quindici" "Sedici" "Diciassette" "Diciotto" "Diciannove"))
  ; le decine - codeB
  (setq decine '("" "" "Venti" "Trenta" "Quaranta" "Cinquanta"
    "Sessanta" "Settanta" "Ottanta" "Novanta"))
  ; le decine senza vocali - codeB1
  (setq dcn    '("" "" "Vent" "Trent" "Quarant" "Cinquant"
    "Sessant" "Settant" "Ottant" "Novant"))
  ; il numero 100
  (setq cento "Cento")
  ; multipli con la cifra 1 - codeC
  (setq multiplo '("" "Mille" "Milione" "Miliardo" "Bilione" "Biliardo"
    "Trilione" "Triliardo" "Quadrilione" "Quadriliardo"))
  ; multipli con la cifra diversa da 1 - codeC1
  (setq multipli '("" "Mila" "Milioni" "Miliardi" "Bilioni" "Biliardi"
    "Trilioni" "Triliardi" "Quadrilioni" "Quadriliardi"))

Poichè la lettura di un numero procede per gruppi di tre (partendo da sinistra) scriviamo una funzione che converte in lettere un numero con 3 cifre. I numeri con una o due cifre devono essere riempiti con degli zeri: 000,001,002,...,999.
L'algoritmo controlla a quale cifra si riferisce (unita, decine o centinaia) e crea la stringa relativa. La creazione della stringa avviene scegliendo la lista corretta in base al valore della cifra e verificando se la cifra vale 1 o 8.

(define (triple num)
  (local (lst res)
    (setq res "")
    ; lista delle cifre
    (setq lst (map int (explode (string num))))
    (dolist (el lst)
      (cond ((= el 0) nil)
            (true (cond ((= $idx 2) ; cifra unita ?
                          (if (!= 1 (lst 1)) ; ultime 2 cifre > 19 ?
                              (setq res (append res (cifre el)))))
                        ((= $idx 1) ; cifra decine ?
                          (if (= el 1) ; ultime 2 cifre < 20 ?
                            ; prendo il numero da 11 a 19
                            (setq res (append res (venti (+ 9 el (lst 2)))))
                            ; oppure prendo le decine
                            (if (or (= 1 (lst 2)) (= 8 (lst 2))) ; numero finisce con 1 o con 8?
                              ; prendo le decine senza vocale finale
                              (setq res (append res (dcn el)))
                              ; oppure prendo le decine con vocale finale
                              (setq res (append res (decine el))))))
                        ((= $idx 0) ; cifra centinaia ?
                          (if (= el 1) ; cifra centinaia = 1 ?
                              ; prendo solo "cento"
                              (setq res (append res cento))
                              ; prendo il numero e "cento"
                              (setq res (append res (venti el) cento))))
                  )
            )
      )
    )
    res
  )
)

Proviamo la funzione:

(triple "010")
;-> Dieci
(triple "070")
;-> "Settanta"
(triple "999")
;-> "NoveCentoNovantaNove"
(triple "007")
;-> "Sette"
(triple "000")
;-> ""
(triple 100)
;-> "Cento"
(triple "001")
;-> "Uno"
(triple "016")
;-> "Sedici"
(triple "020")
;-> Venti
(triple "011")
;-> "Undici"
(triple "071")
;-> "SettantUno"
(triple "021")
;-> "Ventuno"
(triple "088")
;-> "OttantOtto"

Adesso definiamo una funzione che formatta un numero. La funzione prende un numero da formattare in stringa, un numero che rappresenta la lunghezza della stringa finale e un carattere con cui viene riempita la stringa se il numero ha una lunghezza inferiore alla lunghezza della stringa finale.

(define (pad num len ch)
  (local (out)
    (setq out (string num))
    (while (> len (length out))
      (setq out (string ch out)))
  out
  )
)

(pad 1256 8 "0")
;-> "00001256"

(pad 124623 3 "0")
;-> "124623"

(pad 1 3 "0")
;-> "001"

Ora possiamo stampare tutti i numeri da 1 (uno) a 100 (cento):

(for (i 1 100) (println i { - } (triple (pad i 3 "0"))))
;-> 1 - Uno
;-> 2 - Due
;-> 3 - Tre
;-> 4 - Quattro
;-> 5 - Cinque
;-> 6 - Sei
;-> 7 - Sette
;-> 8 - Otto
;-> 9 - Nove
;-> 10 - Dieci
;-> 11 - Undici
;-> ...
;-> 89 - OttantaNove
;-> 90 - Novanta
;-> 91 - NovantUno
;-> 92 - NovantaDue
;-> 93 - NovantaTre
;-> 94 - NovantaQuattro
;-> 95 - NovantaCinque
;-> 96 - NovantaSei
;-> 97 - NovantaSette
;-> 98 - NovantaOtto
;-> 99 - NovantaNove
;-> 100 - Cento

La funzione finale utilizza la funzione "triple" e tiene conto del numero (indice) della tripla a cui si riferisce per la creazione della stringa risultato.

(define (numero num)
  (local (lst tri val out)
    (setq out "")
    (if (= (string num) "0")
      (setq out "zero")
      (begin
        ; calcola il numero di triplette
        (if (zero? (% (length (string num)) 3))
            (setq tri (/ (length (string num)) 3))
            (setq tri (+ (/ (length (string num)) 3) 1))
        )
        ; formatta in stringa il numero (padding)
        ; e crea una lista con tutte le triplette
        (setq lst (explode (pad (string num) (* 3 tri) "0") 3))
        ; ciclo per la creazione della stringa finale
        (dolist (el lst)
          ; creazione del numero rappresentato dalla tripletta
          (setq val (triple el))
          ; controllo se tale numero vale "Uno"
          (if (= val "Uno")
            (cond ((= $idx (- (length lst) 1)) ; primo gruppo a destra ?
                  (setq out (append out val))) ; aggiungo solo "Uno"
                  ((= $idx (- (length lst) 2)) ; secondo gruppo a destra ?
                  (setq out (string out (multiplo (- tri 1))))) ;aggiungo solo "Mille"
                  ;altrimenti aggiungo "Un" e il codice corrispondente
                  (true (setq out (string out "Un" (multiplo (- tri 1)))))
            )
            (if (!= val "") ; se la tripletta vale "000" --> val = ""
              (setq out (string out val (multipli (- tri 1)))))
          )
          (-- tri)
          ;(println (triple el))
        )
        out
      )
    )
  )
)

(numero "2001001")
;-> "DueMilioniMilleUno"
(numero "1000000")
;-> "UnMilione"
(numero "12345670")
;-> "DodiciMilioniTreCentoQuarantaCinqueMilaSeiCentoSettanta"
(numero "2401001024")
;-> "DueMiliardiQuattroCentoUnoMilioniMilleVentiQuattro"
(numero "1111111111")
;-> "UnMiliardoCentoUndiciMilioniCentoUndiciMilaCentoUndici"
(numero "888881")
;-> "OttoCentoOttantOttoMilaOttoCentoOttantUno"

(for (i 0 100) (println i { - } (numero i)))
;-> 0 - zero
;-> 1 - Uno
;-> 2 - Due
;-> 3 - Tre
;-> 4 - Quattro
;-> 5 - Cinque
;-> 6 - Sei
;-> 7 - Sette
;-> 8 - Otto
;-> 9 - Nove
;-> 10 - Dieci
;-> 11 - Undici
;-> ...
;-> 88 - OttantOtto
;-> 89 - OttantaNove
;-> 90 - Novanta
;-> 91 - NovantUno
;-> 92 - NovantaDue
;-> 93 - NovantaTre
;-> 94 - NovantaQuattro
;-> 95 - NovantaCinque
;-> 96 - NovantaSei
;-> 97 - NovantaSette
;-> 98 - NovantOtto
;-> 99 - NovantaNove
;-> 100 - Cento


--------------------------------------
Punto a destra o sinistra di una linea
--------------------------------------

Data una linea e un punto, determinare se il punto si trova a destra o a sinistra della linea.
Utilizziamo il prodotto vettoriale (cross-product) tra due vettori.
Se il prodotto è maggiore di zero, allora il punto si trova a sinistra della linea.
Se il prodotto è minore di zero, allora il punto si trova a destra della linea.
Se il prodotto è uguale a zero, allora il punto si trova sulla linea.

(cross (point-a point-b point-c)
  (((b.X - a.X)*(c.Y - a.Y) - (b.Y - a.Y)*(c.X - a.X))))

dove:
a = primo punto della linea
b = secondo punto della linea
c = punto da verificare

Nel caso in cui la linea è orizzontale:
Se il prodotto è maggiore di zero, allora il punto si trova sopra la linea.
Se il prodotto è minore di zero, allora il punto si trova sotto la linea.
Se il prodotto è uguale a zero, allora il punto si trova sulla linea.

Esempio:

      |         .
      |         .PL2
      |         O
      |         .
      |         .
      |         .      P4
      |         .     X
      |   P3    .
      |     X   .
      |         .
      |         .
      |    P1   .PL1
      |   X     O
      |         .        P2
      |         .       X
      |         .
   -------------.--------------------
      |         .

(setq PL1 '(5 2))
(setq PL2 '(5 8))
(setq P1 '(2 3))
(setq P2 '(9 1))
(setq P3 '(3 6))
(setq P4 '(8 7))

(define (sinistra? PL1 PL2 P)
  (local (pl1.x pl1.y pl2.x pl2.y p.x p.y)
    (setq pl1.x (first PL1) pl1.y (last PL1))
    (setq pl2.x (first PL2) pl2.y (last PL2))
    (setq p.x (first P) p.y (last P))
    (> (sub (mul (sub pl2.x pl1.x) (sub p.y pl1.y))
            (mul (sub pl2.y pl1.y) (sub p.x pl1.x))) 0)
  )
)

(sinistra? PL1 PL2 P1)
;-> true
(sinistra? PL1 PL2 P2)
;-> nil
(sinistra? PL1 PL2 P3)
;-> true
(sinistra? PL1 PL2 P4)
;-> nil


----------------------------------------------
Creazione di un poligono da una lista di punti
----------------------------------------------

Data una lista di punti, costruire un poligono semplice (non autointersecante) con tutti i punti.

Ordiniamo i punti in base all'angolo creato con l'asse X quando si traccia una linea attraverso il punto e il punto più basso a destra (sinistra).
Se due o più punti formano lo stesso angolo con l'asse X (cioè sono allineati rispetto al punto di riferimento), questi punti devono essere ordinati in base alla distanza dal punto di riferimento.

Di seguito il codice che implementa questo algoritmo:

Funzione di confronto angoli usata dalla funzione "sort":

(define (angleCompare a b)
  (local (left)
    (setq left (isLeft p0 a b))
    (if (= left 0)
      (distCompare a b);
      (> left 0)
    )
  )
)

Funzione di confronto distanze usata dalla funzione "sort":

(define (distCompare a b)
  (local (distA distB)
    (setq distA (add (mul (sub (first p0) (first a)) (sub (first p0) (first a)))
                    (mul (sub (last p0)  (last a))  (sub (last p0)  (last a)))))
    (setq distB (add (mul (sub (first p0) (first b)) (sub (first p0) (first b)))
                    (mul (sub (last p0)  (last b))  (sub (last p0)  (last b)))))
    (> distA distB)
  )
)

Funzione che ritorna la posizione di un punto rispetto ad una retta:

(define (isLeft p0 a b)
  (sub (mul (sub (first a) (first p0)) (sub (last b) (last p0)))
       (mul (sub (first b) (first p0)) (sub (last a) (last p0))))
)

(define (crea-poligono lst)
  (local (p0 hull out)
    ; trova il punto più in basso (e più a sinistra)
    (setq hull (lst 0))
    (for (i 1 (- (length lst) 1))
      (if (<= (last (lst i)) (last hull))
          (if (= (last (lst i)) (last hull))
              (if (> (first (lst i)) (first hull))
                  (setq hull (lst i)))
              (setq hull (lst i))
          )
      )
    )
    (setq p0 hull)
    ;(println hull)
    (sort lst angleCompare)
  )
)

Vediamo alcuni esempi:

Esempio 1:

(setq P1 '(0 0))
(setq P2 '(90 10))
(setq P3 '(30 40))
(setq P4 '(80 50))
(setq P5 '(50 60))
(setq P6 '(10 100))
(setq P7 '(20 20))
(setq P8 '(30 10))

(setq points (list P1 P2 P3 P4 P5 P6 P7 P8))

(setq lista (crea-poligono points))
;-> ((90 10) (30 10) (80 50) (20 20) (50 60) (30 40) (10 100) (0 0))

Per verificare il risultato scriviamo una funzione che crea un file postscript (che viene poi convertito con ghostscript tramite un programma batch):

(define (disegna lista-punti file)
  (local (xc yc punti)
    (module "postscript.lsp")
    ; setup iniziale
    ; creazione sfondo nero
    (ps:goto 0 0)
    (ps:fill-color 0 0 0)
    (ps:line-color 0 0 0)
    (ps:rectangle 612 792 true)
    ; tipo giunzione (1 = round)
    (ps:line-join 1)
    ; spessore linea
    (ps:line-width 0.25)
    ;colore linea
    (ps:line-color 220 220 220)
    ;colore riempimento
    (ps:fill-color 255 20 20)
    ; coordinate centro della pagina
    (setq xc (/ 612 2))
    (setq yc (/ 792 2))
    ; punti da tracciare
    (setq punti lista-punti)
    ; Inizia a disegnare dal centro pagina partendo dal primo punto
    (ps:goto (+ xc (first (punti 0))) (+ yc (last (punti 0))))
    ; Sposto il primo punto alla fine (chiusura del poligono)
    (push (pop punti) punti -1)
    ; Disegna il poligono
    (dolist (el punti)
      ; disegna linea dalla posizione corrente al punto passato come parametro
      (ps:drawto (+ xc (first el)) (+ yc (last el)))
      ; disegna un punto alla posizione corrente
      (ps:circle 1 true)
    )
    ; salva il file postscript
    ;(ps:save "poly.ps")
    (ps:save (string file ".ps"))
    ; conversione del file .ps al file .pdf (ghostscript)
    ;(! (string "ps2pdf poly.ps poly.pdf")
    (! (string "ps2pdf " file ".ps " file ".pdf"))
  )
)

Creiamo i file "poly-1.ps" e "poly-1.pdf":

(disegna lista "poly-1")

Esempio 2:

(setq P1 '(20 20))
(setq P2 '(40 80))
(setq P3 '(30 50))
(setq P4 '(50 10))
(setq P5 '(70 40))
(setq P6 '(70 70))
(setq P7 '(80 20))
(setq P8 '(30 10))

(setq points (list P1 P2 P3 P4 P5 P6 P7 P8))

(setq lista (crea-poligono points))
;-> ((80 20) (70 40) (70 70) (40 80) (30 50) (20 20) (30 10) (50 10))

Creiamo i file "poly-2.ps" e "poly-2.pdf":

(disegna lista "poly-2")

Esempio 3:

(setq P1 '(80 90))
(setq P2 '(50 90))
(setq P3 '(70 70))
(setq P4 '(40 70))
(setq P5 '(60 50))
(setq P6 '(80 30))
(setq P7 '(40 40))
(setq P8 '(20 30))
(setq P9 '(60 20))

(setq points (list P1 P2 P3 P4 P5 P6 P7 P8 P9))

(setq lista (crea-poligono points))
;-> ((80 30) (80 90) (70 70) (60 50) (50 90) (40 70) (40 40) (20 30) (60 20))

Creiamo i file "poly-3.ps" e "poly-3.pdf":

(disegna lista "poly-3")

Esempio 4:

(setq P1 '(20 20))
(setq P2 '(40 50))
(setq P3 '(100 20))
(setq P4 '(60 30))
(setq P5 '(80 50))

(setq points (list P1 P2 P3 P4 P5))

(setq lista (crea-poligono points))
;-> ((80 50) (40 50) (60 30) (20 20) (100 20))

Creiamo i file "poly-4.ps" e "poly-4.pdf":

(disegna lista "poly-4")

Esempio 5:

(setq P1 '(20 20))
(setq P2 '(40 80))
(setq P3 '(30 50))
(setq P4 '(50 10))
(setq P5 '(70 40))
(setq P6 '(70 70))
(setq P7 '(80 20))
(setq P8 '(30 10))
(setq P9 '(120 50))
(setq P10 '(50 40))

(setq points (list P1 P2 P3 P4 P5 P6 P7 P8 P9 P10))

(setq lista (crea-poligono points))
;-> ((80 20) (120 50) (70 40) (70 70) (50 40) (40 80) (30 50) (20 20) (30 10) (50 10))

Creiamo i file "poly-5.ps" e "poly-5.pdf":

(disegna lista "poly-5")

Nota: questo algoritmo non trova il percorso minimo tra i punti.


-------------------------------------
Percorso minimo di una lista di punti
-------------------------------------

Data una lista di punti, costruire il poligono (percorso chiuso) che ha lunghezza minima.

Questo problema assomiglia a quello del commesso viaggiatore (Travelling Salesman Problem), ma in questo caso, potenzialmente, ogni punto è connesso con tutti gli altri (grafo completo non orientato).
L'algoritmo che adottiamo è abbastanza brutale: generiamo tutte le permutazioni dei punti e calcoliamo la somma totale della distanza tra i punti per ogni permutazione. La permutazione che ha la distanza minima è la soluzione.
Questo metodo limita fortemente il numero di punti che possiamo analizzare in tempi accettabili.

Funzione per calcolare le permutazioni:

(define (perm lst)
  (local (i indici out)
    (setq indici (dup 0 (length lst)))
    (setq i 0)
    (setq out (list lst))
    (while (< i (length lst))
      (if (< (indici i) i)
          (begin
            (if (zero? (% i 2))
              (swap (lst 0) (lst i))
              (swap (lst (indici i)) (lst i))
            )
            ;(println lst);
            (push lst out -1)
            (++ (indici i))
            (setq i 0)
          )
          (begin
            (setf (indici i) 0)
            (++ i)
          )
       )
    )
    out
  )
)

(length (perm '(0 1 2 3 4 5 6 7)))
;-> 40320

Supponiamo di avere i seguenti punti.

Esempio 1:

(setq P1 '(0 0))
(setq P2 '(90 10))
(setq P3 '(30 40))
(setq P4 '(80 50))
(setq P5 '(50 60))
(setq P6 '(10 100))
(setq P7 '(20 20))
(setq P8 '(30 10))

(setq points (list P1 P2 P3 P4 P5 P6 P7 P8))

Funzione per calcolare il quadrato della distanza tra due punti (questo è sufficiente per il confronto tra due distanze):

(define (quad-dist p q)
  (add
    (mul (sub (first q) (first p)) (sub (first q) (first p)))
    (mul (sub (last q) (last p)) (sub (last q) (last p)))))

(quad-dist P2 P1)
;-> 8200
(quad-dist P3 P2)
;-> 4500

Adesso definiamo la funzione finale:

(define (tsp lst)
  (local (permutazioni sol points dist dist-min)
    ; creazione permutazioni dei punti
    (setq permutazioni (perm lst))
    ; distanza minima iniziale
    (setq dist-min '99999999)
    (dolist (p permutazioni)
      (setq dist 0)
      ; calcola somma della distanza tra tutti i punti di una permutazione
      (for (i 1 (- (length p) 1))
        (setq dist (add dist (quad-dist (p i) (p (- i 1)))))
      )
      ; aggiunge distanza tra ultimo e primo punto (percorso chiuso)
      (setq dist (add dist (quad-dist (p 0) (p (- (length p) 1)))))
      ;controllo distanza minima
      (if (< dist dist-min)
          (begin
            (setq dist-min dist)
            (setq sol p))
            ;(println p { } dist-min)
      )
    )
    sol
  )
)

Proviamo la funzione:

(setq lista (tsp points))
;-> ((0 0) (20 20) (30 40) (10 100) (50 60) (80 50) (90 10) (30 10))

Per verificare il risultato scriviamo una funzione che crea un file postscript (che viene poi convertito con ghostscript in pdf tramite un programma batch):

(define (disegna lista-punti file)
  (local (xc yc punti)
    (module "postscript.lsp")
    ; setup iniziale
    ; creazione sfondo nero
    (ps:goto 0 0)
    (ps:fill-color 0 0 0)
    (ps:line-color 0 0 0)
    (ps:rectangle 612 792 true)
    ; tipo giunzione (1 = round)
    (ps:line-join 1)
    ; spessore linea
    (ps:line-width 0.25)
    ;colore linea
    (ps:line-color 220 220 220)
    ;colore riempimento
    (ps:fill-color 255 20 20)
    ; coordinate centro della pagina
    (setq xc (/ 612 2))
    (setq yc (/ 792 2))
    ; punti da tracciare
    (setq punti lista-punti)
    ; Inizia a disegnare dal centro pagina partendo dal primo punto
    (ps:goto (+ xc (first (punti 0))) (+ yc (last (punti 0))))
    ; Sposto il primo punto alla fine (chiusura del poligono)
    (push (pop punti) punti -1)
    ; Disegna il poligono
    (dolist (el punti)
      ; disegna linea dalla posizione corrente al punto passato come parametro
      (ps:drawto (+ xc (first el)) (+ yc (last el)))
      ; disegna un punto alla posizione corrente
      (ps:circle 1 true)
    )
    ; salva il file postscript
    ;(ps:save "poly.ps")
    (ps:save (string file ".ps"))
    ; conversione del file .ps al file .pdf (ghostscript)
    ; ps2pdf.bat
    ;(! (string "ps2pdf poly.ps poly.pdf")
    (! (string "ps2pdf " file ".ps " file ".pdf"))
  )
)

Creiamo i file "tsp-1.ps" e "tsp-1.pdf":

(disegna lista "tsp-1")

Esempio 2:

(setq P1 '(20 20))
(setq P2 '(40 80))
(setq P3 '(30 50))
(setq P4 '(50 10))
(setq P5 '(70 40))
(setq P6 '(70 70))
(setq P7 '(80 20))
(setq P8 '(30 10))

(setq points (list P1 P2 P3 P4 P5 P6 P7 P8))

(setq lista (tsp points))
;-> ((20 20) (30 50) (40 80) (70 70) (70 40) (80 20) (50 10) (30 10))

Creiamo i file "tsp-2.ps" e "tsp-2.pdf":

(disegna lista "tsp-2")

Esempio 3:

(setq P1 '(80 90))
(setq P2 '(50 90))
(setq P3 '(70 70))
(setq P4 '(40 70))
(setq P5 '(60 50))
(setq P6 '(80 30))
(setq P7 '(40 40))
(setq P8 '(20 30))
(setq P9 '(60 20))

(setq points (list P1 P2 P3 P4 P5 P6 P7 P8 P9))

(setq lista (tsp points))
;-> ((80 30) (60 50) (70 70) (80 90) (50 90) (40 70) (40 40) (20 30) (60 20))

Creiamo i file "tsp-3.ps" e "tsp-3.pdf":

(disegna lista "tsp-3")

Esempio 4:

(setq P1 '(20 20))
(setq P2 '(40 50))
(setq P3 '(100 20))
(setq P4 '(60 30))
(setq P5 '(80 50))

(setq points (list P1 P2 P3 P4 P5))

(setq lista (tsp points))
;-> ((40 50) (20 20) (60 30) (100 20) (80 50))

Creiamo i file "tsp-4.ps" e "tsp-4.pdf":

(disegna lista "tsp-4")

Esempio 5:

(setq P1 '(20 20))
(setq P2 '(40 80))
(setq P3 '(30 50))
(setq P4 '(50 10))
(setq P5 '(70 40))
(setq P6 '(70 70))
(setq P7 '(80 20))
(setq P8 '(30 10))
(setq P9 '(120 50))
(setq P10 '(50 40))

(setq points (list P1 P2 P3 P4 P5 P6 P7 P8 P9 P10))

(time (setq lista (tsp points)))
;-> 37307.071

lista
;-> ((50 10) (30 10) (20 20) (30 50) (40 80) (70 70) (120 50) (80 20) (70 40) (50 40))

Creiamo i file "tsp-5.ps" e "tsp-5.pdf":

(disegna lista "tsp-5")

Nota: Con questo algoritmo possiamo calcolare al massimo dieci punti (altrimenti il calcolo delle permutazioni richiederebbe troppo tempo).


---------------------------
Utilizzo del protocollo ftp
---------------------------

newLISP mette a disposizione un modulo per il download e l'upload di file tramite il protocollo ftp.

Esempio:

; ftp: ftp://ftpzone.data
; remote folder: temp
; Utente    Password    Diritti
; ------    --------    -------
; user1     pwd1        lettura
; user2     pwd2        lettura/scrittura

; load ftp module
(module "ftp.lsp")

; primitive functions
;; (FTP:get <str-user-id> <str-password> <str-host> <str-dir> <str-file-name>)
;; (FTP:put <str-user-id> <str-password> <str-host> <str-dir> <str-file-name>)

(set 'FTP:debug-mode true)

; Upload file:

(FTP:put "user2" "pwd2" "ftpzone.data" "temp" "filename.ext")
;-> true

; Download file:

(FTP:get "user2" "pwd2" "ftpzone.data" "temp" "filename.ext")
;-> true


--------------------------------------
Normalizzazione di una lista di numeri
--------------------------------------

Supponiamo di avere una lista di numeri che devono essere trasformati in un altro sistema di coordinate. Ad esempio una lista di coordinate geografiche che devono essere convertite per poter essere visualizzate sullo schermo o stampate con un plotter (cioè nel sistema di riferimento che usa lo schermo o il plotter).
In questo caso le coordinate geografiche rappresentano un punto di coordinate (x, y) ovvero (long, lat). Quindi useremo una trasformazione lineare in due dimensioni (2D).
Nota: la trasformazione lineare può essere applicata solo se l'estensione della zona geografica è limitata, cioè se possiamo approssimare la zona geografica con un piano cartesiano (in altre parole se possiamo trascurare la curvatura terrestre).

Questa è la lista delle coordinate geografiche:

(setq geo '((12.41142785 43.66627426)
            (12.65043641 43.55027395)
            (12.67496872 43.62171555)
            (12.78785627 43.95023854)
            (12.83323383 43.70941544)
            (12.90976429 43.90989685)
            (12.93863011 43.49932483)))

Poichè le coordinate hanno 8 cifre significative, possiamo moltiplicarle per 1e8 (in modo da avere numeri interi).

(setq geo (map (fn (x) (list (int (mul (first x) 1e8)) (int (mul (last x) 1e8)))) geo))
;-> ((1241142785 4366627426)
;->  (1265043641 4355027395)
;->  (1267496872 4362171555)
;->  (1278785627 4395023854)
;->  (1283323383 4370941544)
;->  (1290976429 4390989685)
;->  (1293863011 4349932483))

(integer? (first (first geo)))
;-> true

(setq long (first (first geo)))
;-> 1241142785
(setq lat (last (first geo)))
;-> 4366627426

Le coordinate hanno i seguenti limiti:

 1200000000 <= long <= 1300000000  --> (1300000000 - 1200000000) = 100000000
 4200000000 <= lat <= 4300000000   --> (4300000000 - 4200000000) = 100000000

Poichè i limiti definiscono un quadrato (100000000 e 100000000), per mantenere i rapporti di proporzione dobbiamo convertire queste coordinate in un piano cartesiano quadrato (10x10 o 200x200 o 150x150 ecc.)

Supponiamo che i limiti delle coordinate piane siano (0,0) e (100,100).
Possiamo scrivere:

(setq long-min 1200000000)
(setq long-max 1300000000)
(setq lat-min 4200000000)
(setq lat-max 4300000000)
(setq x-min 0)
(setq x-max 100)
(setq y-min 0)
(setq y-max 100)

Calcoliamo il fattore di scala nelle due dimensioni x e y:

(setq scala-x (div (sub x-max x-min) (sub long-max long-min)))
;-> 1e-006
(setq scala-y (div (sub y-max y-min) (sub lat-max lat-min)))
;-> 1e-006

Adesso possiamo scrivere le formule di trasformazione da una coordinata geografica (geo-long, geo-lat) ad una coordinata piana (x, y):

x = (geo-long - long-min) * scala-x
y = (geo-lat  -  lat-min) * scala-y

Esempio:

Coordinata geografica da convertire:

(setq geo-long 1241142785)
(setq geo-lat 4366627426)

Formula di trasformazione:

(setq x (mul (sub geo-long long-min) scala-x))
;-> 41.142785
(setq y (mul (sub geo-lat lat-min) scala-y))
;-> 166.627426

Controlliamo la correttezza della trasformazione:

Punto di mezzo
(setq geo-long 1250000000)
(setq geo-lat 4250000000)
(setq x (mul (sub geo-long long-min) scala-x))
;-> 50
(setq y (mul (sub geo-lat lat-min) scala-y))
;-> 50

Punto iniziale
(setq geo-long 1200000000)
(setq geo-lat 4200000000)
(setq x (mul (sub geo-long long-min) scala-x))
;-> 0
(setq y (mul (sub geo-lat lat-min) scala-y))
;-> 0

Punto finale
(setq geo-long 1300000000)
(setq geo-lat 4300000000)
(setq x (mul (sub geo-long long-min) scala-x))
;-> 100
(setq y (mul (sub geo-lat lat-min) scala-y))
;-> 100

Vediamo ora il calcolo senza premoltiplicare le coordinate per 1e8:

(setq geo '((12.41142785 43.66627426)
            (12.65043641 43.55027395)
            (12.67496872 43.62171555)
            (12.78785627 43.95023854)
            (12.83323383 43.70941544)
            (12.90976429 43.90989685)
            (12.93863011 43.49932483)))
(setq long-min 12)
(setq long-max 13)
(setq lat-min 42)
(setq lat-max 43)
(setq x-min 0)
(setq x-max 100)
(setq y-min 0)
(setq y-max 100)
(setq scala-x (div (sub x-max x-min) (sub long-max long-min)))
(setq scala-y (div (sub y-max y-min) (sub lat-max lat-min)))
(setq x (mul (sub geo-long long-min) scala-x))
(setq y (mul (sub geo-lat lat-min) scala-y))

Punto iniziale
(setq geo-long 12)
(setq geo-lat 42)
(setq x (mul (sub geo-long long-min) scala-x))
;-> 0
(setq y (mul (sub geo-lat lat-min) scala-y))
;-> 0

Punto di mezzo
(setq geo-long 12.5)
(setq geo-lat 42.5)
(setq x (mul (sub geo-long long-min) scala-x))
;-> 50
(setq y (mul (sub geo-lat lat-min) scala-y))
;-> 50

Punto finale
(setq geo-long 13)
(setq geo-lat 43)
(setq x (mul (sub geo-long long-min) scala-x))
;-> 100
(setq y (mul (sub geo-lat lat-min) scala-y))
;-> 100

Abbiamo ottenuto gli stessi risultati.

La funzione che effettua la trasformazione ha i seguenti parametri:

1. lista delle coordinate (es. geo)
2. longitudine coordinata geografica minima  (es. 1200000000)
3. longitudine coordinata geografica massima (es. 1300000000)
4. latitudine  coordinata geografica minima  (es. 4200000000)
5. latitudine  coordinata geografica massima (es. 4300000000)
6. X minima coordinate piane
7. X massima coordinate piane
8. Y minima coordinate piane
9. Y massima coordinate piane

(define (trasf-coord punti long-min long-max lat-min lat-max x-min x-max y-min y-max)
  (local (x y scale-x scale-y out)
    (setq scala-x (div (sub x-max x-min) (sub long-max long-min)))
    (setq scala-y (div (sub y-max y-min) (sub lat-max lat-min)))
    (dolist (geo punti)
      (setq x (round (mul (sub (first geo) long-min) scala-x)))
      (setq y (round (mul (sub (last geo) lat-min) scala-y)))
      (push (list x y) out -1)
    )
  )
)

(setq geo '((12.41142785 43.66627426)
            (12.65043641 43.55027395)
            (12.67496872 43.62171555)
            (12.78785627 43.95023854)
            (12.83323383 43.70941544)
            (12.90976429 43.90989685)
            (12.93863011 43.49932483)))

(trasf-coord geo 12 13 42 43 0 100 0 100)
;-> ((41 167) (65 155) (67 162) (79 195) (83 171) (91 191) (94 150))


----------------------------
Trasformazione omografica 2D
----------------------------

Una omografia è una relazione tra punti di due spazi tali per cui ogni punto di uno spazio corrisponde ad uno ed un solo punto del secondo spazio. Si basa su concetti geometrici e matematici abbastanza complessi, noti come "coordinate omogenee" e "piani proiettivi", la cui spiegazione non rientra nell'ambito di questo documento.

Giusto per dare un'idea semplificata, il familiare "piano cartesiano" è composto da un insieme di punti che hanno una correlazione uno-a-uno con coppie di numeri reali, ovvero X-Y sui due assi. Il "piano proiettivo" invece è un superset di quel piano reale dove per ogni punto consideriamo anche tutte le possibili (infinite) rette verso lo spazio.

In questo scenario ogni punto 2D può essere proiettato su qualsiasi altro piano nello spazio.

Sulla base di questi concetti viene definita "omografia tra 2 piani" la trasformazione dei punti di un piano ad un altro piano.

La trasformazione omografica si basa sulle seguenti formule.

Formule di trasformazione omografica

     a*x + b*y + c              d*x + e*y + f
X = ---------------        Y = ---------------
     g*x + h*y + 1              g*x + h*y + 1

Dove X-Y sono le coordinate da calcolare nel secondo sistema di riferimento, date le coordinate x-y nel primo sistema di riferimento in funzione degli 8 parametri di trasformazione a, b, c, d, e, f, g, h.

a = fattore di scala fisso in direzione X con scala Y invariata.
b = fattore di scala in direzione X proporzionale alla distanza Y dall'origine.
c = traslazione dell'origine in direzione X.
d = fattore di scala in direzione Y proporzionale alla distanza X dall'origine.
e = fattore di scala fisso in direzione Y con scala X invariata.
f = traslazione dell'origine in direzione Y.
g = fattore di scala proporzionale X e Y in funzione di X.
h = fattore di scala proporzionale X e Y in funzione di Y.

Quindi, avendo queste 8 incognite, sono richiesti almeno 4 punti noti in entrambi i sistemi. In altre parole, dati 4 punti in un piano, esiste sempre una relazione che li trasforma nei corrispondenti 4 punti in un altro piano.

La trasformazione omografica viene utilizzata per la georeferenziazione di mappe oppure per correggere un'immagine prospettica (es. per generare una vista "in pianta" di un edificio da una foto "prospettica").

Le formule precedenti possono essere trasformate (tramite manipolazione algebrica) nella matrice di trasformazione omografica che ci consente di calcolare gli 8 parametri di trasformazione risolvendo il sistema lineare A*z = B.

Dati i quattro punti di partenza e i quattro punti di destinazione possiamo scrivere 8 equazioni:

        a*x(i) + b*y(i) + c                 d*x(i) + e*y(i) + f
X(i) = ---------------------        Y(i) = ---------------------
        g*x(i) + h*y(i) + 1                 g*x(i) + h*y(i) + 1

per 1 <= i <= 4

Queste 8 equazioni possono essere trasformate nel sistema lineare:

x1*a + y1*b + c - x1*X1*g - y1*X1*h = X1
x2*a + y2*b + c - x2*X2*g - y2*X2*h = X2
x3*a + y3*b + c - x3*X3*g - y3*X3*h = X3
x4*a + y4*b + c - x4*X4*g - y4*X4*h = X4
x1*d + y1*e + f - x1*Y1*g - y1*Y1*h = Y1
x2*d + y2*e + f - x2*Y2*g - y2*Y2*h = Y2
x3*d + y3*e + f - x3*Y3*g - y3*Y3*h = Y3
x4*d + y4*e + f - x4*Y4*g - y4*Y4*h = Y4

Che ha la seguente matrice di rappresentazione A*z = B:

| x1 y1  1  0  0  0 -x1*X1 -y1*X1 |   | a |   | X1 |
| x2 y2  1  0  0  0 -x2*X2 -y2*X2 |   | b |   | X2 |
| x3 y3  1  0  0  0 -x3*X3 -y3*X3 |   | c |   | X3 |
| x4 y4  1  0  0  0 -x4*X4 -y4*X4 | * | d | = | X4 |
|  0  0  0 x1 y1  1 -x1*Y1 -y1*Y1 |   | e |   | Y1 |
|  0  0  0 x2 y2  1 -x2*Y2 -y2*Y2 |   | f |   | Y2 |
|  0  0  0 x3 y3  1 -x3*Y3 -y3*Y3 |   | g |   | Y3 |
|  0  0  0 x4 y4  1 -x4*Y4 -y4*Y4 |   | h |   | Y4 |

matrice A:

  A[0][0] = x1  A[0][1] = y1  A[0][2] = 1  A[0][3] = 0   A[0][4] = 0   A[0][5] = 0  A[0][6] = -(X1*x1)  A[0][7] = -(X1*y1)
  A[1][0] = x2  A[1][1] = y2  A[1][2] = 1  A[1][3] = 0   A[1][4] = 0   A[1][5] = 0  A[1][6] = -(X2*x2)  A[1][7] = -(X2*y2)
  A[2][0] = x3  A[2][1] = y3  A[2][2] = 1  A[2][3] = 0   A[2][4] = 0   A[2][5] = 0  A[2][6] = -(X3*x3)  A[2][7] = -(X3*y3)
  A[3][0] = x4  A[3][1] = y4  A[3][2] = 1  A[3][3] = 0   A[3][4] = 0   A[3][5] = 0  A[3][6] = -(X4*x4)  A[3][7] = -(X4*y4)
  A[4][0] = 0   A[4][1] = 0   A[4][2] = 0  A[4][3] = x1  A[4][4] = y1  A[4][5] = 1  A[4][6] = -(Y1*x1)  A[4][7] = -(Y1*y1)
  A[5][0] = 0   A[5][1] = 0   A[5][2] = 0  A[5][3] = x2  A[5][4] = y2  A[5][5] = 1  A[5][6] = -(Y2*x2)  A[5][7] = -(Y2*y2)
  A[6][0] = 0   A[6][1] = 0   A[6][2] = 0  A[6][3] = x3  A[6][4] = y3  A[6][5] = 1  A[6][6] = -(Y3*x3)  A[6][7] = -(Y3*y3)
  A[7][0] = 0   A[7][1] = 0   A[7][2] = 0  A[7][3] = x4  A[7][4] = y4  A[7][5] = 1  A[7][6] = -(Y4*x4)  A[7][7] = -(Y4*y4)

matrice B (termini noti):

    B[0][0] = X1
    B[1][0] = X2
    B[2][0] = X3
    B[3][0] = X4
    B[4][0] = Y1
    B[5][0] = Y2
    B[6][0] = Y3
    B[7][0] = Y4

vettore incognite z:

    z[0] = a
    z[1] = b
    z[2] = c
    z[3] = d
    z[4] = e
    z[5] = f
    z[6] = g
    z[7] = h

Una volta calcolati questi 8 parametri (a, b, c, d, e, f, g, h) possiamo utilizzare le formule di trasformazione omografica per convertire qualsiasi punto dal primo sistema di riferimento al secondo.

Nota: I quattro punti iniziali devono essere non allineati a tre a tre (cioè non ci devono essere tre punti allineati).

Esempio:

       |
    13 |
    12 |                       #3
    11 |
    10 |
     9 |
     8 |                 #4
     7 |
     6 | o4      o3
     5 |
     4 |                         #2
     3 |
     2 |                   #1
     1 | o1     o2
   ---------------------------------------
       | 1 2 3 4 5 6 7 8 9 101112131415

I punti sono i seguenti:

Iniziale  --> Finale
o1 (1 1)  --> #1 (10 2)
o2 (5 1)  --> #2 (13 4)
o3 (5 5)  --> #3 (12 12)
o4 (1 5)  --> #4 (9 8)

(setq x1 1 y1 1)
(setq x2 5 y2 1)
(setq x3 5 y3 5)
(setq x4 1 y4 5)

(setq X1 10  Y1 2)
(setq X2 13 Y2 4)
(setq X3 12 Y3 12)
(setq X4 9  Y4 8)

Utilizziamo la seguente funzione per risolvere il sistema lineare:

(define (solve-linsys matrice noti)
  (local (dim detm det-i sol copia)
    (setq dim (length matrice))
    (setq sol '())
    (setq copia matrice)
    (setq detm (det copia))
    ; la soluzione è indeterminata se il determinante vale zero.
    (if (= detm 0) (setq sol nil)
    ;(println detm)
      (for (i 0 (- dim 1))
        (for (j 0 (- dim 1))
          (setf (copia j i) (noti j))
        )
        ; 0.0 -> "det" restituisce 0 (invece di nil),
        ; quando la matrice è singolare
        (setq det-i (det copia 0.0))
        (push (div det-i detm) sol -1)
        (setq copia matrice)
      );endfor
    );endif
    sol
  );local
)

(solve-linsys '((2 1 1) (4 -1 1) (-1 1 2)) '(1 -5 5))
 -> (-1 2 1)

Calcoliamo i parametri:

(setq r0 (list x1 y1  1  0  0  0 (- (mul x1 X1)) (- (mul y1 X1))))
(setq r1 (list x2 y2  1  0  0  0 (- (mul x2 X2)) (- (mul y2 X2))))
(setq r2 (list x3 y3  1  0  0  0 (- (mul x3 X3)) (- (mul y3 X3))))
(setq r3 (list x4 y4  1  0  0  0 (- (mul x4 X4)) (- (mul y4 X4))))
(setq r4 (list  0  0  0 x1 y1  1 (- (mul x1 Y1)) (- (mul y1 Y1))))
(setq r5 (list  0  0  0 x2 y2  1 (- (mul x2 Y2)) (- (mul y2 Y2))))
(setq r6 (list  0  0  0 x3 y3  1 (- (mul x3 Y3)) (- (mul y3 Y3))))
(setq r7 (list  0  0  0 x4 y4  1 (- (mul x4 Y4)) (- (mul y4 Y4))))
;-> (1 1 1 0 0 0 -10 -10)
;-> (5 1 1 0 0 0 -65 -13)
;-> (5 5 1 0 0 0 -60 -60)
;-> (1 5 1 0 0 0 -9 -45)
;-> (0 0 0 1 1 1 -2 -2)
;-> (0 0 0 5 1 1 -20 -4)
;-> (0 0 0 5 5 1 -60 -60)
;-> (0 0 0 1 5 1 -8 -40)

(setq matrix (list r0 r1 r2 r3 r4 r5 r6 r7))
;-> ((1 1 1 0 0 0 -10 -10)
;->  (5 1 1 0 0 0 -65 -13)
;->  (5 5 1 0 0 0 -60 -60)
;->  (1 5 1 0 0 0 -9 -45)
;->  (0 0 0 1 1 1 -2 -2)
;->  (0 0 0 5 1 1 -20 -4)
;->  (0 0 0 5 5 1 -60 -60)
;->  (0 0 0 1 5 1 -8 -40))

(setq noti (list X1 X2 X3 X4 Y1 Y2 Y3 Y4))
;-> (10 13 12 9 2 4 12 8)

(setq sol (solve-linsys matrix noti))
;-> (0.05000000000000014 -0.3833333333333334 9.666666666666666 0.2666666666666667 1.266666666666667
;->  0.3333333333333333 -0.04999999999999998 -0.01666666666666667)

(setq a (sol 0))
(setq b (sol 1))
(setq c (sol 2))
(setq d (sol 3))
(setq e (sol 4))
(setq f (sol 5))
(setq g (sol 6))
(setq h (sol 7))

Adesso possiamo trasformare qualunque punto dal sistema di riferimento iniziale al sistema di riferimento finale utilizzando le fornule di trasformazione omografica:

     a*x + b*y + c              d*x + e*y + f
X = ---------------        Y = ---------------
     g*x + h*y + 1              g*x + h*y + 1

(define (toX x y)
  (round (div (add (mul a x) (mul b y) c) (add (mul g x) (mul h y) 1)) -1))

(define (toY x y)
  (round (div (add (mul d x) (mul e y) f) (add (mul g x) (mul h y) 1)) -1))

Verifichiamo la trasformazione dei quattro punti iniziali:

(1 1)  -->  (10 2)
(5 1)  -->  (13 4)
(5 5)  -->  (12 12)
(1 5)  -->  (9 8)

(list (toX 1 1) (toY 1 1))
;-> (10 2)

(list (toX 5 1) (toY 5 1))
;-> (13 4)

(list (toX 5 5) (toY 5 5))
;-> (12 12)

(list (toX 1 5) (toY 1 5))
;-> (9 8)

Proviamo con altri punti:

(list (toX 3 3) (toY 3 3))
;-> (10.8 6.2)

(list (toX 5 3) (toY 5 3))
;-> (12.5 7.8)

Con questo metodo siamo in grado di prendere un file di coordinate geografiche (es. in formato geojson) e visualizzarlo sul monitor oppure creare un file postscript.


------------------------------------
Numeri primi successivi e precedenti
------------------------------------

Dato un numero intero n vogliamo determinare il primo numero primo successivo a n e il primo numero primo precedente a n.

Prima scriviamo la funzione che verifica se un numero è primo:

(define (primo? n)
  (if (< n 2) nil
      (= 1 (length (factor n)))))

Poi scriviamo due funzioni separate "primo+" e "primo-".

(define (primo+ num)
  (local (found val)
    (setq found nil)
    (setq val (+ num 1))
    (until found
      (if (primo? val)
          (setq found true)
          (++ val)
      )
    )
    val
  )
)

(primo+ 50)
;-> 53

(define (primo- num)
  (local (found val)
    (setq found nil)
    (setq val (- num 1))
    (until found
      (if (primo? val)
          (setq found true)
          (-- val)
      )
    )
    val
  )
)

(primo- 50)
;-> 47

(primo+ 2)
;-> 3


----------------------------
Giorno Giuliano (Julian day)
----------------------------
Il giorno giuliano (Julian Day, JD) è il numero di giorni passati dal mezzogiorno del lunedì 1 gennaio 4713 a.C. (-4012 1 1), che viene considerato il giorno 0 (zero) del calendario giuliano.
Il sistema dei giorni giuliani fornisce un singolo sistema di datazione che permette di lavorare con differenti calendari (in pratica è un metodo di normalizzazione delle date).

La formula per il calcolo del giorno giuliano è la seguente:

  JDN = (1461 × (Y + 4800 + (M − 14)/12))/4 +(367 × (M − 2 − 12 × ((M − 14)/12)))/12 − (3 × ((Y + 4900 + (M - 14)/12)/100))/4 + D − 32075

dove Y = Year  (anno)
     M = Month (mese)
     D = Day   (giorno)

Nota: le divisioni sono tutte intere, i resti vengono scartati.

Preferisco usare le formule (equivalenti) definite da Claus Tondering in "Calendar FAQ" e disponibili al seguente indirizzo web:

 https://stason.org/TULARC/society/calendars/index.html

In cui si trovano molte informazioni interessanti sulle date e sui vari calendari creati dall'uomo.

Vediamo l'algoritmo per il calcolo del giorno giuliano.

Calcolare le seguenti variabili ausiliarie:

  a = (14-month)/12
  y = year + 4800 - a
  m = month + 12*a - 3

Per una data nel calendario Gregoriano:

  JD = day + (153*m + 2)/5 + y*365 + y/4 - y/100 + y/400 - 32045

Per una data nel calendario Giuliano:

  JD = day + (153*m + 2)/5 + y*365 + y/4 - 32083

Il calendario Gregoriano viene utilizzato per le date che vanno dal 15 ottobre 1582 d.C. in avanti e il calendario Giuliano viene utilizzato per le date precedenti al 4 ottobre 1582.

Nota: Il calendario Giuliano non ha nulla in comune con il giorno giuliano.
Il calendario Giuliano fu introdotto da Giulio Cesare nel 45 AC ed era di uso comune fino al 1500, quando i paesi iniziarono ad utilizzare il calendario Gregoriano.

Scriviamo la funzione per il calcolo del numero del giorno giuliano partendo da una data del calendario Gregoriano:

(define (julian-g year month day)
  (local (a y m)
    (setq a (/ (- 14 month) 12))
    (setq y (+ year 4800 (- a)))
    (setq m (+ month (* 12 a) (- 3)))
    (+ day (/ (+ (* 153 m) 2) 5) (* y 365) (/ y 4) (- (/ y 100)) (/ y 400) (- 32045))
  )
)

(julian-g 2019 11 11)
;-> 2458799

(julian-g 2019 11 12)
;-> 2458800

Nota: per gli anni Avanti Cristo (Before Christ) occorre prima convertire l'anno A.C. in un anno negativo (es. 10 A.C. = -9).

Le "Idi di Marzo", il giorno dell'assassinio di Giulio Cesare avvenuto il 15 marzo del 44 A.C.

(julian-g -43 3 15)
;-> 1705428

Scriviamo la funzione per il calcolo del numero del giorno giuliano partendo da una data del calendario Giuliano:

(define (julian-j year month day)
  (local (a y m)
    (setq a (/ (- 14 month) 12))
    (setq y (+ year 4800 (- a)))
    (setq m (+ month (* 12 a) (- 3)))
    (+ day (/ (+ (* 153 m) 2) 5) (* y 365) (/ y 4) (- 32083))
  )
)

(julian-j 2019 11 11)
;-> 2458812

(julian-j 2019 11 12)
;-> 2458813

Verifichiamo il primo giorno del periodo giuliano:

(julian-j -4712 01 01)
;-> 0

Per convertire un giorno giuliano in una data del calendario Gregoriano o Giuliano utilizziamo il seguente algoritmo:

Per il calendario Gregoriano:

  a = JD + 32044
  b = (4*a + 3)/146097
  c = a - (b*146097)/4

Per il calendario Giuliano:

  a = 0
  b = 0
  c = JD + 32082

Poi, per entrambi i calendari:

  d = (4*c + 3)/1461
  e = c - (1461*d)/4
  m = (5*e + 2)/153

Infine calcoliamo la data:

  giorno = e - (153*m + 2)/5 + 1
  mese   = m + 3 - 12*(m/10)
  anno   = b*100 + d - 4800 + m/10

Scriviamo la funzione che converte da giorno giuliano a data Gregoriana (anno mese giorno):

(define (date-g JD)
  (local (a b c d e m)
    (setq a (+ JD 32044))
    (setq b (/ (+ (* 4 a) 3) 146097))
    (setq c (- a (/ (* b 146097) 4)))
    (setq d (/ (+ (* 4 c) 3) 1461))
    (setq e (- c (/ (* 1461 d) 4)))
    (setq m (/ (+ (* 5 e) 2) 153))
    (list
      (+ (* b 100) d (- 4800) (/ m 10))
      (+ m 3 (- (* 12 (/ m 10))))
      (+ e (- (/ (+ (* 153 m) 2) 5)) 1)
    )
  )
)

(julian-g 2019 11 11)
;-> 2458799
(date-g 2458799)
;-> (11 11 2019)

(julian-g 2019 11 12)
;-> 2458800
(date-g 2458800)
;-> (2019 11 12)

(julian-g -43 3 15)
;-> 1705428
(date-g 1705428)
;-> (-43 3 15)

Scriviamo la funzione che converte da giorno giuliano a data Giuliana (anno mese giorno):

(define (date-j JD)
  (local (a b c d e m)
    (setq a 0)
    (setq b 0)
    (setq c (+ JD 32082))
    (setq d (/ (+ (* 4 c) 3) 1461))
    (setq e (- c (/ (* 1461 d) 4)))
    (setq m (/ (+ (* 5 e) 2) 153))
    (list
      (+ (* b 100) d (- 4800) (/ m 10))
      (+ m 3 (- (* 12 (/ m 10))))
      (+ e (- (/ (+ (* 153 m) 2) 5)) 1)
    )
  )
)

(julian-j 2019 11 11)
;-> 2458812
(date-j 2458812)
;-> (2019 11 11)

(julian-j 2019 11 12)
;-> 2458813
(date-j 2458813)
;-> (2019 11 12)

(julian-j -4712 01 01)
;-> 0
(date-j 0)
;-> (-4712 1 1)

Adesso vediamo come trovare il giorno della settimana partendo da un giorno giuliano.

Sistema anglosassone
Se la settimana comincia (giorno 0) con la Domenica (Sunday), allora risulta:

  Sun Mon Tue Wed Thu Fri Sat
  Dom Lun Mar Mer Gio Ven Sab
   0   1   2   3   4   5   6

  giorno = mod(JD + 1, 7)

Sistema ISO internazionale
Se la settimana comincia (giorno 1) con il Lunedi (Monday), allora risulta:

  Mon Tue Wed Thu Fri Sat Sun
  Lun Mar Mer Gio Ven Sab Dom
   1   2   3   4   5   6   7

  giorno = mod(J, 7) + 1

(define (jd-day JD) (+ (% JD 7) 1))

(julian-g -43 3 15)
;-> 1705428
(date-g 1705428)
;-> (-43 3 15)
(jd-day 1705428)
;-> 5 ; Caio Giulio Cesare è morto di Venerdi

Le date formano uno spazio affine. Ciò significa che il risultato della sottrazione di due date non è un'altra data, ma piuttosto un intervallo di tempo. Ad esempio, il risultato della sottrazione del 1 gennaio 2013 dal 2 gennaio 2013 è l'intervallo di tempo di un giorno. Non è un'altra data.

In uno spazio affine, ci sono due tipi di oggetti, chiamati "punti" e "vettori". In questo caso i punti sono "date" e i vettori sono gli "intervalli" (numero di giorni). Con questi oggetti è possibile eseguire le seguenti operazioni:

Operazione                      Risultato
  data1 - data2                   intervallo
  data + intervallo               data
  data - intervallo               data
  intervallo1 + intervallo2       intervallo
  intervallo1 - intervallo2       intervallo

Si noti in particolare che non è possibile sommare due date.

Quindi con le funzioni che abbiamo definito (julian-g, date-g, jd-day ecc.) possiamo effettuare tutte le operazioni elencate sopra. Ad esempio, supponiamo di voler calcolare la differenza tra il 22 aprile 2010 e il 28 novembre 2012:

Calcoliamo il giorno giuliano per ognuna delle due date:

(setq jd1 (julian-g 2010 4 22))
;-> 2455309
(setq jd2 (julian-g 2012 11 28))
;-> 2456260

e poi calcoliamo la differenza:

(setq diff (- jd2 jd1))
;-> 951

Un altro esempio: che giorno della settimana sarà il natale del 2020 ?

(jd-day (julian-g 2020 12 25))
;-> 5 ;venerdi


-------------------------
Punto interno al poligono
-------------------------

Dato un poligono e un punto, determinare se il punto è interno o esterno al poligono.

Un metodo per verificare la presenza di un punto all'interno di una regione è il teorema della curva di Jordan. In sostanza, dice che un punto è all'interno di un poligono se, per qualsiasi raggio da questo punto, c'è un numero dispari di intersezioni del raggio con i segmenti (lati) del poligono. Questo vale per tutti i poligoni (concavi, convessi, con isole). Occorre considerare il caso particolare in cui il raggio interseziona uno o più vertici del poligono.

Esempio:

     |
  14 |           X---------X
     |          /           \
     |         /             \
  11 |        /         X-----X
     |       /          |
     |      /           |
   8 |     X     p1     X
     |      \           /
   6 |    p2 \         /
     |        \       /
     |         \     /
     |          \   /
     |           \ /
   1 |            X
     |
  ---------------------------------
     |     5     12     18 21 24

Rappresentazione degli oggetti punto e poligono:

pnt -> (x y)

poly ((x0 y0) (x1 y1) (x2 y2) (x3 y3) ... (xn yn))

Definiamo prima la funzione:

(define (point-in-polygon? pnt poly)
  (local (numpoint i j res)
    (setq numpoint (length poly))
    (setq res nil)
    (setq i 0)
    (setq j (- numpoint 1))
    (while (< i numpoint)
      (if (and (!= (> (last (poly i)) (last pnt)) (> (last (poly j)) (last pnt)))
               (< (first pnt)
                  (add (div (mul (sub (first (poly j)) (first (poly i)))
                                 (sub (last pnt) (last (poly i))))
                            (sub (last (poly j)) (last (poly i))))
                       (first (poly i)))))
          (setq res (not res))
      )
      (setq j i)
      (setq i (+ i 1))
    )
    ; check if point is equal to a vertex of polygon
    (dolist (el poly)
      (if (and (= (first el) (first pnt))
               (= (last el) (last pnt)))
          (setq res true)))
    res
  )
)

Altra versione con variabili ausiliarie:

(define (point-in-polygon? pnt poly)
  (local (numpoint i j res a b)
    (setq numpoint (length poly))
    (setq res nil)
    (setq i 0)
    (setq j (- numpoint 1))
    (while (< i numpoint)
      (setq a (mul (sub (first (poly j)) (first (poly i)))
                   (sub (last pnt) (last (poly i)))))
      (setq b (sub (last (poly j)) (last (poly i))))
      (if (and (!= (> (last (poly i)) (last pnt)) (> (last (poly j)) (last pnt)))
               (< (first pnt) (add (div a b) (first (poly i)))))
          (setq res (not res))
      )
      (setq j i)
      (setq i (+ i 1))
    )
    ; check if point is equal to a vertex of polygon
    (dolist (el poly)
      (if (and (= (first el) (first pnt))
               (= (last el) (last pnt)))
          (setq res true)))
    res
  )
)


Poligono:
(setq poligono '((12 1) (5 8) (12 14) (21 14) (24 11) (18 11) (18 8)))
(setq poligono '((12 1) (5 8) (12 14) (21 14) (24 11) (18 11) (18 8) (12 1)))

Punto interno p1:
(setq p1 '(12 8))

Punto esterno P2:
(setq p2 '(5 6))

(point-in-polygon? p1 poligono)
;-> true

(point-in-polygon? p2 poligono)
;-> nil

(point-in-polygon? '(21 12) poligono)
;-> true

(point-in-polygon? '(12 11) poligono)
;-> true

(point-in-polygon? '(21 10) poligono)
;-> nil

(point-in-polygon? '(5 11) poligono)
;-> nil

I punti del poligono appartengono al poligono:

(point-in-polygon? '(5 8) poligono)
;-> true

(point-in-polygon? '(21 14) poligono)
;-> true

(point-in-polygon? '(12 1) poligono)
;-> true

Spiegazione rapida:
Supponendo che il punto si trovi sulla coordinata y, la funzione calcola semplicemente le posizioni x in cui ciascuna dei lati (non orizzontali) del poligono interseziona con y. Conta il numero di posizioni x che sono inferiori alla posizione x del tuo punto. Se il numero di posizioni x è dispari, il punto è all'interno del poligono.
Un altro modo di visualizzare questo metodo: tracciamo una linea dall'infinito direttamente al tuo punto. Quando questa linea attraversa un lato del poligono siamo all'interno del poligono. Quando attraversiamo di nuovo un lato del poligono, allora siamo fuori. Nuova intersezione, dentro... e così via.

Spiegazione approfondita:

https://stackoverflow.com/questions/8721406/how-to-determine-if-a-point-is-inside-a-2d-convex-polygon

Il metodo esamina un "raggio" che inizia nel punto testato e si estende all'infinito sul lato destro dell'asse X. Per ogni segmento poligonale, controlla se il raggio lo attraversa. Se il numero totale di attraversamenti di segmenti è dispari, il punto testato viene considerato all'interno del poligono, altrimenti è esterno.

Per capire come viene calcolata la traversata, considerare la seguente figura:

              v2
              o
             /
            / c (intersezione)
  o -------- x ----------------------> all'infinito
  t       /
         /
        /
       o
       v1

Affinché si verifichi l'intersezione, test.y deve essere compreso tra i valori y dei vertici del segmento (v1 e v2). Questa è la prima condizione dell'istruzione if nel metodo. In questo caso, la linea orizzontale deve intersecare il segmento. Resta solo da stabilire se l'intersezione avviene alla destra del punto testato o alla sua sinistra. Ciò richiede di trovare la coordinata x del punto di intersezione, che è:

              t.y - v1.y
c.x = v1.x + ----------- * (v2.x - v1.x)
             v2.y - v1.y

Tutto ciò che resta da fare è esaminare i casi particolari:

Se v1.y == v2.y il raggio percorre il segmento e quindi il segmento non ha influenza sul risultato. In effetti, la prima parte dell'istruzione if restituisce false in quel caso.
Il codice moltiplica prima e solo successivamente divide. Questo viene fatto per supportare differenze molto piccole tra v1.x e v2.x, che potrebbero portare a uno zero dopo la divisione, a causa dell'arrotondamento.

Poi, viene il problema dell'incrocio esattamente su un vertice. Considera i seguenti due casi:

           o                    o
           |                     \     o
           | A1                C1 \   /
           |                       \ / C2
  o--------x-----------x------------x--------> all'infinito
          /           / \
      A2 /        B1 /   \ B2
        /           /     \
       o           /       o
                  o

Ora, per verificare se funziona, occorre controllare cosa viene restituito per ciascuno dei 4 segmenti dalla condizione if nel corpo del metodo. Scopriamo che i segmenti sopra il raggio (A1, C1, C2) ricevono un risultato positivo, mentre quelli sotto di esso (A2, B1, B2) ricevono un risultato negativo. Ciò significa che il vertice A contribuisce con un numero dispari (1) al conteggio dei passaggi, mentre B e C contribuiscono con un numero pari (0 e 2, rispettivamente), che è esattamente ciò che si desidera. A è davvero un vero incrocio del poligono, mentre B e C sono solo due casi di "sorvolo".

Infine viene verificato il caso in cui il punto è uguale ad uno dei vertici del poligono.

Vedi anche: 

https://stackoverflow.com/questions/217578/how-can-i-determine-whether-a-2d-point-is-within-a-polygon


-------------------
Prodotto cartesiano
-------------------

In matematica il prodotto cartesiano di due insiemi A e B è l'insieme delle coppie ordinate (a,b) cona in A e b in B:

A x B = [(a,b): a in A AND b in B]

Per esempiop, date due liste A = (1 2) e B = (3 4) il loro prodotto cartesiano vale:

(1 2) x (3 4) = ((1 3) (1 4) (2 3) (2 4))

cioè tutte le coppie formate dall'unione di ogni elemento della lista A con ogni elemento della lista B.

Nota: Il prodotto cartesiano non è commutativo: (A x B) != (B x A)

La funzione per calcolare il prodotto cartesiano di due liste è la seguente:

(define (cp lst1 lst2)
  (let (out '())
    (if (or (null? lst1) (null? lst2)) 
        nil
        (dolist (el1 lst1)
          (dolist (el2 lst2)
            (push (list el1 el2) out -1))))))

(cp '(1 2) '(3 4))
;-> ((1 3) (1 4) (2 3) (2 4))

(cp '(3 4) '(1 2))
;-> ((3 1) (3 2) (4 1) (4 2))

(cp '(1 2) '())
;-> nil

(cp '() '(1 2))
;-> nil

(cp '(1 2 3) '(4 5))
;-> ((1 4) (1 5) (2 4) (2 5) (3 4) (3 5))

Il prodotto cartesiano può essere esteso alla composizione di n insiemi considerando l'insieme delle n-uple ordinate:

A1 x A2 x ... x An = [(a1,a2,...,an): a(i) in A(i) per i=1..n]

Il prodotto cartesiano è naturalmente associativo:

A1 x A2 x ... x An = A1 x (A2 x ... x An)

Per calcolare il prodotto cartesiano di più liste (comunque racchiuse in una lista) potremmo applicare la funzione "apply":

(apply cp '((1 2) (3 4) (5 6)) 2)
;-> (((1 3) 5) ((1 3) 6) ((1 4) 5) ((1 4) 6) ((2 3) 5) ((2 3) 6) ((2 4) 5) ((2 4) 6))

Il risultato è corretto, dobbiamo solo togliere le parentesi ad ogni elemento della lista:

((1 3) 5) --> (1 3 5)
((1 3) 6) --> (1 3 6)
((1 4) 5) --> (1 4 5)
...
((2 4) 6) --> (2 4 6)

Scriviamo la funzione che calcola il prodotto cartesiano di tutte le sotto-liste di una lista:

(define (prodotto-cartesiano lst-lst)
  (let (out '())
    (dolist (el (apply cp lst-lst 2))
      (push (flat el) out -1))))

(prodotto-cartesiano '((1 2) (3 4) (5 6)))
;-> ((1 3 5) (1 3 6) (1 4 5) (1 4 6) (2 3 5) (2 3 6) (2 4 5) (2 4 6))

(prodotto-cartesiano '((1 2 3) (4) (5 6)))
;-> ((1 4 5) (1 4 6) (2 4 5) (2 4 6) (3 4 5) (3 4 6))

(prodotto-cartesiano '((1 5) (2 6) (3 7) (4 8 9)))
;-> ((1 2 3 4) (1 2 3 8) (1 2 3 9) (1 2 7 4) (1 2 7 8) (1 2 7 9) (1 6 3 4) 
;->  (1 6 3 8) (1 6 3 9) (1 6 7 4) (1 6 7 8) (1 6 7 9) (5 2 3 4) (5 2 3 8)
;->  (5 2 3 9) (5 2 7 4) (5 2 7 8) (5 2 7 9) (5 6 3 4) (5 6 3 8) (5 6 3 9)
;->  (5 6 7 4) (5 6 7 8) (5 6 7 9))

(prodotto-cartesiano '((1 2 3) () (500 100)))

Prodotto cartesiano di funzioni
Se f è una funzione da A in B e g una funzione da C in }D, si definisce come loro prodotto cartesiano e si denota con f x g la funzione da A x C in B x D data da:

[f x g](a,c) = [f(a), g(c)]

(Abbiamo distinto le parentesi che delimitano argomenti di funzione () dalle parentesi che delimitano coppie ordinate [])

Esempio:

(define (pcf f g lst1 lst2)
  (let (out '())
    (if (or (null? lst1) (null? lst2)) 
        nil
        (dolist (el1 lst1)
          (dolist (el2 lst2)
            (push (list (f el1) (g el2)) out -1))))))

(define (f x) x)
(define (g x) (* x x))

(pcf f g (sequence 1 3) (sequence 1 3))
;-> ((1 1) (1 4) (1 9) (2 1) (2 4) (2 9) (3 1) (3 4) (3 9))


------------------------------
Insieme delle parti (powerset)
------------------------------

Dato un insieme L, l'insieme delle parti di L, scritto P(L), è l'insieme di tutti i sottoinsiemi di L. Questa collezione di insiemi viene anche detta insieme potenza di L.
Se l'insieme L ha n elementi, allora l'insieme delle parti ha 2^n elementi.

Esempio:
(setq L '(1 2 3))
(powerset-i L)
;-> ((3 2 1) (3 2) (3 1) (3) (2 1) (2) (1) ())
(length (powerset-i L))
;-> 8

Scriviamo una funzione ricorsiva cha calcola l'insieme potenza:

(define (powerset lst)
  (if (empty? lst)
      (list '())
      (let ( (element (first lst))
             (p (powerset (rest lst))))
           (append (map (fn (subset) (cons element subset)) p) p) )))

(powerset '(a b c d))
;-> ((a b c) (a b) (a c) (a) (b c) (b) (c) ())

Adesso scriviamo una funzione iterativa cha calcola l'insieme potenza:

(define (powerset-i lst)
  (define (loop res s)
    (if (empty? s)
      res
      (loop (append (map (lambda (i) (cons (first s) i)) res) res) (rest s))))
  (loop '(()) lst))

Vediamo la differenza di velocità tra le due funzioni:

(time (powerset '(1 2 3 4 5 6 7 8 9 10 15 16)) 1000)
;-> 2906.498

(time (powerset-i '(1 2 3 4 5 6 7 8 9 10 15 16)) 1000)
;-> 3672.166


-----------------
Terne pitagoriche
-----------------

Una terna pitagorica è costituita da tre numeri interi positivi a, b e c con a < b < c tale che a^2 + b^2 = c^2. Ad esempio, i tre numeri 3, 4 e 5 formano una tripla pitagorica perché 3^2 + 4^2 = 9 + 16 = 25 = 5^2. 

Scrivere una funzione per generare tutte le terne pitagoriche.

Esistono diversi metodi per generare le terne pitagoriche ad esempio l'algoritmo di Hall:

Se (a b c) è una terna pitagorica primitiva, allora lo sono anche:

  (a – 2b + 2c,  2a – b + 2c,  2a – 2b + 3c)
  
  (a + 2b + 2c,  2a + b + 2c,  2a + 2b + 3c)
  
  (-a + 2b + 2c, 2a + b + 2c, -2a + 2b + 3c)

Comunque per generare tutte le terne pitagoriche useremo il metodo di Dickson:

Per trovare soluzioni intere a x^2 + y^2 = z^2, trovare degli interi positivi r, s, t tali che r^2 = 2st sia un quadrato perfetto.
Quindi calcolare la terna pitagorica (x y z):

  x = r + s, y = r + t, z = r + s + t

Notiamo che r è un numero intero pari e che s e t sono fattori di (r ^ 2) / 2. Tutte le terne pitagoriche possono essere trovate con questo metodo. Quando s e t sono coprimi, la terna viene detta primitiva.

Nota: Una terna (x y z) viene detta primitiva quando x e y sono coprimi. Una terna primitiva (x y z) genera infinite terne non primitive moltiplicando i termini per un qualunque numero intero positivo n. 

Esempio:

Terna primitiva: (3 4 5)       n
Terna non primitiva: (3 4 5) * 2 ==> (6 8 10)
Terna non primitiva: (3 4 5) * 3 ==> (9 12 15)
...

Il metodo di Dickson genera tutte le terne pitagoriche, anche quelle simmetriche (quelle in cui vengono scambiati i valori di x e y). Esempio: (3 4 5) e (4 3 5) sono due terne pitagoriche distinte.

La seguente funzione restituisce n terne pigatoriche:

(define (terne n)
  (local (a b c r f1 f2 idx somma continua out)
    (setq r 2)
    (setq f1 1)
    (setq idx 0)
    (while (< idx n)
      (setq continua true)
      (while continua
      ; calcola i fattori s (f1) e t (f2) del prossimo r^2/2 
      ; e inserisci l'equazione per s e t
        (cond ((zero? (% (/ (* r r) 2) f1))
                (setq f2 (/ (/ (* r r) 2) f1))
                (setq a (+ r f1))
                (setq b (+ r f2))
                (setq c (+ r f1 f2))
                (++ f1)
                (setq continua nil)
                (push (list a b c) out -1))
                ; se f1 è maggiore di r^2/2, passa alla r successiva 
                ; e imposta il fattore f1 a 1                
              ((= f1 (+ (/ (* r r) 2) 1))
                (setq r (+ r 2))
                (setq f1 1))
              (true (++ f1))
        )
      )
      (++ idx)
    )
    out))

Calcoliamo le prime venti terne pitagoriche (primitive e non primitive):

(terne 20)
;-> ((3 4 5) (4 3 5) (5 12 13) (6 8 10) (8 6 10) (12 5 13) (7 24 25)
;->  (8 15 17) (9 12 15) (12 9 15) (15 8 17) (24 7 25) (9 40 41)
;->  (10 24 26) (12 16 20) (16 12 20) (24 10 26) (40 9 41) (11 60 61)
;->  (12 35 37))

Se vogliamo estrarre solo le terne primitive usiamo la funzione "filter" con il seguente predicato che verifica se i primi due numeri di una terna sono coprimi:

(define (coprimi? lst) (= (gcd (first lst) (first (rest lst))) 1))

(coprimi? '(3 4 5))
;-> true

Estraiamo solo le terne primitive:

(filter coprimi? (terne 20))
;-> ((3 4 5) (4 3 5) (5 12 13) (12 5 13) (7 24 25) (8 15 17) (15 8 17) 
;->  (24 7 25) (9 40 41) (40 9 41) (11 60 61) (12 35 37))

Se vogliamo eliminare le terne simmetriche possiamo ordinare tutte le terne e poi rimuovere tutti i duplicati:

(unique (map (fn(x) (sort x)) (filter coprimi? (terne 20))))
;-> ((3 4 5) (5 12 13) (7 24 25) (8 15 17) (9 40 41) (11 60 61) (12 35 37))


---------------------------------
Calcolo di e con il metodo spigot
---------------------------------

Definiamo una funzione che calcola il numero di Eulero usando l'algoritmo di Rabinowitz e Wagon.

Il numero di Eulero "e" vale (con 500 cifre dopo la virgola):

2.7182818284590452353602874713526624977572470936999595749669676277240766303535475945713821785251664274274663919320030599218174135966290435729003342952605956307381323286279434907632338298807531952510190115738341879307021540891499348841675092447614606680822648001684774118537423454424371075390777449920695517027618386062613313845830007520449338265602976067371132007093287091274437470472306969772093101416928368190255151086574637721112523897844250569536967707854499699679468644549059879316368892300987931

Di seguito lo pseudo-codice dell'algoritmo come riportato nell'articolo di Rabinowitz e Wagon:

Algorithm e-spigot:

1. Initialize: 
   Let the first digit be 2 and 
   initialize an array A of length n + 1 to (1, 1, 1, . . . , 1).
2. Repeat n − 1 times:
   Multiply by 10: Multiply each entry of A by 10.
   Take the fractional part: Starting from the right, 
                             reduce the ith entry of A modulo i + 1, 
                             carrying the quotient one place left.
   Output the next digit: The final quotient is the next digit of e.

Questa è l'implementazione in newLISP:

(define (spigot-e n)
  (local (vec cifra out)
    (setq out '())
    ; vettore con n elementi tutti di valore 1
    (setq vec (array n '(1)))
    (for (i 0 (- n 1))
      (setq cifra 0)
      (for (j (- n 1) 0 -1)
        (setf (vec j) (+ (* 10 (vec j)) cifra))
        (setq cifra (/ (vec j) (+ j 2)))
        (setf (vec j) (% (vec j) (+ j 2)))
      )
      (push cifra out -1))
    out))

(spigot-e 10)
;-> (7 1 8 2 8 1 8 2 6 1)

Un aspetto negativo di questo algoritmo è che le ultime cifre calcolate non sono corrette (soprattutto quando calcoliamo poche cifre). Questo problema può essere risolto in maniera pratica calcolando più cifre di quelle necessarie, in quanto l'algoritmo è molto veloce (calcolando 50 cifre in più siamo al sicuro fino a miliardi di cifre...). 

Calcoliamo il numero "e" con 500 cifre dopo la virgola:

(join (map string (spigot-e 499)))
;-> "7182818284590452353602874713526624977572470936999595749669676277240766303535475945713821785251664274274663919320030599218174135966290435729003342952605956307381323286279434907632338298807531952510190115738341879307021540891499348841675092447614606680822648001684774118537423454424371075390777449920695517027618386062613313845830007520449338265602976067371132007093287091274437470472306969772093101416928368190255151086574637721112523897844250569536967707854499699679468644549059879316368892300987931"

In questo caso tutte le cifre sono corrette.


-----------
Calcolo IVA
-----------

Due funzioni per calcolare l'IVA (Imposta Valore Aggiunto) e per scorporare l'IVA.

(define (iva+ value iva-perc)
  (mul value (add 1 (div iva-perc 100))))

(iva+ 100 20)
;-> 120

(iva+ 80 20)
;-> 96

(define (iva- value iva-perc)
  (div value (add 1 (div iva-perc 100))))

(iva- 96 20)
;-> 80


-----------------------
Numeri casuali distinti
-----------------------

Generare una lista ordinata con N numeri casuali distinti tra loro compresi tra "a" e "b".

Usiamo la funzione "rand-range" per generare un numero compreso tra "a" e "b":

(define (rand-range a b)
  (if (> a b) (swap a b))
  (+ a (rand (+ (- b a) 1))))

Poi scriviamo la funzione richiesta:

(define (sample n a b)
  (local (value out)
    ; creazione di un hashmap
    (new Tree 'hset)
    (until (= (length (hset)) n)
      ; genera valore casuale
      (setq value (rand-range a b))
      ; inserisce valore casuale nell'hash
      (hset (string value) value))
      ; assegnazione dei valori dell'hasmap ad una lista
      (setq out (getValues hset))
      ; eliminazione dell'hashmap
      (delete 'hset)
      (sort out)))

(sample 50 1 1000)
;-> (52 58 71 97 103 107 111 128 131 135 160 203 219 221 
;->  225 240 284 291 294 301 307 324 397 416 428 474 530 
;->  547 623 651 744 763 773 779 790 807 821 826 837 839 
;->  851 859 875 921 930 936 965 970 980 988)

Nota: La chiamata (sample 50 1 25) non termina mai. Per correttezza dovremmo inserire un controllo che verifica se "n" è maggiore di "(b - a + 1)", nel qual caso non esiste una lista con 50 numeri diversi con un intervallo minore della dimensione della lista. Il caso limite è quando risulta n = (b - a + 1):

(sample 10 1 10)
;-> (1 2 3 4 5 6 7 8 9 10)

Invece la seguente chiamata non termina mai:

(sample 10 1 9)
Premere Ctrl+C per fermare l'elaborazione...
;-> ERR: received SIGINT - in function length
;-> called from user function (sample 10 1 9)>

Riscriviamo la funzione inserendo il controllo:

(define (sample n a b)
  (local (value out)
    (cond ((> n (+ b (- a) 1)) '()) ; controllo
          (true
            ; creazione di un hashmap
            (new Tree 'hset)
            (until (= (length (hset)) n)
              ; genera valore casuale
              (setq value (rand-range a b))
              ; inserisce valore casuale nell'hash
              (hset (string value) value))
              ; assegnazione dei valori dell'hasmap ad una lista
              (setq out (getValues hset))
              ; eliminazione dell'hashmap
              (delete 'hset)
              (sort out)))))

(sample 10 1 10)
;-> (1 2 3 4 5 6 7 8 9 10)

Adesso quando risulta n > (b - a + 1) la funzione restituisce la lista vuota:

(sample 10 1 9)
;-> ()


-----------------------------------------------------
Numeri casuali con distribuzione discreta predefinita
-----------------------------------------------------

Supponiamo di voler generare uno dei seguenti eventi (a b c d) con le seguenti probabilità associate (0.05 0.15 0.35 0.45). In altre parole, se generiamo 1000 eventi la distribuzione deve essere uguale a quella predefinita: 50 a, 150 b, 350 c e 450 d (più o meno).

Nota: la somma delle probabilità deve valere 1.0.

Definiamo gli intervalli:

1) (0.00, 0.05) --> probabilità 5%
2) (0.05, 0.20) --> probabilità 15% (0.20 = 0.05 + 0.15)
3) (0.20, 0.55) --> probabilità 35% (0.55 = 0.20 + 0.35)
4) (0.55, 1.00) --> probabilità 45% (1.00 = 0.55 + 0.45)

(setq intervalli '(0.0 0.05 0.2 0.55 1.0))

Adesso generiamo un numero casuale R:

- se R cade nell'intervallo 1 (0.00, 0.05), 
  allora si verifica l'evento "a" --> indice 0
- se R cade nell'intervallo 2 (0.05, 0.20), 
  allora si verifica l'evento "b" --> indice 1
- se R cade nell'intervallo 3 (0.20, 0.55), 
  allora si verifica l'evento "c" --> indice 2
- se R cade nell'intervallo 4 (0.55, 1.00), 
  allora si verifica l'evento "d" --> indice 3

La funzione genera un numero da 0 a (n-1) che rappresenta l'indice del valore di probabilità nella lista delle probabilità:

(define (rand-prob probs)
  (local (out inter cur val found)
    (setq found nil)
    (setq inter '(0.0))
    (setq cur 0)
    ; creazione della lista degli intervalli
    (dolist (el probs)
      (setq cur (round (add cur el) -4))
      (push cur inter -1)
    )
    ; l'ultimo valore della lista degli intervalli deve valere 1
    (if (!= (last inter) 1) (println "Errore: somma probabilita diversa da 1"))
    ; generazione numero random con probabilità predefinite
    (setq val (random))
    (setq out nil)
    ; ricerca in quale intervallo cade il numero random
    ; e restituisce l'indice corrispondente
    (for (i 0 (- (length inter) 2) 1 found)
      (if (and (>= val (inter i)) (<= val (inter (+ i 1))))
        (begin
        (setq out i)
        (setq found true))
      )
    )
    out))

Proviamo con l'esempio iniziale:

(setq p '(0.05 0.15 0.35 0.45))

(rand-prob p)
;-> 2

Verifichiamo la funzione generando 1000000 di valori che popolano un vettore di frequenze:

(setq vet (array 4 '(0)))
;-> (0 0 0 0)
(for (i 0 999999) (++ (vet (rand-prob p))))
vet
;-> (50177 150075 348712 451036)
Il risultato segue bene la distribuzione perfetta che vale (50000 150000 350000 450000).

Calcoliamo la somma dei valori del vettore:
(apply + vet)
;-> 1000000

Sembra che tutto funzioni correttamente.


------------------------------
Generatore di stringhe casuali
------------------------------

Scrivere una funzione che genera stringhe casuali di lunghezza prefissata.

Lettere minuscole:
(char 97)
;-> "a"
(char 122)
;-> "z"
(setq lower (map char (sequence 97 122)))
;-> ("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m"
;->  "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")
(length lower)
;-> 26

Lettere maiuscole:
(char 65)
;-> "A"
(char 90)
;-> "Z"
(setq upper (map char (sequence 65 90)))
;-> ("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M"
;->  "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")
(length upper)
;-> 26

Vocali:
(setq vowels '("a" "e" "i" "o" "u"))

Consonanti:
(setq consonants '("b" "c" "d" "f" "g" "h" "j" "k" "l" "m" "n" "p" "q" "r" "s" "t" "v" "w" "x" "y" "z"))

(setq upper-rnd (map char (randomize (sequence 65 90))))
;-> ("A" "P" "G" "V" "Q" "B" "N" "Y" "W" "D" "M" "X" "J"
;->  "T" "R" "F" "E" "U" "C" "O" "Z" "L" "I" "K" "H" "S")

Generatore di interi tra [a, b]:

(define (rand-range a b)
  (if (> a b) (swap a b))
  (+ a (rand (+ (- b a) 1))))

Estrae un carattere casuale da una lista:

(define (rand-char lst) (lst (rand (length lst))))

(rand-char lower)
;-> "c"

Il più semplice dei generatori casuali utilizza la funzione "rand-char" per creare una stringa di lunghezza n con caratteri presi dall'alfabeto alfa:

(define (rand-string n alfa)
  (let (out '())
    (dotimes (i n)
      (push (rand-char alfa) out -1))
      (join out)))

(rand-string 10 lower)
;-> "unhwsyyodm"

(rand-string 10 upper)
;-> "YTCPKTPOJD"

(rand-string 10 vowels)
;-> "eiuiuoeaoi"

Adesso ci proponiamo di scrivere una funzione che genera stringhe "leggibili". Per stringa "leggibile" intendiamo una stringa che segue le regole generali della lingua italiana e quindi può essere letta senza difficoltà (es. "unhwsyyodm" è illeggibile).
Vediamo alcune di queste regole (che hanno quasi sempre delle eccezioni):
1) non ci sono tre vocali di seguito (eccez. aiuola)
2) non ci sono tre consonanti di seguito (eccez. strada)
3) non ci sono quattro consonanti di seguito
4) alcune consonanti non possono essere doppie (es. hh, yy, xx, ww)
5) ecc.

La funzione che implementiamo segue le seguenti regole di costruzione:

a) Inizia con una consonante
b) segue una vocale
c) può seguire:
   c1) una consonante (percentuale di probabilità 60%)
   c2) due consonanti uguali (nn,rr,tt,...) (30%)
   c3) due consonanti diverse (fr,pr,tr,sf,...) (15%)
   c4) tre consonanti diverse (sfr, str, ttr,...) (5%)
d) segue una vocale
e) ritornare al punto a)

Cominciamo a definire quali sono le consonanti doppi possibili.

(define (doppia lst)
  (let (out '())
    (dolist (el lst)
      (push (string el el) out -1))))

(doppia consonants)
;-> ("bb" "cc" "dd" "ff" "gg" "hh" "jj" "kk" "ll" "mm" "nn" "pp"
;->  "qq" "rr" "ss" "tt" "vv" "ww" "xx" "yy" "zz")

Eliminiamo "hh", "jj", "kk", ,"qq", "ww", "xx" e "yy".

(setq doppie '("bb" "cc" "dd" "ff" "gg" "ll" "mm" "nn" "pp" "rr" "ss" "tt" "zz"))

Adesso analizziamo le consonanti diverse.

(setq lettere '("b" "c" "d" "f" "g" "l" "m" "n" "p" "q" "r" "s" "t" "v"))

Generiamo tutte le doppie:

(define (cp lst1 lst2 func)
  (let (out '())
    (if (or (null? lst1) (null? lst2))
        nil
        (dolist (el1 lst1)
          (dolist (el2 lst2)
            (push (func el1 el2) out -1))))))

(difference (unique (cp lettere lettere string)) (doppia lettere))
;-> ("bc" "bd" "bf" "bg" "bl" "bm" "bn" "bp" "bq" "br" "bs" "bt" "bv"
;->  "cb" "cd" "cf" "cg" "cl" "cm" "cn" "cp" "cq" "cr" "cs" "ct" "cv"
;->  "db" "dc" "df" "dg" "dl" "dm" "dn" "dp" "dq" "dr" "ds" "dt" "dv"
;->  "fb" "fc" "fd" "fg" "fl" "fm" "fn" "fp" "fq" "fr" "fs" "ft" "fv"
;->  "gb" "gc" "gd" "gf" "gl" "gm" "gn" "gp" "gq" "gr" "gs" "gt" "gv"
;->  "lb" "lc" "ld" "lf" "lg" "lm" "ln" "lp" "lq" "lr" "ls" "lt" "lv"
;->  "mb" "mc" "md" "mf" "mg" "ml" "mn" "mp" "mq" "mr" "ms" "mt" "mv"
;->  "nb" "nc" "nd" "nf" "ng" "nl" "nm" "np" "nq" "nr" "ns" "nt" "nv"
;->  "pb" "pc" "pd" "pf" "pg" "pl" "pm" "pn" "pq" "pr" "ps" "pt" "pv"
;->  "qb" "qc" "qd" "qf" "qg" "ql" "qm" "qn" "qp" "qr" "qs" "qt" "qv"
;->  "rb" "rc" "rd" "rf" "rg" "rl" "rm" "rn" "rp" "rq" "rs" "rt" "rv"
;->  "sb" "sc" "sd" "sf" "sg" "sl" "sm" "sn" "sp" "sq" "sr" "st" "sv"
;->  "tb" "tc" "td" "tf" "tg" "tl" "tm" "tn" "tp" "tq" "tr" "ts" "tv"
;->  "vb" "vc" "vd" "vf" "vg" "vl" "vm" "vn" "vp" "vq" "vr" "vs" "vt")

Scegliamo "br", "cl", "cr", "dr", "fl", "fr", "gl", "gn", "gr", "lg", "pl", "pr", "rb", "rc" , "rs", "sb", "sc", "sf", "sl", "sm", "sp", "st", "tr".

(setq doppie-div '("br" "cl" "cr" "dr" "fl" "fr" "gl" "gn" "gr" "lg" "pl" "pr" "rb" "rc"  "rs" "sb" "sc" "sf" "sl" "sm" "sp" "st" "tr"))

Vediamo le triple consonanti:

(setq triple '("sfr" "str" "ttr"))

Funzione che estrae un elemento casuale dalla lista passata:

(define (rand-list lst) (lst (rand (length lst))))

(rand-list doppie)
;-> "cc"
(rand-list doppie-div)
;-> "dr"

Infine scriviamo la funzione che genera parole casuali "leggibili":

(define (rand-word iter)
  (local (out)
    (setq out '())
    (dotimes (i iter)
      (push (rand-list consonants) out -1)
      (push (rand-list vowels) out -1)
      (case (rand 4)
            (0 (push (rand-list consonants) out -1))
            (1 (push (rand-list doppie) out -1))
            (2 (push (rand-list doppie-div) out -1))
            (3 (push (rand-list triple) out -1))
            (true (println "error")))
      (push (rand-list vowels) out -1))
    (join out)))

(rand-word 2)
;-> "fuzzarazza"

Dieci parole casuali:

(dotimes (x 10) (println (rand-word (+ 1 (rand 2)))))
;-> nistra
;-> kattru
;-> riscumexu
;-> dusfri
;-> cadidosbo
;-> sestruvela
;-> guledavo
;-> bissinopa
;-> xunototto
;-> paslo

Il passo successivo sarebbe quello di definire una percentuale di probabilità predefinita ad ogni evento casuale, per esempio:
c1) una consonante (percentuale di probabilità 60%)
c2) due consonanti uguali  (30%)
c3) due consonanti diverse (15%)
c4) tre consonanti diverse (5%)

Inoltre sarebbe interessante modificare o definire altre regole di costruzione.

