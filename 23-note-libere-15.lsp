================

 NOTE LIBERE 15

================

-------------------------------
Potenze più vicine ad un numero
-------------------------------

Dati due numeri interi N e K, trovare la prima potenza di K inferiore a N e la prima potenza di K superiore a N.

Per esempio, con N = 8 e K = 3:
Le potenze di 3 sono: 3, 9, 27, 81, ...
La prima potenza di 3 inferiore a 8 vale: 3
La prima potenza di 3 superiore a 8 vale: 9

In generale:
- la prima potenza minore di N vale K^floor(logk(N)).
- la prima potenza maggiore di N vale K^ceil(logk(N)).

Dobbiamo solo stare attenti quando N è una potenza perfetta di K (perchè i numeri floating point sono pericolosi).

(define (close-power num k)
  (local (eps lg p1 p2 a b)
    (setq eps 1e-6)
    (setq lg (log num k))
    (setq p1 (floor lg))
    (setq p2 (ceil  lg))
    (setq a (pow k p1))
    (setq b (pow k p2))
    ; controlla se num è una potenza perfetta di k
    (cond ((> eps (abs (sub num a)))
            (setq a (pow k (- p1 1)))
            (setq b (pow k (+ p1 1))))
          ((> eps (abs (sub num b)))
            (setq a (pow k (- p2 1)))
            (setq b (pow k (+ p2 1))))
    )
    (list a b)))

Facciamo alcune prove:  
  
(close-power 8 3)
;-> (3 9)
(close-power 81 3)
;-> (27 243)
(close-power 1000 10)
;-> (100 10000)
(close-power 100 10)
;-> (10 1000)
(close-power 78125 5)
;-> (15625 390625)


------------------------------------------------
Problemi di pesatura (con bilancia a due piatti)
------------------------------------------------

Un problema di pesatura è un puzzle logico sul peso di oggetti, spesso monete, per determinare quale ha un valore diverso, utilizzando una bilancia a due piatti un numero limitato (minimo) di volte.
Questo tipo di puzzle comprende i seguenti tre casi:

1) La moneta target è più leggera o più pesante delle altre
Bisogna identificare la moneta target.
Numero massimo di monete con N pesature: 3^N
Numero di pesature necessarie con M monete: ceil(log3(M))

2) La moneta target è diversa dalle altre
Bisogna identificare la moneta target.
Numero massimo di monete con N pesature: (3^N - 1)/2
Numero di pesature necessarie con M monete: ceil(log3(2*M + 1))

3) La moneta target è diversa dalle altre o tutte le monete sono uguali
Bisogna identificare se esiste una moneta unica e se è più leggera o più pesante.
Numero massimo di monete con N pesature: (3^N - 1)/2 - 1
Numero di pesature necessarie con M monete: ceil(log3(2*M + 3))

Ad esempio, cercando una moneta diversa con tre pesate (n = 3), il numero massimo di monete analizzabili è (3^3 − 1)/2 = 13.
Con 3 pesate e 13 monete non è sempre possibile determinare l'identità dell'ultima moneta (se è più pesante o più leggera delle altre), ma semplicemente che la la moneta è diversa.
In generale, con n pesate, è possibile determinare l'identità di una moneta se abbiamo (3n − 1)/2 - 1 monete o meno.
Nel caso n = 3, è possibile identificare la moneta diversa su 12 monete.

Vediamo due esempi classici:

Problema delle nove monete
--------------------------
Abbiamo nove monete dal peso uguale tranne una, che è più leggera delle altre. Dobbiamo identificare la moneta diversa utilizzando il minor numero di pesate con una bilancia a due piatti.

