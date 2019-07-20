==============

 ROSETTA CODE
 
==============

https://rosettacode.org/wiki/Category:Programming_Tasks

Rosetta Code è un sito di programmazione "chrestomathy" (proviene dal greco χρηστομάθεια e significa "desiderio di imparare"). L'idea è di risolvere/presentare la soluzione per lo stesso problema in quanti più linguaggi possibili, per dimostrare le analogie e le differenze dei linguaggi, e per aiutare chi conosce un linguaggio ad apprenderne un altro.
Il sito contiene moltissimi problemi risolti in 714 linguaggio (non tutti problemi sono stati risolti con tutti i linguaggi).
Di seguito vengono presentanti alcuni di questi problemi e la loro soluzione.
Per avere una migliore comprensione si consiglia di provare a risolverli per conto proprio prima di leggere la soluzione.

--------
FIZZBUZZ
--------

Scrivere un programma che stampa i numeri interi da 1 a 100 (inclusi).
Ma:
- per multipli di tre, stampa Fizz (invece del numero)
- per multipli di cinque, stampa Buzz (invece del numero)
- per multipli di entrambi tre e cinque, stampa FizzBuzz (invece del numero)

(define (fizzbuzz)
  (for (i 1 100)
    (cond ((= 0 (% i 15)) (println "FizzBuzz"))
          ((= 0 (% i 3))  (println "Fizz"))
          ((= 0 (% i 5))  (println "Buzz"))
          (true           (println i))
    )
  )
)

(fizzbuzz)

Vediamo ora una generalizzazione del problema. Occorre scrivere una funzione che accetta una lista di fattori e una lista di parole associate. Un ulteriore parametro permette di specificare il numero massimo da stampare.
Come esempio possiamo usiare la seguente lista associativa:

(3 "Fizz")
(5 "Buzz")
(7 "Baxx")

Nel caso in cui un numero sia un multiplo di almeno due fattori, stampare ciascuna delle parole associate a tali fattori nell'ordine dal fattore minore a quello maggiore. Ad esempio, il numero 15 è un multiplo di entrambi 3 e 5, allora stampa FizzBuzz. Se il numero massimo vale 105, occorre stampare FizzBuzzBaxx perché è un multiplo di 3, 5 e 7.

(setq lst '((3 "Fizz") (5 "Buzz") (7 "Baxx")))

(define (fizzbuzzG n lst)
  (local (out)
    (for (i 1 n)
      (setq out "")
      (dolist (el lst)
        (if (= 0 (% i (first el))) (setq out (append out (last el))))
      )
      (if (= out "") (setq out (string i)))
      (print out {, })
    )
  )
)

(fizzbuzzG 20 lst)
;-> 1, 2, Fizz, 4, Buzz, Fizz, Baxx, 8, Fizz, Buzz, 11,
;-> Fizz, 13, Baxx, FizzBuzz, 16, 17, Fizz, 19, Buzz

(setq lst '((2 "Fizz") (3 "Buzz") (5 "Baxx")))

(fizzbuzzG 30 lst)
;-> 1, Fizz, Buzz, Fizz, Baxx, FizzBuzz, 7, Fizz, Buzz, FizzBaxx, 11,
;-> FizzBuzz, 13, Fizz, BuzzBaxx, Fizz, 17, FizzBuzz, 19, FizzBaxx, Buzz,
;-> Fizz, 23, FizzBuzz, Baxx, Fizz, Buzz, Fizz, 29, FizzBuzzBaxx


------------
NUMERI PRIMI
------------

In matematica, un numero primo (in breve anche primo) è un numero intero positivo che ha esattamente due divisori distinti. In modo equivalente si può definire come un numero naturale maggiore di 1 che è divisibile solamente per 1 e per sé stesso. Al contrario, un numero maggiore di 1 che abbia più di due divisori è detto composto.
L'algoritmo di base per calcolare i numeri primi è il cosiddetto Crivello di Eratostene.
Di seguito è riportato l'algoritmo che trova tutti i numeri primi minori o uguali a un intero dato n con il metodo di Eratostene:

1) Creare una lista di numeri interi consecutivi da 2 a n: (2, 3, 4, ..., n).

2) Inizialmente, sia p uguale a 2, il primo numero primo.

3) A partire da p^2, contare ad incrementi di p e marca nella lista tutti quei numeri che sono maggiori o uguali a p^2 stesso. Questi numeri saranno p(p + 1), p(p + 2), p(p + 3), ecc.

4) Trova nella lista il primo numero maggiore di p che non è marcato. Se non esiste tale numero, fermati algoritmo terminato). Altrimenti, lascia p ora uguale a questo numero (che è il prossimo primo), e ripeti dal punto 3.

Quando l'algoritmo termina, tutti i numeri nell'elenco che non sono contrassegnati sono primi.

