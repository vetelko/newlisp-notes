================

 NOTE LIBERE 13

================

---------------------------------------------------
Moltiplicazione tra matrici - Algoritmo di Strassen
---------------------------------------------------

https://www.geeksforgeeks.org/implementing-strassens-algorithm-in-java/

Complessità temporale: O(n^(ln 7)) = O(n^2.807)

Ipotesi di questa implementazione:
- Le matrici devono essere quadrate
- Le matrici devono avere la stessa dimensione
- La dimensione deve essere una potenza di 2 ((n & (n - 1)) == 0)

L'algoritmo è valido anche per matrici non quadrate e con dimensioni che non sono potenza di 2. In pratica si rendono quadrate queste matrici con numeri fittizi.

(define (print-matrix matrix)
"Print a matrix m x n"
  (local (row col lenmax digit fmtstr)
    (if (array? matrix) (setq matrix  (array-list matrix)))
    (setq row (length matrix))
    (setq col (length (first matrix)))
    (setq lenmax (apply max (map length (map string (flat matrix)))))
    (setq digit (+ 1 lenmax))
    (setq fmtstr (append "%" (string digit) "s"))
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (print (format fmtstr (string (matrix i j))))
      )
      (println))))

(define (sub-matrix M i j rows cols)
  (local (sub-mat ic jc)
    ; no passing rows, cols then
    ; select all sub-matrix from M(i j)
    (if (= rows nil) (setq rows (- (length M) i)))
    (if (= cols nil) (setq cols (- (length (M 0)) j)))
    ; create the result array (empty)
    (setq sub-mat (array rows cols '(0)))
    ; index for rows of sub-mat
    (setq ic 0)
    (for (rr i (+ rows i -1))
      ; index for cols of sub-mat
      (setq jc 0)
      (for (cc j (+ cols j -1))
        (setf (sub-mat ic jc) (M rr cc))
        (++ jc)
      )
      (++ ic)
    )
    (array-list sub-mat)))

(define (merge-matrix A B position)
  (local (out rowsA colsA rowsB colsB)
    (setq rowsA (length A))
    (setq colsA (length (A 0)))
    (setq rowsB (length B))
    (setq colsB (length (B 0)))
    (cond ((= position "n") ; B sopra A (nord) con (colsA == colsB)
            (setq out '())
            (dolist (r B) (push r out -1))
            (dolist (r A) (push r out -1)))
          ((= position "s") ; B sotto A (sud) con (colsA == colsB)
            (setq out '())
            (dolist (r A) (push r out -1))
            (dolist (r B) (push r out -1)))
          ((= position "e") ; B a destra di A (est) con (rowsA == rowsB)
            (dolist (r A)
              (push (append r (B $idx)) out -1)))
          ((= position "o") ; B a sinistra di A (ovest) con (rowsA == rowsB)
            (dolist (r A)
              (push (append (B $idx) r) out -1)))
    )
    out))


(define (strassen A B)
  (local (R n A11 A12 A21 A22 B11 B12 B21 B22
              C11 C12 C21 C22
              M1 M2 M3 M4 M5 M6 M7 T1 T2)
    (setq n (length A))
    (cond ((= n 1)
            (setq R '((nil)))
            (setf (R 0 0) (mul (A 0 0) (B 0 0)))
            R)
          (true
            (setq A11 (sub-matrix A 0 0 (/ n 2) (/ n 2)))
            (setq A12 (sub-matrix A 0 (/ n 2) (/ n 2) (/ n 2)))
            (setq A21 (sub-matrix A (/ n 2) 0 (/ n 2) (/ n 2)))
            (setq A22 (sub-matrix A (/ n 2) (/ n 2) (/ n 2) (/ n 2)))
            (setq B11 (sub-matrix B 0 0 (/ n 2) (/ n 2)))
            (setq B12 (sub-matrix B 0 (/ n 2) (/ n 2) (/ n 2)))
            (setq B21 (sub-matrix B (/ n 2) 0 (/ n 2) (/ n 2)))
            (setq B22 (sub-matrix B (/ n 2) (/ n 2) (/ n 2) (/ n 2)))
            (setq M1 (strassen (mat + A11 A22) (mat + B11 B22)))
            (setq M2 (strassen (mat + A21 A22) B11))
            (setq M3 (strassen A11 (mat - B12 B22)))
            (setq M4 (strassen A22 (mat - B21 B11)))
            (setq M5 (strassen (mat + A11 A12) B22))
            (setq M6 (strassen (mat - A21 A11) (mat + B11 B12)))
            (setq M7 (strassen (mat - A12 A22) (mat + B21 B22)))
            (setq C11 (mat + (mat - (mat + M1 M4) M5) M7))
            (setq C12 (mat + M3 M5))
            (setq C21 (mat + M2 M4))
            (setq C22 (mat + (mat - (mat + M1 M3) M2) M6))
            (setq T1 (merge-matrix C11 C12 "e"))
            (setq T2 (merge-matrix C21 C22 "e"))
            (setq R (merge-matrix T1 T2 "s")))
    )))

Proviamo la funzione:

(strassen '((2)) '((9)))
;-> ((18))

(setq m1 '( (1 2 3 4)
            (4 3 0 1)
            (5 6 1 1)
            (0 2 5 6)))

(setq m2 '((1 0 5 1)
           (1 2 0 2)
           (0 3 2 3)
           (1 2 1 2)))

(print-matrix (setq s (strassen m1 m2)))
;->  7 21 15 22
;->  8  8 21 12
;-> 12 17 28 22
;->  8 31 16 31

(print-matrix (multiply m1 m2))
;->  7 21 15 22
;->  8  8 21 12
;-> 12 17 28 22
;->  8 31 16 31


---------------------------------------------------
Ricerca in una matrice di numeri uguali in sequenza
---------------------------------------------------

Abbiamo una matrice MxN di numeri interi.
Cercare tutte le celle della matrice che sono i numeri iniziali di una linea di una determinata lunghezza con numeri tutti uguali.
La linea può trovarsi lungo una delle 8 direzioni (n,e,s,o,ne,se,so,no).
Per esempio: cercare l'inizio di una linea di numeri 1 di lunghezza 3 -> 1 1 1.


Funzione che analizza ogni cella della matrice per vedere se si tratta dell'inizio di una linea:

Parametri:
num = numero intero da cercare
len = lunghezza della linea di numeri uguali
matrix = matrice NxM di interi

Restituisce una lista di punti iniziali del tipo:
( ((i0 j0 dir0) (i0 j0 (dir1) ... (i0 j0 dirn)))
  ((i1 j1 dir0) (i1 j1 (dir1) ... (i1 j1 dirn)))
  ...
  ((in jn dir0) (in jn (dir1) ... (in jn dirn))) )

(define (straight num len matrix)
  (local (out rows cols res)
    (setq out '())
    (setq rows (length matrix))
    (setq cols (length (first matrix)))
    (for (r 0 (- rows 1))
      (for (c 0 (- cols 1))
        (setq res (check num len r c matrix))
        ;(print r { } c { } res) (read-line)
        (if res (push res out -1))
      )
    )
    out))

Funzione ausiliaria che crea una lista con tutte le linee che partono dalla cella (i j):

Se esistono linee dalla cella (i j), allora restituisce una lista di linee:
  ((i0 j0 dir0) (i1 j1 (dir1) ... (in jn dirn)))
Se la cella non è un estremo, restituisce nil.

(define (check num len i j matrix)
  (local (rows cols ext out)
    (setq out nil)
    (setq rows (length matrix))
    (setq cols (length (first matrix)))
    (setq ext (- len 1))
    ; il numero corrente deve essere uguale a quello da cercare
    (if (= num (matrix i j))
      (begin
        ; search right - est
        (if (< (+ j ext) cols) (begin
            (setq equal true)
            ;(for (k 1 ext)
            (for (k 1 ext 1 (not equal))
              (if (!= (matrix i j) (matrix i (+ j k))) (setq equal nil))
            )
            (if equal (push (list i j "e") out -1)))
        )
        ; search left - ovest
        (if (>= (- j ext) 0) (begin
            (setq equal true)
            (for (k 1 ext 1 (not equal))
              (if (!= (matrix i j) (matrix i (- j k))) (setq equal nil))
            )
            (if equal (push (list i j "o") out -1)))
        )
        ; search down - sud
        (if (< (+ i ext) rows) (begin
            (setq equal true)
            (for (k 1 ext 1 (not equal))
              (if (!= (matrix i j) (matrix (+ i k) j)) (setq equal nil))
            )
            (if equal (push (list i j "s") out -1)))
        )
        ; search up - nord
        (if (>= (- i ext) 0) (begin
            (setq equal true)
            (for (k 1 ext 1 (not equal))
              (if (!= (matrix i j) (matrix (- i k) j)) (setq equal nil))
            )
            (if equal (push (list i j "n") out -1)))
        )
        ; search up-right - nord-est
        (if (and (>= (- i ext) 0) (< (+ j ext) cols)) (begin
            (setq equal true)
            (for (k 1 ext 1 (not equal))
              (if (!= (matrix i j) (matrix (- i k) (+ j k))) (setq equal nil))
            )
            (if equal (push (list i j "ne") out -1)))
        )
        ; search up-left - nord-ovest
        (if (and (>= (- i ext) 0) (>= (- j ext) 0)) (begin
            (setq equal true)
            (for (k 1 ext 1 (not equal))
              (if (!= (matrix i j) (matrix (- i k) (- j k))) (setq equal nil))
            )
            (if equal (push (list i j "no") out -1)))
        )
        ; search down-left - sud-ovest
        (if (and (< (+ i ext) rows) (>= (- j ext) 0)) (begin
            (setq equal true)
            (for (k 1 ext 1 (not equal))
              (if (!= (matrix i j) (matrix (+ i k) (- j k))) (setq equal nil))
            )
            (if equal (push (list i j "so") out -1)))
        )
        ; search down-right - sud-est
        (if (and (< (+ i ext) rows) (< (+ j ext) cols)) (begin
            (setq equal true)
            (for (k 1 ext 1 (not equal))
              (if (!= (matrix i j) (matrix (+ i k) (+ j k))) (setq equal nil))
            )
            (if equal (push (list i j "se") out -1)))
        )
      ) ;begin
    ) ;if
    out))

Facciamo alcune prove:

(setq test '((1 1 1 1)
             (1 1 1 1)
             (1 1 1 1)
             (1 1 1 1)))

(straight 1 4 test)
;-> (((0 0 "e") (0 0 "s") (0 0 "se"))
;->  ((0 1 "s"))
;->  ((0 2 "s"))
;->  ((0 3 "o") (0 3 "s") (0 3 "so"))
;->  ((1 0 "e"))
;->  ((1 3 "o"))
;->  ((2 0 "e"))
;->  ((2 3 "o"))
;->  ((3 0 "e") (3 0 "n") (3 0 "ne"))
;->  ((3 1 "n"))
;->  ((3 2 "n"))
;->  ((3 3 "o") (3 3 "n") (3 3 "no")))

(straight 1 2 test)
;-> (((0 0 "e") (0 0 "s") (0 0 "se"))
;->  ((0 1 "e") (0 1 "o") (0 1 "s") (0 1 "so") (0 1 "se"))
;->  ((0 2 "e") (0 2 "o") (0 2 "s") (0 2 "so") (0 2 "se"))
;->  ((0 3 "o") (0 3 "s") (0 3 "so"))
;->  ((1 0 "e") (1 0 "s") (1 0 "n") (1 0 "ne") (1 0 "se"))
;->  ((1 1 "e") (1 1 "o") (1 1 "s") (1 1 "n") (1 1 "ne") (1 1 "no") (1 1 "so") (1 1 "se"))
;->  ((1 2 "e") (1 2 "o") (1 2 "s") (1 2 "n") (1 2 "ne") (1 2 "no") (1 2 "so") (1 2 "se"))
;->  ((1 3 "o") (1 3 "s") (1 3 "n") (1 3 "no") (1 3 "so"))
;->  ((2 0 "e") (2 0 "s") (2 0 "n") (2 0 "ne") (2 0 "se"))
;->  ((2 1 "e") (2 1 "o") (2 1 "s") (2 1 "n") (2 1 "ne") (2 1 "no") (2 1 "so") (2 1 "se"))
;->  ((2 2 "e") (2 2 "o") (2 2 "s") (2 2 "n") (2 2 "ne") (2 2 "no") (2 2 "so") (2 2 "se"))
;->  ((2 3 "o") (2 3 "s") (2 3 "n") (2 3 "no") (2 3 "so"))
;->  ((3 0 "e") (3 0 "n") (3 0 "ne"))
;->  ((3 1 "e") (3 1 "o") (3 1 "n") (3 1 "ne") (3 1 "no"))
;->  ((3 2 "e") (3 2 "o") (3 2 "n") (3 2 "ne") (3 2 "no"))
;->  ((3 3 "o") (3 3 "n") (3 3 "no")))

(setq test1 '((1 0 1 0)
              (1 0 1 0)
              (1 0 1 0)
              (1 0 1 0)))

(straight 1 2 test1)
;-> (((0 0 "s"))
;->  ((0 2 "s"))
;->  ((1 0 "s") (1 0 "n"))
;->  ((1 2 "s") (1 2 "n"))
;->  ((2 0 "s") (2 0 "n"))
;->  ((2 2 "s") (2 2 "n"))
;->  ((3 0 "n"))
;->  ((3 2 "n")))

(straight 0 3 test1)
;-> (((0 1 "s"))
;->  ((0 3 "s"))
;->  ((1 1 "s"))
;->  ((1 3 "s"))
;->  ((2 1 "n"))
;->  ((2 3 "n"))
;->  ((3 1 "n"))
;->  ((3 3 "n")))


------------------
Potere di acquisto
------------------

A) Se il nostro stipendio aumenta del 30% (e i prezzi rimangono stabili) di quanto aumenta il nostro potere di acquisto?

B) Se i prezzi scendono del 30% (e lo stipendio rimane stabile) di quanto diminuisce il nostro potere di acquisto?

Situazione iniziale:
Guadagniamo 100 e spendiamo 100 --> potere = 100/100 = 1 = 100%

Situazione A (+30% stipendio):
Guadagniamo 130 e spendiamo 100 --> potere = 130/100 = 1.3 = 100% + 30%

Situazione B (-30% prezzi):
Guadagniamo 100 e spendiamo 70  --> potere = 100/70 = 1.4286 = 100% + 42.86%

Quindi è più conveniente che diminuiscano i prezzi.


-------------------------------
Copertura di segmenti con punti
-------------------------------

Trovare il numero minimo di punti necessari per individuare tutti i segmenti lungo una linea.

Data una lista di segmenti costituita da coppie di numeri interi positivi che denotano rispettivamente i punti iniziale e finale di ogni segmento (start end), il compito è trovare il numero minimo di numeri interi che si trovano in almeno uno dei segmenti dati e ogni segmento contiene almeno uno di loro.

Il modo matematico di descrivere il problema è considerare ogni dato intervallo di numeri interi come un segmento di linea definito da due coordinate intere (x1 x2) su una linea.
Quindi il numero minimo di numeri interi richiesti per coprire ciascuno dell'intervallo dato è il numero minimo di punti tale che ogni segmento contenga almeno un punto.

Esempi
------

Input: segmenti = ((1 3) (2 5) (3 6))
Output: 3
Spiegazione:
Tutti e tre gli intervalli (1 3), (2 5), (3 6) contengono il numero intero 3.

              |
              3-----------6
              |
          2-----------5
              |
      1-------3
              |
  +---+---+---+---+---+---+---+
  0   1   2   3   4   5   6   7

Input: segmenti = ((4 7) (1 3) (2 5) (5 6)))
Output: 3 6 oppure 2 5 oppure ...
Spiegazione:
I segmenti (1 3) e (2 5) contengono il numero intero 3.
I segmenti (4 7) e (5 6) contengono il numero intero 6.