Soluzione
Il numero massimo di monete tra le quali è possibile trovare quella più leggera in una sola pesata vale 3.
Infatti, per trovare quella più leggera, possiamo confrontare due monete qualsiasi, escludendo la terza. 
Se le due monete hanno lo stesso peso, allora la moneta più leggera deve essere una di quelle non sulla bilancia. 
Altrimenti è quello indicata come più leggera dalla bilancia.
Adesso consideriamo le nove monete in tre pile di tre monete ciascuna. 
In una sola mossa possiamo trovare quale delle tre pile è più leggera (ovvero quella contenente la moneta più leggera). 
Ci vuole quindi solo un'altra mossa per identificare la moneta leggera dall'interno di quella pila più leggera. 
Quindi, in due pesate, possiamo trovare una singola moneta leggera da un insieme di 3 * 3 = 9.
Per estensione, basterebbero solo 3 pesate per trovare la moneta più leggera tra 27 monete e 4 pesate per trovarla da 81 monete.

Problema delle dodici monete (Grossman, Howard (1945). Scripta Mathematica XI)
------------------------------------------------------------------------------
Un problema più complesso consiste in 12 monete, in cui 11 o dodici sono uguali. Se una è diversa, non sappiamo se è più pesante o più leggera delle altre. In questo caso bastano 3 pesate per determinare se esiste una moneta unica e, in tal caso, per isolarla e determinarne il peso rispetto alle altre. 

Soluzione
La soluzione proposta è facilmente scalabile a un numero maggiore di monete utilizzando la numerazione in base tre: etichettando ogni moneta con un diverso numero di tre cifre in base tre e posizionando all'n-esima pesatura di tutte le monete etichettate con l'n-esima cifra identica all'etichetta del piatto (con tre piatti, uno su ciascun lato della scala etichettati 0 e 2, e uno al centro scala (pareggio) etichettato 1). Per questo problema la seconda e la terza pesatura potrebbero dipendere da ciò che è accaduto in precedenza.

Quattro monete sono messe su ogni lato. Ci sono due possibilità:
1. Un lato è più pesante dell'altro. In tal caso, rimuovere tre monete dal lato più pesante, spostare tre monete dal lato più leggero a quello più pesante e posizionare tre monete che non sono state pesate la prima volta sul lato più leggero. (Ricorda quali monete sono quali.) Ci sono tre possibilità:
  1.a) Lo stesso lato che era più pesante la prima volta è ancora più pesante. Ciò significa che la moneta che è rimasta lì è più pesante o che la moneta che è rimasta sul lato più leggero è più leggera. Bilanciare una di queste contro una delle altre dieci monete rivela quale di queste è vera, risolvendo così il puzzle.
  1.b) Il lato che era più pesante la prima volta è più leggero la seconda volta. Ciò significa che una delle tre monete che sono andate dal lato più leggero a quello più pesante è la moneta leggera. Per il terzo tentativo, pesa due di queste monete l'una contro l'altra: se una è più leggera, è l'unica moneta, se si bilanciano, la terza moneta è quella leggera.
  1.c) Entrambi i lati sono pari. Ciò significa che una delle tre monete che è stata rimossa dal lato più pesante è la moneta pesante. Per il terzo tentativo, pesa due di queste monete l'una contro l'altra: se una è più pesante, è l'unica moneta, se si bilanciano, la terza moneta è quella pesante.
2. Entrambi i lati sono pari. In tal caso, tutte e otto le monete sono identiche e possono essere messe da parte. Prendi le quattro monete rimanenti e posizionane tre su un lato della bilancia. Posiziona 3 delle 8 monete identiche sull'altro lato. Ci sono tre possibilità:
  2.a) Le tre monete rimanenti sono più leggere. In questo caso ora sai che una di quelle tre monete è quella dispari e che è più leggera. Prendi due di quelle tre monete e pesale l'una contro l'altra. Se la bilancia si inclina, la moneta più leggera è quella dispari. Se le due monete si bilanciano, la terza moneta non in bilico è quella dispari ed è più leggera.
  2.b) Le tre monete rimanenti sono più pesanti. In questo caso ora sai che una di quelle tre monete è quella dispari e che è più pesante. Prendi due di quelle tre monete e pesale l'una contro l'altra. Se la bilancia si ribalta, la moneta più pesante è quella dispari. Se le due monete si bilanciano, la terza moneta non in bilico è quella dispari ed è più pesante.
  2.c) Saldo delle tre monete rimanenti. In questo caso devi solo pesare la moneta rimanente contro una qualsiasi delle altre 11 monete e questo ti dice se è più pesante, più leggera o uguale.