(setq n 1000)
;definiamo un vettore di n+1 elementi tutti con valore true
;al termine dell'algoritmo i valori del vettore "primi" che hanno valore true sono numeri primi ()
(setq primi (array (add 1 n) '(true)))
(setq p 2)

(while (<= (* p p) n)
  (if (= (primi p) true)) ; se primi[p} non è cambiato, allora è un numero primo)
  ; Poniamo a nil tutti i multipli di p che sono maggiori o uguali al quadrato di p
  ; I numeri che sono multipli di p e sono minori di p^2 sono già stati marcati (posti a nil).
  (for (i (* p p) n p) (setq (primi i) nil))
  (++ p)
)

; stampiamo solo gli indici del vettore primi che hanno valore true (cioè sono numeri primi).
(for (p 2 n 1)
   (if (= (primi p) true)
      (print p { })
   )
)

Adesso possiamo scrivere la funzione completa:

(define (Eratostene n)
  (setq primi (array (add 1 n) '(true)))
  (setq p 2)
  (while (<= (* p p) n)
    (if (= (primi p) true))
    (for (i (* p p) n p) (setq (primi i) nil))
    (++ p)
  )
  (for (p 2 n 1)
    (if (= (primi p) true)
        (print p { })
    )
  )
)

(Eratostene 1000)
;-> 2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97 101 103 107 109 113
;-> 127 131 137 139 149 151 157 163 167 173 179 181 191 193 197 199 211 223 227 229 233 239 241
;-> 251 257 263 269 271 277 281 283 293 307 311 313 317 331 337 347 349 353 359 367 373 379 383
;-> 389 397 401 409 419 421 431 433 439 443 449 457 461 463 467 479 487 491 499 503 509 521 523
;-> 541 547 557 563 569 571 577 587 593 599 601 607 613 617 619 631 641 643 647 653 659 661 673
;-> 677 683 691 701 709 719 727 733 739 743 751 757 761 769 773 787 797 809 811 821 823 827 829
;-> 839 853 857 859 863 877 881 883 887 907 911 919 929 937 941 947 953 967 971 977 983 991 997

(prime 137)
;-> true

(prime 889)
;-> nil

Se vogliamo sapere soltanto se un certo numero è primo possiamo utilizzare altri metodi.
Il test di primalità più semplice è la "prova della divisione": Dato un numero n, controlla se ogni numero intero m, che va da 2 a sqrt(n), divide precisamente n (la divisione non lascia resto). Se n è divisibile per uno qualsiasi dei valori di m allora n è composto, altrimenti è primo.

Ad esempio, per testare la primalità di 100 con questo metodo, considera tutti i divisori interi di 100:

2, 4, 5, 10, 20, 25, 50

Il fattore più grande è 100/2 = 50. Questo è vero per tutti n: tutti i divisori sono inferiori o uguali a n/2. Ispezionando i divisori, si determina che alcuni di essi sono ridondanti. L'elenco dei divisori può essere scritto come:

100 = 2 × 50 = 4 × 25 = 5 × 20 = 10 × 10 = 20 × 5 = 25 × 4 = 50 × 2

che dimostra la ridondanza. Una volta testato il divisore 10, che è sqrt(100), il primo divisore è semplicemente il dividendo di un precedente divisore. Pertanto, è possibile eliminare i divisori di prova superiori a sqrt(n). Tutti i numeri pari maggiori di 2 possono anche essere eliminati, poiché se un numero pari può dividere n, anche 2 può dividere quel numero.

Diamo un'occhiata ad un altro esempio e usiamo la prova della divisione per testare la primalità di 17. Poiché ora sappiamo che non abbiamo bisogno di testare usando divisori superiori a sqrt(n), abbiamo solo bisogno di usare divisori interi minori o uguali a sqrt(17) circa uaguale 4.12. Quindi sarebbero 2, 3 e 4. Come detto sopra, possiamo saltare 4 perché se 4 divide precisamente 17, 2 deve anche dividere precisamente 17, che avremmo già controllato prima. Questo ci lascia solo con 2 e 3. Dopo la divisione, troviamo che 17 non è divisibile per 2 o 3, e possiamo confermare che 17 deve essere primo.

L'algoritmo può essere ulteriormente migliorato osservando che tutti i numeri primi sono della forma 6k ± 1, con l'eccezione di 2 e 3. Ciò è dovuto al fatto che tutti gli interi possono essere espressi come (6k + i) per alcuni interi k e per i = - 1, 0, 1, 2, 3 o 4, poi 2 divide (6k + 0), (6k + 2), (6k + 4) e 3 divide (6k + 3). Quindi, un metodo più efficiente è quello di verificare se n è divisibile per 2 o 3, quindi controllare tutti i numeri della forma (6k ± 1 <= sqrt(n)). Questo è 3 volte più veloce di testare tutti i valori di m.
Lo pseudocodice della funzione è il seguente:

 function is_prime(n)
     if n ≤ 3
        return n > 1
     else if n mod 2 = 0 or n mod 3 = 0
        return false
     let i ← 5
     while i * i ≤ n
        if n mod i = 0 or n mod (i + 2) = 0
            return false
        i ← i + 6
     return true

Adesso scriviamo la nostra funzione:

(define (primo? n)
  (setq out true) ; il numero viene considerato primo fino a che non troviamo un divisore preciso
  (cond ((<= n 3) (setq out true))
        ((or (= (% n 2) 0) (= (% n 3) 0)) (setq out nil))
        (true (setq i 5)
              (while (<= (* i i) n)
                (if (or (= (% n i) 0) (= (% n (+ i 2)) 0)) (setq out nil))
                (setq i (+ i 6))
              )
        )
  )
  out
)

(primo? 100)
;-> nil

(primo? 3347833720307)
;-> nil

(primo? 100000017239)
;-> true

Calcoliamo il tempo di esecuzione:

(time (primo? 3347833720307) 100)
;-> 9468.2
(time (primo? 100000017239) 100)
;-> 1640.4

newLISP mette a disposizione la funzione "factor" per calcolare i fattori primi di un numero.
Ad esempio:

(factor 67456)
;-> (2 2 2 2 2 2 2 17 31)

"factor" restituisce una lista con i numeri della scomposizione in fattori del numero fornito.
Possiamo scrivere un'altra funzione per verificare se un dato numero è primo:
se la lunghezza della lista restituita dalla funzione "factor" vale 1, allora il numero è primo.

(define (primo-a? n)
  (= 1 (length (factor n))))

(primo-a? 3347833720307)
;-> nil
(primo-a? 100000017239)
;-> true

Poichè "factor" è una funzione predefinita (compilata) è molto veloce. Se proviamo a migliorare la nostra funzione (ad esempio eliminando i numeri pari dalla fattorizzazione) otteniamo miseri risultati:

(define (primo-b? n)
  (if (even? n) nil
      (= 1 (length (factor n)))))

(primo-b? 3347833720307)
;-> nil
(primo-b? 100000017239)
;-> true

Adesso vediamo la velocità di esecuzione delle due funzioni primo-a e primo-b:

(time (primo-a? 3347833720307) 100)
;-> 203.1
(time (primo-a? 100000017239) 100)
;-> 156.2

(time (primo-b? 3347833720307) 100)
;-> 203.2
(time (primo-b? 100000017239) 100)
;-> 156.2

Ci sono miglioramenti sostanziali tra "primo-a?" e "primo-b?", comunque entrambe sono circa 10 volte più veloci della funzione "primo?".

Nota: le funzioni "primo-a" e "primo-b" non funzionano con i big integer perchè la funzione "factor" non funziona con i big integer. Il numero massimo possibile (int64) vale: 9223372036854775807.

Riscriviamo la nostra funzione "primo?" in modo da funzionare con i big integer:

(define (primoBig? n)
  (setq out true) ; il numero viene considerato primo fino a che non troviamo un divisore preciso
  (cond ((<= n 3L) (setq out true))
        ((or (= (% n 2L) 0L) (= (% n 3L) 0L)) (setq out nil))
        (true (setq i 5L)
              (while (<= (* i i) n)
                (if (or (= (% n i) 0L) (= (% n (+ i 2L)) 0L)) (setq out nil))
                (setq i (+ i 6L))
              )
        )
  )
  out
)

La funzione è lenta con numeri grandi:

(time (primoBig? 3347833720307) 100)
;-> 17672.8

(time (primoBig? 100000017239) 100)
;-> 3066.7

E raggiunge rapidamente il limite pratico di utilizzo con i big integer:

(primoBig? 1111235916285193) ; numero con 16 cifre
;-> true

(time (primoBig? 1111235916285193)) ; numero con 16 cifre
;-> 3250.1

(primoBig? 76912895956636885) ; numero con 17 cifre
;->  nil
(time (primoBig? 76912895956636885))
;-> 27235.75

Adesso scriviamo una funzione che fattorizza un numero raggruppando i termini uguali.
Ad esempio (fattorizza 45) deve produrre ((3 2) (5 1)), cioè 45 = 3^2 * 5^1.

(define (fattorizza x)
  (setq fattori (factor x))
  (setq unici (unique fattori))
  (transpose (list unici (count unici fattori)))
  ;(map (list unici (count unici fattori)))
)

(fattorizza 45)
;-> ((3 2) (5 1))

(fattorizza 232792560)
;-> ((2 4) (3 2) (5 1) (7 1) (11 1) (13 1) (17 1) (19 1))

(time (fattorizza 232792560) 100000)
;-> 342.6

(factor 9223372036854775807)
;-> (7 7 73 127 337 92737 649657)

(fattorizza 9223372036854775807)
;-> ((7 2) (73 1) (127 1) (337 1) (92737 1) (649657 1))

Può essere utile avere due funzioni che ricostruiscono il numero originale partendo dai due tipi di fattorizzazione:

Operazione inversa di "factor":

(setq f (factor 45))
;-> (3 3 5)

(setq num-f (apply * f))
;-> 45

Operazione inversa di "fattorizza":

(setq fg (fattorizza 45))
;-> ((3 2) (5 1))

(setq num-fg (apply * (map (lambda (x) (pow (first x) (last x))) fg)))
;-> 45

(setq fg (fattorizza 232792560))
;-> ((2 4) (3 2) (5 1) (7 1) (11 1) (13 1) (17 1) (19 1))

(setq num-fg (apply * (map (lambda (x) (pow (first x) (last x))) fg)))
;-> 232792560

Per finire scriviamo una funzione "fattori-primi" che fa lo stesso lavoro di "factor":

(define (fattori-primi numero)
  (define (fattori divisore numero)
    (if (> (* divisore divisore) numero)
        (list numero)
        (if (= (mod numero divisore) 0)
            (cons divisore (fattori divisore (/ numero divisore)))
            (fattori (+ divisore 1) numero)
        )
    )
  )
  (fattori 2L numero)
)

(fattori-primi 3434344L)
;-> (2L 2L 2L 151L 2843L)

(apply * (fattori-primi 3434344L))
;-> 3434344L

(factor 3434344L)
;-> (2 2 2 151 2843)

Ricordiamo che il valore massimo per i numeri int64 è 9223372036854775807.

(factor 9223372036854775807L)
;-> (7 7 73 127 337 92737 649657)

(fattori-primi 9223372036854775807L)
;-> ERR: call or result stack overflow in function > : *

Purtroppo "fattori-primi" è una funzione ricorsiva che consuma tutto lo stack di newLISP.

Proviamo allora a scrivere una versione iterativa che funziona con i big integer:

(define (fattori-primi n)
  (local (fp lim i)
    (setq fp '())
    (while (zero? (% n 2L))  ; quante volte il numero 2 divide esattamente il numero n
      (setq fp (cons 2L fp))
      (setq n (/ n 2L))
    )
    ; adesso n è un numero dispari
    (setq i 3L)
    (setq lim (sqrt n))
    (while (<= i lim)
      (while (zero? (% n i))  ; quante volte il numero "i" divide esattamente il numero n
        (setq fp (cons i fp))
        (setq n (/ n i))
      )
      (setq i (+ 2L i))
    )
    ; questa condizione verifica il caso che il numero n sia un numero primo maggiore di 2
    (if (> n 2L) (setq fp (cons n fp)))
    (reverse fp)
  )
)

(fattori-primi 256)
;-> (2L 2L 2L 2L 2L 2L 2L 2L)

(fattori-primi 3434344L)
;-> (2L 2L 2L 151L 2843L)

Questa volta la funzione "fattori-primi" produce i risultati corretti, ma è molto lenta con numeri grandi:

(time (fattori-primi 9223372036854775807L))
;-> 432092.716 ; 7 minuti e 12 secondi

(time (factor 9223372036854775807L))
;-> 1.998 ;

(fattori-primi 9223372036854775808L)
;-> (2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L 2L 2L 2L 2L 2L)

(time (fattori-primi 9223372036854775808L))
;-> 0

(factor 9223372036854775808L)
;-> ERR: number out of range in function factor

Attenzione: la funzione è molto lenta con numeri grandi.

(fattori-primi 9223372036854775809L)
;-> (3L 3L 3L 19L 43L 5419L 77158673929L)

(apply * '(3L 3L 3L 19L 43L 5419L 77158673929L))
;-> 9223372036854775809L

(time (fattori-primi 9223372036854775809L))
;-> 551342.497 ; 9 minuti e 11 secondi


---------------
NUMERI DI SMITH
---------------

I numeri di Smith sono numeri in cui la somma delle cifre decimali che compongono il numero è uguale alla somma delle cifre decimali dei suoi fattori primi escluso 1.
Per definizione, tutti i numeri primi sono esclusi in quanto (naturalmente) soddisfano questa condizione!

Esempio utilizzando il numero 166
I fattori primi di 166 sono: 2 x 83 = 166
Somma tutte le loro cifre decimali: 2 + 8 + 3 = 13
Somma le cifre decimali di 166: 1 + 6 + 6 = 13
Allora, il numero 166 è un numero Smith.

Scrivere un programma per trovare tutti i numeri Smith inferiori a 10000.

Le seguenti istruzioni verificano se un numero x è un numero di Smith:

(setq x 1234567890)
;-> 1234567890
(setq s (string x))
;-> "1234567890"
(setq a (slice (explode s) 0))
;-> ("1" "2" "3" "4" "5" "6" "7" "8" "9" "0")
(setq b (apply + (map int a)))
;-> 45

(setq f (factor x))
;-> (2 3 3 5 3607 3803)
(setq sf (apply string f))
;-> "233536073803"
(setq af (slice (explode sf) 0))
;-> ("2" "3" "3" "5" "3" "6" "0" "7" "3" "8" "0" "3")
(setq bf (apply + (map int af)))
;-> 43
(if (= b bf) true nil)
;-> nil

Adesso possiamo scrivere la funzione richiesta:

(define (smith? x)
  (cond
    ((bigint? x) -1) ; do not work with big integer
    ( true
        (setq s (string x))
        (setq a (slice (explode s) 0))
        (setq b (apply + (map int a)))
        (setq f (factor x))
        (if (= 1 (length f)) (setq f '(0))) ; trovato numero primo
        (setq sf (apply string f))
        (setq af (slice (explode sf) 0))
        (setq bf (apply + (map int af)))
        (= b bf)
        ;(if (= b bf) true nil)
    )
  )
)

(smith? 166)
;-> true
(smith? 1234567890)
;-> nil
(smith? 123456789012938347464736374657484756578)
;-> -1

(define (smith10000)
  (setq n '())
  (for (i 1 10000)
    (if (smith? i) (setq n (append (list i) n)))
  )
  (println (reverse n))
  (println "Fino a 10000 ci sono " (length n) " numeri di Smith.")
)

(smith10000)
;-> (4 22 27 58 85 94 121 166 202 265 274 319 346 355 378 382 391 438 454 483 517 526
;->  535 562 576 588 627 634 636 645 648 654 663 666 690 706 728 729 762 778 825 852
;->  861 895 913 915 922 958 985 1086 1111 1165 1219 1255 1282 1284 1376 1449 1507 1581
;->  1626 1633 1642 1678 1736 1755 1776 1795 1822 1842 1858 1872 1881 1894 1903 1908
;->  1921 1935 1952 1962 1966 2038 2067 2079 2155 2173 2182 2218 2227 2265 2286 2326
;->  2362 2366 2373 2409 2434 2461 2475 2484 2515 2556 2576 2578 2583 2605 2614 2679
;->  2688 2722 2745 2751 2785 2839 2888 2902 2911 2934 2944 2958 2964 2965 2970 2974
;->  3046 3091 3138 3168 3174 3226 3246 3258 3294 3345 3366 3390 3442 3505 3564 3595
;->  3615 3622 3649 3663 3690 3694 3802 3852 3864 3865 3930 3946 3973 4054 4126 4162
;->  4173 4185 4189 4191 4198 4209 4279 4306 4369 4414 4428 4464 4472 4557 4592 4594
;->  4702 4743 4765 4788 4794 4832 4855 4880 4918 4954 4959 4960 4974 4981 5062 5071
;->  5088 5098 5172 5242 5248 5253 5269 5298 5305 5386 5388 5397 5422 5458 5485 5526
;->  5539 5602 5638 5642 5674 5772 5818 5854 5874 5915 5926 5935 5936 5946 5998 6036
;->  6054 6084 6096 6115 6171 6178 6187 6188 6252 6259 6295 6315 6344 6385 6439 6457
;->  6502 6531 6567 6583 6585 6603 6684 6693 6702 6718 6760 6816 6835 6855 6880 6934
;->  6981 7026 7051 7062 7068 7078 7089 7119 7136 7186 7195 7227 7249 7287 7339 7402
;->  7438 7447 7465 7503 7627 7674 7683 7695 7712 7726 7762 7764 7782 7784 7809 7824
;->  7834 7915 7952 7978 8005 8014 8023 8073 8077 8095 8149 8154 8158 8185 8196 8253
;->  8257 8277 8307 8347 8372 8412 8421 8466 8518 8545 8568 8628 8653 8680 8736 8754
;->  8766 8790 8792 8851 8864 8874 8883 8901 8914 9015 9031 9036 9094 9166 9184 9193
;->  9229 9274 9276 9285 9294 9296 9301 9330 9346 9355 9382 9386 9387 9396 9414 9427
;->  9483 9522 9535 9571 9598 9633 9634 9639 9648 9657 9684 9708 9717 9735 9742 9760
;->  9778 9840 9843 9849 9861 9880 9895 9924 9942 9968 9975 9985)
;-> Fino a 10000 ci sono 376 numeri di Smith.


-----------------
NUMERI DI HAMMING
-----------------

I numeri di Hamming sono numeri della forma:

        H = 2^i × 3^j × 5^k

dove: i, j, k ≥ 0

Scrivere un programma per calcolare i numeri di hamming nel corretto ordine.

Questa funzione restituisce il più piccolo tra due numeri (anche big integer):

(define (minimo x y)
  (if (< x y) x y)
)

(define (hamming n bool)
  (setq h (array n '(0L))) ; utilizziamo un vettore big integer
  (setf (h 0) 1L)
  (setq i 0L)  (setq j 0L)  (setq k 0L)
  (setq x2 2L)  (setq x3 3L)  (setq x5 5L)
  (for (m 1 (-- n) 1)
    (setf (h m) (minimo x2 (minimo x3 x5)))
    ;(setf (h m) (min x2 (min x3 x5))) ; la funzione "min" non funziona con i big integer
    (if (= (h m) x2) (begin (++ i) (setq x2 (* (h i) 2L))))
    (if (= (h m) x3) (begin (++ j) (setq x3 (* (h j) 3L))))
    (if (= (h m) x5) (begin (++ k) (setq x5 (* (h k) 5L))))
  )
  (if bool h (last h)) ; se bool = true, allora stampa tutti i numeri, altrimenti solo l'ultimo
)

(hamming 20 true)
;-> (1L 2L 3L 4L 5L 6L 8L 9L 10L 12L 15L 16L 18L 20L 24L 25L 27L 30L 32L 36L)

(hamming 1691)
;-> 2125764000L

(hamming 1000000)
;-> 519312780448388736089589843750000000000000000000000000000000000000000000000000000000L

(time (hamming 1000000))
;-> 2130.027 (millisecondi)


-----------------
NUMERI DI CATALAN
-----------------

I numeri di Catalan formano una successione di numeri naturali utile in molti calcoli combinatori. Prendono il nome dal matematico belga Eugène Charles Catalan.
Esistono diverse definizioni equivalenti per calcolare questi numeri.
Prendiamo in considerazione una definizione ricorsiva:

C(0) = 1

         2*(2*n - 1)
C(n) = --------------- * C(n-1)
           (n + 1)

Quindi scriviamo una funzione che utilizza i big integer per il calcolo:

(define (catalan n)
  (if (< n 2) 1L
      (/ (* (- (* 4L n) 2L) (catalan (- n 1L))) (+ n 1L))
  )
)

(catalan 5L)
;-> 42L

(catalan 500L)
;-> 53949748691703906090941056611971112873483434819670316767942689642041003733637164
;-> 45082085507475097208889473175349731459177688817366281036278441002389211945617238
;-> 83202123256952806711505149177419849031086149939116975191706558395784192643914160
;-> 118616272189452807591091542120727401415762287153293056320L

Possiamo scrivere anche una versione iterativa, ma non possiamo usare i big integer poichè la divisione altera il risultato, quindi dobbiamo usare i floating-point.
Utilizziamo una funzione diversa:

C(0) = C(1) = 1

C(n) = Prod[ (n + k)/k ] (dove k va da 2 a n) (per n > 1)

Iterativo
Non possiamo usare i big integer poichè la divisione altera il risultato, quindi dobbiamo usare i floating-point.

(define (catalan-i n)
  (setq res 1.0)
  (for (k 2 n)
      (setq res (mul res (div (add n k) k)))
  )
)

(catalan-i 5L)
;-> 41.99999999999999

(ceil (catalan-i 5L))
;-> 42

(catalan-i 500L)
;-> 5.394974869170395e+296


------------------
NUMERI DI KAPREKAR
------------------

Un numero intero positivo è un numero di Kaprekar se la rappresentazione decimale del suo quadrato può essere divisa una volta in due parti costituite da numeri interi positivi che sommano al numero originale.
Si noti che una divisione risultante in una parte costituita esclusivamente da 0 non è valida, poiché 0 non è considerato positivo.
Per convenzione 1 è un numero di Kaprekar.

(setq x 45)
;-> 45
(setq xx (* x x))
;-> 2025
(setq s (string (* x x)))
;-> "2025"

(for (i 0 (length s))
  (setq num1 (int (slice s 0 i) 0 10))
  (setq num2 (int (slice s i (length s)) 0 10))
  (println num1 { } num2)
)
;-> 0 2025
;-> 2 25
;-> 20 25 (la loro somma vale 45, quindi 45 è un numero di Kaprekar)
;-> 202 5
;-> 2025 0

Adesso possiamo scrivere la funzione:

(define (kaprekar? n)
  (setq kap nil)
  (setq i 0)
  (setq xx (* n n))
  (setq s (string xx))
  (while (and (<= i (length s)) (= kap nil))
    (setq num1 (int (slice s 0 i) 0 10))
    (setq num2 (int (slice s i (length s)) 0 10))
    (if (and (> num2 0) (= n (+ num1 num2))) (setq kap true))
    (++ i)
  )
  kap
)

(kaprekar? 1)
;-> true
(kaprekar? 10)
;-> nil
(kaprekar 2223)
;-> true

(define (kaprekar10000)
  (setq out '())
  (for (j 1 10000)
    (if (kaprekar? j) (setq out (append (list j) out)))
  )
  (println (reverse out))
  (println "Fino a 10000 ci sono " (length out) " numeri di Kaprekar.")
)

(kaprekar10000)
;-> (1 9 45 55 99 297 703 999 2223 2728 4950 5050 7272 7777 9999)
;-> Fino a 10000 ci sono 15 numeri di Kaprekar.

(define (kaprekar1milione)
  (setq out '())
  (for (m 1 1000000)
    (if (kaprekar? m) (setq out (append (list m) out)))
  )
  (println (reverse out))
  (println "Fino a 1000000 ci sono " (length out) " numeri di Kaprekar.")
)

(kaprekar1milione)
;-> (1 9 45 55 99 297 703 999 2223 2728 4879 4950 5050 5292 7272 7777 9999 17344 22222
;->  38962 77778 82656 95121 99999 142857 148149 181819 187110 208495 318682 329967 351352
;->  356643 390313 461539 466830 499500 500500 533170 538461 609687 627615 643357 648648
;->  670033 681318 791505 812890 818181 851851 857143 961038 994708 999999)
;-> Fino a 1000000 ci sono 54 numeri di Kaprekar.

(time (kaprekar1milione))
;-> 11532 (millisecondi)


-------------
NUMERI FELICI
-------------

Un numero felice è definito dal seguente processo:
Iniziando con un numero intero positivo, sostituisci il numero con la somma dei quadrati delle sue cifre e ripeti il processo fino a quando il numero è uguale a 1 (dove rimarrà), o si genera un ciclo infinito che non include 1. Quei numeri per cui questo processo finisce in 1 sono numeri felici, mentre quelli che non terminano in 1 sono numeri infelici.
Vediamo un esempio:

(setq lista '())
;-> ()
(setq x 31)
;-> 31
(setq s (string x))
;-> "31"
(setq a (slice (explode s) 0))
;-> ("3" "1")
(setq b (apply + (map (lambda (x) (* (int x) (int x)))  a)))
;-> 10 (3*3 + 1*1)

(cond ((= b 1) (setq felice true) (setq continua nil))
      ((!= (ref b lista) nil) (setq felice nil) (setq continua nil))
      (true (setq lista (cons b lista)) (setq n b))
)

se (b = 1) allora (felice = true) e (continua = nil)                  ;(il numero è felice)
se (b si trova nella lista) allora (felice = nil) e (continua = nil)  ;(il numero non è felice)
altrimenti inserisci il numero nella lista e continua                 ;continua creazione lista

(define (felice? n)
  (setq continua true)
  (setq lista '())
  (setq x n)
  (while (= continua true)
    (setq s (string x))
    (setq a (slice (explode s) 0))
    (setq b (apply + (map (lambda (x) (* (int x) (int x)))  a)))
    (cond ((= b 1) (setq felice true) (setq continua nil))
          ((!= (ref b lista) nil) (setq felice nil) (setq continua nil))
          (true (setq lista (cons b lista)) (setq x b))
    )
  )
  felice
)

(felice? 10)
;-> true
(felice? 11)
;-> nil
(felice? 31)
;-> true

(define (felici1000)
  (setq out '())
  (for (j 1 1000)
    (if (felice? j) (setq out (append (list j) out)))
  )
  (println (reverse out))
  (println "Fino a 1000 ci sono " (length out) " numeri felici.")
)

(felici1000)
;-> (1 7 10 13 19 23 28 31 32 44 49 68 70 79 82 86 91 94 97 100 103 109 129 130 133 139
;->  167 176 188 190 192 193 203 208 219 226 230 236 239 262 263 280 291 293 301 302
;->  310 313 319 320 326 329 331 338 356 362 365 367 368 376 379 383 386 391 392 397
;->  404 409 440 446 464 469 478 487 490 496 536 556 563 565 566 608 617 622 623 632
;->  635 637 638 644 649 653 655 656 665 671 673 680 683 694 700 709 716 736 739 748
;->  761 763 784 790 793 802 806 818 820 833 836 847 860 863 874 881 888 899 901 904
;->  907 910 912 913 921 923 931 932 937 940 946 964 970 973 989 998 1000)
;-> Fino a 1000 ci sono 143 numeri felici.


-----------------
NUMERI PRIMORIALI
-----------------

I numeri primoriali sono quelli formati moltiplicando i numeri primi successivi.
La serie di numeri primoriali vale:

   primoriale (0) = 1 (per definizione)
   primoriale (1) = 2 (2)
   primoriale (2) = 6 (2 * 3)
   primoriale (3) = 30 (2 * 3 * 5)
   primoriale (4) = 210 (2 * 3 * 5 * 7)
   primoriale (5) = 2310 (2 * 3 * 5 * 7 * 11)
   primoriale (6) = 30030 (2 * 3 * 5 * 7 * 11 * 13)
   ...

Per esprimere questo matematicamente, primoriale(n) è il prodotto dei primi n numeri primi (successivi):

primorial(n) = prod[prime(k)] (con k che va da 1 a n)

Un metodo semplice, anche se relativamente lento, è quello di generare n numeri primi con il metodo di Eratostene e poi calcolare i numeri primoriali.
Il teorema dei numeri primi ci dice che l'ennesimo numero primo viene delimitato dalla seguente espressione:

n*ln(n) + n*ln(ln(n)) - 1 < p(n) < n*ln(n) + n*ln(ln(n)) per n ≥ 6

La funzione è la seguente (utilizza i big integer):

(define (primoriale n bool)
  (cond ((= n 0L) (setq pn '(1L)))
        ((= n 1L) (setq pn '(1L 2L)))
        (
          (if (<= n 6L) (setq maxnum 20L)
              (setq maxnum (ceil (mul n (add (log n) (log (log n)))))) ; limite superiore
          )
          ;(println maxnum)
          ; generiamo la lista con tutti i numeri primi esistenti fino a maxnum
          (setq primi (array (+ 1L maxnum) '(true)))
          (setq p 2L)
          (while (<= (* p p) maxnum)
            (if (= (primi p) true))
            (for (i (* p p) maxnum p) (setq (primi i) nil))
            (++ p)
          )
          (setq lista-primi '())
          (for (p 2L maxnum)
            (if (= (primi p) true)
                ;(print p { })
                (setq lista-primi (cons p lista-primi))
            )
          )
          (reverse lista-primi) ; funzione distruttiva (cambia direttamente lista-primi)
          ;(println lista-primi)
          ;(println (length lista-primi))
          (if (> n (length lista-primi)) (println "Errore")
              ; Calcoliamo i numeri primoriali fino a n
              (begin
                (setq pn '(1L))
                (setq sum 1L)
                (for (i 0L (- n 1L))
                  ;(println {i =} i)
                  (for (k 0L i)
                    ;(println k)
                    (setq sum (* sum (nth k lista-primi)))
                  )
                  (setq pn (cons sum pn))
                  (setq sum 1L)
                )
                (reverse pn)
                ; risultato
                (if (= bool true) pn
                    (last pn)
                )
              )
          )
        )
  ); end cond
)

(primoriale 0)
;-> 1L

(primoriale 1)
;-> (1L 2L)

(primoriale 6 true)
;-> (1L 2L 6L 30L 210L 2310L 30030L)

(primoriale 10 true)
;-> (1L 2L 6L 30L 210L 2310L 30030L 510510L 9699690L 223092870L 6469693230L)

(primoriale 20 true)
;-> (1L 2L 6L 30L 210L 2310L 30030L 510510L 9699690L 223092870L 6469693230L 200560490130L
;->  7420738134810L 304250263527210L 13082761331670030L 614889782588491410L 32589158477190044730L
;->  1922760350154212639070L 117288381359406970983270L 7858321551080267055879090L
;->  557940830126698960967415390L)

(primoriale 20)
;-> 557940830126698960967415390L

(primoriale 40)
;-> 166589903787325219380851695350896256250980509594874862046961683989710L


---------------
NUMERI PERFETTI
---------------

Un numero è perfetto quando è uguale alla somma dei suoi divisori propri.
Oppure, un numero è perfetto quando è uguale alla metà della somma di tutti i suoi divisori positivi (incluso se stesso).
I divisori propri di un numero sono tutti i divisori del numero tranne il numero stesso.
Ad esempio, i divisori di 6 sono {1,2,3,6}, mentre i divisori propri di 6 sono {1,2,3}.
Inoltre, poichè 1 + 2 + 3 = 6, allora 6 è un numero perfetto.
Si conoscono pochi numeri perfetti perchè diventano enormi velocemente.

Per calcolare questi numeri scriviamo per primo una funzione che restituisce i divisori propri di un numero:

(define (divisori n)
  (setq lista-div '(1L))
  (setq m (sqrt n))
  (setq i 2L)
  (while (<= i m)
      (if (zero? (% n i))   ; se 'i' è divisore di 'n'
          (if (= i (/ n i)) ; se entrambi i divisori sono gli stessi aggiungine uno,
                            ; altrimenti aggiungili entrambi
            (setq lista-div (cons i lista-div))
            (setq lista-div (cons (/ n i) (cons i lista-div)))
          )
      )
      (setq i (+ i 1L))
  )
  (sort lista-div)
)

(divisori 128)
;-> (1 2 4 8 16 32 64)

(divisori 20)
;-> (1 2 4 5 10)

(define (perfetto? n)
  (if (= n (apply + (divisori n))) true nil)
)

(perfetto? 6)
;-> true

(perfetto? 8)
;-> nil

(define (perfetti n)
  (setq res '())
  (for (x 2 n)
    (if (= true (perfetto? x)) (setq res (cons x res)))
  )
  (reverse res)
)

(perfetti 10000)
;-> (6 28 496 8128)

La funzione è corretta, ma molto lenta. Proviamo a scrivere una versione ottimizzata:

(define (perfetto-fast? n)
  (cond ((< n 2) (setq somma nil))
        ((!= (mod n 2) 0) (setq somma nil)) ; i numeri dispari non sono perfetti
        (true (setq somma 1)
              (for (i 2 (sqrt n))
                   (if (= (mod n i) 0) (begin (setq somma (+ somma i))
                                              (setq q (/ n i))
                                              (if (> q i) (setq somma (+ somma q)))
                                        )
                   )
               )
        )
  )
  (= n somma)
)

(perfetto-fast? 6)
;-> true

(perfetto-fast? 8128)
;-> true

(perfetto-fast? 33550336)
;-> true

(define (perfetti-fast n)
  (setq res '())
  (for (x 2 n)
    (if (= true (perfetto-fast? x)) (setq res (cons x res)))
  )
  (reverse res)
)

(perfetti-fast 10000)
;-> (6 28 496 8128)

Non provare ad eseguire (perfetti-fast 35000000) per trovare il prossimo numero perfetto (che vale 33550336) perchè impiega molto tempo (alcune ore sul mio computer).

(time (perfetti-fast 34000000))

Vediamo la differenza di velocità:

(time (perfetti 10000) 100)
;-> 12625.9

(time (perfetti-fast 10000) 100)
;-> 6797.5

(div 12625.9 6797.5)
;-> 1.857432879735197

La funzione "perfetti-fast" è 1.86 volte più veloce della funzione "perfetti".

Nota: i numeri perfetti hanno come espressione binaria p valori uguali a uno seguiti da (p-1) zeri (con p numero primo). Qui il numero tra parentesi denota la base in cui il numero viene espresso:

6(10)        = 110(2)
28(10)       = 11100(2)
496(10)      = 111110000(2)
4128(10)     = 1111111000000(2)
33550336(10) = 1111111111111000000000000(2)

Proviamo con il numero 17 (17 valori 1 seguiti da 16 valori 0)
(binary2decimal "111111111111111110000000000000000")
(perfetto-fast? 8589869056)
;-> true

Quindi possiamo cercare i numeri perfetti con il seguente algoritmo:
1) Prendere il primo numero primo pk ()
2) Costruire il numero binario con pk volte 1 e (pk - 1) volte 0
3) Convertire il numero in decimale
4) Controllare se il numero covertito è perfetto
5) Prendere il successivo numero primo e ripeti dal passo 2)

Prima di tutto definiamo una funzione che converte una stringa binaria in un numero decimale (big integer):

(define (binary2decimal _b)
  (setq _l (length _b))
  (setq _d 0L)
  (setq _r (reverse _b))
  (dostring (_c _r)
    ;(println c { } (char c) { } $idx)
    (setq _d (+ _d (* (int (char _c)) (pow 2 $idx))))
  )
)

(binary2decimal "1111111")
;-> 127L

(binary2decimal "1111111111111000000000000")
;-> 33550336L

Adesso scriviamo la funzione per trovare i numeri perfetti con il nostro algoritmo:

(define (perfetti-primi)
  ; lista di numeri primi (attenzione che la funzione "divisori" è lenta)
  (setq primi '(2L 3L 5L 7L 11L 13L 17L 19L 23L))
  (setq res '())
  (dolist (p primi)
    ; creo il numero binario
    (setq ns (join (list (dup "1" p) (dup "0" (- p 1)))))
    ; converto il numero binario in decimale
    (setq dp (binary2decimal ns))
    ; se il numero decimale è perfetto, allora lo stampo
    (if (= dp (apply + (divisori dp))) (print dp { (} p {), }))
  )
)

(perfetti-primi)
;-> 6L (2L), 28L (3L), 496L (5L), 8128L (7L), 33550336L (13L), 8589869056L (17L), 137438691328L
;-> (19L), nil

(perfetto-fast? 2305843008139952128)
;-> true ; ma ci vuole tanto tempo


----------------
NUMERI AMICABILI
----------------

Due interi N e M sono considerati coppia di numeri amicabili se N != M e la somma dei divisori propri di N è uguale a M e la somma dei divisori propri di M è uguale a N.
I divisori propri di un intero positivo N sono quei numeri, diversi da N, che dividono N senza resto.
Per N > 1 includeranno sempre 1, ma per N == 1 non ci sono divisori propri.

Scrivere una funzione per trovare le coppie di numeri amicabili fino a N = 100.000

(define (somma-divisori n)
  (setq res 0)
  (setq m (sqrt n))
  (setq i 2)
  (while (<= i m)
      (if (zero? (% n i))   ; se 'i' è un divisore di 'n'
          (if (= i (/ n i)) ; se entrambi i divisori sono uguali...
            (setq res (+ res i)) ; aggiungili una volta
            (setq res (+ res i (/ n i))) ; altrimenti aggiungili entrambi
          )
      )
      (setq i (+ i 1))
  )
  res
)

(somma-divisori 10)
;-> 7

(define (somma-divisori-propri n)
  (+ 1 (somma-divisori n))
)

(define (amicabili)
  (for (j 1 100000)
      (setq spd (somma-divisori-propri j))
      (setq spd2 (somma-divisori-propri spd))
      (if (and (= j spd2) (!= spd spd2))
          (println j { } spd)
      )
  )
)

(amicabili)
;-> 220 284
;-> 284 220
;-> 1184 1210
;-> 1210 1184
;-> 2620 2924
;-> 2924 2620
;-> 5020 5564
;-> 5564 5020
;-> 6232 6368
;-> 6368 6232
;-> 10744 10856
;-> 10856 10744
;-> 12285 14595
;-> 14595 12285
;-> 17296 18416
;-> 18416 17296
;-> 63020 76084
;-> 66928 66992
;-> 66992 66928
;-> 67095 71145
;-> 69615 87633
;-> 71145 67095
;-> 76084 63020
;-> 79750 88730
;-> 87633 69615
;-> 88730 79750


-----------------
NUMERI PERNICIOSI
-----------------

Un numero pernicioso è un numero intero positivo il cui conteggio della popolazione è un numero primo.
Il numero di abitanti è il numero di uno (1) nella rappresentazione binaria di un numero intero non negativo.

Esempio
22 (che è 10110 in binario) ha un numero di abitanti pari a 3, che è primo, e quindi 22 è un numero pernicioso.

Funzione per verificare se un numero è primo:

(define (primo? n)
  (= 1 (length (factor n))))

Funzione che conta elementi in una lista:

(define (conta item lst)
    (cond ((null? lst) 0)
          ((= (first lst) item) (+ 1 (conta item (rest lst))))
          (true (conta item (rest lst)))))

(conta 'a '(a b c a n a c a a d f))
;-> 5

Funzione predefinita che conta elementi in una lista:

(count '(a) '(a b c a n a c a a d f))
;-> (5)

Funzione che converte un numero decimale in un numero binario:

(define (decimal2binary n)
  (cond ((zero? n) '())
        (true (cons (% n 2)
                    (decimal2binary (/ n 2))))))

(decimal2binary 63)
;-> (1 1 1 1 1 1)

Funzione che verifica se un numero è pernicioso:

(define (pernicioso? n)
  (setq np (count '(1) (decimal2binary n)))
  (if (= true (primo? (first np))) true nil)
)

(pernicioso? 22)
;-> true

Funzione che calcola i numeri perniciosi fino a n:

(define (pernicioso n)
  (setq res '())
  (for (x 2 n)
    (if (= true (pernicioso? x)) (setq res (cons x res)))
  )
  (reverse res)
)

(pernicioso 25)
;-> (3 5 6 7 9 10 11 12 13 14 17 18 19 20 21 22 24 25)


--------------------
NUMERI DI MUNCHAUSEN
--------------------

Un numero di Munchausen è un numero naturale n la cui somma di cifre (in base 10), ciascuna (tranne la cifra zero) elevata alla potenza di se stessa, è uguale a n.

Ad esempio: 3435 = 3^3 + 4^4 + 3^3 + 5^5

Precalcoliamo i valori delle potenze:

(setq powers (cons '0 (map (lambda (x) (pow x x)) (sequence 1 9))))
;-> (0 1 4 27 256 3125 46656 823543 16777216 387420489)

Facciamo una prova:
(setq a (explode (string 3435)))
;-> ("3" "4" "3" "5")
(setq b (map int a))
;-> (3 4 3 5)
(apply + (map (lambda (x) (nth x powers)) b))
;-> 3435

Adesso definiamo la funzione che verifica se un dato numero è di Munchausen:

(define (munchausen n)
  (apply + (map (lambda (x) (nth x powers)) (map int (explode (string n)))))
)

(munchausen 3435)
;-> 3435

(munchausen 438579088)
;-> 438579088

Infine scriviamo la funzione che ricerca i numeri di Munchausen:

(define (cerca-munchausen m)
  (setq powers (cons '0 (map (lambda (x) (pow x x)) (sequence 1 9))))
  ;-> (0 1 4 27 256 3125 46656 823543 16777216 387420489)
  (dotimes (0 m)
    (if (= i (munchausen i)) (println i))
  )
)

(cerca-munchausen 10000)
;-> 1
;-> 3435
;-> nil

(time (cerca-munchausen 500000000))
;-> 0
;-> 1
;-> 3435
;-> 438579088
;-> 1814539.27 ; millisecondi (circa 30 minuti)


-------------------
SEQUENZA DI COLLATZ
-------------------

La sequenza di numeri di Collatz (o Hailstone) può essere generata da un numero intero positivo iniziale, n da:

   se n è 1, la sequenza termina.
   se n è pari anche allora il successivo n della sequenza vale n / 2
   se n è dispari allora il successivo n della sequenza vale (3 * n) + 1

(define (collatz n)
  (if (= n 1) '(1)
    (cons n (collatz (if (even? n) (/ n 2) (+ 1 (* 3 n)))))))

(define (collatz-lenght n)
  (length (collatz n))
)

(collatz 13123)
;-> (13123 39370 19685 59056 29528 14764 7382 3691 11074 5537 16612 8306 4153 12460
;->  6230 3115 9346 4673 14020 7010 3505 10516 5258 2629 7888 3944 1972 986 493 1480 740
;->  370 185 556 278 139 418 209 628 314 157 472 236 118 59 178 89 268 134 67 202 101 304
;->  152 76 38 19 58 29 88 44 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1)

(collatz-lenght 13123)
;-> 77


------------
PERMUTAZIONI
------------

; =====================================================
; (permutations lst)
; Permutazioni di n elementi
; =====================================================

(define (remove x lst)
  (cond
    ((null? lst) '())
    ((= x (first lst))(remove x (rest lst)))
    (true (cons (first lst) (remove x (rest lst))))))

(define (permutations lst)
  (cond
    ((= (length lst) 1)(list lst))
    (true (apply append(map(lambda (i) (map (lambda (j)(cons i j))
                                            (permutations (remove i lst)))) lst)))))
(permutations '(1 2 3))
;-> ((1 2 3) (2 1 3) (2 3 1) (1 3 2) (3 1 2) (3 2 1))

Come funziona?

Quali sono le permutazioni di una lista e come le troveresti?

Le permutazioni di una lista con un singolo elemento sono la lista stessa.
Le permutazioni di (1 2) sono l'insieme: [(1 2) (2 1)].
Le permutazioni di (1 2 3) sono l'insieme: [(1 2 3) (1 3 2) (2 3 1) (2 1 3) (3 1 2) (3 2 1)]

In generale ci sono n! permutazioni in un elenco di lunghezza n - abbiamo n scelte per il primo elemento, e una volta che abbiamo scelto quello, (n-1) scelte per il secondo elemento, (n-2) per il terzo elemento, e così via. Questa diminuzione dei gradi di libertà ci suggerisce di trovare le permutazioni di un elenco di lunghezza n in termini di permutazioni di un elenco di lunghezza (n - 1), e così via fino a raggiungere le permutazioni di un elenco di elementi singoli.
Si scopre che le permutazioni di una lista sono precisamente l'insieme [elemento anteposto alle permutazioni di [lista - elemento], per ogni elemento nella lista].

Osservando il caso (1 2 3) si conferma che questo è vero - abbiamo 1 che prece (2 3) e (3 2), che sono le permutazioni di (2 3), 2 che precede (1 3) e (3 1) e così via. Questa operazione di anteporre l'elemento alla sottolista potrebbe essere definita come:

(define (prepend j)
  (cons element j))

e l'operazione per applicarlo a tutte le permutazioni della sottolista potrebbe essere:

(map prepend (permutations sublist))

Questa operazione è molto onerosa (considerando che hanno tutti la stessa forma), quindi utilizziamo un approccio lambda che cattura il valore dell'elemento considerato. L'operazione che vogliamo diventa:

(map (lambda (j) (cons element j)) (permutations sublist))

Adesso vogliamo applicare questa operazione ad ogni elemento della lista, quindi utilizziamo la funzione map con un'altra funzione lambda:

(map (lambda (element)
       (lambda (j) (cons element j) (permutations sublist)))
     list)

Sembra che vada tutto bene, ma c'è un problema: ogni ciclo di ricorsione prende un elemento e lo converte in una lista. Questo va bene per una lista di lunghezza 1, ma per liste più lunghe ogni elemento genera un annidamento della lista. Per inserire allo stesso livello ogni permutazione generata dobbiamo utilizzare la funzione (apply append...).
Adesso l'unica cosa che manca è come generare la prima sottolista? Questo viene ottenuto utilizzando la funzione "remove": la sottolista è uguale a (remove element list).
La funzione "remove" elimina l'elemento x dalla lista lst:

(remove '1 '(1 2 3 1 1))
;-> (2 3)

In definitiva l'istruzione completa è la seguente:

(apply append (map (lambda (i) (lambda (j) (cons i j))
                               (permutations (remove i lst))) lst))

che risove tutti i casi tranne quello base che viene preso in conasiderazione da:

((= (length lst) 1)(list lst))

Questo è tutto, ma per capire meglio la funzione "permutations" facciamo un esempio partendo dall'interno e proseguendo verso l'esterno.
Applichiamo l'espressione interna (permutations (remove i lst)) ad uno degli elementi:

(define lst '(1 2 3))
(define i 1)
(permutations (remove i lst))
;-> ((2 3) (3 2))

L'espressione rimuove un elemento e genera, ricorsivamente, le permutazioni del resto della lista.
Adesso applichiamo map con la funzione lambda sulle permutazioni ottenute:

(define j 1)
(map (lambda (j) (cons i j)) (permutations (remove i lst)))
;-> ((1 2 3) (1 3 2))

Quindi il map interno produce tutte le permutazioni per un dato i (in questo caso i=1)
Il map esterno assicura che tutte le permutazioni sono generate considerando tutti gli elementi della lista lst come primo elemento:

(map (lambda (i) (map (lambda (j) (cons i j))
                      (permutations (remove i lst))))
     lst)
;-> (((1 2 3) (1 3 2)) ((2 1 3) (2 3 1)) ((3 1 2) (3 2 1)))

Ma questo genera troppe liste innestate, quindi l'applicazione di append appiattisce una lista di liste:

(append '(1 2) '(3 4) '(5 6))
;-> (1 2 3 4 5 6)

(apply append '(((1 2 3) (1 3 2)) ((2 1 3) (2 3 1)) ((3 1 2) (3 2 1))))
;-> ((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1))

In questo modo otteniamo la lista corretta delle permutazioni.

Anche la seguente funzione calcola le permutazioni, ma con un metodo diverso:

(define (insert lst n e)
  (if (= 0 n)
      (cons e lst)
      (cons (first lst)
            (insert (rest lst) (- n 1) e))))

(define (permutations l)
  (if (null? l) '(())
      (apply append (map (lambda (p)
                           (map (lambda (n)
                                  (insert p n (first l)))
                                (sequence 0 (length p))))
                         (permutations (rest l))))))

(permutations '(1 2 3))
;-> ((1 2 3) (2 1 3) (2 3 1) (1 3 2) (3 1 2) (3 2 1))


------------
COMBINAZIONI
------------

; =====================================================
; (combinazioni k nlst)
; Calcola le combinazioni di k elementi da n elementi
; senza ripetizione
; =====================================================

(define (combinazioni k nlst)
  (cond ((zero? k)     '(()))
        ((null? nlst)  '())
        (true
          (append (map (lambda (k-1) (cons (first nlst) k-1))
                       (combinazioni (- k 1) (rest nlst)))
                  (combinazioni k (rest nlst))))))

(combinazioni 2 '(1 2 3 4))
;-> ((1 2) (1 3) (1 4) (2 3) (2 4) (3 4))

(combinazioni 3 '(1 2 3 4))
;-> ((1 2 3) (1 2 4) (1 3 4) (2 3 4))

(combinazioni 1 '(a b c))
;-> ((a) (b) (c))

(combinazioni 2 '(a b c))
;-> ((a b) (a c) (b c))

(combinazioni 3 '(a b c))
;-> ((a b c))


----------------
REGOLA DI HORNER
----------------

Calcolare il valore del polinomio: y = 6*x^3 - 4*x^2 + 7*x - 19 per x = 3.
La regola di Horner è un algoritmo inventato da William George Horner che permette di valutare un polinomio: Pn(x) = a(0)*x^n + a(1)*x^(n-1) +...+ a(n-1)*x + a(n) svolgendo n addizioni ed n moltiplicazioni (algoritmo ottimale). Infatti è possibile riscrivere il polinomio nella forma:

Pn(x) = a(n) + x*(a(n-1) + x*(a(n-2) + ... + x*(a(1) + a(0)*x)...))

Pertanto, il valore di tale polinomio si può calcolare sfruttando la definizione ricorsiva:

p(0) = a(0)
p(k+1) = p(k)*x + a(k+1)

Scriviamo la funzione prima in stile funzionale:

(define (horner lst x)
  (define (*horner lst x acc)
    (if (null? lst) acc
        (*horner (rest lst) x (+ (* acc x) (first lst)))))
  (*horner (reverse lst) x 0))

(horner '(-19 7 -4 6) '3)
;-> 128

Adesso la scriviamo in stile iterativo:

(define (horner lst-coeffs x)
  (setq acc 0)
  (reverse lst-coeffs) ; funzione distruttiva
  (dolist (el lst-coeffs)
    acc = acc * x + c
    (setq acc (add (mul acc x) el))
  )
  acc
)

(horner '(-19 7 -4 6) '3)
;-> 128


-------------------------------
PROBLEMA DELLO ZAINO (KNAPSACK)
-------------------------------

Il problema dello zaino, detto anche problema di Knapsack, è un problema di ottimizzazione combinatoria definito nel modo seguente:
Dato uno zaino che può supportare determinato peso e dati N oggetti, ognuno dei quali caratterizzato da un peso e un valore, il problema si propone di scegliere quali di questi oggetti mettere nello zaino per ottenere il maggiore valore senza eccedere il peso sostenibile dallo zaino stesso.
In maniera formale la formulazione del problema diventa:
- ognuno degli N oggetti possiede un peso p(i) e un valore v(i)
- il valore W indica il peso massimo sopportabile dallo zaino;
- la possibilità che un oggetto venga inserito o meno nello zaino è espressa dalle variabili intere x(i)
La funzione obiettivo è:

max Z = Sum(ci*xi) (per i=1..N)

Con i vincoli:

W <= Sum(wi*xi) (per i=1..N)

Si indichino con w{i} il peso dell'i-esimo oggetto e con c{i} il suo valore. Si vuole massimizzare il valore totale rispettando il vincolo che il peso totale sia minore o uguale al peso massimo consentito W. Definiamo A(i,j) come il massimo valore che può essere trasportato con uno zaino di capacità j <= W avendo a disposizione solo i primi "i" oggetti.

Si può definire A(i,j) ricorsivamente come segue:

A(0,j) = 0
A(i,0) = 0
A(i,j) = A(i-1,j) se w(i) > j
A(i,j) = max[A(i-1,j), A(i-1,j-w(i)) + c(i)] se w(i) <= j.}

Cerchiamo di risolvere il problema con la forza bruta: calcolo tutte le combinazioni di oggetti con il relativo valore e poi scelgo quella combinazione che ha il valore maggiore (potrebbero esserci più di una combinazione con valore massimo).
I dati sono rappresentati da una lista i cui elementi hanno la seguente struttura:

(nome peso valore)

Supponiamo che la lista iniziale sia la seguente:

(setq k '((a 2 3) (b 3 4) (c 4 5) (d 5 6)))
;-> ((a 2 3) (b 3 4) (c 4 5) (d 5 6))

Definizmo tre funzioni che estraggono le liste dei noni, dei pesi e dei valori:

(define (getNomi lst) (map (fn(x) (first x)) lst))
(define (getPesi lst) (map (fn(x) (first (rest x))) lst))
(define (getValori lst) (map (fn(x) (last x)) lst))

(setq nomi (getNomi k))
;-> (a b c d)
(setq pesi (getPesi k))
;-> (2 3 4 5)
(setq valori (getValori k))
;-> (3 4 5 6)

Questa è la funzione per generare le combinazioni:

(define (combinazioni k nlst)
  (cond ((zero? k)     '(()))
        ((null? nlst)  '())
        (true
          (append (map (lambda (k-1) (cons (first nlst) k-1))
                       (combinazioni (- k 1) (rest nlst)))
                  (combinazioni k (rest nlst))))))

(combinazioni 2 '(3 4 5 6))
;-> ((3 4) (3 5) (3 6) (4 5) (4 6) (5 6))

Dobbiamo generare le combinazioni (dei valori) relative a tutte le possibili liste (quindi quelle di qualunque lunghezza):

(setq allv '())
(for (i 1 (length valori))
  (extend allv (combinazioni i valori))
)
;-> ((3) (4) (5) (6) (3 4) (3 5) (3 6) (4 5) (4 6) (5 6) (3 4 5) (3 4 6) (3 5 6)
;->  (4 5 6) (3 4 5 6))

Notare che il numero di combinazioni da cansiderare vale (2^elementi + 1).
Ad esempio con 22 elementi dobbiamo considerare (pow 2 22) = 4194304 combinazioni.

Adesso dobbiamo calcolare la somma dei valori di ogni sottolista (peso):

(setq sumv (map (fn (x) (apply + x)) allv))
;-> (3 4 5 6 7 8 9 9 10 11 12 13 14 15 18)

Cerchiamo il valore massimo
(setq valmax (apply max sumvOK))
;-> 10

Adesso dobbiamo eliminare tutti i valori che sono superiori al peso massimo W:
(setq W 10)

(setq sumvOK (map (fn(x) (if (> x W) 0 x)) sumv))
;-> (3 4 5 6 7 8 9 9 10 0 0 0 0 0 0)

Troviamo gli indici dei valori che hanno valore massimo (10):
(setq sol-idx (flat (ref-all 10 sumvOK)))
;-> (8)

Adesso cerchiamo i valori che concorrono a creare il valore massimo:
(setq val-max '())
(dolist (el sol-idx)
  (push (allv el) val-max -1)
)
;-> ((4 6))

Troviamo gli indici degli elementi che hanno valore 4 e 6:

(setq ele-idx '())
(dolist (el val-max)
  (setq item '())
  (dolist (x el)
    (setq vv (ref x valori))
    (push (list (nomi vv) (valori vv)) item -1)
  )
  (push item ele-idx -1)
)
;-> (((b 4) (d 6)))

Finalmente abbiamo trovato la soluzione.

Come abbiamo anticipato, si può trovare la soluzione calcolando A(n,W). Per farlo in modo efficiente si può usare una tabella che memorizzi i calcoli fatti precedentemente (memoization o programmazione dinamica). Questa soluzione impiegherà quindi un tempo proporzionale a O(nW)} e uno spazio anch'esso proporzionale a O(nW).

(define (knapsack C items)
  (define (getNomi lst) (map (fn(x) (first x)) lst))
  (define (getPesi lst) (map (fn(x) (first (rest x))) lst))
  (define (getValori lst) (map (fn(x) (last x)) lst))
  (local (table x name weight val cp n nome peso valore)
    ;creazione i vettori dei dati
    (setq n (length items))
    (setq name (getNomi items))
    (setq weight (getPesi items))
    (setq val (getValori items))
    (setq table (array (add n 1) (add C 1) '(0)))
    ;(for (i 0 (sub n 1)) (setf (table i 0) 0))
    ;(for (j 0 (sub n 1)) (setf (table 0 j) 0))
    (for (i 1 n)
      (for (cp 1 C)
        (if (<= (weight (sub i 1)) cp)
            (begin
              ;(println (weight (sub i 1)) { } (val (sub i 1)))
              (setq x (sub cp (weight (sub i 1))))
              (setf (table i cp) (max (add (val (sub i 1)) (table (sub i 1) x))
                                      (table (sub i 1) cp)))
            )
        ;else
            (begin
              (setf (table i cp)  (table (sub i 1) cp))
            )
        )
      )
    )
    ;(println (table n C))
    ; Selezione elementi della soluzione
    (setq res '())
    (setq cp C)
    (setq ptot 0)
    (setq vtot 0)
    (for (i n 1 -1)
      (setq aggiunto (!= (table i cp) (table (sub i 1) cp)))
      (if aggiunto
        (begin
           (setq nome (name (sub i 1)))
           (setq peso (weight (sub i 1)))
           (setq valore (val (sub i 1)))
           (push (list nome peso valore) res)
           (setq ptot (add ptot peso))
           (setq vtot (add vtot valore))
           (setq cp (sub cp peso))
        )
      )
    )
    (println "Valore: " vtot { } "Peso: " ptot)
    res
  )
)

(setq item '((maps 9 150)
             (compass 13 35)
             (water 153 200)
             (sandwich 50 160)
             (glucose 15 60)
             (tin 68 45)
             (banana 27 60)
             (apple 39 40)
             (cheese 23 30)
             (beer 52 10)
             (suntan-cream 11 70)
             (camera 32 30)
             (T-shirt 24 15)
             (trousers 48 10)
             (umbrella 73 40)
             (waterproof-trousers 42 70)
             (waterproof-overclothes 43 75)
             (note-case 22 80)
             (sunglasses 7 20)
             (towel 18 12)
             (socks 4 50)
             (book 30 10)
            )
)

(knapsack 400 items)
;-> Valore: 1030 Peso: 396
;-> ((maps 9 150) (compass 13 35) (water 153 200) (sandwich 50 160) (glucose 15 60)
;->  (banana 27 60) (suntan-cream 11 70) (waterproof-trousers 42 70) (waterproof-overclothes 43 75)
;->  (note-case 22 80) (sunglasses 7 20) (socks 4 50))


----------------------
GIORNO DELLA SETTIMANA
----------------------

Dato anno, mese e giorno, determinare il giorno della settimana.
Esistono diversi algoritmi per risolvere questo problema.

La prima funzione utilizza la regola di Zeller per calcolare il giorno della settimana nel calendario gregoriano prolettico (Domenica = 0)

(define (dayZ year month day)
  (local (adjust mm yy d)
    (setq adjust (/ (- 14 month) 12))
    (setq mm (+ month (* 12 adjust) (- 2)))
    (setq yy (- year adjust))
    (setq d (% (+ day (/ (- (* 13 mm) 1) 5) yy (/ yy 4) (- (/ yy 100)) (/ yy 400)) 7))
  )
)

(dayZ 2019 6 2)
;-> 0

La seconda funzione usa l'algoritmo di Gauss per determinare il giorno della settimana.
Questo metodo vale per il calendario gregoriano.
La funzione seguente è presa dal sito di newLISP (Lutz Mueller).

(define (dayG year month day) ; 0..6 --> Domenica..Sabato
    (letn ( d day
            m (+ (% (- month 3) 12) 1)
            Y (if (> m 10) (- year 1) year)
            y (% Y 100)
            c (/ (- Y y) 100)
            w (add d (floor (sub (mul 2.6 m) 0.2)) y (floor (div y 4)) (floor (div c 4)) (- (mul c 2)))
            w (% w 7)
          )
       (if (< w 0) (inc w 7) w))
)

(dayG 2019 6 2)
;-> 0

La terza funzione usa l'algoritmo di Tomohiko Sakamoto. Anche questo metodo vale per il calendario gregoriano.

Vediamo come funziona l'algoritmo.
Il 1 gennaio dell'anno 1 D.C. è un lunedì nel calendario gregoriano.
Prendiamo in considerazione il primo caso in cui non abbiamo anni bisestili, quindi il numero totale di giorni in ogni anno è 365. Gennaio ha 31 giorni cioè 7*4+3 giorni, quindi il giorno del 1° febbraio sarà sempre 3 giorni prima della giornata del 1° gennaio. Ora febbraio ha 28 giorni (esclusi gli anni bisestili) che è il multiplo esatto di 7 (7 * 4 = 28) Quindi non ci saranno cambiamenti nel mese di marzo e sarà anche 3 giorni prima del giorno del 1° gennaio dell'anno rispettivo. Considerando questo modello, se creiamo un vettore del numero iniziale di giorni per ogni mese, avremo: t = (0, 3, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5).
Ora diamo un'occhiata al caso reale quando ci sono anni bisestili. Ogni 4 anni, il nostro calcolo guadagnerà un giorno in più. Tranne ogni 100 anni quando non lo guadagna. Tranne ogni 400 anni quando lo guadagna. Come inseriamo questi giorni aggiuntivi? Basta aggiungere y / 4 - y / 100 + y / 400. Si noti che tutta la divisione è una divisione intera. Questo aggiunge esattamente il numero richiesto di giorni bisestili. Ma qui c'è un problema, il giorno bisestile è il 29 febbraio e non il 0 gennaio. Ciò significa che l'anno corrente non deve essere conteggiato per il calcolo del giorno bisestile per i primi due mesi. Supponiamo che se il mese fosse gennaio o febbraio, abbiamo sottratto 1 dall'anno. Ciò significa che durante questi mesi, il valore y/4 sarà quello dell'anno precedente e non verrà conteggiato. Se sottraiamo 1 dai valori t[] di ogni mese dopo febbraio? Ciò riempirebbe il vuoto e il problema degli anni bisestili verrà risolto. In altre parole, dobbiamo apportare le seguenti modifiche:
1. t[] diventa (0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4).
2. se m corrisponde a Gen/Feb (ovvero, i mesi < 3) diminuiamo y di 1.
3. l'incremento annuo all'interno del modulo è ora y + y/4 - y/100 + y/400 al posto di y.

Adesso possiamo scrivere la funzione:

(define (dayT year month day) ; 0..6 --> Domenica..Sabato
  (local (t d)
    (setq t '(0 3 2 5 0 3 5 1 4 6 2 4))
    (if (< month 3) (-- year))
    (setq d (% (add year (/ year 4) (/ (- year) 100) (/ year 400) (t (- month 1)) day) 7))
  )
)

(dayT 2019 6 2)
;-> 0

(dayZ 2017 7 13) ;-> 4
(dayG 2017 7 13) ;-> 4
(dayT 2017 7 13) ;-> 4

(dayZ 2012 8 15) ;-> 3
(dayG 2012 8 15) ;-> 3
(dayT 2012 8 15) ;-> 3

(dayZ 2456 12 24) ;-> 0
(dayG 2456 12 24) ;-> 0
(dayT 2456 12 24) ;-> 0


-------------------
TRIANGOLO DI PASCAL
-------------------

Il triangolo di Pascal (o di Tartaglia) è una matrice triangolare formata dai coefficienti binomiali (ossia dai coefficienti dello sviluppo del binomio (a + b) elevato ad una qualsiasi potenza n - Esempio: (a + b)^2 = 1*a^2 + 2*a*b + 1*b^2).

Ecco un triangolo con 9 linee, in cui le righe e le colonne sono state numerate (a base zero):

         colonne
         0  1  2  3  4  5  6  7  8
righe
    0    1  0  0  0  0  0  0  0  0
    1    1  1  0  0  0  0  0  0  0
    2    1  2  1  0  0  0  0  0  0
    3    1  3  3  1  0  0  0  0  0
    4    1  4  6  4  1  0  0  0  0
    5    1  5 10 10  5  1  0  0  0
    6    1  6 15 20 15  6  1  0  0
    7    1  7 21 35 35 21  7  1  0
    8    1  8 28 56 70 56 28  8  1

dove ogni elemento della matrice vale: matrice[riga][colonna] = binomiale[n, k]

Tutte le righe iniziano e terminano con il numero 1.

Ogni riga ha un elemento in più rispetto al suo predecessore.

Definiamo una funzione che calcola il triangolo di Pascal utilizzando i coeffiecienti binomiali.
La prima funzione permette di calcolare il coefficiente binomiale di n,k.

(define (binomiale n k)
  (local (M q)
    (setq M (array (+ n 1) (+ k 1) '(0)))
    (for (i 0 n)
      (setq q (min i k))
      (for (j 0 q)
        (if (or (= j 0) (= j i))
          (setq (M i j) 1)
          (setq (M i j) (+ (M (- i 1) (- j 1)) (M (- i 1) j)))
        )
      )
    )
    (M n k)
  );local
)

(binomiale 5 0)
;-> 1
(binomiale 5 3)
;-> 10

Poi definiamo la funzione che crea il triangolo di Pascal:

(define (pascal n)
  (local (P)
    (setq P (array n n '(0)))
    (for (riga 0 (- n 1))
      (for (i 0 riga)
        (setf (P riga i) (binomiale riga i))
      )
    )
    ; disabilitare la seguente istruzione per calcolare la velocità
    (print-matrix P)
  )
)

Definiamo la funzione che stampa la matrice:

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

(pascal 9)
;-> 1  0  0  0  0  0  0  0  0
;-> 1  1  0  0  0  0  0  0  0
;-> 1  2  1  0  0  0  0  0  0
;-> 1  3  3  1  0  0  0  0  0
;-> 1  4  6  4  1  0  0  0  0
;-> 1  5 10 10  5  1  0  0  0
;-> 1  6 15 20 15  6  1  0  0
;-> 1  7 21 35 35 21  7  1  0
;-> 1  8 28 56 70 56 28  8  1

Il matematico tedesco Stifel ha scoperto che gli elementi del triangolo di Pascal hanno la seguente proprietà (nota come Relazione di Stifel):

Se col = 0 o row = col,
  P(row,col) = 1

Se row >= col,
  P(row,col) = P(row-1,col) + P(row-1,col-1)

dove (row >= 0) e (col >= 0)

Quindi possiamo definire una nuova funzione per calcolare il triangolo di Pascal utilizzando la relazione di Stifel:

(define (pascalS n)
  (local (P)
    (setq P (array n n '(0L)))
    (for (row 0 (- n 1))
      (for (col 0 row)
        (if (or (= col 0) (= row col))
            (setf (P row col) 1L)
            (setf (P row col) (+ (bigint (P (- row 1) col)) (bigint  (P (- row 1) (- col 1)))))
        )
      )
    )
    ; disabilitare la seguente istruzione per calcolare la velocità
    (print-matrix P)
  );local
)

(pascalS 9)
;-> 1  0  0  0  0  0  0  0  0
;-> 1  1  0  0  0  0  0  0  0
;-> 1  2  1  0  0  0  0  0  0
;-> 1  3  3  1  0  0  0  0  0
;-> 1  4  6  4  1  0  0  0  0
;-> 1  5 10 10  5  1  0  0  0
;-> 1  6 15 20 15  6  1  0  0
;-> 1  7 21 35 35 21  7  1  0
;-> 1  8 28 56 70 56 28  8  1

(pascalS 14)
;-> 1    0    0    0    0    0    0    0    0    0    0    0    0    0
;-> 1    1    0    0    0    0    0    0    0    0    0    0    0    0
;-> 1    2    1    0    0    0    0    0    0    0    0    0    0    0
;-> 1    3    3    1    0    0    0    0    0    0    0    0    0    0
;-> 1    4    6    4    1    0    0    0    0    0    0    0    0    0
;-> 1    5   10   10    5    1    0    0    0    0    0    0    0    0
;-> 1    6   15   20   15    6    1    0    0    0    0    0    0    0
;-> 1    7   21   35   35   21    7    1    0    0    0    0    0    0
;-> 1    8   28   56   70   56   28    8    1    0    0    0    0    0
;-> 1    9   36   84  126  126   84   36    9    1    0    0    0    0
;-> 1   10   45  120  210  252  210  120   45   10    1    0    0    0
;-> 1   11   55  165  330  462  462  330  165   55   11    1    0    0
;-> 1   12   66  220  495  792  924  792  495  220   66   12    1    0
;-> 1   13   78  286  715 1287 1716 1716 1287  715  286   78   13    1

Per vedere quale funzione è più veloce commentiamo nelle due funzioni la riga che contiene l'istruzione per stampare la matrice:

; (print-matrix P)


(time (pascal 30) 100)
;-> 2914.029

(time (pascalS 30) 100)
;-> 34.966

La seconda funzione è velocissima perchè non calcola tutti i coefficienti binomiali, ma riempie la matrice ricorsivamente con una relazione matematica.

Per finire vediamo come calcolare la riga n-esima del triangolo di Pascal (valida anche per i big integer):

(define (pascaln n)
  (local (out)
    (setq out '(1L))
    (for (k 0 (- n 1))
      (push (/ (* (out k) (- n k)) (+ k 1)) out -1)
    )
    out
  )
)

(pascaln 9)
;-> (1L 9L 36L 84L 126L 126L 84L 36L 9L 1L)

(pascaln 20)
;-> (1L 20L 190L 1140L 4845L 15504L 38760L 77520L 125970L 167960L 184756L 167960L 125970L
;->  77520L 38760L 15504L 4845L 1140L 190L 20L 1L)

Questa funzione sfrutta la seguente identità matemetica sulle combinazioni:

C(n, k+1) = C(n,k) * (n-k) / (k+1)

Quindi iniziamo con C(n, 0) = 1 e poi calcoliamo il resto della riga usando questa identità, cioè moltiplichiamo ogni volta l'elemento precedente per (n-k)/(k+1).
Ricordiamo che il coefficiente binomiale rappresenta il numero di scelte di k elementi tra quelli di un insieme di n elementi (numero di combinazioni semplici).


------------
CODICE MORSE
------------

Il codice Morse è un metodo per trasmettere informazioni, utilizzando sequenze standardizzate di brevi e lunghi segni o impulsi, comunemente noti come punti e linee ("dot and dashes"), per le lettere, i numeri e i caratteri speciali di un messaggio.
Originariamente creato per il telegrafo elettrico di Samuel Morse verso la metà del 1830, fu anche ampiamente utilizzato per le prime comunicazioni radio a partire dal 1890.

Rappresentazione del codice

A  • −         N  − •         0  − − − − −     .  • − • − • −
B  − • • •     O  − − −       1  • − − − −     ,  − − • • − −
C  − • − •     P  • − − •     2  • • − − −     :  − − − • • •
D  − • •       Q  − − • −     3  • • • − −     ?  • • − − • •
E  •           R  • − •       4  • • • • −     =  − • • • −
F  • • − •     S  • • •       5  • • • • •     -  − • • • • −
G  − − •       T  −           6  − • • • •     (  − • − − •
H  • • • •     U  • • −       7  − − • • •     )  − • − − • −
I  • •         V  • • • −     8  − − − • •     {"}  • − • • − •
J  • − − −     W  • − −       9  − − − − •     '  • − − − − •
K  − • −       X  − • • −                      /  − • • − •
L  • − • •     Y  − • − −                      @  • − − • − •
M  − −         Z  − − • •                      !  − • − • − −
                                               " "  "       "

Il codice Morse internazionale è composto da 5 elementi:

1) Impulso breve, punto (dot o "dit"): "dot duration" vale una unità di tempo
2) Impulso lungo, linea (dash o "dah"): "dash duration" vale tre unità di tempo
3) Intervallo di divisione tra dot e dash di un carattere: vale una unità di tempo
4) Intervallo breve (tra le lettere): vale tre unità di tempo
5) Intervallo lungo (tra le parole): vale sette unità di tempo

Il codice Morse viene trasmesso come un codice digitale usando solo due stati (acceso e spento). Il codice Morse può essere rappresentato come un codice binario: 1 acceso e 0 spento. Quindi una sequenza di codice Morse è costituita da una combinazione delle seguenti cinque stringhe di bit:

1) Impulso breve, punto (dot o "dit"): "dot duration" 1
2) Impulso lungo, linea (dash o "dah"): "dash duration" 111
3) Intervallo di divisione tra dot e dash di un carattere: 0
4) Intervallo breve (tra le lettere): 000
5) Intervallo lungo (tra le parole): 0000000

Notare che gli impulsi e gli intervalli (zeri) sono alternati: punti e linee sono sempre separati da uno degli intervalli vuoti e che gli intervalli sono sempre separati da un punto o da una linea.

In termini di spazio invece che di tempo, abbiamo:

1) Un punto (dot) occupa uno spazio "."
2) Una linea (dash) occupa 3 spazi "---"
3) Le parti di ogni lettera sono separate da uno spazio " "
4) Tra due lettere intercorrono 3 spazi. "   "
5) Tra due parole intercorrono 7 spazi.  "       "

Per scrivere le funzioni di conversione abbiamo bisogno di creare due liste di associazione:

; Lista di associazione carattere --> codice morse
(setq alfa-morse '(
("A"  ". -")
("B"  "- . . .")
("C"  "- . - .")
("D"  "- . .")
("E"  ".")
("F"  ". . - .")
("G"  "- - .")
("H"  ". . . .")
("I"  ". .")
("J"  ". - - -")
("K"  "- . -")
("L"  ". - . .")
("M"  "- -")
("N"  "- .")
("O"  "- - -")
("P"  ". - - .")
("Q"  "- - . -")
("R"  ". - .")
("S"  ". . .")
("T"  "-")
("U"  ". . -")
("V"  ". . . -")
("W"  ". - -")
("X"  "- . . -")
("Y"  "- . - -")
("Z"  "- - . .")
("0"  "- - - - -")
("1"  ". - - - -")
("2"  ". . - - -")
("3"  ". . . - -")
("4"  ". . . . -")
("5"  ". . . . .")
("6"  "- . . . .")
("7"  "- - . . .")
("8"  "- - - . .")
("9"  "- - - - .")
("."  ". - . - . -")
(","  "- - . . - -")
(":"  "- - - . . .")
("?"  ". . - - . .")
("="  "- . . . -")
("-"  "- . . . . -")
("("  "- . - - .")
(")"  "- . - - . -")
("\""  ". - . . - .")
("'"  ". - - - - .")
("/"  "- . . - .")
("@"  ". - - . - .")
("!"  "- . - . - -")
(" "  "       ")))

Sottolineato  ". . - - . -"

; Lista di associazione codice morse --> carattere
(setq morse-alfa (map (fn (n) (list (last n) (first n))) alfa-morse))

(lookup "A" alfa-morse)
;-> ". -"
(lookup "−" morse-alfa)
;-> "T"

Adesso possiamo scrivere la funzione che converte un messaggio di testo in una lista di codici morse:

(define (morse2alfa msg)
  (let (out '())
    (dolist (ch (explode msg))
      (if (lookup ch alfa-morse)
          (push (lookup ch alfa-morse) out -1)
          (push "$$$" out -1)
          ;(print (lookup ch alfa-morse){   })
          ;(print "$$$"{   })
      )
    )
    out
  )
)

(setq msg "Testo da tradurre.")
; conversione del messaggio in lettere maiuscole
(setq msg (upper-case msg))

(morse2alfa msg)
;-> ("-" "." ". . ." "-" "- - -" "       " "- . ." ". -" "       " "-" ". - ." ". -"
;->  "- . ." ". . -" ". - ." ". - ." "." ". - . - . -")

Definiamo la funzione inversa che converta da una lista di codici morse ad una lista di caratteri:

(define (alfa2morse msg)
  (let (out '())
    (dolist (ch msg)
      (if (lookup ch morse-alfa)
          (push (lookup ch morse-alfa) out -1)
          (push "$$$" out -1)
      )
    )
    out
  )
)

(join (alfa2morse (morse2alfa msg)))
;-> "TESTO DA TRADURRE."


-------------------
PROBLEMA DI BABBAGE
-------------------

Qual è il più piccolo intero positivo il cui quadrato termina con le cifre 269.696?
Lettera di Charles Babbage a Lord Bowden, 1837.

Notiamo che solo i numeri che terminano con 4 o 6 posoono produrre un quadrato che ha il numero 6 come ultima cifra.

Inoltre risulta:

(sqrt 269696)
;-> 519.3226357477594

quindi qualsiasi numero inferiore a 520 produce un quadrato più piccolo di 269.696.
Allora, il numero più piccolo da provare vale 574.

(define (babbage)
  (catch
    (local (num quadrato)
      (setq num 524)
      (setq quadrato (* num num))
      (while true
        ; eleva il numero al quadrato
        (setq quadrato (* num num))
        ; controlla se è il numero cercato
        (if (= (slice (string quadrato) -6 6) "269696")
          ; numero trovato
          (throw (list num quadrato))
        )
        ; aumenta in numero di 2
        ; adesso il numero termina con la cifra 6
        (setq num (+ num 2))
        ; eleva il numero al quadrato
        (setq quadrato (* num num))
        ; controlla se è il numero cercato
        (if (= (slice (string quadrato) -6 6) "269696")
          ; numero trovato
          (throw (list num quadrato))
        )
        ; aumenta in numero di 8
        ; adesso il numero termina con la cifra 4
        (setq num (+ num 8))
      );while
    );local
  );catch
)

(babbage)
;-> (25264 638269696)

(time (babbage))
;-> 15.627


------------------
CIFRARIO DI CESARE
------------------

Il cifrario di Cesare è uno dei più antichi algoritmi crittografici conosciuti. È un cifrario a sostituzione monoalfabetica in cui ogni lettera del messaggio in chiaro è sostituita nel messaggio cifrato dalla lettera che si trova un certo numero di posizioni dopo (o prima) nell'alfabeto. La sostituzione avviene lettera per lettera, analizzando il testo dall'inizio alla fine.
Il cifrario prende il nome da Giulio Cesare, che lo utilizzava per proteggere i suoi messaggi segreti. Cesare utilizzava in genere una chiave di 3 per il cifrario. A quel tempo il metodo era sicuro perché la maggior parte della gente spesso non era neanche in grado di leggere.

Definiamo il nostro alfabeto:
(setq alfa (explode "ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
;-> ("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")

Definiamo l'alfabeto di partenza:
(setq s1 alfa)
;-> ("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")

Definiamo l'alfabeto di arrivo (con chiave 3):
(setq s2 (rotate (copy alfa) -3))
;-> ("D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" "A" "B" "C")

Creiamo la lista di associazione tra le lettere in chiaro e le lettere cifrate:

(setq codice (transpose (list s1 s2)))
;-> (("A" "D") ("B" "E") ("C" "F") ("D" "G") ("E" "H") ("F" "I") ("G" "J")
;->  ("H" "K") ("I" "L") ("J" "M") ("K" "N") ("L" "O") ("M" "P") ("N" "Q")
;->  ("O" "R") ("P" "S") ("Q" "T") ("R" "U") ("S" "V") ("T" "W") ("U" "X")
;->  ("V" "Y") ("W" "Z") ("X" "A") ("Y" "B") ("Z" "C"))

Creiamo la lista di associazione tra le lettere cifrate e le lettere in chiaro:

(setq anticodice (transpose (list s2 s1)))
;-> (("D" "A") ("E" "B") ("F" "C") ("G" "D") ("H" "E") ("I" "F") ("J" "G")
;->  ("K" "H") ("L" "I") ("M" "J") ("N" "K") ("O" "L") ("P" "M") ("Q" "N")
;->  ("R" "O") ("S" "P") ("T" "Q") ("U" "R") ("V" "S") ("W" "T") ("X" "U")
;->  ("Y" "V") ("Z" "W") ("A" "X") ("B" "Y") ("C" "Z"))

Funzione di conversione da chiaro a cirato:

(define (chiaro-cifrato msg)
  (let (out '())
    (dolist (ch (explode (upper-case msg)))
      (if (lookup ch codice)
          (push (lookup ch codice) out -1)
          (push "$" out -1)
      )
    )
    (join out)
  )
)

(setq msg "Testo da tradurre")

(chiaro-cifrato msg)
;-> "WHVWR$GD$WUDGXUUH"

Funzione di conversione da cifrato a chiaro:

(define (cifrato-chiaro msg)
  (let (out '())
    (dolist (ch (explode (upper-case msg)))
      (if (lookup ch anticodice)
          (push (lookup ch anticodice) out -1)
          (push "$" out -1)
      )
    )
    (join out)
  )
)

(cifrato-chiaro "WHVWR$GD$WUDGXUUH")
;-> "TESTO$DA$TRADURRE"

Scriviamo una funzione generica che codifica e decodifica ed ha come parametro la chiave (numero):

(define (cesare msg tipo key)
  (local (s1 s2 codice anticodice)
    (setq out '())
    (setq s1 (explode "ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
    (setq s2 (rotate (copy s1) (- key)))
    (setq codice (transpose (list s1 s2)))
    (setq anticodice (transpose (list s2 s1)))
    (cond ((= tipo 0)
           (dolist (ch (explode (upper-case msg)))
              (if (lookup ch codice)
                  (push (lookup ch codice) out -1)
                  (push "$" out -1)
              )
           ))
          ((= tipo 1)
           (dolist (ch (explode (upper-case msg)))
              (if (lookup ch anticodice)
                  (push (lookup ch anticodice) out -1)
                  (push "$" out -1)
              )
           ))
          (true (println "tipo: 0 -> cifra, 1 -> decifra"))
    );cond
    (join out)
  ); local
)

(cesare "TESTO DA TRADURRE" 0 3)
;-> "WHVWR$GD$WUDGXUUH"

(cesare "WHVWR$GD$WUDGXUUH" 1 3)
;-> "TESTO$DA$TRADURRE"

(cesare "newLISP is great" 0 6)
;-> "TKCROYV$OY$MXKGZ"

(cesare "TKCROYV$OY$MXKGZ" 1 6)
;-> "newLISP$IS$GREAT"

(cesare "newLISP is great" 2 6)
;-> tipo: 0 -> cifra, 1 -> decifra


--------------------
CIFRARIO DI VIGENERE
--------------------

Il cifrario di Vigenère è il più semplice dei cifrari polialfabetici. Il metodo è una generalizzazione del cifrario di Cesare: invece di spostare la lettera da cifrare di un numero fisso di posti, questa viene spostata di un numero di posti variabile, determinato in base ad una parola chiave, che deve essere conosciuta sia dal mittente che dal destinatario. La chiave (detta anche "verme") deve essere ripetuta per tutta la lunghezza del messaggio.
Per esempio:

Testo in chiaro: RICERCARETESORO
Verme          : VERMEVERMEVERMEVE
Testo cifrato  : MMTQVXEIQXZWFDS

Il testo cifrato si ottiene spostando la lettera chiara di un numero fisso di caratteri, pari al numero ordinale della lettera corrispondente del verme. Di fatto si esegue una somma aritmetica tra l'ordinale dei caratteri in chiaro (A = 0, B = 1, C = 2...) e quello del verme. Superando l'ultima lettera, Z, si ricomincia dalla A, secondo la logica delle aritmetiche modulari.

Il vantaggio rispetto ai cifrari monoalfabetici (come il cifrario di Cesare) è dovuto al fatto che il testo è cifrato con n alfabeti cifranti. In questo modo, la stessa lettera viene cifrata (se ripetuta consecutivamente) n volte e questo rende più complessa la crittoanalisi del testo.

Possiamo usare una funzione matematica per la cifratura e la decifratura:

L = Lunghezza del cifrario = Numero caratteri alfabeto (26)

Numero prima lettera del cifrario "A" = 0

Numero ultima lettera del cifrario "Z" = 25

a = Numero della lettera della parola in Chiaro (0-25)

b = Numero della lettera della parola Chiave/Verme (0-25)

c = Numero della lettera della parola Cifrata (0-25)

Formula per cifrare/criptare: n = a + b (mod L)

Formula per decifrare/decriptare: n = c - b + L

r = floor(n / L)

x = n - ( L * r ) = Numero della lettera della parola in Chiaro/Cifrata (0-25)

La funzione si basa sulla somma/sottrazione dei numeri delle lettere e sulla divisione per la lunghezza del cifrario per ottenere il numero della lettera cercata. Per avere sempre un numero n positivo (anche per la decriptazione) basta aggiungere la lunghezza del cifrario L, in quanto verrà poi eliminata grazie al metodo con cui calcoliamo r.

Esempio di criptazione per il carattere "R":

L = 26
a[R] = 17
b[V] = 21
n = 17 + 21 = 38
r = 38 / 26 = 1,461... = 1
x = 38 - ( 26 * 1 ) = 38 - 26 = 12
lettera(12) = M

Esempio di decriptazione per il carattere "M":

L = 26
b[V] = 21
c[M] = 12
n = 12 - 21 + 26 = 17
r = 17 / 26 = 0,653... = 0
x = 17 - ( 26 * 0 ) = 17 - 0 = 17
lettera(17) = R

; messaggio in chiaro
(setq msg "RICERCARETESORO")
; costruzione il cifrario
(setq cifrario "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
;-> "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
(setq lettere (explode cifrario))
;-> ("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M"
;->  "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")
; liste di associazione lettera <--> numero
(setq char-num (map (fn (x) (list x $idx)) (explode cifrario)))
;-> (("A" 0) ("B" 1) ("C" 2) ("D" 3) ("E" 4) ("F" 5) ("G" 6)
;->  ("H" 7) ("I" 8) ("J" 9) ("K" 10) ("L" 11) ("M" 12) ("N" 13)
;->  ("O" 14) ("P" 15) ("Q" 16) ("R" 17) ("S" 18) ("T" 19) ("U" 20)
;->  ("V" 21) ("W" 22) ("X" 23) ("Y" 24) ("Z" 25))
(setq num-char (map (fn (x) (list $idx x)) (explode cifrario)))
;-> ((0 "A") (1 "B") (2 "C") (3 "D") (4 "E") (5 "F") (6 "G") (7 "H")
;->  (8 "I") (9 "J") (10 "K") (11 "L") (12 "M") (13 "N") (14 "O")
;->  (15 "P") (16 "Q") (17 "R") (18 "S") (19 "T") (20 "U") (21 "V")
;->  (22 "W") (23 "X") (24 "Y") (25 "Z"))
; la chiave è il valore del verme ripetuto per tutta la lunghezza del messaggio
(setq chiave (slice (dup verme (+ (/ (length msg) (length verme)) 1)) 0 (length msg) 1))
;-> "VERMEVERMEVERME"
(setq L (length cifrario))
;-> 26

cifratura:

(dolist (el (explode msg))
  (setq a (lookup el char-num))
  (setq b (lookup (chiave $idx) char-num))
  ;(println a { } b)
  (setq n (% (+ a b) L))
  (setq r (/ n L))
  (setq x (- n (* L r)))
  ;(println n { } r { } x)
  (print (lookup x num-char))
)
;-> MMTQVXEIQXZWFDS

Adesso scriviamo le due funzioni di cifratura/decifratura tenendo conto dei caratteri del messaggio che non si trovano nel cifrario (alfabeto). Inoltre aggiungiamo uno spazio " " al nostro alfabeto.

Funzione di cifratura:

(define (vige-cifra msg verme)
  (local (cifrario lettere char-num num-char chiave L out)
    (setq out '())
    (setq msg (upper-case msg))
    (setq verme (upper-case verme))
    ; costruzione del cifrario
    (setq cifrario "ABCDEFGHIJKLMNOPQRSTUVWXYZ ")
    (setq lettere (explode cifrario))
    ; liste di associazione lettera <--> numero
    (setq char-num (map (fn (x) (list x $idx)) (explode cifrario)))
    (setq num-char (map (fn (x) (list $idx x)) (explode cifrario)))
    ; la chiave è il valore del verme ripetuto per tutta la lunghezza del messaggio
    (setq chiave (slice (dup verme (+ (/ (length msg) (length verme)) 1)) 0 (length msg) 1))
    (setq L (length cifrario))
    ; ciclo di cifratura del messaggio
    (dolist (el (explode msg))
      ; controllo caratteri sconosciuti
      (cond ((or (nil? (lookup el char-num)) (nil? (lookup (chiave $idx) char-num)))
             (push "$" out -1)
            )
            (true
              (setq a (lookup el char-num))
              (setq b (lookup (chiave $idx) char-num))
              ;(println a { } b)
              (setq n (% (+ a b) L))
              (setq r (/ n L))
              (setq x (- n (* L r)))
              ;(println n { } r { } x)
              ;(print (lookup x num-char))
              (push (lookup x num-char) out -1)
            )
      );cond
    );dolist
    (join out)
  );local
)

(setq msg "CIFRARIO DI VIGENERE")
(vige-cifra msg "VERME")
;-> "XMWCELMELHCDLUKZRVCI"

(define (vige-decifra msg verme)
  (local (cifrario lettere char-num num-char chiave L out)
    (setq out '())
    (setq msg (upper-case msg))
    (setq verme (upper-case verme))
    ; costruzione del cifrario
    (setq cifrario "ABCDEFGHIJKLMNOPQRSTUVWXYZ ")
    (setq lettere (explode cifrario))
    ; liste di associazione lettera <--> numero
    (setq char-num (map (fn (x) (list x $idx)) (explode cifrario)))
    (setq num-char (map (fn (x) (list $idx x)) (explode cifrario)))
    ; la chiave è il valore del verme ripetuto per tutta la lunghezza del messaggio
    (setq chiave (slice (dup verme (+ (/ (length msg) (length verme)) 1)) 0 (length msg) 1))
    (setq L (length cifrario))
    ; ciclo di cifratura del messaggio
    (dolist (el (explode msg))
      ; controllo caratteri sconosciuti
      (cond ((or (nil? (lookup el char-num)) (nil? (lookup (chiave $idx) char-num)))
             (push "$" out -1)
            )
            (true
              (setq c (lookup el char-num))
              (setq b (lookup (chiave $idx) char-num))
              ;(println c { } b)
              (setq n (+ (- c b) L))
              (setq r (/ n L))
              (setq x (- n (* L r)))
              ;(println n { } r { } x)
              ;(print (lookup x num-char))
              (push (lookup x num-char) out -1)
            )
      );cond
    );dolist
    (join out)
  );local
)

(setq msg "XMWCELMELHCDLUKZRVCI")
(vige-decifra msg "VERME")
;-> "CIFRARIO DI VIGENERE"


---------
ANAGRAMMI
---------

Quando due o più parole sono composte dagli stessi caratteri, ma in un ordine diverso, vengono chiamate anagrammi.
Usando l'elenco di parole: http://wiki.puzzlers.org/pub/wordlists/unixdict.txt trovare l'insieme di anagrammi che ha il maggior numero di parole (elementi).

Leggiamo tutto il file in una stringa:
(setq datafile (read-file "unixdict1.txt"))

Trasformiamo questa stringa in una lista di stringhe delimitate dal carattere di fine linea (eol - end of line). La funzione "parse" fa proprio questo, suddivide una stringa in sottostringhe basandosi su un delimitatore (in windows il delimitatore di fine linea è "\r\n", mentre su UNIX è "\n"):

(setq data (parse datafile "\r\n"))

Se volessi convertire le stringhe in simboli:
(setq data (map sym data))
;-> (10th 1st 2nd 3rd 4th 5th 6th 7th 8th 9th a a&m a&p a's aaa aaas aarhus aaron aau
;->  aba ababa aback abacus abalone abandon abase abash abate abater abbas abbe abbey
;->  abbot abbott abbreviate abc abdicate abdomen abdominal abduct abe abed abel abelian
;->  abelson aberdeen abernathy aberrant aberrate abet)

Creazione di una lista ordinata in cui ogni elemento è formato dalla parola ordinata e dalla parola di partenza:
(setq lst (sort (map (fn (x) (list (join (sort (explode x))) x)) data)))
;-> (("&am" "a&m") ("&ap" "a&p") ("'as" "a's") ("01ht" "10th")
;->  ("1st" "1st") ("2dn" "2nd") ("3dr" "3rd") ("4ht" "4th")
;->  ("5ht" "5th") ("6ht" "6th") ("7ht" "7th") ("8ht" "8th")
;->  ("9ht" "9th") ("a" "a") ("aaa" "aaa") ("aaabb" "ababa")
;->  .......

Scriviamo una funzione che utilizza un metodo molto simile al Run-Length Encoding: raggruppa le parole che hanno lo stesso anagramma:

(define (rle lst)
  (local (palo conta ana out)
    (cond ((= lst '()) '())
          (true
           (setq out '())
           (setq ana '())
           (setq palo (first (first lst)))
           (setq conta 0)
           (dolist (el lst)
              ; se l'elemento è uguale al precedente aumentiamo il suo conteggio
              ; e aggiungiamo l'anagramma alla lista degli anagrammi
              (if (= (first el) palo)
                  (begin (++ conta)
                         (push (last el) ana -1)
                  )
                  ; altrimenti costruiamo la lista (conta ana)
                  ; poi la aggiungiamo al risultato
                  ; e azzeriamo le variabili
                  (begin (push conta ana)
                         (push ana out -1)
                         (setq conta 1)
                         (setq palo (first el))
                         (setq ana (rest el))
                  )
              )
           )
           ; aggiungiamo l'ultima coppia di valori al risultato
           (push conta ana)
           (push ana out -1)
          )
    )
    out
  )
)

(rle lst)
;-> ((1 "a&m") (1 "a&p") (1 "a's") (1 "10th") (1 "1st") (1 "2nd") (1 "3rd")
;->  (1 "4th") (1 "5th") (1 "6th") (1 "7th") (1 "8th") (1 "9th") (1 "a") (1 "aaa")
;->  .....

Quindi la soluzione è la seguente:

  (silent (setq datafile (read-file "unixdict.txt")))
  (silent (setq data (parse datafile "\n")))
  (silent (setq lst (sort (map (fn (x) (list (join (sort (explode x))) x)) data))))
  (silent (rle lst))
  (slice (sort (rle lst) >) 0 10)

Scriviamo la funzione:

(define (solveAna)
  (setq datafile (read-file "unixdict.txt"))
  (setq data (parse datafile "\n"))
  (setq lst (sort (map (fn (x) (list (join (sort (explode x))) x)) data)))
  (rle lst)
  (slice (sort (rle lst) >) 0 10)
)

(solveAna)
;-> ((5 "evil" "levi" "live" "veil" "vile")
;->  (5 "elan" "lane" "lean" "lena" "neal")
;->  (5 "caret" "carte" "cater" "crate" "trace")
;->  (5 "angel" "angle" "galen" "glean" "lange")
;->  (5 "alger" "glare" "lager" "large" "regal")
;->  (5 "abel" "able" "bale" "bela" "elba")
;->  (4 "resin" "rinse" "risen" "siren")
;->  (4 "pare" "pear" "rape" "reap")
;->  (4 "nepal" "panel" "penal" "plane")
;->  (4 "mate" "meat" "tame" "team"))

(time (solveAna))
;-> 265.205 ;la funzione è molto veloce.

Usando il file "60000_parole_italiane.txt" otteniamo:

(solveAna)
;-> ((9 "avresti" "restavi" "stivare" "svitare" "versati"
;->     "vestira" "viraste" "vistare" "vistera")
;->  (8 "riavesti" "stiverai" "sviterai" "vestiari" "vestirai"
;->     "visitare" "visitera" "visterai")
;->  (8 "aperti" "aprite" "pareti" "patrie" "perita"
;->     "pietra" "rapite" "ripeta")
;->  (7 "cernite" "cretine" "incerte" "recenti" "recinte" "tenerci" "trincee")
;->  (7 "cavero" "covare" "covera" "creavo" "recavo" "revoca" "vorace")
;->  (7 "argenti" "girante" "granite" "ingrate" "integra" "regnati" "ritenga")
;->  (6 "piastre" "prestai" "rapiste" "sparite" "sperati" "spirate")
;->  (6 "piastra" "rapasti" "raspati" "sparati" "sparita" "spirata")
;->  (6 "perso" "porse" "poser" "preso" "prose" "spero")
;->  (6 "parati" "patria" "pirata" "rapati" "rapita" "tarpai"))

Adesso scriviamo una funzione che controlla se due parole sono anagrammi l'una dell'altra:

(define (anagram? str1 str2)
  (if (or (null? str1) (null? str2)) nil
      (if (!= (length str1) (length str2)) nil
          (if (= (sort (explode str1)) (sort (explode str2)))
              true
              nil
          )
      )
  )
)

(anagram? "pippo" "poppi")
;-> true

(anagram? "abcdefghi" "abcdefghij")
;-> nil

(anagram? "abcdefghi" "abcdefghj")
;-> nil

(time (anagram? "pippipappopoppi" "poppipappopippi") 10000)
;-> 71.007

Se le parole utilizzano solo le lettere maiuscole, allora possiamo scrivere la funzione con un altro algoritmo:

(define (anagram? str1 str2)
  (local (vec ret)
    (if (or (null? str1) (null? str2)) (setq ret nil)
        (if (!= (length str1) (length str2)) (setq ret nil)
          (begin
            (setq ret true)
            (setq str1 (upper-case str1))
            (setq str2 (upper-case str2))
            (setq vec (array 26 '(0)))
            (dostring (ch str1) (++ (vec (- ch 65))))
            (dostring (ch str2) (-- (vec (- ch 65))))
            (while (and ret (< i (length str1)))
               (if (!= (vec i) 0) (setq ret nil))
               (++ i)
            )
          )
        )
    )
    ;(println vec)
    ret
  );local
)

(anagram? "pippo" "poppi")
;-> true

(anagram? "abcdefghi" "abcdefghij")
;-> nil

(anagram? "abcdefghi" "abcdefghj")
;-> nil

(time (anagram? "pippipappopoppi" "poppipappopippi") 10000)
;-> 73.007

Per finire vediamo due funzioni per generare tutti gli anagrammi di una parola.
Il primo dei due algoritmi è stato fornito da Sam Cox e funziona direttamente sulla stringa stessa. Sottosezioni ricorsive della stringa vengono esplose, ruotate e poi unite per formare una nuova stringa.

(define (anagrams s)
    (if (<= (length s) 1)
        (list s)
        (flat (map (fn (n) (aux (rotate-string s n)))
                          (sequence 1 (length s))))))

(define (aux rs)
    (map (fn (x) (append (first rs) x)) (anagrams (rest rs))))

(define (rotate-string s n)
    (join (rotate (explode s) n)))

(anagrams "lisp")
;-> ("psil" "psli" "pils" "pisl" "plsi" "plis" "silp" "sipl" "slpi"
;->  "slip" "spil" "spli" "ilps" "ilsp" "ipsl" "ipls" "islp" "ispl"
;->  "lpsi" "lpis" "lsip" "lspi" "lips" "lisp")

Il secondo algoritmo è un po 'più lento ma si basa, su un algoritmo di permutazioni generalmente applicabile. La funzione permutazioni genera tutte le possibili permutazioni di offset nella stringa, quindi applica tali permutazioni.

(define (permutations lst)
  (if (= (length lst) 1)
   lst
   (apply append (map (fn (rot) (map (fn (perm) (cons (first rot) perm))
      (permutations (rest rot))))
    (rotations lst)))))

(define (rotations lst)
  (map (fn (x) (rotate lst)) (sequence 1 (length lst))))

(define (anagrams str)
  (map (fn (perm) (select str perm))
     (permutations (sequence 0 (- (length str) 1)))))

(anagrams "lisp")
;-> ("psil" "psli" "pils" "pisl" "plsi" "plis" "silp" "sipl" "slpi"
;->  "slip" "spil" "spli" "ilps" "ilsp" "ipsl" "ipls" "islp" "ispl"
;->  "lpsi" "lpis" "lsip" "lspi" "lips" "lisp")

Nota: numero di anagrammi = fattoriale(numero di caratteri)


------------------
NUMERI PRIMI CUBAN
------------------

Il nome "cuban" non ha nulla a che fare con Cuba, ma ha a che fare con il fatto che i cubi (le terze potenze) hanno un ruolo nella sua definizione.

I primi cuban sono tutti i numeri primi p che soddisfano:

p = (x^3 - y^3)/(x - y),    dove x = y + 1

I numeri primi cuban sono stati nominati nel 1923 da Allan Joseph Champneys Cunningham.

La seguente funzione brute-force è abbastanza veloce per trovare i numeri primi cubani sotto a 10000:

(define (isprime? n)
  (if (< n 2) nil
    (if (= 1 (length (factor n))))))

(define (primi_cuban N)
  (local (cubani cubo1 cubo2 conta i diff)
    (setq cubani (array (+ N 1) '(0L)))
    (setq cubo1 1L)
    (setq conta 0)
    (setq i 1L)
    (catch
      (while true
        (setq cubo2 (* i i i))
        (setq diff (- cubo2 cubo1))
        (if (isprime? diff)
          (begin
            (if (<= conta N) (setf (cubani conta) diff))
            (if (= conta N) (throw nil))
            (++ conta)
          )
        )
        (setq cubo1 cubo2)
        (++ i)
      )
    );catch
    cubani
  );local
)

(primi_cuban 100)
;-> (7L 19L 37L 61L 127L 271L 331L 397L 547L 631L 919L 1657L 1801L 1951L 2269L 2437L
;->  2791L 3169L 3571L 4219L 4447L 5167L 5419L 6211L 7057L 7351L 8269L 9241L 10267L 11719L
;->  12097L 13267L 13669L 16651L 19441L 19927L 22447L 23497L 24571L 25117L 26227L 27361L
;->  33391L 35317L 42841L 45757L 47251L 49537L 50311L 55897L 59221L 60919L 65269L 70687L
;->  73477L 74419L 75367L 81181L 82171L 87211L 88237L 89269L 92401L 96661L 102121L 103231L
;->  104347L 110017L 112327L 114661L 115837L 126691L 129169L 131671L 135469L 140617L
;->  144541L 145861L 151201L 155269L 163567L 169219L 170647L 176419L 180811L 189757L
;->  200467L 202021L 213067L 231019L 234361L 241117L 246247L 251431L 260191L 263737L
;->  267307L 276337L 279991L 283669L 285517L)

(time (primi_cuban 1000))
;-> 46.869
(time (primi_cuban 5000))
;-> 922.045
(time (primi_cuban 10000))
;-> 3797.161
(time (primi_cuban 20000))
;-> 16017.151
(time (primi_cuban 30000))
;-> 37065.96
(time (primi_cuban 50000))
;-> 108592.154
(time (primi_cuban 100000))
;-> 455520.319


--------------
DATA DI PASQUA
--------------

Calcolo della data di pasqua per gli anni 1583 a 4099
La domenica di Pasqua è la domenica successiva alla luna piena Paschal (PFM).
Questo algoritmo è un'interpretazione aritmetica del metod EDS "Easter Dating Method" sviluppato da Ron Mallen 1985.
Poichè i valori vengono ricavati in modo sequenziale da calcoli inter-dipendenti, non modificare l'ordine dei calcoli !
L'operatore / rappresenta la divisione intera, ad esempio: 30 / 7 = 4
Tutte le variabili sono tipi di dati interi.
Per maggiori informazioni: https://www.assa.org.au/edm

(define (pasqua y)
  (local (FirstDig Remain19 temp tA tB tC tD tD)
    (setq FirstDig (/ y 100)) ; prime 2 cifre anno
    (setq Remain19 (% y 19))   ; cifre restanti anno
    ;calcola data PFM
    (setq temp (+ (/ (- FirstDig 15) 2) 202 (- (* 11 Remain19))))
    (if (find FirstDig '(21 24 25 27 28 29 30 31 32 34 35 38))
      (setq temp (- temp 1))
    )
    (if (find FirstDig '(33 36 37 39 40))
      (setq temp (- temp 2))
    )
    (setq temp (% temp 30))
    (setq tA (+ temp 21))
    (if (= temp 29) (setq tA (- tA 1)))
    (if (and (= temp 28) (> Remain19 10)) (setq tA (- tA 1)))
    ; trova la domenica successiva
    (setq tB (% (- tA 19) 7))
    (setq tC (% (- 40 FirstDig) 4))
    (if (= tC 3) (setq tC (+ tC 1)))
    (if (> tC 1) (setq tC (+ tC 1)))
    (setq temp (% y 100))
    (setq tD (% (+ temp (/ temp 4)) 7))
    (setq tE (+ (% (- 20 tB tC tD) 7) 1))
    (setq d (+ tA tE))
    ;data
    (if (> d 31)
      (setq d (- d 31) m 4)
      (setq m 3)
    )
    (list d m y)
  );local
)

(pasqua 2000)
;-> (23 4 2000)

Definiamo una funzione che calcola tutte le domeniche di Pasqua partendo dall'anno x fino all'anno y:

(define (pasque x y)
  (for (i x y)
    (print (pasqua i) { })
    (if (= (% (+ (- i x) 1) 5) 0) (println { }))
  )
  'fine
)

(pasque 2020 2029)
;-> (12 4 2020) (4 4 2021) (17 4 2022) (9 4 2023) (31 3 2024)
;-> (20 4 2025) (5 4 2026) (28 3 2027) (16 4 2028) (1 4 2029)
;-> fine


-----------------
EQUAZIONE DI PELL
-----------------

L'equazione di Pell (detta anche equazione di Pell-Fermat) è un'equazione diofantina della forma:

x^2 - n*y^2 = 1

dove il parametro "n" è un numero intero positivo non quadrato.
L'equazione ha soluzioni intere per x e y.

Trovare la soluzione più piccola dell'equazione di Pell per n = 61, 109, 181, 277.

(define (Pell n)
  (local (z r x y e1 e2 f1 f2 A B t1 t2)
    (setq x (bigint (int (sqrt n))))
    (setq y x)
    (setq z 1L)
    (setq r (* x 2))
    (setq e1 1L e2 0L)
    (setq f1 0L f2 1L)
    (catch
      (while true
        (setq y (bigint (- (* r z) y)))
        (setq z (bigint (/ (- n (* y y)) z)))
        (setq r (bigint (/ (+ x y) z)))
        (setq t1 e1) (setq t2 e2)
        (setq e1 t2)
        (setq e2 (bigint (+ (* t2 r) t1)))
        (setq t1 f1) (setq t2 f2)
        (setq f1 t2)
        (setq f2 (bigint (+ (* t2 r) t1)))
        (setq A f2)
        (setq B e2)
        (setq t1 A) (setq t2 B)
        (setq B t1)
        (setq A (bigint (+ (* t1 x) t2)))
        (if (= (- (* A A) (* B B n)) 1) (throw (list A B)))
        ;(println (format "z = %s\nr = %s\nx = %s\ny = %s" (string z) (string r) (string x) (string y)))
        ;(println (format "e1 = %s\ne2 = %s\nf1 = %s\nf2 = %s" (string e1) (string e2) (string f1) (string f2)))
        ;(println (format "A = %s\nB = %s" (string A) (string B)))
        ;(read-line)
      );while
    );catch
  );local
)

(Pell 61)
;-> (1766319049L 226153980L)

(Pell 109)
;-> (158070671986249L 15140424455100L)

(Pell 181)
;-> (2469645423824185801L 183567298683461940L)

(Pell 277)
;-> (159150073798980475849L 9562401173878027020L)

Se passiamo un numero quadrato, otteniamo un errore:

(Pell 4)
;-> ERR: division by zero
;-> called from user function (Pell 4)

Troviamo le soluzione dell'equazione di Pell per n = [1..100].

(define (Pell100)
  (for (i 1 100)
    (if (= (sqrt i) (int (sqrt i))) (println i {:})
        (println i {:  }(Pell i))
    )
  )
)

(Pell100)
;-> 1:
;-> 2:  (3L 2L)
;-> 3:  (2L 1L)
;-> 4:
;-> 5:  (9L 4L)
;-> 6:  (5L 2L)
;-> 7:  (8L 3L)
;-> 8:  (3L 1L)
;-> 9:
;-> 10:  (19L 6L)
;-> 11:  (10L 3L)
;-> 12:  (7L 2L)
;-> 13:  (649L 180L)
;-> 14:  (15L 4L)
;-> 15:  (4L 1L)
;-> 16:
;-> 17:  (33L 8L)
;-> 18:  (17L 4L)
;-> 19:  (170L 39L)
;-> 20:  (9L 2L)
;-> 21:  (55L 12L)
;-> 22:  (197L 42L)
;-> 23:  (24L 5L)
;-> 24:  (5L 1L)
;-> 25:
;-> 26:  (51L 10L)
;-> 27:  (26L 5L)
;-> 28:  (127L 24L)
;-> 29:  (9801L 1820L)
;-> 30:  (11L 2L)
;-> 31:  (1520L 273L)
;-> 32:  (17L 3L)
;-> 33:  (23L 4L)
;-> 34:  (35L 6L)
;-> 35:  (6L 1L)
;-> 36:
;-> 37:  (73L 12L)
;-> 38:  (37L 6L)
;-> 39:  (25L 4L)
;-> 40:  (19L 3L)
;-> 41:  (2049L 320L)
;-> 42:  (13L 2L)
;-> 43:  (3482L 531L)
;-> 44:  (199L 30L)
;-> 45:  (161L 24L)
;-> 46:  (24335L 3588L)
;-> 47:  (48L 7L)
;-> 48:  (7L 1L)
;-> 49:
;-> 50:  (99L 14L)
;-> 51:  (50L 7L)
;-> 52:  (649L 90L)
;-> 53:  (66249L 9100L)
;-> 54:  (485L 66L)
;-> 55:  (89L 12L)
;-> 56:  (15L 2L)
;-> 57:  (151L 20L)
;-> 58:  (19603L 2574L)
;-> 59:  (530L 69L)
;-> 60:  (31L 4L)
;-> 61:  (1766319049L 226153980L)
;-> 62:  (63L 8L)
;-> 63:  (8L 1L)
;-> 64:
;-> 65:  (129L 16L)
;-> 66:  (65L 8L)
;-> 67:  (48842L 5967L)
;-> 68:  (33L 4L)
;-> 69:  (7775L 936L)
;-> 70:  (251L 30L)
;-> 71:  (3480L 413L)
;-> 72:  (17L 2L)
;-> 73:  (2281249L 267000L)
;-> 74:  (3699L 430L)
;-> 75:  (26L 3L)
;-> 76:  (57799L 6630L)
;-> 77:  (351L 40L)
;-> 78:  (53L 6L)
;-> 79:  (80L 9L)
;-> 80:  (9L 1L)
;-> 81:
;-> 82:  (163L 18L)
;-> 83:  (82L 9L)
;-> 84:  (55L 6L)
;-> 85:  (285769L 30996L)
;-> 86:  (10405L 1122L)
;-> 87:  (28L 3L)
;-> 88:  (197L 21L)
;-> 89:  (500001L 53000L)
;-> 90:  (19L 2L)
;-> 91:  (1574L 165L)
;-> 92:  (1151L 120L)
;-> 93:  (12151L 1260L)
;-> 94:  (2143295L 221064L)
;-> 95:  (39L 4L)
;-> 96:  (49L 5L)
;-> 97:  (62809633L 6377352L)
;-> 98:  (99L 10L)
;-> 99:  (10L 1L)
;-> 100:


----------------------------
PUNTEGGIO NUMERICO (RANKING)
----------------------------

Il punteggio numerico dei concorrenti (ranking) mostra se uno è migliore, uguale o peggiore di un altro in base ai risultati ottenuti in una  o più competizioni.
Il punteggio numerico di un concorrente può essere assegnato in diversi modi:

1) Ordinale. (I concorrenti prendono il successivo numero intero disponibile. I punteggi uguali non sono trattati diversamente).

2) Standard (I punteggi uguali condividono quello che sarebbe stato il loro primo numero ordinale).

3) Denso. (I punteggi uguali condividono il successivo numero intero disponibile).

Scrivere una funzione per ognuno dei tre metodi di calcolo elencati.

Lista di concorrenti e relativi risultati:

44 Solomon
42 Jason
42 Errol
41 Garry
41 Bernard
41 Barry
39 Stephen

Tipi di punteggi:

Ordinal Ranking    Standard Ranking    Dense Ranking
---------------    ----------------    -------------
1  44  Solomon     1  44  Solomon      1  44  Solomon
2  42  Jason       2  42  Jason        2  42  Jason
3  42  Errol       2  42  Errol        2  42  Errol
4  41  Garry       4  41  Garry        3  41  Garry
5  41  Bernard     4  41  Bernard      3  41  Bernard
6  41  Barry       4  41  Barry        3  41  Barry
7  39  Stephen     7  39  Stephen      4  39  Stephen


Modified Ranking   Fractional Ranking
----------------   ------------------
1  44  Solomon     1.0  44  Solomon
3  42  Jason       2.5  42  Jason
3  42  Errol       2.5  42  Errol
6  41  Garry       5.0  41  Garry
6  41  Bernard     5.0  41  Bernard
6  41  Barry       5.0  41  Barry
7  39  Stephen     7.0  39  Stephen

(setq lst '((44 Solomon) (42 Jason) (42 Errol) (41 Garry) (41 Bernard) (41 Barry) (39 Stephen)))

(define (ordinal-rank lst)
  (println "Ordinal rank")
  (for (i 0 (- (length lst) 1))
    (println (format "%d  %d  %s" (+ i 1) (first (lst i)) (string (last (lst i)))))
  )
  'fine
)

(ordinal-rank lst)
;-> Ordinal rank
;-> 1  44  Solomon
;-> 2  42  Jason
;-> 3  42  Errol
;-> 4  41  Garry
;-> 5  41  Bernard
;-> 6  41  Barry
;-> 7  39  Stephen

(define (standard-rank lst)
  (let (j 1)
    (println "Standard rank")
    (for (i 0 (- (length lst) 2))
      (println (format "%d  %d  %s" j (first (lst i)) (string (last (lst i)))))
      (if (< (first (lst (+ i 1))) (first (lst i)))
        (setq j (+ i 2))
      )
    )
    (println (format "%d  %d  %s" j (first (last lst)) (string (last (last lst)))))
  )
  'fine
)

(standard-rank lst)
;-> Standard rank
;-> 1  44  Solomon
;-> 2  42  Jason
;-> 2  42  Errol
;-> 4  41  Garry
;-> 4  41  Bernard
;-> 4  41  Barry
;-> 7  39  Stephen

(define (dense-rank lst)
  (let (j 1)
    (println "Dense rank")
    (for (i 0 (- (length lst) 2))
      (println (format "%d  %d  %s" j (first (lst i)) (string (last (lst i)))))
      (if (< (first (lst (+ i 1))) (first (lst i)))
        (++ j)
      )
    )
    (println (format "%d  %d  %s" j (first (last lst)) (string (last (last lst)))))
  )
  'fine
)

(dense-rank lst)
;-> Dense rank
;-> 1  44  Solomon
;-> 2  42  Jason
;-> 2  42  Errol
;-> 3  41  Garry
;-> 3  41  Bernard
;-> 3  41  Barry
;-> 4  39  Stephen

Proviamo con una diversa lista relativi risultati:

44 Solomon
44 Jason
42 Errol
41 Garry
41 Bernard
39 Barry
39 Stephen

(setq lst '((44 Solomon) (44 Jason) (42 Errol) (41 Garry) (41 Bernard) (39 Barry) (39 Stephen)))

(ordinal-rank lst)
;-> Ordinal rank
;-> 1  44  Solomon
;-> 2  44  Jason
;-> 3  42  Errol
;-> 4  41  Garry
;-> 5  41  Bernard
;-> 6  39  Barry
;-> 7  39  Stephen

(standard-rank lst)
;-> Standard rank
;-> 1  44  Solomon
;-> 1  44  Jason
;-> 3  42  Errol
;-> 4  41  Garry
;-> 4  41  Bernard
;-> 6  39  Barry
;-> 6  39  Stephen

(dense-rank lst)
Dense rank
;-> 1  44  Solomon
;-> 1  44  Jason
;-> 2  42  Errol
;-> 3  41  Garry
;-> 3  41  Bernard
;-> 4  39  Barry
;-> 4  39  Stephen

-----------------
LEGGE DI BENDFORD
-----------------

La legge di Benford, chiamata anche legge della prima cifra, si riferisce alla distribuzione di frequenza delle cifre in molte (ma non tutte) fonti di dati reali.

In questa distribuzione, il numero 1 si presenta come la prima cifra circa il 30% delle volte, mentre i numeri più grandi si verificano in quella posizione meno frequentemente: 9 come prima cifra meno del 5% delle volte. Questa distribuzione delle prime cifre è uguale alle larghezze di una griglia con scala logaritmica.

La legge di Benford riguarda anche la distribuzione prevista per cifre oltre la prima, che si avvicina ad una distribuzione uniforme.

È stato riscontrato che questo risultato si applica a un'ampia varietà di set di dati, tra cui bollette elettriche, indirizzi stradali, quotazioni azionarie, numero di abitanti, tassi di mortalità, lunghezze dei fiumi, costanti fisiche e matematiche e processi descritti dalle leggi di potenza (che sono molto comune in natura). Tende ad essere più preciso quando i valori sono distribuiti su più ordini di grandezza.

Si dice che una serie di numeri soddisfa la legge di Benford se le cifre iniziali (1..9) si verificano con probabilità:

P(d) = log10(d + 1) - log10(d) = log10(1 + 1/d)

(define (P)
  (let (out '())
    (for (i 1 9)
      (push (mul 100 (log (add 1 (div 1 i)) 10)) out -1)
    )
  )
)

(setq bend (P))
;-> (30.10299956639812 17.60912590556812  12.49387366082999 
;->   9.69100130080564  7.918124604762481  6.694678963061322 
;->   5.799194697768673 5.115252244738128  4.575749056067514)

Scriviamo una funzione per calcolare la distribuzione delle prime cifre significative (non zero) in un insieme di numeri, quindi confrontare la distribuzione effettiva rispetto a quella attesa (cioè quella di Bendford). La funzione ha come parametro il nome del file che contiene l'insieme dei numeri.

Come primo esempio utilizziamo come insieme di dati i primi 1000 numeri di fibonacci.
Scriviamo una funzione che crea un file di testo con i primi 1000 numeri di fibonacci.

Funzione che calcola il numero di fibonacci di un numero n:

(define (fibo-i n)
  (local (a b c)
    (setq a 0L b 1L c 0L)
    (for (i 0 (- n 1))
      (setq c (+ a b))
      (setq a b)
      (setq b c)
    )
    a
  )
)

Funzione che crea un file con n numeri di Fibonacci (un numero per ogni riga).

(define (fibfile file n)
  (local (outfile)
    (setq outfile (open file "write"))
    (for (i 1 n)
      (write-line outfile (string (fibo-i i)))
    )
    (close outfile)
  )
)

(fibfile "fibo1000.txt" 1000)
;-> true

Adesso scriviamo la funzione per verificare la legge di Bendford. La prima versione della funzione crea il vettore con le frequenze:

(define (bendford file)
  (local (infile val data)
    (setq data (array 10 '(0)))
    ; leggiamo i numeri dal file
    (setq infile (open file "read"))
    (while (read-line infile)
      ; (current-line) restituisce una stringa
      (setq val (int ((current-line) 0)))
      ;aggiorniamo il vettore delle frequenze
      (++ (data val))
    )
    (close infile)
     data
  )
)

(setq out (bendford "fibo1000.txt"))
;-> (0 301 177 125 96 80 67 56 53 45)

Verifichiamo il risultato:
(apply + out)
;-> 1000

Adesso scriviamo la versione finale:

(define (bendford file)
  (local (infile val data dataB perc-freq-reali perc-freq-attese)
    (setq data (array 10 '(0)))
    ; leggiamo i numeri dal file
    (setq infile (open file "read"))
    (while (read-line infile)
      ; (current-line) restituisce una stringa
      (setq val (int ((current-line) 0)))
      ;aggiorniamo il vettore delle frequenze
      (++ (data val))
    )
    (close infile)
    (setq data (array-list data))
    ; calcoliamo le percentuali delle frequenze reali
    (setq somma (apply add data))
    (setq perc-freq-reali (map (fn (x) (mul 100 (div x somma))) data))
    ;(println perc-freq-reali)
    ; calcoliamo le percentuali delle frequenze attese (Bendford)
    (setq perc-freq-attese '(0))
    (for (i 1 9)
      (push (mul 100 (log (add 1 (div 1 i)) 10)) perc-freq-attese -1)
    )
    ;(println perc-freq-attese)
    ;calcoliamo la differenza tra le due percentuali di ogni cifra
    (setq diff (map sub perc-freq-attese perc-freq-reali))
    ;stampiamo i risultati
    (println {     %att     %real     diff})
    (for (i 1 9)
      (println (format "%d %8.2f %8.2f %+8.2f" 
               i (perc-freq-attese i) (perc-freq-reali i) (diff i)))
    )
    '-----------------------------
  )
)

(bendford "fibo1000.txt")
     %att     %real     diff
1    30.10    30.10    +0.00
2    17.61    17.70    -0.09
3    12.49    12.50    -0.01
4     9.69     9.60    +0.09
5     7.92     8.00    -0.08
6     6.69     6.70    -0.01
7     5.80     5.60    +0.20
8     5.12     5.30    -0.18
9     4.58     4.50    +0.08
-----------------------------

I primi 1000 numeri di Fibonacci rispettano la legge di Bendford.

Proviamo con un altro insieme di dati: i numeri primi.

(bendford "primi5000.txt")
;->      %att     %real     diff
;-> 1    30.10    23.86    +6.24
;-> 2    17.61    22.58    -4.97
;-> 3    12.49    21.94    -9.45
;-> 4     9.69    18.72    -9.03
;-> 5     7.92     2.62    +5.30
;-> 6     6.69     2.70    +3.99
;-> 7     5.80     2.50    +3.30
;-> 8     5.12     2.54    +2.58
;-> 9     4.58     2.54    +2.04
;-> -----------------------------

I primi 5000 numeri Primi non sembra che rispettino la legge di Bendford.

Proviamo con un altro insieme di dati: 10000 cifre decimali di pi greco.

(bendford "pigreco10000.txt")
;->      %att     %real     diff
;-> 1    30.10    10.26   +19.84
;-> 2    17.61    10.21    +7.40
;-> 3    12.49     9.74    +2.75
;-> 4     9.69    10.12    -0.43
;-> 5     7.92    10.46    -2.54
;-> 6     6.69    10.21    -3.52
;-> 7     5.80     9.70    -3.90
;-> 8     5.12     9.48    -4.36
;-> 9     4.58    10.14    -5.56
;-> -----------------------------

Le prime 10000 cifre decimali di pi greco non sembra che rispettino la legge di Bendford.

Proviamo con i primi 100000 numeri.

(define (numeri file n)
  (local (outfile)
    (setq outfile (open file "write"))
    (for (i 1 n)
      (write-line outfile (string i))
    )
    (close outfile)
  )
)

(numeri "numeri100000.txt" 100000)
;-> true

(bendford "numeri100000.txt")
;->      %att     %real     diff
;-> 1    30.10    11.11   +18.99
;-> 2    17.61    11.11    +6.50
;-> 3    12.49    11.11    +1.38
;-> 4     9.69    11.11    -1.42
;-> 5     7.92    11.11    -3.19
;-> 6     6.69    11.11    -4.42
;-> 7     5.80    11.11    -5.31
;-> 8     5.12    11.11    -6.00
;-> 9     4.58    11.11    -6.54
;-> -----------------------------

Le prime cifre dei numeri naturali hanno una distribuzione uniforme.

Proviamo con un altro insieme di dati: la lunghezza dei fiumi italiani (6226).

(bendford "fiumi.txt")
;->      %att     %real     diff
;-> 1    30.10    26.10    +4.00
;-> 2    17.61    12.19    +5.42
;-> 3    12.49    11.05    +1.44
;-> 4     9.69    11.84    -2.15
;-> 5     7.92    10.62    -2.70
;-> 6     6.69     8.79    -2.09
;-> 7     5.80     7.65    -1.85
;-> 8     5.12     6.73    -1.61
;-> 9     4.58     5.04    -0.47
;-> -----------------------------

Le lunghezze dei fiumi seguono abbastanza la legge di Bendford.


----------
CALENDARIO
----------

Unix e Linux hanno il comando "cal" per stampare il calendario corrente. Un programma ancora più completo è GNU "gcal" (con alcune funzionalità esoteriche). Per windows non esiste niente di simile, allora scriviamo una funzione che stampa il calendario dell'anno corrente o di un'anno definito (anno > 1752).
Ci servono due funzioni ausiliarie, una per il calcolo del giorno della settimana a partire da una data e un'altra per calcolare se un anno è bisestile.

Giorno della settimana

(define (giorno year month day) ; 0..6 --> Domenica..Sabato
  (local (t d)
    (setq t '(0 3 2 5 0 3 5 1 4 6 2 4))
    (if (< month 3) (-- year))
    (setq d (% (add year (/ year 4) (/ (- year) 100) (/ year 400) (t (- month 1)) day) 7))
  )
)

(giorno 2019 7 17)
;-> 3

Anno bisestile

(define (leap? year)
  (cond ((= (% year 400) 0) true) ; divisibile per 400
        ((= (% year 100) 0) nil)  ; divisibile per 100, ma non per 400
        ((= (% year 4) 0) true)   ; divisibile per 4, ma non per 100 e 400
        (true nil)                ; non divisibile per 4 o 100 o 400
  )
)

(leap? 1900)
;-> nil

La funzione integrata "now" fornisce le seguenti informazioni:

(now)
;-> (2019 7 18 8 15 43 236522 199 4 120 2)

Ecco il significato dei numeri interi (11) restituiti dalla funzione "now":

Descrizione                       Valore

 1) year                          Gregorian calendar
 2) month                         (1–12)
 3) day                           (1–31)
 4) hour                          (0–23) UTC
 5) minute                        (0–59)
 6) second                        (0–59)
 7) microsecond                   (0–999999) OS-specific, millisecond resolution
 8) day of current year           Jan 1st is 1
 9) day of current week           (1–7) starting Monday
10) time zone offset in minutes   west of GMT including daylight savings bias
11) daylight savings time type    (0–6) on Linux/Unix or (0–2) on MS Windows

(define (cal anno)
  (local (startNum startNum day month numDays pad)
    (setq day '((1 Lunedi) (2 Martedi) (3 Mercoledi) (4 Giovedi) (5 Venerdi) (6 Sabato) (7 Domenica)))
    (setq month '((GENNAIO 31) (FEBBRAIO 28) (MARZO 31) (APRILE 30) (MAGGIO 31) (GIUGNO 30)
      (LUGLIO 31) (AGOSTO 31) (SETTEMBRE 30) (OTTOBRE 31) (NOVEMBRE 30) (DICEMBRE 31)))
    (if (or (= anno nil) (<= anno 1752)) (setq anno (first (now))))
    ; if (anno < 1753) then anno = (first (now))
    ; primo giorno dell'anno (numero)
    (setq startNum (giorno anno 1 1))
    ; (1: lunedi ... 7: domenica)
    (if (= startNum 0) (setq startNum 7))
    (setq startDay (lookup startNum day))
    ; anno bisestile?
    (if (leap? anno) (setf (last (month 1)) 29))
    ; stampa anno
    (println (format "\n%d\n" anno))
    (setq ultimo startNum)
    (for (i 0 11)
      ; stampa mese
      ;(println (format "%s" (first (month i))))
      (println (first (month i)))
      ; stampa intestazione giorni
      (println "Lu Ma Me Gi Ve Sa Do")
      ; calcola e stampa lo spazio di inizio del primo giorno
      (setq pad (dup " " (* (- ultimo 1) 3)))
      (print pad)
      ; giorni del mese
      (setq numDays (lookup (first (month i)) month))
      (for (j 1 numDays)
        (print (format "%2d " j))
        ; se il giorno è Domenica (e non è l'ultimo del mese), allora andiamo a capo
        (if (and (= (giorno anno (+ i 1) j) 0) (!= j numDays))  (println { }))
      )
      ; ultimo giorno stampato
      (setq ultimo (+ 1 (giorno anno (+ i 1) (lookup (first (month i)) month))))
      (println "\n")
    )
    '--------------------
  )
)

(cal 2020)

2020

GENNAIO                FEBBRAIO               MARZO
Lu Ma Me Gi Ve Sa Do   Lu Ma Me Gi Ve Sa Do   Lu Ma Me Gi Ve Sa Do
       1  2  3  4  5                   1  2                      1
 6  7  8  9 10 11 12    3  4  5  6  7  8  9    2  3  4  5  6  7  8
13 14 15 16 17 18 19   10 11 12 13 14 15 16    9 10 11 12 13 14 15
20 21 22 23 24 25 26   17 18 19 20 21 22 23   16 17 18 19 20 21 22
27 28 29 30 31         24 25 26 27 28 29      23 24 25 26 27 28 29
                                              30 31

APRILE                 MAGGIO                 GIUGNO
Lu Ma Me Gi Ve Sa Do   Lu Ma Me Gi Ve Sa Do   Lu Ma Me Gi Ve Sa Do
       1  2  3  4  5                1  2  3    1  2  3  4  5  6  7
 6  7  8  9 10 11 12    4  5  6  7  8  9 10    8  9 10 11 12 13 14
13 14 15 16 17 18 19   11 12 13 14 15 16 17   15 16 17 18 19 20 21
20 21 22 23 24 25 26   18 19 20 21 22 23 24   22 23 24 25 26 27 28
27 28 29 30            25 26 27 28 29 30 31   29 30

LUGLIO                 AGOSTO                 SETTEMBRE
Lu Ma Me Gi Ve Sa Do   Lu Ma Me Gi Ve Sa Do   Lu Ma Me Gi Ve Sa Do
       1  2  3  4  5                   1  2       1  2  3  4  5  6
 6  7  8  9 10 11 12    3  4  5  6  7  8  9    7  8  9 10 11 12 13
13 14 15 16 17 18 19   10 11 12 13 14 15 16   14 15 16 17 18 19 20
20 21 22 23 24 25 26   17 18 19 20 21 22 23   21 22 23 24 25 26 27
27 28 29 30 31         24 25 26 27 28 29 30   28 29 30
                       31

OTTOBRE                NOVEMBRE               DICEMBRE
Lu Ma Me Gi Ve Sa Do   Lu Ma Me Gi Ve Sa Do   Lu Ma Me Gi Ve Sa Do
          1  2  3  4                      1       1  2  3  4  5  6
 5  6  7  8  9 10 11    2  3  4  5  6  7  8    7  8  9 10 11 12 13
12 13 14 15 16 17 18    9 10 11 12 13 14 15   14 15 16 17 18 19 20
19 20 21 22 23 24 25   16 17 18 19 20 21 22   21 22 23 24 25 26 27
26 27 28 29 30 31      23 24 25 26 27 28 29   28 29 30 31
                       30

Nota: L'output della funzione stampa tutti i mesi uno di seguito all'altro.


--------------
CARTE DA GIOCO
--------------

Crea una struttura dati e le funzioni associate per definire e manipolare un mazzo di carte da gioco.
Il mazzo dovrebbe contenere 54 carte uniche.

Le funzioni devono includere la capacità di:

1) crea un nuovo mazzo
2) mischiare il mazzo (shuffle)
3) Estrarre una carta dal mazzo
4) Stampare il contenuto del mazzo

Ogni carta deve avere un valore e un seme che costituiscono il codice univoco della carta.

Per chi ha i caratteri utf-8 può usare la definizione seguente:

(setq semi '("♥" "♦" "♣" "♠"))

Definiamo una funzione che crea un mazzo di carte:

(define (crea-carte)
  (local (semi numeri indice carte)
    ; definiamo i semi delle carte
    (setq semi '(Cuori Quadri Fiori Picche))
    ; definiamo i numeri delle carte
    (setq numeri '(Asso Due Tre Quattro Cinque Sei Sette Otto Nove Dieci Jack Donna Re))
    ; creiamo il mazzo di carte: (1 (Asso Cuori)) (2 (Due Cuori)) ...
    (setq carte '())
    (setq indice 0)
    (dolist (seme semi)
      (push (map (fn (x) (list (+ $idx 1 indice) (list x seme))) numeri) carte -1)
      (++ indice 13)
    )
    ; togliamo un livello alla lista carte (da 4 elementi passa a 52 elementi)
    (setq carte (flat carte 1))
    ; aggiungiamo i Jolly (le matte)
    (push '(53 (Matta Jolly)) carte -1)
    (push '(54 (Matta Jolly)) carte -1)
    carte
  )
)

(setq mazzo (crea-carte))
;-> ((1 (Asso Cuori)) (2 (Due Cuori)) (3 (Tre Cuori)) (4 (Quattro Cuori))
;->  (5 (Cinque Cuori)) ...
;->  ...
;->  (51 (Donna Picche)) (52 (Re Picche)) (53 (Matta Jolly)) (54 (Matta Jolly)))

Definiamo una funzione che mischia le carte:

(define (mischia mazzo)
  (seed (time-of-day))
  (randomize mazzo)
)

(setq partita (mischia mazzo))
;-> ((34 (Otto Fiori)) (30 (Quattro Fiori)) (26 (Re Quadri))...
;->  ... (21 (Otto Quadri)) (37 (Jack Fiori)))

Per la funzione di estrazione possiamo usare la funzione integrata "pop" estraendo la prima carta del mazzo:

(define (estrai mazzo) (pop mazzo))

Però qualcosa non funziona:

(length partita)
;-> 54

(estrai partita)
;-> (34 (Otto Fiori))

(length partita)
;-> 54

Abbiamo estratto la prima carta, ma non è stata eliminata dal mazzo perchè alla funzione estrai viene passata una copia del mazzo "partita".
Per risolvere il problema definiamo un mazzo come contesto, in questo modo newLISP passa la variabile definita per riferimento.

(setq p:p (mischia mazzo))
;-> ((26 (Re Quadri)) (12 (Donna Cuori)) ...
;->  ... (9 (Nove Cuori)) (43 (Quattro Picche)))

Vediamo se funziona:

(length p)
;-> 54

(estrai p)
;-> (26 (Re Quadri))

(length p)
;-> 53

Sembra che vada tutto bene. Senza utilizzare i contesti avremmo dovuto applicare la funzione "pop" direttamente sulla variabile mazzo.

Infine definiamo una funzione che stampa le carte del mazzo:

(define (stampa-tutto mazzo)
  (dolist (carta mazzo)
    (print (format "%18s" (string (last carta))))
    (if (= (% (+ $idx 1) 4) 0) (println))
  )
)

(stampa-tutto partita)
;->   (Otto Quadri)     (Matta Jolly)      (Tre Picche)     (Donna Fiori)
;->   (Otto Picche)   (Cinque Picche)       (Sei Fiori)        (Re Fiori)
;->    (Otto Fiori)     (Matta Jolly)     (Jack Picche)   (Quattro Fiori)
;->     (Sei Cuori)        (Re Cuori)     (Sette Cuori)       (Due Cuori)
;->  (Sette Picche)      (Nove Cuori)     (Dieci Cuori)       (Due Fiori)
;->     (Re Picche)     (Nove Quadri)      (Sei Quadri)       (Tre Cuori)
;->   (Asso Picche)     (Sette Fiori)      (Sei Picche)    (Sette Quadri)
;->   (Donna Cuori)     (Jack Quadri)    (Cinque Fiori)      (Jack Cuori)
;->     (Tre Fiori)    (Cinque Cuori)      (Otto Cuori)    (Donna Picche)
;->    (Jack Fiori)       (Re Quadri)      (Asso Cuori)      (Nove Fiori)
;-> (Cinque Quadri)  (Quattro Quadri)  (Quattro Picche)    (Donna Quadri)
;->    (Due Picche)    (Dieci Picche)      (Tre Quadri)     (Dieci Fiori)
;->    (Asso Fiori)     (Asso Quadri)    (Dieci Quadri)     (Nove Picche)
;-> (Quattro Cuori)      (Due Quadri)


----------------------
GENERATORE DI PASSWORD
----------------------

Creare un programma per la generazione di password contenenti caratteri ASCII casuali dai seguenti gruppi:
lettere minuscole:  (a..z)
lettere maiuscole:  (A..Z)
cifre numeriche:    (0..9)
cartteri speciali:  (# ! $ % & ( ) * + , - . / : ; < = > ? @ [ ] ^ _ { | } ~)

Le password generate devono includere almeno un carattere di ciascuno dei seguenti quattro gruppi):

1) lettera minuscola,
2) lettera maiuscola,
3) cifra numerica,
4) carattere speciale

La funzione ha come parametri la lunghezza della password e il numero di password da generare.

La funzione deve anche escludere la creazione di password con i seguenti caratteri visualmente simili:

1) Il lI
2) 1l l1
3) 1I I1
4) O0 0O
5) 5S S5
6) Z2 2Z

(define (gen-pwd num lun stampa)
  (local (pwd g g0 g1 g2 g3 gv out)
    (cond ((or (< num 1) (< lun 4)) (setq out nil) (println "parametri errati"))
          (true
            ; inizializza il generatore random
            (seed (time-of-day))
            (setq out '())
            (setq g0 (explode "abcdefghijklmnopqrstuvwxyz"))
            (setq g1 (explode "ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
            (setq g2 (explode "0123456789"))
            (setq g3 (explode "#!$%&()*+,-./:;<=>?@[]^_{|}~"))
            ; ciclo numero di password
            (for (i 1 num)
              (setq pwd '())
              ; aggiungiamo un carattere per ogni gruppo
              (push (g0 (rand 26)) pwd -1)
              (push (g1 (rand 26)) pwd -1)
              (push (g2 (rand 10)) pwd -1)
              (push (g3 (rand 28)) pwd -1)
              ; ciclo genera password di lunghezza lun
              (if (> lun 4)
                (begin
                  (for (j 1 (- lun 4))
                    (setq g (rand 4))
                    (if (= g 0) (push (g0 (rand 26)) pwd -1)
                      (if (= g 1) (push (g1 (rand 26)) pwd -1)
                        (if (= g 2) (push (g2 (rand 10)) pwd -1)
                          (if (= g 3) (push (g3 (rand 28)) pwd -1)))))
                  )
                )
              )
              ; randomize per mischiare i caratteri
              ; soprattuto per i primi quattro che altrimenti
              ; seguirebbero una regola fissa
              (setq pwd (join (randomize pwd)))
              ; controllo caratteri visualmente simili
              ; (Il lI) (1l l1) (1I I1) (O0 0O) (5S S5) (Z2 2Z)
              (if (setq idx (find "Il" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "ll" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "1l" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "l1" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "1I" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "I1" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "0O" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "O0" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "5S" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "S5" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "Z2" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "2Z" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if stampa (println pwd))
              (push pwd out -1)
            );for
          );true
    );cond
    out
  );local
)

(gen-pwd 2 8)
;-> ("BPT=v+8s" "M&I9^o0L")

(gen-pwd 1 3)
;-> parametri errati
;-> nil

(gen-pwd 1 4)
;-> ("M5}g")

(gen-pwd 6 12)
;-> ("Jrfh.F2~uEtd" "ljR8[=3VYoSH" "|0J4u^4dv0{9" 
;->  "87HFP;{u6ini" "M3w|1:4],G4m" "3@LH5Q*E00mv")

Funzione che controlla la presenza di caratteri visualmente simili:

(define (test pwd)
  (for (i 1 100000)
    (setq pwd (first (gen-pwd 1 21)))
    (if (or (find "Il" pwd) (find "ll" pwd) (find "1l" pwd)
            (find "l1" pwd) (find "1I" pwd) (find "I1" pwd)
            (find "0O" pwd) (find "O0" pwd) (find "5S" pwd)
            (find "S5" pwd) (find "Z2" pwd) (find "2Z" pwd))
        (println pwd)
    )
  )
)

(test pwd)
;-> nil