I segmenti (1 3) e (2 5) contengono il numero intero 2.
I segmenti (2 5) (4 7) e (5 6) contengono il numero intero 5.

                                     
              |           |                    |           |  
              |       5---6                    |           5---6
              |           |                    |           |
          2-----------5   |                    2-----------5   
              |           |                    |           |
      1-------3           |                1-------3       |
              |           |                    |           |
              |   4-----------7                |       4-----------7
              |           |                    |           |
  +---+---+---+---+---+---+---+        +---+---+---+---+---+---+---+
  0   1   2   3   4   5   6   7        0   1   2   3   4   5   6   7

In alcuni casi ci possono essere diverse soluzioni.

Algortimo 1
-----------
Trovare il valore minimo di tutti i punti iniziali e il valore massimo di tutti i punti finali di tutti i segmenti.
Iterare su questo intervallo e per ogni punto in questo intervallo tenere traccia del numero di segmenti che possono essere coperti usando questo punto.
Utilizzare un array per memorizzare il numero di segmenti come:

arr(punto) = numero di segmenti che sono attraversati da questo punto

1. Trovare il valore massimo nell'array arr[].
2. Se questo valore massimo è uguale a N, l'indice corrispondente a questo valore è il punto che copre tutti i segmenti.
3. Se questo valore massimo è minore di N, allora l'indice corrispondente a questo valore è un punto che copre alcuni segmenti.
4. Ripetere i passaggi da 1 a 3 per l'array arr[] escludendo questo valore massimo finché la somma di tutti segmenti relativi ai valori massimi trovati non è uguale a N.
Nota: ogni valore massimo ha associati i relativi segmenti che attraversa. Non è corretto sommare i valori massimi, bisogna sommare i segmenti nuovi (per la soluzione) associati ad ogni valore massimo.