Una bilancia a piatti ha naturalmente 3 posizioni: a sinistra, a destra e in equilibrio.
Nella tabella sottostante, accanto a ciascun numero di moneta c'è il numero della triade. La terza colonna fornisce un secondo numero di triade ottenuto cambiando ogni 0 in 2 e ogni 2 in 0 dal primo numero di triade.

 numero  ternario  modificato
   1       001*      221
   2       002*      220
   3       010*      212
   4       011       211*
   5       012*      210
   6       020       202*
   7       021       201*
   8       022       200*
   9       100       122*
  10       101       121*
  11       102       120*
  12       110       112*

Quindi sceglere quelli in cui le prime due cifre disuguali sono uguali a 01, 12 o 20. Questi sono segnati con l'asterisco "*" nella tabella.

Come prima pesatura le monete con la prima cifra 2 vanno a destra e quelle con la prima cifra 0 a sinistra:

  001       200
  010       201   
  011       202
  012       220

Se c'è un saldo, scriviamo 1 come prima cifra della moneta contraffatta. Quando la bilancia di sinistra scende scriviamo 0, quando quella di destra scende scriviamo 2.
Per la seconda pesata facciamo lo stesso con la seconda cifra delle monete, quindi:

  001       120
  200       121
  201       122
  202       220

Ancora una volta scriviamo un 1, 0 o 2 come secondo numero, a seconda che la scala sia bilanciata, oscilla a sinistra o oscilla a destra.
Infine, facciamo di nuovo la stessa cosa, ora con la terza cifra delle monete:

  010       012
  120       112
  200       122
  220       202

È così che finalmente otteniamo il numero della moneta contraffatta.
Possiamo capire dai pesi se la moneta era troppo leggera o troppo pesante. 
La moneta è troppo pesante se il numero trovato era anche il numero usato della moneta. 
Se la moneta era troppo leggera, troviamo l'altro numero che appartiene alla moneta.

Nota: questo problema ha una variante più semplice con 3 monete in 2 pesate, e una variante più complessa con 39 monete in 4 pesate.


-------------------------------------------
Problemi di pesatura (con bilancia a molla)
-------------------------------------------

Ci sono N monete dall'aspetto identico. N − 1 sono autentiche con un peso noto P e una, di un peso sconosciuto diverso da P, è falsa. 
Determinare il numero minimo di pesate, con una bilancia a molla, necessarie per identificare la moneta falsa. 
La bilancia a molla indica il peso esatto delle monete pesate.

Soluzione
---------
Il numero minimo di pesate necessarie per garantire l'identificazione della moneta falsa è ceil(log2 N).
Si consideri un sottoinsieme arbitrario S di M ≥ 1 monete selezionate tra le N monete fornite.
Se il suo peso totale T è uguale a P*M, tutte le monete in S sono autentiche, altrimenti una delle monete in S è falsa.
Possiamo quindi procedere alla ricerca del falso tra le monete non in S nel primo caso e tra le monete in S nel secondo caso. 
Se S contiene la metà (o quasi la metà) delle monete date, dopo una pesatura possiamo procedere alla ricerca del falso in un insieme grande la metà. 
Dovremo ripetere questa operazione di dimezzamento e pesatura ceil(log2 N) volte prima che N, la dimensione dell'insieme originale, possa essere sicuramente ridotto a 1.
Dal punto di vista matematico, il numero di pesate nel caso peggiore è definito dalla funzione ricorsiva:

   W(n) = W(ceil(n/2)) + 1 per n > 1,
   W(1) = 0
 
la cui soluzione è: W(n) = ceil(log2 n).


-----------------------------
Punto interno ad un triangolo
-----------------------------

Date le coordinate dei tre vertici di un triangolo e un altro punto P, scrivere una funzione per verificare se P si trova all'interno del triangolo oppure no.
Esempi:
  A = (0 0), B = (10 30), C = (20 0)
  P = (10 15)
  Il punto è interno.

  A = (0 0), B = (10 30), C = (20 0)
  P = (30 15)
  Il punto è esterno.
 
Algoritmo
Siano (x1 y1), (x2 y2) e (x3 y3) le coordinate dei tre vertici del triangolo.
Sia (x y) le coordinate del punto dato P.
Calcolare l'area del triangolo ABC:
  Area A = [x1(y2 – y3) + x2(y3 – y1) + x3(y1 - y2)]/2
Calcolare l'area del triangolo PAB. Sia quest'area A1.
Calcolare l'area del triangolo PBC. Sia quest'area A2.
Calcolare l'area del triangolo PAC. Sia quest'area A3.
Il punto P si trova all'interno del triangolo se e solo se:
  (A1 + A2 + A3) è uguale ad A (+- epsilon).

Funzione che calcola l'area di un triangolo dati i tre vertici:

(define (area-triangle x1 y1 x2 y2 x3 y3)
  (abs (div (add (mul x1 (sub y2 y3))
                 (mul x2 (sub y3 y1))
                 (mul x3 (sub y1 y2))) 2)))

Funzione che verifica se un punto è interno ad un triangolo:

(define (inside-triangle? x y x1 y1 x2 y2 x3 y3)
  (local (eps a a1 a2 a3)
    (setq eps 1e-6) ; compensate rounding errors
    (setq a  (area-triangle x1 y1 x2 y2 x3 y3))
    (setq a1 (area-triangle x y x2 y2 x3 y3))
    (setq a2 (area-triangle x1 y1 x y x3 y3))
    (setq a3 (area-triangle x1 y1 x2 y2 x y))
    ;(println a { } (add a1 a2 a3) { } a1 { } a2 { } a3)
    (> eps (abs (sub a (add a1 a2 a3))))))

Facciamo alcune prove:

(inside-triangle? 10 15 0 0 20 0 10 30 10 15)
;-> true

(inside-triangle? 0 2 0 0 4 0 0 4)
;-> true

(inside-triangle? 1 0 0 0 2 0 1 1)
;-> true


------------------------------
Punto interno ad un rettangolo
------------------------------

Date le coordinate dei quattro vertici di un rettangolo e un altro punto P, scrivere una funzione per verificare se P si trova all'interno del rettangolo oppure no.

Primo metodo
------------
Dividiamo il rettangolo in 4 triangoli e calcoliamo la somma delle loro aree.
Se la somma dei triangoli è uguale all'area del rettangolo, allora il punto è interno al rettangolo.

Funzione che calcola l'area di un triangolo dati i tre vertici:

(define (area-triangle x1 y1 x2 y2 x3 y3)
  (abs (div (add (mul x1 (sub y2 y3))
                 (mul x2 (sub y3 y1))
                 (mul x3 (sub y1 y2))) 2)))

(define (dist2d x1 y1 x2 y2)
"Calculates 2D Cartesian distance of two points P1 = (x1 y1) and P2 = (x2 y2)"
  (sqrt (add (mul (sub x1 x2) (sub x1 x2))
             (mul (sub y1 y2) (sub y1 y2)))))

Funzione che calcola l'area di un rettangolo dati i quattro vertici:

(define (area-rectangle x1 y1 x2 y2 x3 y3 x4 y4)
  (mul (dist2d x1 y1 x2 y2) (dist2d x2 y2 x3 y3)))