Vediamo una funzione che mostra la situazione:

(define (within x a b) (and (>= x a) (<= x b)))

(define (max-idx lst)
  (let ((massimo (apply max lst)))
    (list massimo (first (ref massimo lst)))))

(define (pts-seg-status lst)
  (local (x1 x2 min-x max-x arr out x-seg seg maxidx idx)
    (setq all '())
    ; numero di segmenti
    (setq n (length lst))
    ; coordinate iniziali
    (setq x1 (map first lst))
    ; coordinate finali
    (setq x2 (map last lst))
    ; valore minimo iniziale
    (setq min-x (apply min x1))
    ; valore massimo finale
    (setq max-x (apply max x2))
    ; arr(i) = numero di segmenti che contengono/attraversano "i"
    (setq arr (array (+ max-x 2 (- min-x)) '(0)))
    ; ciclo per ogni punto intero
    (for (x min-x max-x)
      (setq x-seg '())
      (dolist (s lst)
        (if (within x (s 0) (s 1)) 
          (begin
            (push s x-seg -1)
            (++ (arr x))
          )
        )
      )
      ; (numero segmenti lista-segmenti)
      (push (list x (length x-seg) x-seg) all -1)
    )
    all))

Vediamo cosa abbiamo dopo i primi 3 passi dell'agoritmo:

(setq p1 '((1 3) (2 5) (3 6)))
(pts-seg-status p1)
;-> ((1 1 ((1 3))) 
;->  (2 2 ((1 3) (2 5))) 
;->  (3 3 ((1 3) (2 5) (3 6))) 
;->  (4 2 ((2 5) (3 6)))
;->  (5 2 ((2 5) (3 6)))
;->  (6 1 ((3 6))))

(setq p2 '((4 7) (1 3) (2 5) (5 6)))
(pts-seg-status p2)
;-> ((1 1 ((1 3))) 
;->  (2 2 ((1 3) (2 5))) 
;->  (3 2 ((1 3) (2 5))) 
;->  (4 2 ((4 7) (2 5))) 
;->  (5 3 ((4 7) (2 5) (5 6)))
;->  (6 2 ((4 7) (5 6)))
;->  (7 1 ((4 7))))

Adesso il passo 4 consiste nel selezionare i punti massimi e contare quanti segmenti nuovi aggiungono alla soluzione fino ad arrivare al numero totale di segmenti. 

Invece di scrivere questa parte, utilizziamo un algoritmo greedy più veloce.

Algoritmo 2
-----------
1) Ordinare in modo ascendente i segmenti in base ai loro punti finali.
2) Inizializzare il punto corrente come primo punto finale (punto finale minimo).
3) Inserire il punto corrente nella lista soluzione.
4) Loop sui punti finali
     se il punto corrente non si trova nel segmento corrente,
     allora aggiornare il punto corrente come punto finale del segmento corrente
            e
            inserire il punto corrente nella soluzione.
5) Restituire la lista soluzione.

(define (pts-seg seg)
  (local (pts p)
    ; ordina lista ind modo crescente rispetto al punto finale dei segmenti
    (sort seg (fn (x y) (<= (last x) (last y))))
    ; lista soluzione
    (setq pts '())
    ; il primo punto corrente è il punto finale del primo segmento
    (setq p (seg 0 1))
    ; il punto finale del primo segmento fa parte della soluzione
    (push p pts -1)
    (for (i 1 (- (length seg) 1))
      ; se in punto corrente non si trova nel segmento corrente
      (if (or (< p (seg i 0)) (> p (seg i 1)))
        (begin
          ; aggiorna il punto corrente
          (setq p (seg i 1))
          ; inserisce il punto corrente nella soluzione
          (push p pts -1)
        )
      )
    )
    pts))

Complessità temporale:v O(n*log(n))

Proviamo la funzione:

(setq p1 '((1 3) (2 5) (3 6)))
(pts-seg p1)
;-> (3)

(setq p2 '((4 7) (1 3) (2 5) (5 6)))
(pts-seg p2)
;-> (3 6)

(setq p3 '((1 2) (5 7) (8 9)))
(pts-seg p3)
;-> (2 7 9)

(setq p4 '((5 6) (4 7) (3 8) (2 9)))
(pts-seg p4)
;-> (6)

=============================================================================