Funzione che verifica se un punto è interno ad un rettangolo:

(define (inside-rect? x y x1 y1 x2 y2 x3 y3 x4 y4)
  (local (eps a a1 a2 a3 a4)
    (setq eps 1e-6) ; compensate rounding errors
    (setq a  (area-rectangle x1 y1 x2 y2 x3 y3 x4 y4))
    (setq a1 (area-triangle x y x1 y1 x2 y2))
    (setq a2 (area-triangle x y x2 y2 x3 y3))
    (setq a3 (area-triangle x y x3 y3 x4 y4))
    (setq a4 (area-triangle x y x1 y1 x4 y4))
    ; (println a { } (add a1 a2 a3 a4) { } a1 { } a2 { } a3 { } a4)
    (> eps (abs (sub a (add a1 a2 a3 a4))))))

Vediamo alcuni esempi:

(inside-rect? -1 -1 -2 -2 -2 8 10 8 10 -2)
;-> true
(inside-rect? 2 2 3.5 5 7.5 1 5.5 -1 1.5 3)
;-> nil
(inside-rect? 5.5 0.5 3.5 5 7.5 1 5.5 -1 1.5 3)
;-> true

Secondo metodo
--------------
Supponiamo di avere un rettangolo con punti in p1 = (x1, y1), p2 = (x2, y2), p3 = (x3, y3) e p4 = (x4, y4), procedendo in senso orario. 
Se un punto p = (x, y) giace all'interno del rettangolo, allora il prodotto scalare (p - p1).(p2 - p1) sarà compreso tra 0 e |p2 - p1|^2, e (p - p1).(p4 - p1) sarà compreso tra 0 e |p4 - p1|^2. 
Ciò equivale a prendere la proiezione del vettore p - p1 lungo la lunghezza e la larghezza del rettangolo, con p1 come origine.

(define (inside-rect? x y x1 y1 x2 y2 x3 y3 x4 y4)
  (local (p21x p21y p41x p41y p21mag-sq p41mag-sq px py v1 v2 out)
    (setq p21x (sub x2 x1))
    (setq p21y (sub y2 y1))
    (setq p41x (sub x4 x1))
    (setq p41y (sub y4 y1))
    (setq p21mag-sq (add (mul p21x p21x) (mul p21y p21y)))
    (setq p41mag-sq (add (mul p41x p41x) (mul p41y p41y)))
    (setq px (sub x x1))
    (setq py (sub y y1))
    (setq v1 (add (mul px p21x) (mul py p21y)))
    (setq v2 (add (mul px p41x) (mul py p41y)))
    (if (and (>= v1 0) (<= v1 p21mag-sq))
        (if (and (>= v2 0) (<= v2 p41mag-sq))
          (setq out true)
          ;else
          (setq out nil)
        )
        ;else
        (setq out nil)
    )
    out))

Vediamo alcuni esempi:

(inside-rect? -1 -1 -2 -2 -2 8 10 8 10 -2)
;-> true
(inside-rect? 2 2 3.5 5 7.5 1 5.5 -1 1.5 3)
;-> nil
(inside-rect? 5.5 0.5 3.5 5 7.5 1 5.5 -1 1.5 3)
;-> true


----------------------------------------
Ricerca in una lista di numeri adiacenti
----------------------------------------

Data una lista di numeri interi positivi in cui due elementi vicini sono adiacenti (con differenza assoluta 1), scrivere un algoritmo per cercare un elemento nella lista e restituirne la posizione.
Se l'elemento appare più volte, restituire la prima occorrenza.

Ad esempio:
lista = (3 4 5 6 5 6 7 8 7 8 9) 
numero = 8
Il numero appare due volte nella lista e la prima occorrenza è nella posizione 7.

Algoritmo
Partiamo dalla posizione 0 dove si trova il numero 3.
La differenza tra 3 e 8 vale 5, quindi ci spostiamo nella posizione 5. Perchè?
Perché la differenza assoluta tra due elementi vicini è 1. 
Se i numeri nella lista fossero ordinati in modo crescente, l'elemento in posizione 5 sarebbe 9. 
Se alcuni elementi diminuiscono, allora 8 dovrebbe trovarsi a destra della posizione 5. 
Pertanto, 5 è la posizione più a sinistra possibile per il numero 8.
Alla posizione 5 troviamo il numero 6. La differenza tra 8 e 6 vale 2.
Quindi ci spostiamo 2 posizioni in avanti (dalla posizione 5) nella posizione 7.
Nella posizione 7 troviamo il numero 8.

Proviamo a cercare un numero che non esiste nella lista, ad esempio 2.
Alla posizione 0 troviamo il 3, la differenza 3 - 2 vale 1.
Alla posizione 1 troviamo 4, 4 - 2 = 2.
Alla posizione 3 (2+1) troviamo 6, 6 - 2 = 4.
Alla posizione 7 (4+3) troviamo 8, 8 - 2 = 6.
Alla posizione 13 (6+7) abbiamo supreato la lunghezza della lista e restituiamo nil.

Possiamo riassumere la soluzione: iniziamo dal primo elemento dell'elemento e lo confrontiamo con il numero dato. 
Se la differenza assoluta è K, ci spostiamo a destra della distanza K (partendo dalla posizione corrente). 
Quindi confrontiamo l'elemento attualmente visitato. 
Ripetere finché non viene trovato l'elemento specificato o la posizione è oltre la lunghezza della lista quando l'elemento cercato non si trova nella lista.

(define (cerca val nums)
  (local (len idx delta)
    (setq len (length nums))
    (setq idx 0)
    (while (and (< idx len) (!= (nums idx) val))
      ;(println idx { } (nums idx))
      (setq delta (abs (sub val (nums idx))))
      ;(println delta)
      (++ idx delta)
    )
    (if (< idx len) idx nil)))

(setq lst '(3 4 5 6 5 6 7 8 7 8 9))

(cerca 7 lst)
;-> 6

(cerca 2 lst)
;-> nil


-----------
Super primi
-----------

I numeri super primi sono la sottosequenza di numeri primi che occupano posizioni prime all'interno della sequenza di tutti i numeri primi.

posizione:    (0)  1  2  3  4  5   6
numeri primi: (1)  2  3  5  7  11  13
super primi:          3  5     11

Sequenza OEIS A006450:
  3, 5, 11, 17, 31, 41, 59, 67, 83, 109, 127, 157, 179, 191, 211, 241, 277, 
  283, 331, 353, 367, 401, 431, 461, 509, 547, 563, 587, 599, 617, 709, 739,
  773, 797, 859, 877, 919, 967, 991, 1031, 1063, 1087, 1153, 1171, 1201, 1217,
  1297, 1409, 1433, 1447, 1471, ...

(define (primes-to num)
"Generates all prime numbers less than or equal to a given number"
  (cond ((= num 1) '())
        ((= num 2) '(2))
        (true
         (let ((lst '(2)) (arr (array (+ num 1))))
          (for (x 3 num 2)
            (when (not (arr x))
              (push x lst -1)
              (for (y (* x x) num (* 2 x) (> y num))
                (setf (arr y) true)))) lst))))

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

Funzione che genra tutti i super primi minori o uguali ad un dato numero:

(define (super-primes-to num)
  (let ( (primes (primes-to num)) (out '()) )
    (push 1 primes)
    (dolist (p primes)
      (if (prime? $idx) (push p out -1))
    )
    out))

(super-primes-to 1000)
;-> (3 5 11 17 31 41 59 67 83 109 127 157 179 191 211 241 277 
;->  283 331 353 367 401 431 461 509 547 563 587 599 617 709 739 
;->  773 797 859 877 919 967 991)

=============================================================================

