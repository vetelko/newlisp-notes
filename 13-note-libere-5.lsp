===============

 NOTE LIBERE 5

===============

-------------------
Spostamento di zeri
-------------------

Data una lista di numeri interi, scrivere una funzione che sposta gli tutti gli zeri all'inizio o alla fine della lista. L'ordine degli elementi diversi da 0 deve rimanere lo stesso. Per esempio:

Input:
lista = (1 0 5 -4 0 3 0 4 -2 -1)

Output:
zeri all'inizio = (0 0 0 1 5 -4 3 4 -2 -1)
zeri alla fine  = (1 5 -4 3 4 -2 -1 0 0 0)

Un metodo per risolvere il problema è il seguente (zeri alla fine):
1) Per ogni elemento:
  se il numero corrente è diverso da zero,
  allora mettere il numero nella posizione disponibile nella lista.
2) Riempire tutti gli indici rimanenti con 0.

La seguente funzione utilizza questo metodo:

(define (move0 lst)
  ; "idx" memorizza l'indice della posizione disponibile
  (let ((idx 0) (len (length lst)))
    (for (i 0 (- len 1))
      ; se il numero corrente è diverso da zero,
      ; allora mette il numero nella posizione libera
      (if (!= (lst i) 0)
        (begin
          (setf (lst idx) (lst i))
          ; aggiorna posizione libera
          (++ idx)
        )
      )
    )
    ; sposta gli zeri (0) in fondo alla lista (gli indici rimanenti)
    (for (i idx (- len 1))
      (setf (lst i) 0)
    )
    lst))

(setq a '(1 0 5 -4 0 3 0 4 -2 -1))
(move0 a)
;-> (1 5 -4 3 4 -2 -1 0 0 0)

Per scrivere la funzione che mette gli zeri all'inizio è sufficiente cominciare il ciclo "for" dalla fine della lista e modificare l'inserimento di zeri al termine del ciclo.

La seguente funzione utilizza "dolist" invece del ciclo "for":

(define (move-0 lst)
  ; "idx" memorizza l'indice della posizione disponibile
  (let ((idx 0) (len (length lst)))
    (dolist (el lst)
      ; se il numero corrente è diverso da zero,
      ; allora mette il numero nella posizione libera
      (if (!= el 0)
        (begin
          (setf (lst idx) el)
          ; aggiorna posizione libera
          (++ idx)
        )
      )
    )
    ; sposta gli zeri (0) in fondo alla lista (gli indici rimanenti)
    (for (i idx (- len 1))
      (setf (lst i) 0)
    )
    lst))

(move-0 a)
;-> (1 5 -4 3 4 -2 -1 0 0 0)

Adesso scriviamo una funzione che risolve lo stesso problema utilizzando le funzioni primitive "clean" e "filter":

(define (move-zero lst pos)
  (cond ((= pos 1) ; 1 ==> zeri alla fine
         (append (clean zero? lst) (filter zero? lst)))
        ((= pos 0) ; 0 ==> zeri all'inizio
         (append (filter zero? lst) (clean zero? lst)))
        (true ; default ==> zeri alla fine
         (append (clean zero? lst) (filter zero? lst)))))

(setq a '(1 0 5 -4 0 3 0 4 -2 -1))
; zeri all'inizio (pos = 0)
(move-zero a 0)
;-> (0 0 0 1 5 -4 3 4 -2 -1)
; zeri alla fine (pos = 1)
(move-zero a 1)
;-> (1 5 -4 3 4 -2 -1 0 0 0)
; zeri alla fine (default)
(move-zero a)
;-> (1 5 -4 3 4 -2 -1 0 0 0)

Vediamo i tempi di esecuzione delle tre funzioni:

(setq nums (rand 10 1000))
(time (move0 nums) 1000)
;-> 1552.321
(time (move-0 nums) 1000)
;-> 604.397
(time (move-zero nums) 1000)
;-> 103.849

(silent (setq nums (rand 10 10000)))
(time (move0 nums) 1000)
;-> 219458.513 ; ciclo "for" molto lento con liste con numero elementi > 1000
(time (move-0 nums) 1000)
;-> 74461.084  ; ciclo "dolist" più veloce sulle liste
(time (move-zero nums) 1000)
;-> 1042.734   ; le primitive newLISP vincono nettamente

Per velocizzare il calcolo le funzioni "move0" e "move-0" possono utilizzare anche dei vettori:

(silent (setq vec (array (length nums) nums)))
(time (move0 vec) 1000)
;-> 1368.295 ; ciclo "for" veloce con vettori
(time (move-0 vec) 1000)
;-> 1225.153 ; ciclo "dolist" veloce anche con vettori

Con l'uso dei vettori otteniamo quasi la stessa velocità della funzione "move-zero". Quindi, utilizzando i vettori i cicli "for" e "dolist" hanno velocità simili, mentre con le liste il ciclo "dolist" è molto più veloce del ciclo "for".

Un altro metodo per risolvere il problema è quello di utilizzare la logica del quicksort. L'idea è di usare 0 come elemento pivot e poi fare un ciclo per leggere tutti gli elementi e scambiare ogni elemento non pivot con la prima occorrenza del pivot.

La seguente funzione implementa questo metodo:

(define (zeri lst)
  (let (idx 0)
    ; se l'elemento è diverso da zero,
    ; allora l'elemento viene posizionato prima del pivot
    ; e "idx" viene incrementato
    (for (i 0 (- (length lst) 1))
      (if (!= (lst i) 0) ; 0 è il pivot
        (begin
          (swap (lst i) (lst idx))
          (++ idx)
        )
      )
    )
    lst))

(setq a '(1 0 5 -4 0 3 0 4 -2 -1))
(zeri a)
;-> (1 5 -4 3 4 -2 -1 0 0 0)

Vediamo la velocità di questa ultima funzione utilizzando un vettore:

(time (zeri vec) 1000)
;-> 1280.851


-----------------------
Quadratura approssimata
-----------------------

La funzione f(x) = x * ceil(x) viene chiamata "quadratura approssimata" ed è studiata nell'articolo "Approximate Squaring" di Lagarias e Sloane.
Consideriamo la frazione x = n/d quando n > d > 1. Prendiamo 8/7 come esempio e cominciamo a calcolare la funzione:

1) f(8/7) = 8/7 * (ceil 8/7) = 8/7 * 2 = 16/7, adesso applichiamo di nuovo la funzione:

2) f(16/7) = 16/7 * (ceil 16/7) = 16/7 * 3 = 48/7, adesso applichiamo di nuovo la funzione:

3) f(48/7) = 48/7 * (ceil 48/7) = 48/7 * 7 = 48 , adesso abbiamo raggiunto un numero intero e il ciclo è finito.

Il numero di passaggi dipende dalla frazioni iniziale e il suo comportamento è abbastanza caotico. Per esempio, con 6/5 si arriva in 18 passi ad un numero di 57735 cifre prima di raggiungere un numero intero, con 200/199 si arriva ad un numero di 10^435 cifre. È congetturato, ma non dimostrato, che iterando la quadratura approssimata si ottenga sempre un numero intero.
La seguente tabella mostra alcune frazioni di esempio con i relativi risultati:

  Frazione  Passi  Numero
  --------  -----  ------
  3/2       1      3
  5/2       2      60
  7/2       1      14
  9/2       3      268065
  11/2      1      33
  13/2      2      2093
  15/2      1      60
  17/2      4      1204154941925628
  19/2      1      95

Scrivere un programma che calcola il numero di passaggi per raggiungere un numero intero partendo da una frazione x = n/d con n > d > 1.

La funzione che calcola la squadratura approssimata è la seguente:

(define (approx n d)
  (div (* n (ceil (div n d))) d))

Purtroppo le funzioni "div" e "ceil" non possono essere utilizzate con i big-integer, allora simuliamo la funzione "ceil" nel modo seguente:
  se (% n d) = 0, allora (ceil (div n d)) = (/ n d)
              altrimenti (ceil (div n d)) = (+ (/ n d) 1)

Scriviamo la funzione:

(define (itera n d)
  (let (passi 0L)
    ; fintanto che n/d non è un numero intero...
    (do-until (zero? (% n d))
      (++ passi)
      ; calcola il nuovo numeratore
      (if (zero? (% n d))
        ;(setq n (* n (int (ceil (div n d)))))
        (setq n (* n (/ n d)))
        (setq n (* n (+ 1L (/ n d))))
      ))
    (list passi (/ n d))))

(itera 8L 7L)
;-> (3L 48L)
(itera 3 2)
;-> (1L 3)
(itera 9 2)
;-> (3L 268065)
(itera 17L 2L)
;-> (4L 1204154941925628L)
(itera 10L 6L)
;-> (6L 1484710602474311520L)

Vediamo il numero da 57735 cifre:

(length (last (itera 6L 5L)))
;-> 57735

La seguente espressione "crasha" newLISP...perchè  un numero di 10^435 cifre dove lo mette?

(length (last (itera 200L 199L)))
;->  puff


-----------------------------------------
Introduzione alla programmazione dinamica
-----------------------------------------

"Dynamic Programming is not about filling in tables, but writing smart recursions." – Jeff Erickson.

La programmazione dinamica è un metodo per risolvere un problema complesso scomponendolo in un insieme di sottoproblemi più semplici, e poi risolvendo ciascuno di questi sottoproblemi una sola volta e memorizzando le loro soluzioni in una utilizzando una struttura di dati (lista, vettore, hash, ecc.). Ogni soluzione del sottoproblema è indicizzata in qualche modo, in genere in base ai valori dei parametri di input, per facilitarne la ricerca. Quindi, la prossima volta che si verifica lo stesso sottoproblema, invece di ricalcolare la sua soluzione, si utilizza la soluzione calcolata in precedenza, risparmiando così tempo di calcolo. Questa tecnica di memorizzazione delle soluzioni ai sottoproblemi invece di ricalcolarli è chiamata memoizzazione.

Ecco una brillante metafora per spiegare ad un principiante il concetto alla base della programmazione dinamica:

https://www.quora.com/How-should-I-explain-dynamic-programming-to-a-4-year-old/answer/Jonathan-Paulson

  *writes down "1+1+1+1+1+1+1+1 =" on a sheet of paper*
  "What's that equal to?"
  *counting* "Eight!"
  *writes down another "1+" on the left*
  "What about that?"
  *quickly* "Nine!"
  "How'd you know it was nine so fast?"
  "You just added one more."
  "So you didn't need to recount because you remembered there were eight! Dynamic Programming is just a fancy way to say 'remembering stuff to save time later'"

Ci sono due attributi chiave che un problema deve avere affinché la programmazione dinamica sia applicabile: una sottostruttura ottimale e sovrapposizione dei sottoproblemi.

1. Sottostruttura ottimale
La programmazione dinamica semplifica un problema complicato suddividendolo in sottoproblemi più semplici in modo ricorsivo. Un problema che può essere risolto in modo ottimale suddividendolo in sottoproblemi e quindi trovando ricorsivamente le soluzioni ottimali dei sottoproblemi si dice che abbia una sottostruttura ottimale. In altre parole, la soluzione di un dato problema di ottimizzazione può essere ottenuta dalla combinazione delle soluzioni ottime dei suoi sottoproblemi (le soluzioni dei sottoproblemi sono indipendenti tra di loro).

Ad esempio, il cammino minimo p da un vertice u a un vertice v in un dato grafo mostra una sottostruttura ottimale: prendiamo qualsiasi vertice intermedio w su questo cammino minimo p. Se p è veramente il cammino minimo, allora può essere suddiviso in sottopercorsi p1 da u a w e p2 da w a v tali che questi, a loro volta, siano effettivamente i cammini più brevi tra i vertici corrispondenti.

2. Sovrapposizione dei sottoproblemi
Si dice che un problema ha sottoproblemi sovrapposti se il problema può essere suddiviso in sottoproblemi e ogni sottoproblema viene ripetuto più volte, o un algoritmo ricorsivo per il problema risolve ripetutamente lo stesso sottoproblema invece di generare sempre nuovi sottoproblemi.

Ad esempio, il problema del calcolo della sequenza di Fibonacci mostra sottoproblemi sovrapposti. Il problema del calcolo dell'n-esimo numero di Fibonacci F(n) può essere scomposto nei sottoproblemi del calcolo di F(n-1) e F(n-2) e quindi sommando i due. Il sottoproblema del calcolo di F(n-1) può essere esso stesso scomposto in un sottoproblema che coinvolge il calcolo di F(n-2). Pertanto, il calcolo di F(n-2) viene riutilizzato e la sequenza di Fibonacci mostra quindi sottoproblemi sovrapposti. La programmazione dinamica tiene conto di questo fatto e risolve ogni sottoproblema una sola volta. Ciò può essere ottenuto in uno dei due modi seguenti:

Approccio top-down (dall'alto verso il basso) (Memoizzazione): questa è la ricaduta diretta della formulazione ricorsiva di qualsiasi problema. Se la soluzione a qualsiasi problema può essere formulata ricorsivamente utilizzando la soluzione ai suoi sottoproblemi e se i suoi sottoproblemi si sovrappongono, si può facilmente utilizzare la memoizzazione oppure memorizzare le soluzioni dei sottoproblemi in una tabella. Ogni volta che tentiamo di risolvere un nuovo sottoproblema, prima controlliamo la tabella per vedere se è già stato risolto. Se il sottoproblema è già risolto, usiamo direttamente la sua soluzione, altrimenti, risolviamo il sottoproblema e aggiungiamo la sua soluzione alla tabella.

Approccio bottom-up (dal basso verso l'alto) (Tabella): una volta che formuliamo la soluzione a un problema in modo ricorsivo in termini di sottoproblemi, possiamo provare a riformulare il problema in modo dal basso verso l'alto: proviamo a risolvere prima i sottoproblemi e usiamo le loro soluzioni per costruire verso l'alto e arrivare alle soluzioni dei sottoproblemi più grandi. Questo viene solitamente fatto anche in forma tabellare generando in modo iterativo soluzioni a sottoproblemi sempre più grandi utilizzando le soluzioni dei sottoproblemi più piccoli. Ad esempio, se conosciamo già i valori di F(i-1) e F(i-2), possiamo calcolare direttamente il valore di F(i).
Quando un problema può essere risolto combinando soluzioni ottimali con sottoproblemi non sovrapposti, allora la strategia si chiama "Divide et impera". Questo è il motivo per cui il MergeSort e il QuickSort non sono classificati come problemi di programmazione dinamica.

Consideriamo un'implementazione ricorsiva di una funzione che trova l'ennesimo numero della sequenza di Fibonacci:

(define (fib num)
  (if (<= num 1)
      num
      (+ (fib (- num 1)) (fib (- num 2)))))

(fib 5)
;-> 5

Quando chiamiamo (fib 5) (per esempio) produciamo un albero di chiamate che chiama la funzione sullo stesso valore molte volte:

                                   (fib 5)
                                   .     .
                                .           .
                             .                 .
                          .                       .
                       .                             .
                    (fib 4)                        (fib 3)
                  .        .                         .  .
                .            .                      .    .
              .                .                   .      .
          (fib 3)            (fib 2)            (fib 2) (fib 1)
            / \                / \                / \
           /   \              /   \              /   \
          /     \            /     \            /     \
      (fib 2) (fib 1)    (fib 1) (fib 0)    (fib 1) (fib 0)
        / \
       /   \
      /     \
  (fib 1) (fib 0)

In particolare, (fib 3) è stato calcolato due volte e (fib 2) è stato calcolato tre volte. Con numeri più grandi vengono ricalcolati molti più sottoproblemi, portando questo algoritmo ad una complessità temporale esponenziale.

Ora supponiamo di avere una struttura per memorizzare i risultati intermedi di fib e modifichiamo la nostra funzione per usarlo e aggiornarlo. La funzione risultante viene eseguita in tempo O(n) anziché in tempo esponenziale (ma richiede uno spazio O(n)).

Di seguito è riportata l'implementazione basata su questo metodo:

; lista associativa per memorizzare i risultati parziali
(setq memo '())

(define (fib-memo num)
  (local (val)
    (cond ((<= num 1)
            num)
          ; se il numero di Fibonacci relativo a num non è stato calcolato
          ((nil? (lookup num memo))
            ; allora lo calcola...
            (setq val (+ (fib-memo (- num 1)) (fib-memo (- num 2))))
            ; e poi mette il risultato
            ; (num fib(num)) nella lista associativa memo
            (push (list num val) memo -1)))
    (lookup num memo)))

(fib-memo 5)
;-> 5

Da notare che avremmo potuto usare un'altra struttura dati per memorizzare i valori invece di una lista associativa (vettore, hash-map, ecc.).

Questa tecnica di memorizzazione dei valori già calcolati è chiamata memoizzazione e questo è l'approccio top-down poiché prima suddividiamo il problema in sottoproblemi e poi calcoliamo e memorizziamo i valori.

Nell'approccio bottom-up, calcoliamo prima i valori più piccoli di fib, quindi costruiamo da essi valori più grandi. Anche questo metodo utilizza un tempo O(n) poiché contiene un ciclo che si ripete n-1 volte, ma richiede solo uno spazio costante O(1) costante, in contrasto con l'approccio top-down, che richiede spazio O(n) per memorizzare tutti i risultati. In questo caso la tabella di memorizzazione è costituita solo da tre valori: il valore corrente di fib, il valore precedente e il valore successivo.

Di seguito è riportato il programma che utilizza questo metodo (tabella):

(define (fib-tab num)
  (local (new-fib prev-fib curr-fib)
    (cond ((<= num 1) num)
          (true
           (setq prev-fib 0)
           (setq curr-fib 1)
           (for (i 1 (- num 1))
              (setq new-fib (+ prev-fib curr-fib))
              (setq prev-fib curr-fib)
              (setq curr-fib new-fib))))
    curr-fib))

(fib-tab 5)
;-> 5

In entrambe le ultime due funzioni, la chiamata a (fib 5) calcola (fib 2) solo una volta e poi il valore viene usato per calcolare sia (fib 4) che (fib 3), invece di essere ricalcolato nuovamente ogni volta che deve essere valutato.


--------------------------------------------------------------------
Programmazione dinamica: il gioco delle pentole d'oro (pots of gold)
--------------------------------------------------------------------

Ci sono due giocatori, A e B, e delle pentole disposte in fila ciascuna contenente alcune monete d'oro. I giocatori possono vedere quante monete ci sono in ogni pentola. A turni alternati ogni giocatore può scegliere una pentola da una delle estremità della linea. Alla fine il vincitore è il giocatore che ha un numero maggiore di monete. Per esempio, la seguente lista rappresenta una linea di 8 pentole ognuna contenente un numero di monete (valore dell'elemento):

(setq pentole '(3 4 1 6 7 4 8 9))

L'obiettivo del nostro problema è "massimizzare" il numero di monete raccolte da A, supponendo che B giochi "in modo ottimale" e che A inizi il gioco.

Vediamo un paio di esempi:

Pentole              A    B
4, 6, 2, 3           3
4, 6, 2                   4
6, 2                 6
2                         2
                    --------
totale monete        9    6

Pentole              A    B
6, 1, 4, 9, 8, 5     6
1, 4, 9, 8, 5             5
1, 4, 9, 8           8
1, 4, 9                   9
1, 4                 4
1                         1
                    --------
totale monete       18   15

L'idea è quella di trovare una strategia ottimale che faccia vincere il giocatore A, sapendo che l'avversario sta giocando in modo ottimale. Il giocatore ha due scelte per coin[i..j], dove i e j indicano rispettivamente la parte anteriore e quella posteriore della linea di pentole.

1. Se il giocatore sceglie la pentola anteriore i, l'avversario può scegliere tra [i+1, j].
       Se l'avversario sceglie la pentola anteriore i+1, ricorsione per [i+2, j].
       Se l'avversario sceglie la pentola posteriore j, ricorsione per [i+1, j-1].

2. Se il giocatore sceglie la pentola posteriore j, l'avversario può scegliere tra [i, j-1].
       Se l'avversario sceglie la pentola anteriore i, ricorsione per [i+1, j-1].
       Se l'avversario sceglie la pentola posteriore j-1, ricorsione per [i, j-2].

Poiché l'avversario sta giocando in modo ottimale, cercherà di ridurre al minimo i punti del giocatore, cioè l'avversario farà una scelta che lascerà al giocatore il minimo di monete. Quindi, possiamo definire ricorsivamente il problema nel modo seguente:

                 | coin[i]                            (se i = j)
 optimal(i, j) = | max(coin[i], coin[j])              (se i + 1 = j)
                 | max(coin[i] + min(optimal(coin, i + 2, j),
                           optimal(coin, i + 1, j – 1)),
                           coin[j] + min(optimal(coin, i + 1, j – 1),
                           optimal(coin, i, j – 2)))

Quindi la funzione che implementa la strategia ottimale è la seguente:

(define (optimal pentole i j)
  ; caso base: una pentola rimasta, solo una scelta possibile
  (cond ((= i j)
        (pentole i))
        ; se rimangono solo due pentole,
        ; scegliere quella con il massimo numero di monete
        ((= (+ i 1) j)
          (max (pentole i) (pentole j)))
        (true
          (local (inizio fine)
          ; Se il giocatore sceglie la pentola anteriore i,
          ; l'avversario può scegliere tra [i+1, j].
          ; 1. Se l'avversario sceglie la pentola anteriore i+1,
          ;    ricorsione per [i+2, j].
          ; 2. Se l'avversario sceglie la pentola posteriore j,
          ;    ricorsione per [i+1, j-1].
          (setq inizio (+ (pentole i) (min (optimal pentole (+ i 2) j)
                                           (optimal pentole (+ i 1) (- j 1)))))
          ; Se il giocatore sceglie la pentola posteriore j,
          ; l'avversario può scegliere tra [i, j-1].
          ; 1. Se l'avversario sceglie la pentola anteriore i,
          ;    ricorsione per [i+1, j-1].
          ; 2. Se l'avversario sceglie la pentola posteriore j-1,
          ;  ricorsione per [i, j-2].
          (setq fine (+ (pentole j) (min (optimal pentole (+ i 1) (- j 1))
                                         (optimal pentole i (- j 2)))))
          (max inizio fine)))))

Funzione main:

(define (pots-gold pots)
  (local (i j)
    (setq i 0)
    (setq j (- (length pots) 1))
    (optimal pots i j)))

(pots-gold '(4 6 2 3))
;-> 9
(pots-gold '(6 1 4 9 8 5))
;-> 18
(setq pentole '(3 4 1 6 7 4 8 9))
(pots-gold pentole)
;-> 23

La complessità temporale della soluzione di cui sopra è esponenziale e occupa spazio nello stack di chiamate.

Il problema ha una sottostruttura ottimale, quindi può essere suddiviso in sottoproblemi più piccoli, che possono essere ulteriormente suddivisi in sottoproblemi ancora più piccoli e così via. Il problema mostra anche sottoproblemi sovrapposti, quindi finiremo per risolvere lo stesso sottoproblema più e più volte. Abbiamo visto che i problemi con sottostruttura ottimale e sottoproblemi sovrapposti possono essere risolti mediante la programmazione dinamica, in cui le soluzioni dei sottoproblemi vengono memorizzate piuttosto che calcolate di nuovo.

Vediamo la versione top-down:

(define (optimal-td pentole i j)
  (local (inizio fine)
  ; caso base: una pentola rimasta, solo una scelta possibile
  (cond ((= i j)
         (pentole i))
        ; se rimangono solo due pentole,
        ; scegliere quella con il massimo numero di monete
        ((= (+ i 1) j)
         (max (pentole i) (pentole j)))
        ; valore non calcolato?
        ((zero? (memo i j))
         (setq inizio (+ (pentole i) (min (optimal-td pentole (+ i 2) j)
                                          (optimal-td pentole (+ i 1) (- j 1)))))
         (setq fine (+ (pentole j) (min (optimal-td pentole (+ i 1) (- j 1))
                                        (optimal-td pentole i (- j 2)))))
         (setf (memo i j) (max inizio fine)))
         (true
          (memo i j)))))

(define (pots-gold-td pots)
  (local (memo i j)
    (setq memo (array (length pots) (length pots) '(0)))
    (setq i 0)
    (setq j (- (length pots) 1))
    (optimal-td pots i j)))

(pots-gold-td '(4 6 2 3))
;-> 9
(pots-gold-td '(6 1 4 9 8 5))
;-> 18
(setq pentole '(3 4 1 6 7 4 8 9))
(pots-gold-td pentole)
;-> 23

La complessità temporale di questa soluzione è O(n^2) e richiede O(n^2) spazio extra, dove n è il numero totale di pentole.

Vediamo la versione bottom-up:

(define (calc T i j)
  (if (<= i j)
      (T i j)
      0))

(define (optimal-bu pentole)
  (local (len dp j inizio fine)
    (setq len (length pentole))
    (cond ((= len 1) (pentole 0))
          ((= len 2) (max (pentole 0) (pentole 1)))
          (true
           ; matrice 2D dinamica per memorizzare
           ; le soluzioni dei sottoproblemi
           (setq dp (array len len '(0)))
           (for (iter 0 (- len 1))
              (setq i 0)
              (for (j iter (- len 1))
                (setq inizio (+ (pentole i) (min (calc dp (+ i 2) j)
                                                 (calc dp (+ i 1) (- j 1)))))
                (setq fine (+ (pentole j) (min (calc dp (+ i 1) (- j 1))
                                              (calc dp i (- j 2)))))
                (setf (dp i j) (max inizio fine))
                (++ i)
              )
           )
           ;(println dp)
           (dp 0 (- len 1))))))

(define (pots-gold-bu pots)
    (optimal-bu pots))

(pots-gold-bu '(4 6 2 3))
;-> 9
(pots-gold-bu '(6 1 4 9 8 5))
;-> 18
(setq pentole '(3 4 1 6 7 4 8 9))
(pots-gold-bu pentole)
;-> 23

La complessità temporale di questa soluzione è O(n^2) e richiede O(n) spazio extra, dove n è il numero totale di pentole.

Nota: questo algoritmo non assicura che il giocatore A vinca sempre. La vittoria di A dipende dalla casualità della distribuzione delle pentole, questo algoritmo massimizza il valore che A può ottenere, ma non è detto che il valore di B sia inferiore. Per convincersi è sufficiente considerare la seguente distribuzione di pentole: (1 3 1). Qualunque scelta faccia A, il massimo che può ottenere è 2, mentre B può ottenere 3:

(pots-gold-bu '(1 3 1))
;-> 2

In altre parole, questo algoritmo trova il comportamento ottimale per il giocatore A, ma non è in grado di definire una strategia vincente.

Nota: per definire una strategia vincente (se la distribuzione iniziale lo consente) occorre usare un algoritmo che considera l'intero albero delle possibili mosse (infatti è necessario ricorrere più in profondità per ottenere la soluzione ottimale anziché limitarsi a raggiungere il massimo alla mossa successiva).

Nota: per rendere più equo il gioco il numero di pentole dovrebbe essere pari, altrimenti il primo giocatore A sceglierebbe una pentola in più del giocatore B.

Comunque se il numero di pentole è dispari, allora il giocatore B è in grado di selezionare una determinata pentola.
Per esempio, nella distribuzione (1 2 6 2 101 6 8) il giocatore B sarà sempre in grado di scegliere la pentola con 101 monete (e vincere il gioco):
(pots-gold-bu '(1 2 6 2 101 6 8))
;-> 18

Invece se il numero di pentole è pari, allora il giocatore A è in grado di selezionare una determinata pentola.
Per esempio, nella distribuzione (1 2 6 2 101 6) il giocatore A sarà sempre in grado di scegliere la pentola con 101 monete (e vincere il gioco):
(pots-gold-bu '(1 2 6 2 101 6))
;-> 108

Per maggiori informazioni consultare l'articolo "An Optimal Algorithm for Calculating the Profit in the Coins in a Row Game" di Tomasz Idziaszek.

Quante partite diverse possono essere giocate con una fila di n pentole?

Una partita può essere considerata una sequenza di catture a Sinistra o a Destra della linea, cioè una partita con quattro pentole può essere rappresentata dalla lista (s s d d): A prende a Sinistra, B prende a Sinistra, A prende a destra e, infine, B prende a destra.
Comunque la lista (s s d d) è equivalente alla lista (s s d s), perchè l'ultima pentola si trova indifferentemente a Sinistra e a Destra.
Quindi il numero di partite è dato da tutte le permutazioni con ripetizione di s e d di lunghezza (n - 1):

(define (perm-rep k lst)
  (if (zero? k) '(())
      (flat (map (lambda (p) (map (lambda (e) (cons e p)) lst))
                         (perm-rep (- k 1) lst)) 1)))

Queste sono tutte le possibili partite con una linea di 2 pentole (s=sinistra, d=destra)
(perm-rep 1 '(s d))
;-> ((s) (d))

Queste sono tutte le possibili partite con una linea di 4 pentole (s=sinistra, d=destra)
(perm-rep 3 '(s d))
;-> ((s s s) (d s s) (s d s) (d d s) (s s d) (d s d) (s d d) (d d d))

Queste sono tutte le possibili partite con una linea di 5 pentole (s=sinistra, d=destra)
(perm-rep 4 '(s d))
;-> ((s s s s) (d s s s) (s d s s) (d d s s) (s s d s) (d s d s) (s d d s)
;->  (d d d s) (s s s d) (d s s d) (s d s d) (d d s d) (s s d d) (d s d d)
;->  (s d d d) (d d d d))

Quindi la funzione che calcola il numero di partite con n pentole è la seguente:

(define (game-pots num)
  (length (perm-rep (- num 1) '(s d))))

Oppure più semplicemente,

  numero partite = elementi^scelte

dove "elementi" è il numero di cose tra cui scegliere (s e d), e ne scegliamo "scelte" (num-1), la ripetizione è consentita e l'ordine è importante.

(define (game-pots num)
  (pow 2 (- num 1)))

(game-pots 10)
;-> 512

Scriviamo una funzione che data una linea di pentole calcola il risultato di tutte le partite possibili:

(define (all-game lst)
  (local (len perm tmp val aa bb tot-a tot-b tot-ab)
    ;tot-a:  vittoria giocatore A
    ;tot-b:  vittoria giocatore B
    ;tot-ab: pareggio
    (setq tot-a 0 tot-b 0 tot-ab 0)
    (setq len (length lst))
    (setq perm (perm-rep (- len 1) '(s d)))
    ; per ogni permutazione
    (dolist (p perm)
      (setq tmp lst)
      (setq aa 0 bb 0)
      ; per ogni elemento di una permutazione (partita)
      (dolist (el p)
        ; calcola il valore preso (a sinistra o a destra)
        (if (= el 's)
          (setq val (pop tmp 0))
          (setq val (pop tmp -1))
        )
        ; aumenta il punteggio del relativo giocatore
        (if (even? $idx)
            (setq aa (+ aa val))
            (setq bb (+ bb val))
        )
      )
      ; assegna l'ultimo valore della lista
      ; ad uno dei due giocatori
      (if (odd? len)
          (setq aa (+ aa (last tmp)))
          (setq bb (+ bb (last tmp)))
      )
      ;(println lst { } p { } aa { } bb)
      ; aumenta numero vittorie al vincitore corrente
      (cond ((= aa bb) (++ tot-ab))
            ((> aa bb) (++ tot-a))
            (true (++ tot-b)))
    )
    (list tot-a tot-b tot-ab)
  )
)

(all-game '(1 2 3 4 5 6 7))
;-> (45 12 7)

(all-game '(1 3 1))
;-> (2 2 0)

(all-game '(3 9 5 7 1 6 4 8 1 9 8 7))
;-> (914 995 139)


---------------------------------------------
Somma delle cifre in posizioni pari e dispari
---------------------------------------------

Scrivere una funzione che calcola tutti i numeri fino ad un dato limite che hanno la seguente proprietà:

la somma delle cifre in posizione pari è uguale alla somma delle cifre in posizione dispari

Prendiamo per esempio il numero 7523351:

somma delle cifre con indice pari: 5 + 3 + 5 = 13
somma delle cifre con indice dispari: 7 + 2 + 3 + 1 = 13

Quindi il numero 7523351 soddisfa la condizione.

Sequenza OEIS A135499: 11, 22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 132,
 143, 154, 165, 176, 187, 198, 220, 231, 242, 253, 264, 275, 286, 297, 330,
 341, 352, 363, 374, 385, 396, 440, 451, 462, 473, 484, 495, 550, 561, 572,
 583, 594, 660, 671, 682, 693, 770, 781, 792, 880, 891, 990, ...

Funzione che verifica se un numero soddisfa la condizione:

(define (equal-sum? num)
  (if (zero? num) nil
      (local (odd-sum even-sum len)
        (setq odd-sum 0 even-sum 0)
        (setq len (length num))
        (while (!= num 0)
          (if (odd? len)
              (setq odd-sum (+ odd-sum (% num 10)))
              (setq even-sum (+ even-sum (% num 10)))
          )
          (setq num (/ num 10))
          (-- len)
        )
        (= odd-sum even-sum))))

(equal-sum? 0)
;-> nil
(equal-sum? 7523351)
;-> true
(equal-sum? 11165)
;-> true
(equal-sum? 11111)
;-> nil

Funzione che calcola tutti i numeri che verificano la condizione fino ad un dato limite:

(define (equal-sum limite)
  (let (out '())
    (for (i 1 limite)
      (if (equal-sum? i)
          (push i out -1)))
    out))

(equal-sum 1e3)
;-> (11 22 33 44 55 66 77 88 99 110 121 132 143 154 165 176 187 198 220 231
;->  242 253 264 275 286 297 330 341 352 363 374 385 396 440 451 462 473 484
;->  495 550 561 572 583 594 660 671 682 693 770 781 792 880 891 990)

(time (println (length (equal-sum 1e8))))
;-> 4816029
;-> 186272.126 ; 3 minuti e 6 secondi


-------------------------------------
Ordinare una lista con un'altra lista
-------------------------------------

Supponiamo di avere una lista di numeri e una seconda lista di indici o di posizioni. Per esempio,

lista di numeri:
(setq nums '(3 5 2 8 6 4))

lista di posizioni:
(setq pos '(3 2 1 4 5 0))

lista di indici:
(setq idx '(3 2 1 4 5 0))

Primo problema
Ordinare la lista di numeri in accordo con la lista di posizioni. In questo caso l'elemento i-esimo della lista "nums" deve essere posizionato/spostato all'indice ord(i), cioè nums(i) = nums(ord(i)).

(define (order1 lst pos)
  (local (len out)
    (setq len (length lst))
    (setq out (array len '(0)))
    (for (i 0 (- len 1))
      (setf (out (pos i)) (lst i))
    )
    out))

(order1 '(1 2 3 4 5) '(3 2 4 1 0))
;-> (5 4 2 1 3)

(order1 nums pos)
;-> (4 2 5 3 8 6)

Secondo problema
Ordinare la lista di numeri in accordo agli indici della lista di indici. In questo caso l'elemento i-esimo della lista "idx" rappresenta l'indice del numero che va posizionato/spostato alla posizione i-esima, cioè nums(idx(i)) = nums(i)

(define (order2 lst idx)
  (local (len out)
    (setq len (length lst))
    (setq out (array len '(0)))
    (for (i 0 (- len 1))
      (setf (out i) (lst (idx i)))
    )
    out))

(order2 '(1 2 3 4 5) '(3 2 4 1 0))
;-> (4 3 5 2 1)

(order2 nums idx)
;-> (8 2 5 6 4 3)

Nota: newLISP ha la funzione primitiva "select" che produce lo stesso risultato di "order2":

(select '(1 2 3 4 5) '(3 2 4 1 0))
;-> (4 3 5 2 1)
(select nums idx)
;-> (8 2 5 6 4 3)


--------------------
Test di Lucas-Lehmer
--------------------

Il test di Lucas-Lehmer è una verifica della primalità dei primi di Mersenne.
Per p numero primo, detto M(p) = 2^p - 1 il p-esimo numero di Mersenne, esso è primo se e solo se divide L(p-1), dove L(n) è l'n-esimo termine della successione definita ricorsivamente come:

  L(n+1) = L(n)^2 - 2, con L(1) = 4

Il test è stato sviluppato da Lucas nel 1870 e semplificato da Lehmer nel 1930.

La seguente funzione calcola i numeri primi di mersenne fino a un dato indice. Il secondo numero di Mersenne, M2, è primo, ma la funzione seguente calcola solo da M3 fino all'indice dato.

Nota: M2 è l'unico numero di Mersenne con indice pari (perchè l'indice è un numero primo).

(define (lucas-lehmer limite)
  (local (s n i expo)
    (println "M2 primo.")
    (setq n 1L)
    (for (expo 2 limite)
      (if (= expo 2)
          (setq s 0L)
          (setq s 4L))
      ; evita l'utilizzo della funzione pow
      (setq n (- (* (+ n 1) 2) 1))
      (for (i 1 (- expo 2))
        (setq s (% (- (* s s) 2) n)))
      (if (zero? s)
          (println "M" expo " primo.")))))

(lucas-lehmer 1000)
;-> M2 primo.
;-> M3 primo.
;-> M5 primo.
;-> M7 primo.
;-> M13 primo.
;-> M17 primo.
;-> M19 primo.
;-> M31 primo.
;-> M61 primo.
;-> M89 primo.
;-> M107 primo.
;-> M127 primo.
;-> M521 primo.
;-> M607 primo.

(time (lucas-lehmer 2300))
;-> M2 primo.
;-> M3 primo.
;-> M5 primo.
;-> M7 primo.
;-> M13 primo.
;-> M17 primo.
;-> M19 primo.
;-> M31 primo.
;-> M61 primo.
;-> M89 primo.
;-> M107 primo.
;-> M127 primo.
;-> M521 primo.
;-> M607 primo.
;-> M1279 primo.
;-> M2203 primo.
;-> M2281 primo.
;-> 89791.177 ; 90 secondi


-------------
0,1,2 con 0,1
-------------

Scrivere un algoritmo per generare 0, 1 e 2 con uguale probabilità utilizzando una funzione che produce 0 o 1 con il 50% di probabilità.

Supponiamo che la funzione specificata sia rnd(), che genera 0 o 1 con una probabilità del 50%. Quindi, se effettuiamo due chiamate diverse alla funzione rnd() e memorizziamo il risultato in due variabili, a e b, la loro somma a+b può essere uno qualsiasi di {0, 1, 2}. Qui, la probabilità di ottenere 0 e 2 è del 25% ciascuno e la probabilità di ottenere 1 è del 50%.
Ora il problema si riduce alla diminuzione della probabilità di ottenere 1 dal 50% al 25%. Possiamo farlo facilmente forzando la nostra funzione a non generare mai né (a = 1, b = 0) oppure (a = 0, b = 1), il che fa sì che la somma sia uguale a 1.

(define (rnd012)
  (local (a b)
    (setq a (rand 2))
    (setq b (rand 2))
    (if (and (= a 1) (= b 0))
        (rnd012)
        (+ a b))))

(rnd012)
;-> 0
(rnd012)
;-> 2

(define (test iter)
  (let (freq '(0 0 0))
    (for (i 1 iter)
      (++ (freq (rnd012))))
    (map (fn(x) (div x iter)) freq)))

Calcoliamo le frequenze:

(test 1e5)
;-> (0.33403 0.33284 0.33313)
(test 1e8)
;-> (0.33333341 0.33337291 0.33329368)


------------------------------------
Angolo delle lancette di un'orologio
------------------------------------

Data l'ora in formato ore:minuti, calcolare l'angolo minore tra la lancetta delle ore e quella dei minuti in un orologio analogico.
Per esempio:

Ora:  5:30
Angolo: 15°

Ora:  9:10
Angolo: 145°

Ora:  12:55
Angolo: 57°

La lancetta delle ore di un orologio analogico a 12 ore ruota di 360° in 12 ore e la lancetta dei minuti ruota di 360° in 60 minuti. Quindi, possiamo calcolare l'angolo in gradi della lancetta delle ore e della lancetta dei minuti separatamente e poi restituire la loro differenza utilizzando la seguente formula:

  Gradi(ore) = ore*(360/12) + (minuti*360)/(12*60)

  Gradi(minuti) = minuti*(360/60)

dove: 0 <= ore <= 23 e 0 <= minuti <= 59

L'angolo deve essere in gradi e misurato in senso orario dalla posizione delle ore 12 dell'orologio. Se l'angolo è maggiore di 180°, allora prendere la sua differenza con 360.

(define (angolo ore minuti)
  (local (angle-ore angle-minuti)
    (setq angle-ore (+ (/ (* ore 360) 12) (/ (* minuti 360) (* 12 60))))
    (setq angle-minuti (/ (* minuti 360) 60))
    (setq diff (abs (- angle-ore angle-minuti)))
    (if (> diff 180)
        (- 360 diff)
        diff)))

(angolo 5 30)
;-> 15
(angolo 9 10)
;-> 145
(angolo 12 55)
;-> 57
(angolo 1 30)
;-> 135


----------
Data e ora
----------

Scrivere una funzione che stampa la data e l'ora corrente aggiornate in tempo reale (al secondo).

newLISP ha la funzione "now" che restituisce una lista con le informazioni che ci servono (vedere il manuale per maggiori informazioni).

(define (clock)
  (local (year month day hour minute second
          days-name months-name erase actual val)
    (setq days-name '("0" "lunedì" "martedì" "mercoledì" "giovedì" "venerdì" "sabato" "domenica"))
    (setq months-name '("gennaio" "febbraio" "marzo" "aprile" "maggio" "giugno" "luglio"
                      "agosto" "settembre" "ottobre" "novembre" "dicembre"))
    (setq erase (dup " " 70))
    (setq actual (slice (now) 0 6))
    (setq val '())
    ; infinite loop (break with CTRL-C)
    (while true
             ; update only when change year or
             ; month or day or hour or minute or second
      (cond ((!= actual (slice val 0 6))
             (setq val (now))
             (setq actual (slice val 0 6))
             (setq year (string (val 0)))
             (setq month (months-name (val 1)))
             (setq day (string (val 2)))
             (setq hour (string (val 3)))
             (setq minute (string (val 4)))
             (setq second (string (val 5)))
             (setq day-name (days-name (val 8)))
             (setq printed (string " " day-name ", " day " " month " " year ", " hour ":" minute ":" second))
             ; erase output line (print blank chars)
             (print (dup " " (length printed)) " \r")
             ; print informations
             (print printed "\r"))
            (true
             ; update clock values
             (setq val (now)))))))

(clock)
;->  lunedì, 28 luglio 2021, 16:49:28

Nota: premere CTRL-C per terminare il programma.


------------------------
Corda intorno alla Terra
------------------------

Supponiamo di avere una corda che circonda una Terra perfettamente sferica che ha una circonferenza pari a 40000 km. La corda viene allungata di 1 metro e posta come una circonferenza a distanza costante dalla Terra.
Quanto è distante la nuova circonferenza dalla Terra?
Di quanto bisogna allungare la corda per fare una circonferenza che si trovi a 1 metro di distanza dalla Terra?

La prima circonferenza C vale:

  C = 2*π*R

La seconda circonferenza C + L vale:

  C + L = 2*π*R1

dove R e R1 sono i raggi delle due circonferenze e L è la lunghezza della corda aggiunta.

La differenza (R1 - R) vale:

            C + L       C        C + L - C       L
  R1 - R = ------- - ------- = ------------- = -----
             2*π       2*π          2*π         2*π

Quindi la distanza dalla Terra dipende solo da quanto viene allungata la corda e non dipende dal valore della circonferenza.

(define (diff L)
  (div L (mul 2 3.1415926535897931)))

(diff 1)
;-> 0.1591549430918954

La nuova circonferenza è distante 15.9 cm dalla Terra.

(diff 5)
;-> 0.7957747154594768

Per la seconda domanda, se R - R1 = 1, allora deve risultare L = 2*π.


-------
Eredità
-------

Autore: Richard A. Proctor (1886)

Uno sceicco lascia in eredità 35 cammelli ai suoi tre figli.
L'eredità dovrà essere divisa nel modo seguente:
1/2 al figlio maggiore, 1/3 al secondogenito e 1/9 al terzo figlio, senza uccidere animali. Il notaio dovrà ricevere un cammello come ricompensa per il suo lavoro. Come dividere i cammelli?

Nota: 1/2 + 1/3 + 1/9 = 17/18 = 34/36

Il notaio presta un cammello e, dei 36 cammelli totali, il primo figlio ne prende 18 (la metà), il secondo 12 (la terza parte) ed il terzo 4 (la nona parte). In totale i cammelli "spartiti" sono 34. I due cammelli rimasti vengono presi dal notaio (uno già gli apparteneva) che quindi ottiene un cammello come ricompensa.
Da notare che tutti i figli hanno avuto di più della parte stabilita nel testamento.


-----------------
Sequenza di Farey
-----------------

La sequenza di Farey F(n) per ogni intero positivo n è l'insieme dei numeri razionali a/b irriducibili (ridotti ai minimi termini) con 0<=a<=b<=n e (a,b)=1 disposti in ordine crescente.

Un termine a/b può essere valutato ricorsivamente utilizzando i due termini precedenti. Di seguito è riportata la formula per calcolare a(n+2)/b(n+2) da a(n+1)/b(n+1) e a(n)/b(n):

a(n+2) = floor((b(n) + n)/b(n+1))*a(n+1) - a(n)
b(n+2) = floor((b(n) + n)/b(n+1))*b(n+1) - b(n)

(define (farey num)
  (local (a b a1 b1 a2 b2 out)
    (setq out '())
    (setq a1 0 b1 1 a2 1 b2 num)
    ; il primo termine vale 0/1
    (push (list 0 1) out)
    ; il secondo termine vale 1/num
    (push (list 1 num) out -1)
    ; inizializzazione dei valori nuovo termine
    (setq a 0 b 0)
    ; ciclo fino a che b = 1
    (while (!= b 1)
      ; relazione per trovare il termine corrente
      (setq a (- (* (floor (div (add b1 num) b2)) a2) a1))
      (setq b (- (* (floor (div (add b1 num) b2)) b2) b1))
      ; inserimento del termine corrente
      (push (list a b) out -1)
      ; aggiornamento valori per la prossima iterazione
      (setq a1 a2)
      (setq a2 a)
      (setq b1 b2)
      (setq b2 b)
    )
    ; funzione di comparazione per l'ordinamento (sort)
    (define (cmp x y) (< (div (first x) (last x)) (div (first y) (last y))))
    ; ordina la lista (crescente)
    (sort out cmp)))

(farey 7)
;-> ((0 1) (1 7) (1 6) (1 5) (1 4) (2 7) (1 3) (2 5) (3 7) (1 2)
;->  (4 7) (3 5) (2 3) (5 7) (3 4) (4 5) (5 6) (6 7) (1 1))

(length (farey 100))
;-> 3045
(length (farey 1000))
;-> 304193

Il numero N di frazioni contenute nella sequenza di Farey di un numero n vale:

          n
  N = 1 + ∑ totient(k)
         k=1

Funzione che calcola il toziente di eulero di un dato numero:

(define (totient num)
  (if (= num 1) 1
    (let (res num)
      (dolist (f (unique (factor num)))
        (setq res (- res (/ res f))))
      res)))

Funzione che calcola la lunghezza della sequenza di Farey di un dato numero:

(define (farey-len num)
  (let (out 1)
    (for (k 1 num)
      (setq out (+ out (totient k)))
    )
    out))

(farey-len 100)
;-> 3045

(farey-len 1000)
;-> 304193

              3*n²
Nota: N(n) ≈ ------
               π²

(define (farey-len2 num)
  (div (mul 3 num num) (mul 3.1415926535897931 3.1415926535897931)))

(farey-len2 1000)
;-> 303963.5509270133

(farey-len 100000)
;-> 3039650755
(farey-len2 100000)
;-> 3039635509.270134


---------------------
Distanza di Chebyshev
---------------------

La distanza di Chebyshev (o della scacchiera o di Lagrange), è il valore tale per cui la distanza tra due vettori è il valore massimo della loro differenza lungo gli assi:

  d(p,q) = max[(|p(i) - q(i)|)]

Nella geometria piana (2D), dati due punti P(x1,y1) e Q(x2,y2) la loro distanza di Chebyshev vale:

  d(P,Q) = max(|x2 - x1|,|y2 - y1|)

Nota: In due dimensioni, la distanza di Chebyshev è equivalente ad una rotazione ed una riscalatura della distanza di Manhattan.

Scriviamo una funzione che calcola la distanza di Chebyshev:

(define (dist-chebyshev x1 y1 x2 y2)
  (max (abs (sub x2 x1)) (abs (sub y2 y1))))

(dist-chebyshev 1 3 3 6)
;-> 3

In N dimensioni i due punti hanno le seguenti coordinate:

  P = (p1, p2, ..., pN)
  Q = (q1, q2, ..., qN)

E la distanza di Chebyshev tra i due punti P e Q vale:

  d(P,Q) = max(|pi - qi|), dove 1<=i<=N

Quindi la funzione generica per calcolare la distanza di Chebyshev tra due punti diventa:

(define (dist-cheby P Q)
  (apply max (map (fn(x y) (abs (sub x y))) P Q)))

(dist-cheby '(1 2 3 4) '(4 7 8 2))
;-> 5

(dist-cheby '(1 3) '(3 6))
;-> 3


----------
Anti-primi
----------

Gli anti-primi (o numeri altamente composti) sono i numeri naturali con più fattori di quelli più piccoli di se stesso. In altre parole, i numeri altamente composti sono quei numeri n dove d(n), il numero di divisori di n, aumenta a record (cioè è maggiore del precedente).

Sequenza OEIS A002182:
  1, 2, 4, 6, 12, 24, 36, 48, 60, 120, 180, 240, 360, 720, 840, 1260,
  1680, 2520, 5040, 7560, 10080, 15120, 20160, 25200, 27720, 45360,
  50400, 55440, 83160, 110880, 166320, 221760, 277200, 332640, 498960,
  554400, 665280, 720720, 1081080, 1441440, 2162160, ...

Funzione che fattorizza un numero:

(define (factor-group num)
  (if (< num 2) nil
      (letn ((out '()) (lst (factor num)) (cur-val (first lst)) (cur-count 0))
        (dolist (el lst)
          (if (= el cur-val) (++ cur-count)
              (begin
                (push (list cur-val cur-count) out -1)
                (setq cur-count 1 cur-val el))))
        (push (list cur-val cur-count) out -1))))

Funzione che conta i divisori di un numero:

(define (divisors-count num)
  (if (= num 1)
      1
      (let (lst (factor-group num))
        (apply * (map (fn(x) (+ 1 (last x))) lst)))))

Funzione che calcola gli anti-primi fino ad un dato limite:

(define (anti-primes limit)
  (local (out best)
    (setq out '())
    (setq best 0)
    (for (i 1 limit)
      (setq val (divisors-count i))
      (if (> val best) (begin
          (setq best val)
          (push (list i val) out -1))
      )
    )
    out))

(anti-primes 1000)
;-> ((1 1) (2 2) (4 3) (6 4) (12 6) (24 8) (36 9) (48 10) (60 12)
;->  (120 16) (180 18) (240 20) (360 24) (720 30) (840 32))

(map first (anti-primes 10000))
;-> (1 2 4 6 12 24 36 48 60 120 180 240 360 720 840 1260 1680 2520 5040 7560)

Possiamo calcolare anche i numeri altamente composti il cui anche il numero di divisori è un numero altamente composto.

Sequenza OEIS A189394:
  1, 2, 6, 12, 60, 360, 1260, 2520, 5040, 55440, 277200, 720720, 3603600,
  61261200, 2205403200, 293318625600, 6746328388800, 195643523275200, ...

(define (anti2-primes limit)
  (local (out best)
    (setq out '())
    (setq best 0)
    (for (i 1 limit)
      (setq val (divisors-count (divisors-count i)))
      (if (> val best) (begin
          (setq best val)
          (push (list i val) out -1))
      )
    )
    out))

(anti2-primes 10000)
;-> ((1 1) (2 2) (6 3) (12 4) (60 6) (360 8) (1260 9) (2520 10) (5040 12))
(map first (anti2-primes 1e6))
;-> (1 2 6 12 60 360 1260 2520 5040 55440 277200 720720)

(time (println (map first (anti2-primes 1e8))))
;-> (1 2 6 12 60 360 1260 2520 5040 55440 277200 720720 3603600 61261200)
;-> 683129.503


---------------------------
Numeri altamente abbondanti
---------------------------

I numeri altamente abbondanti sono quei numeri k tali che sigma(k) > sigma(m) per ogni m < k, dove sigma(k) è la somma dei divisori di k.

Sequenza OEIS A002093:
  1, 2, 3, 4, 6, 8, 10, 12, 16, 18, 20, 24, 30, 36, 42, 48, 60, 72, 84,
  90, 96, 108, 120, 144, 168, 180, 210, 216, 240, 288, 300, 336, 360,
  420, 480, 504, 540, 600, 630, 660, 720, 840, 960, 1008, 1080, 1200,
  1260, 1440, 1560, 1620, 1680, 1800, 1920, 1980, 2100, ...

Funzione che fattorizza un numero:

(define (factor-group num)
  (if (< num 2) nil
      (letn ((out '()) (lst (factor num)) (cur-val (first lst)) (cur-count 0))
        (dolist (el lst)
          (if (= el cur-val) (++ cur-count)
              (begin
                (push (list cur-val cur-count) out -1)
                (setq cur-count 1 cur-val el))))
        (push (list cur-val cur-count) out -1))))

Funzione che somma tutti i divisori di un numero:

(define (divisors-sum num)
  (local (sum out)
    (if (= num 1)
        1
        (begin
          (setq out 1)
          (setq lst (factor-group num))
          (dolist (el lst)
            (setq sum 0)
            (for (i 0 (last el))
              (setq sum (+ sum (pow (first el) i)))
            )
            (setq out (* out sum)))))))

Funzione che calcola i numeri altamente abbondanti fino ad un dato limite:

(define (high-abundant limit)
  (local (out best)
    (setq out '())
    (setq best 0)
    (for (i 1 limit)
      (setq val (divisors-sum i))
      (if (> val best) (begin
          (setq best val)
          (push (list i val) out -1))
      )
    )
    out))

(high-abundant 100)
;-> ((1 1) (2 3) (3 4) (4 7) (6 12) (8 15) (10 18) (12 28) (16 31) (18 39)
;->  (20 42) (24 60) (30 72) (36 91) (42 96) (48 124) (60 168) (72 195)
;->  (84 224) (90 234) (96 252))

(map first (high-abundant 1e3))
;-> (1 2 3 4 6 8 10 12 16 18 20 24 30 36 42 48 60 72 84 90 96
;->  108 120 144 168 180 210 216 240 288 300 336 360 420 480
;->  504 540 600 630 660 720 840 960)


-------------------------------
Creazione dinamica di variabili
-------------------------------

Scrivere una funzione che permette di creare dinamicamente una variabile.

La seguente funzione prende due parametri, il nome (stringa) della variabile da creare e il valore della varibile:

(define (create-var name-var value-var)
  (local (var)
    (setq var name-var)
    (set (sym var) value-var)
    (sym var)))

(create-var "pluto" '(10 20 30))
;-> pluto
pluto
;-> '(10 20 30)
(list? pluto)
;-> true

Possiamo anche creare una variabile definita dall'utente:

(define (make-var)
  (local (var)
    (print "Nome della variabile: ")
    (setq var (read-line))
    ; crea il simbolo/variabile inserito dall'utente come stringa
    (set (sym var) '())
    (println "Variabile " var " creata.")
    (println "Valore della variabile: " (eval (sym var)))
    (print "Nuovo valore della variabile: ")
    ;(set (sym var) (sym (read-line))) ; no list, only a symbol !!!
    ; eval-string valuta la stringa inserita dall'utente
    (set (sym var) (eval-string (read-line)))
    (println (sym var) " = " (eval (sym var)))
  ))

(make-var)
;-> Nome della variabile:
pippo
;-> Variabile pippo creata.
;-> Valore della variabile: ()
;-> Nuovo valore della variabile:
'(10 20 30)
;-> pippo = (10 20 30)
pippo
;-> (10 20 30)
(list? pippo)
;-> true


-----------------
La funzione curry
-----------------

Prima di tutto vediamo la definizione del manuale:

******************
>>>funzione CURRY
******************
sintassi: (curry func exp)

Trasforma "func" da una funzione f(x, y) che prende due argomenti, in una funzione fx(y) che prende un singolo argomento. "curry" funziona come una macro, nel senso che non valuta i suoi argomenti. Questi ultimi vengono valutati durante l'applicazione della funzione "func".

Vediamo alcuni esempi:

(set 'f (curry + 10))
;-> (lambda ($x) (+ 10 $x))

(f 7)
;-> 17

(filter (curry match '(a *)) '((a 10) (b 5) (a 3) (c 8) (a 9)))
;-> ((a 10) (a 3) (a 9))

(clean (curry match '(a *)) '((a 10) (b 5) (a 3) (c 8) (a 9)))
;-> ((b 5) (c 8))

(map (curry list 'x) (sequence 1 5))
;-> ((x 1) (x 2) (x 3) (x 4) (x 5))

"curry" può essere usato con tutte le funzioni che prendono due argomenti.

Vediamo come usare "curry" insieme alla funzione "map".

(map (curry list 1) '(a b c))
;-> ((1 a) (1 b) (1 c))

In pratica "curry" crea una funzione anonima:
(curry list 1)
;-> (lambda ($x) (list 1 $x))

Ecco altri esempi:

(curry * 2)
;-> (lambda ($x) (* 2 $x))
(curry + 3)
;-> (lambda ($x) (+ 3 $x))
((curry + 3) 10)
;-> 13

Possiamo assegnare un nome alla funzione creata da "curry":

(define add3 (curry + 3))
;-> (lambda ($x) (+ 3 $x))
(add3 10)
;-> 13

Possiamo utilizzare "map" con una funzione che riceve più di un argomento (ad esempio la funzione "pow") in questo modo:

(map pow '(2 1) '(3 4))
;-> (8 1)

dove: 8 = 2^3, 1 = 1^4

Ma se la lista degli argomenti si trova all'interno di un'altra lista, allora otteniamo un errore:

(setq lst '((2 1) (3 4)))
(map pow lst)
;-> ERR: value expected in function pow : '(2 1)

Utilizziamo la funzione "curry" per risolvere questo problema:

(map (curry apply pow) lst)
;-> (2 81)

dove: 2 = 2^1, 81 = 3^4

Ok, non è il risultato che volevamo, ma se trasponiamo la lista degli argomenti:

(transpose lst)
;-> ((2 3) (1 4))

Quindi possiamo scrivere:

(map (curry apply pow) (transpose lst))
;-> (8 1)

Che è equivalente a:

(map (lambda(x) (apply pow x)) (transpose lst))
;-> (8 1)

Possiamo anche utilizzare una funzione definita dall'utente:

(define (mypow lst)
  (if (null? lst) '()
      (cons (pow (nth '(0 0) lst) (nth '(0 1) lst)) (mypow (rest lst)))
  )
)

(setq lst '((2 1) (3 4)))
(mypow (transpose lst))
;-> (8 1)

Un altro esempio con la funzione "max":

(map max '(3 5) '(2 7))
;-> (3 7)

(map (curry apply max) '((3 5) (2 7)))
;-> (5 7)

(map (curry apply max) (transpose '((3 5) (2 7))))
;-> (3 7)

Definiamo una macro che si comporta come la funzione predefinita "curry":

(define-macro (curry1 f)
  (append (lambda (z)) (list (cons f (append (args) '(z))))))

(curry1 + 10)
;-> (lambda (z) (+ 10 z))
((curry1 + 10) 20)
;-> 30

(map (curry1 list 1) '(a b c))
;-> ((1 a) (1 b) (1 c))

(map (curry1 list 'x) '(a b c))
;-> ((x a) (x b) (x c))

Ecco un'altra soluzione che utilizza "expand", ma è più lenta:

(define-macro (curry2 f)
   (letex (body (cons f (append (args) '(z))))
      (lambda (z) body)))

(curry2 + 10)
;-> (lambda (z) (+ 10 z))
((curry2 + 10) 20)
;-> 30

(map (curry2 list 1) '(a b c))
;-> ((1 a) (1 b) (1 c))

(map (curry2 list 'x) '(a b c))
;-> ((x a) (x b) (x c))

Vediamo perchè una funzione (invece di una macro) non si comporta correttamente:

(define (curry3 f)
  (append (lambda (z)) (list (cons f (append (args) '(z))))))

(curry3 + 1)
;-> (lambda (z) (+@41493E 1 z))

Se quotiamo la funzione otteniamo:

(curry3 '+ 1)
;-> (lambda (z) (+ 1 z))

La seguente chiamata si comporta correttamente:

(map (curry3 list 1) '(a b c))
;-> ((1 a) (1 b) (1 c))

Ma la seguente non genera il risultato corretto:

(map (curry3 list 'x) '(a b c))
;-> ((nil a) (nil b) (nil c))

perchè il simbolo "x" viene valutato a nil, invece la macro non valuta il simbolo "x".


-------------------
Algoritmo evolutivo
-------------------

Data una stringa (target) scrivere un algoritmo che genera una stringa (current) uguale in modo evolutivo.

Un algoritmo può essere il seguente:

1) generare la stringa "current" con tutti spazi vuoti lunga come la stringa "target"
2) se target=current, allora abbiamo ottenuto la soluzione.
   altrimenti,
    Calcolare la 'distanza' tra la stringa "target" e la stringa "current" (quanti caratteri sono differenti?).
    Modificare in modo casuale/evolutivo i caratteri della stringa "current" che sono diversi da quelli della stringa "target".
    Andare al passo 2.

Vediamo il procedimento:

La stringa da ottenere:

(setq target "NEWLISP IS FUN")

La stringa iniziale (tutti spazi):

(setq current (dup " " (length target)))

Funzione che genera un carattere maiuscolo casuale:

(define (rnd-char) (char (+ (rand 26) 65)))

Funzione che genera una lista con tutti gli indici dei caratteri che sono differenti tra la stringa str1 e la stringa str2:

(define (fitness str1 str2)
  (let (out '())
    (for (i 0 (- (length str1) 1))
      (if (!= (str1 i) (str2 i))
        ;(push (list i (str1 i)) out -1)
        (push i out -1)
      )
    )
    out))

(setq change (fitness target current))
;-> (0 1 2 3 4 5 6 8 9 11 12 13)

Funzione che aggiorna casualmente tutti i caratteri della stringa current che sono differenti tra la stringa target e la stringa current:

(define (update current change)
  (for (i 0 (- (length change)))
    (setf (current (change i)) (rnd-char))
  )
  current)

(setq current (update current change))
;-> "EELVYHN PK KWT"

Adesso possiamo scrivere la funzione "evolutiva":

(define (evolutionary target)
  (local (current change counter)
    (setq counter 1)
    (setq current (dup " " (length target)))
    (while (!= target current)
      (setq change (fitness target current))
      (setq current (update current change))
      (println counter {: } target { - } current)
      (++ counter)
    )))

(evolutionary "NEWLISP IS FUN")
;-> 1: NEWLISP IS FUN - ZTJQPIA BU PQA
;-> 2: NEWLISP IS FUN - LNHQYPN DO MVZ
;-> 3: NEWLISP IS FUN - GKQWVTU MT EMW
;-> 4: NEWLISP IS FUN - SEGBWIY TY VAQ
;-> 5: NEWLISP IS FUN - MEWVNQZ NA KRO
;-> 6: NEWLISP IS FUN - IEWZYQA KC XRD
;-> ...
;-> 49: NEWLISP IS FUN - NEWLISP ES FUN
;-> 50: NEWLISP IS FUN - NEWLISP RS FUN
;-> 51: NEWLISP IS FUN - NEWLISP GS FUN
;-> 52: NEWLISP IS FUN - NEWLISP TS FUN
;-> 53: NEWLISP IS FUN - NEWLISP IS FUN

A dire il vero, questo algoritmo non è "evolutivo" nel senso stretto del significato: non esiste una popolazione e le mutazioni avvengono solo nei caratteri errati.

L'algoritmo generale (Weasel algorithm) è stato proposto da Richard Dawkins utilizzando la seguente frase di 28 caratteri:

  "METHINKS IT IS LIKE A WEASEL"

1. Iniziare con una stringa casuale di 28 caratteri.
2. Fare 100 copie della stringa (riproduzione).
3. Per ogni carattere in ciascuna delle 100 copie, con una probabilità del 5%, sostituire (mutare) il carattere con un nuovo carattere casuale.
4. Confrontare ogni nuova stringa con la stringa di destinazione "METHINKS IT IS LIKE A WEASEL" e assegnare a ciascuna un punteggio che rappresenta l'adattamento evolutivo (il numero di lettere nella stringa che sono corrette e nella posizione corretta).
5. Se una delle nuove stringhe ha un punteggio perfetto (28), abbiamo finito. Altrimenti, prendere la stringa con il punteggio più alto e andare al passo 2.

Un "carattere" è una qualsiasi lettera maiuscola o uno spazio. Il numero di copie per generazione e la possibilità di mutazione per lettera non sono specificati nel libro di Dawkins. Inoltre, 100 copie e un tasso di mutazione del 5% sono solo numeri di esempio. Le lettere corrette non sono "bloccate". Ogni lettera corretta può diventare errata nelle generazioni successive. I termini del programma e l'esistenza della frase target indicano tuttavia che tali 'mutazioni negative' verranno rapidamente corrette.

Vediamo come implementare l'algoritmo Weasel.

(setq target  "METHINKS IT IS LIKE A WEASEL")
(setq current "DFGCBVHJUIDGC VHAQ JKLOPQB Q")

Funzione che genera un carattere maiuscolo casuale o uno spazio:

(define (rnd-char-space)
  (let (ch (char (+ (rand 27) 65)))
    (if (= ch "[")
        " "
        ch)))

(rnd-char-space)
;-> "W"

Funzione che confronta la similitudine di due strignhe (numero di caratteri uguali nella stessa posizione):

(define (check-evolution str1 str2)
  (let (same 0)
    (for (i 0 (- (length str1) 1))
      (if (= (str1 i) (str2 i))
        (++ same)
      )
    )
    same))

(check-evolution target current)
;-> 1

Funzione che modifica una popolazione:

(define (evolve mutation)
  (for (m 0 (- (length mutation) 1))
    (for (i 0 (- (length (mutation m)) 1))
       (if (> change (rand 100)) (begin
           (setf ((mutation m) i) (rnd-char-space))
       ))
    )
  )
  mutation)

Funzione che calcola la mutazione più adatta (stringa più vicina al target):

(define (best-fit mutation)
  (local (score out val-max)
    (setq out -1)
    (setq val-max -1)
    (setq score '())
    ;(dolist (m mutation)
    ;  (push (check-evolution target m) score -1)
    ;)
    (setq score (map (curry check-evolution target) mutation))
    (dolist (s score)
      (if (> s val-max)
        (setq val-max s out $idx)
      )
    )
    out))

Funzione finale dell'algoritmo di Weasel:

(define (evolution target start population change)
(catch
  (local (mutation current generation)
    (setq current start)
    (setq generation 0)
    (while true
      ; creazione della mutazione
      (setq mutation (dup current population true))
      (setq mutation (evolve mutation))
      ; calcolo mutazione più adatta
      (setq current (mutation (best-fit mutation)))
      (++ generation)
      (println current)
      ; target raggiunto?
      (if (= current target) (throw generation))
    ))))

Facciamo alcune prove:

(setq target  "METHINKS IT IS LIKE A WEASEL")
(setq current "DFGCBVHJUIDGC VHAQ JKLOPQB Q")
(evolution target current 100 5)
;-> QFXCBVHJ IDGC VHGQ JKLOPQB Q
;-> QFXCBMHJ IDQC VHGQ JKLOPQB L
;-> MFXCBMHJ IDQC VHGQ JKLOPQB L
;-> MFTCBMHJ IDQC VHGQ JKLOPQB L
;-> ...
;-> METHINKS IT IS LIKE A WEASKL
;-> METHINKS IT IS LIKE A WEASKL
;-> METHINKS IT IS LIKE A WEASKL
;-> METHINKS IT IS LIKE A WEASKL
;-> METHINKS IT IS LIKE A WEASEL
;-> 111

(setq target  "METHINKS IT IS LIKE A WEASEL")
(setq current "DFGCBVHJUIDGC VHAQ JKLOPQB Q")
(evolution target current 1000 10)
;-> ...
;-> 45

(setq target  "EVA VINCE A BRISCOLA MA PERDE A TRESSETTE")
(setq current "                                         ")
(evolution target current 1000 5)
;->        D       S    T                 T
;->   A    M      WS    T                 T
;->   A    M     NWS    T      D          T
;->   A    M     WWS    T   P  D          T
;->  VA    MK    WWS  E T   P  D          T
;->  VA    ML    WWS  E     P  D         WT
;-> EVA    ML    WIS  E     P  D      J  WT
;-> EVA    ML    WIS  E   B P  D      J  WT E
;-> ...
;-> EVA VINCE A BRIS OLA MA PERDE A TRESSETTE
;-> EVA VINCE A BRIS OLA MA PERDE A TRESSETTE
;-> EVA VINCE A BRISCOLA MA PERDE A TRESSETTE
;-> 89

La convergenza dell'algoritmo dipende molto dai parametri "population" e "change".


------------------
Nome del programma
------------------

newLISP ha una funzione per gestire il nome del programma e i suoi parametri: "main-args"
Vediamo la definizione del manuale:

sintassi: (main-args)
sintassi: (main-args int-index)
main-args returns a list with several string members, one for program invocation and one for each of the command-line arguments.
restituisce una lista con diversi elementi stringa, uno per l'invocazione del programma e uno per ciascuno degli argomenti della riga di comando.

newlisp 1 2 3

(main-args)
;-> ("newlisp" "1" "2" "3")

Dopo che "newlisp 1 2 3" è stato eseguito al prompt dei comandi, main-args restituisce un elenco contenente il nome del programma invocante e tre argomenti della riga di comando.

Facoltativamente, main-args può prendere un int-index come indice nella lista. Nota che un indice fuori dall'intervallo farà sì che venga restituito nil, non l'ultimo elemento dell'elenco come nell'indicizzazione standard delle liste.

newlisp a b c

(main-args 0)
;-> "newlisp"
(main-args -1)
;-> "c"
(main-args 2)
;-> "b"
(main-args 10)
;-> nil

Nota che quando newLISP viene eseguito da uno script, main-args restituisce anche il nome dello script come secondo argomento:

# script to show the effect of 'main-args' in script file
(print (main-args) "\n")
(exit)
# end of script file

;; eseguire lo script dalla shell del sistema operativo

script 1 2 3

("newlisp" "script" "1" "2" "3")

Try executing this script with different command-line parameters.

newLISP has a function, (main-args int) for this.

Per ottenere il nome del programma/script possiamo usare il seguente script:

(let ((program (main-args 1)))
  (println (format "Program: %s" program))
  (exit))


------------------
loop e recur macro
------------------

Le macro "loop" e "recur" (scritte da ClaudeM) facilitano l'utilizzo di una programmazione simile al linguaggio Scheme in quanto newLISP non supporta l'ottimizzazione della ricorsione in coda (Tail Code Optimization).
Queste macro sono molto eleganti anche se sono meno efficienti della tecnica di "trampolining" o delle tecniche iterative.

; looking at options to simulate TCO (Tail Code Optimization)
; I come from Scheme and I like simple recursion
; maybe like Clojure, which makes it explixit with loop & recur
;
; Use a pair of macros. The process is as follows:
;   - use a loop (otherwise infinite)
;   - there must be two args: let-list and body
;   - define local variables with initial values
;   - execute the body, must have an exit test and recur
;   - recur macro
;     - in tail position - how would I check for this?
;     - take new values for local variables (positional)
;     - loop back; if not in tail position, problems may occur
(define-macro (loop)
  (letn (loop-recur-let-list (args 0)
         loop-recur-body (args 1)
         loop-recur-let-list-length (length loop-recur-let-list)
         loop-recur-var-names '()
         loop-recur-variables '()
         loop-recur-done nil)
    ;
    ; let-list could be a list of pairs or a list of two-item lists
    ; convert pairs to a list of lists
    ;
;   (println "loop-recur-let-list : " loop-recur-let-list)
;   (println "loop-recur-body : " loop-recur-body)
;   (println " - - - - - - - -")
    (if (not (list? (loop-recur-let-list 0)))
      (begin
        (if (not (even? loop-recur-let-list-length))
            (begin
              ;;(println "The loop's let list must contain an even number of items.")
              ;;(println "  (loop " loop-recur-let-list " ...)")
              (exit 1)))
        ;
        ; loop over pairs and convert
        ;
        (letn (loop-recur-old-let-list loop-recur-let-list)
          (setq loop-recur-let-list '())
          (for (i 0 (- loop-recur-let-list-length 1) 2)
            (push (list (nth i loop-recur-old-let-list)
                        (nth (+ i 1) loop-recur-old-let-list))
                  loop-recur-let-list
                  -1)))))
    ;
    ; process loop-recur-let-list: extract variable names and initial values
    ; so I can redefine at each iteration
    ; build loop-recur-var-names and initial loop-recur-variables
    ;
    (dolist (i loop-recur-let-list)
      (push (first i) loop-recur-var-names -1)
      (push (nth 1 i) loop-recur-variables -1))
    ;;(println "loop-recur-var-names : " loop-recur-var-names)
    ;;(println "loop-recur-variables : " loop-recur-variables)
    ;
    ; loop variables are defined and given initial values
    ;
    (until loop-recur-done
      ; define variables, made fresh each iteration
      (setq loop-recur-let-list
            (map list loop-recur-var-names loop-recur-variables))
      ;;(println "loop-recur-let-list : " loop-recur-let-list)
      (letex (loop-recur-let-list-expanded loop-recur-let-list)
        (let loop-recur-let-list-expanded
          (setq loop-recur-done true)  ; if recur is not used, the loop should end
          (eval loop-recur-body))))))  ; evaluate the body, it should call recur
;
; build a new loop-recur-let-list
;
(define-macro (recur)
  (begin
    (setq loop-recur-variables
          (map eval (args)))
;   (println "recur: new variables are " loop-recur-variables)
    (setq loop-recur-done nil)))
;
; quick test
;
(define (factorial n)
  (loop (i 1
         prod 1L)
      (if (> i n)
        prod
        (recur (+ 1 i) (* prod i)))))

(factorial 5)
;-> loop-recur-var-names : (i prod)
;-> loop-recur-variables : (1 1L)
;-> loop-recur-let-list : ((i 1) (prod 1L))
;-> loop-recur-let-list : ((i 2) (prod 1L))
;-> loop-recur-let-list : ((i 3) (prod 2L))
;-> loop-recur-let-list : ((i 4) (prod 6L))
;-> loop-recur-let-list : ((i 5) (prod 24L))
;-> loop-recur-let-list : ((i 6) (prod 120L))
;-> 120L

Vediamo la diffferenza di velocità con una versione iterativa del fattoriale:

(define (fact num)
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

(= (fact 200) (factorial 200))
;-> true

(time (factorial 200) 1000)
;-> 281.456

(time (fact 200) 1000)
;-> 31.178

La versione iterativa è 9 volte più veloce.


---------------------------
Breve introduzione ai grafi
---------------------------

A) Cosa è un Grafo?
-------------------

Un grafo è una coppia ordinata G = (V, E) che comprende un insieme V di vertici o nodi e un insieme di coppie di vertici da V, noti come archi (edges) di un grafo. Ad esempio, per il grafo sottostante.

  V = { 1, 2, 3, 4, 5, 6 }
  E = { (1, 4), (1, 6), (2, 6), (4, 5), (5, 6) }

  ╔═══╗           ╔═══╗
  ║ 6 ║-----------║ 2 ║
  ╚═══╝           ╚═══╝
    |  \
    |   \
    |    \
    |     ╔═══╗           ╔═══╗
    |     ║ 1 ║           ║ 3 ║
    |     ╚═══╝           ╚═══╝
    |          \
    |           \
    |            \
  ╔═══╗           ╔═══╗
  ║ 5 ║-----------║ 4 ║
  ╚═══╝           ╚═══╝

B) Tipi di grafi
----------------

1. Grafo non orientato (Undirected graph)
-----------------------------------------
Un grafo non orientato (grafo) è un grafo in cui gli archi non hanno orientamento. L'arco (x, y) è identico all'arco (y, x), cioè non sono coppie ordinate. Il numero massimo di archi possibili in un grafo non orientato senza cicli (loop) è n*(n-1)/2.

Esempio di grafo non orientato

  ╔═══╗           ╔═══╗
  ║ 6 ║-----------║ 2 ║
  ╚═══╝           ╚═══╝
    |  \
    |   \
    |    \
    |     ╔═══╗           ╔═══╗
    |     ║ 1 ║-----------║ 3 ║
    |     ╚═══╝           ╚═══╝
    |          \         /
    |           \       /
    |            \     /
  ╔═══╗           ╔═══╗
  ║ 5 ║-----------║ 4 ║
  ╚═══╝           ╚═══╝

2. Grafo orientato (Direct graph)
-------------------------------
Un grafo orientato (digrafo) è un grafo in cui gli archi sono orientati, ovvero l'arco (x, y) non è identico all'arco (y, x).

Esempio di grafo orientato (Il carattere "■" rappresenta la fine dell'arco)

          ╔═══╗
          ║ 2 ║
          ╚═══╝
        ■
       /
      /
  ╔═══╗           ╔═══╗
  ║ 1 ║■---------■║ 3 ║
  ╚═══╝           ╚═══╝
       \         ■
        \       /
         ■     /
          ╔═══╗
          ║ 4 ║
          ╚═══╝

3. Grafo aciclico diretto (Directed Acyclic Graph - DAG)
----------------------------------------------------------
Un grafo aciclico diretto (DAG) è un grafo orientato che non contiene cicli.

Esempio di DAG

          ╔═══╗
          ║ 2 ║
          ╚═══╝
        ■
       /
      /
  ╔═══╗           ╔═══╗
  ║ 1 ║■----------║ 3 ║
  ╚═══╝           ╚═══╝
       \         ■
        \       /
         ■     /
          ╔═══╗
          ║ 4 ║
          ╚═══╝

4. Multi grafo
--------------
Un multigrafo è un grafo non orientato in cui sono consentiti più archi (e talvolta cicli/loop). Gli archi multipli sono due o più archi che collegano gli stessi due vertici. Un ciclo è un arco (diretto o non orientato) che collega un vertice a se stesso (può essere consentito o meno)

5. Grafo semplice
-----------------
Un grafo semplice è un grafo non orientato in cui non sono consentiti sia gli archi multipli che i cicli/loop rispetto a un multigrafo. In un grafo semplice con n vertici, il grado di ogni vertice è al massimo n-1.

Esempi di archi multipli

  ╔═══╗----------■╔═══╗           ╔═══╗-----------╔═══╗
  ║ 1 ║           ║ 2 ║           ║ 1 ║           ║ 2 ║
  ╚═══╝■----------╚═══╝           ╚═══╝-----------╚═══╝

Esempio di ciclo/loop

  ╔═══╗------+
  ║ 1 ║      |
  ╚═══╝------+

6. Grafo pesato e non pesato
------------------------------------
Un grafo pesato associa un valore (peso) a ogni arco del grafo. Possiamo anche usare le parole costo o lunghezza invece di peso.

Un grafo non pesato non ha alcun valore (peso) associato a ogni arco del grafo. In altre parole, un grafo pesato è un grafo pesato con tutti i pesi degli archi pari a 1. Se non diversamente specificato, si presume che tutti i grafi non siano ponderati per impostazione predefinita.

Esempio di grafo diretto pesato

          ╔═══╗
          ║ 2 ║
          ╚═══╝
        ■
    10 /
      /
  ╔═══╗     3     ╔═══╗
  ║ 1 ║■----------║ 3 ║
  ╚═══╝           ╚═══╝
       \         ■
      8 \       / 4
         ■     /
          ╔═══╗
          ║ 4 ║
          ╚═══╝

7. Grafo completo
-----------------
Un grafo completo è quello in cui ogni due vertici sono adiacenti: tutti i bordi che possono esistere sono presenti.

8. Grafo connesso
-----------------
Un grafo connesso ha un percorso tra ogni coppia di vertici. In altre parole, non ci sono vertici irraggiungibili. Un grafo disconnesso è un grafo non connesso.

C) Termini comunemente usati per i Grafi
----------------------------------------

Un "arco (edge)" è (insieme ai "vertici (vertices") una delle due unità di base da cui sono costruiti i grafi. Ogni arco ha due vertici a cui è attaccato, chiamati i suoi "punti finali (endpoints)".

Due vertici sono chiamati "adiacenti (adjacent)" se sono punti finali dello stesso arco.

Gli "archi in uscita (outgoing edges)" di un vertice sono archi diretti di cui il vertice è l'origine.

Gli "archi in entrata (ingoing edges)" di un vertice sono archi diretti di cui il vertice è la destinazione.

Il "grado (degree)" di un vertice in un grafo è il numero totale di archi incidenti su di esso.

In un grafo orientato, il "grado esterno (out-degree)" di un vertice è il numero totale di archi uscenti e il "grado interno (in-degree)" è il numero totale di archi entranti.

Un vertice con zero di grado è chiamato "vertice sorgente (source vertex)", mentre un vertice con zero di grado esterno è chiamato "vertice sink (sink vertex)".

Un "vertice isolato (isolated vertex)" è un vertice con grado zero, che non è un punto finale di un arco.

"Percorso (path)" è una sequenza di vertici e archi alternati in modo tale che ogni arco colleghi ogni vertice successivo.

"Ciclo (cycle)" è un percorso che inizia e finisce nello stesso vertice.

"Percorso semplice (simple path)" è un percorso con vertici distinti.

Un grafo è "fortemente connesso (strongly connected)" se contiene un cammino orientato da u a v e un cammino orientato da v a u per ogni coppia di vertici u, v.

Un grafo orientato è detto "debolmente connesso (weakly connected)" se la sostituzione di tutti i suoi archi orientati con archi non orientati produce un grafo connesso (non orientato). I vertici in un grafo debolmente connesso hanno un grado esterno o un grado interno di almeno 1.

"Componente connesso (connected component)" è il sottografo connesso massimale di un grafo non connesso.

Un "ponte (bridge)" è un arco la cui rimozione disconnetterebbe il grafo.

"Foresta (forest)" è un grafo senza cicli.

"Albero (tree)" è un grafo connesso senza cicli. Se rimuoviamo tutti i cicli da DAG (grafo aciclico diretto), diventa un albero e se rimuoviamo qualsiasi arco in un albero, diventa una foresta.

"Albero di copertura (spanning tree)" di un grafo non orientato è un sottografo che è un albero che include tutti i vertici del grafo.

D) Relazione tra numero di archi e vertici
------------------------------------------

Per un grafo semplice con m bordi e n vertici, se il grafo è

diretto, allora m = n*(n-1)

non orientato, allora m = n*(n-1)/2

connesso, allora m = n-1

un albero, allora m = n-1

una foresta, allora m = n-1

completo, allora m = n*(n-1)/2

Pertanto, O(m) può variare tra O(1) e O(n^2), a seconda di quanto è denso il grafo.

E) Rappresentazione dei grafi
-----------------------------

1. Rappresentazione con matrice di adiacenza
--------------------------------------------
Una matrice di adiacenza è una matrice quadrata utilizzata per rappresentare un grafo finito. Gli elementi della matrice indicano se le coppie di vertici sono adiacenti o meno nel grafo.
Definizione:
Per un semplice grafo non pesato con insieme di vertici V, la matrice di adiacenza è un quadrato |V| × |V| matrice A tale che il suo elemento:

A(i j) = 1, quando c'è un arco dal vertice i al vertice j, e
A(i j) = 0, quando non c'è un arco.

Ogni riga nella matrice rappresenta i vertici di origine e ogni colonna rappresenta i vertici di destinazione. Gli elementi diagonali della matrice sono tutti zero poiché i bordi da un vertice a se stesso, cioè i cicli non sono consentiti nei grafi semplici. Se il grafo non è orientato, la matrice di adiacenza sarà simmetrica. Inoltre, per un grafo ponderato, Aij può rappresentare i pesi degli archi.

Esempio di matrice di adiacenza di un grafo orientato

          ╔═══╗
          ║ 0 ║
          ╚═══╝             ╔═══╗
        ■      \            ║ 4 ║
       /        \           ╚═══╝             |0 1 0 0 0 0|
      /          ■            ■               |0 0 1 0 0 0|
  ╔═══╗           ╔═══╗       |               |1 1 0 0 0 0|
  ║ 2 ║■---------■║ 1 ║       |               |0 0 1 0 0 0|
  ╚═══╝           ╚═══╝       |               |0 0 0 0 0 1|
       ■                      ■               |0 0 0 0 1 0|
        \                   ╔═══╗
         \                  ║ 5 ║
          ╔═══╗             ╚═══╝
          ║ 3 ║
          ╚═══╝

Una matrice di adiacenza mantiene un valore (1/0/arco-peso) per ogni coppia di vertici, indipendentemente dal fatto che l'arco esista o meno, quindi richiede n^2 spazi. Può essere utilizzata in modo efficiente solo quando il grafo è denso.

2. Rappresentazione con una lista delle adiacenze
-------------------------------------------------
Una rappresentazione del grafo con una lista delle adiacenze associa ciascun vertice nel grafo alla raccolta dei suoi vertici o archi vicini, ovvero ogni vertice memorizza un elenco di vertici adiacenti. Esistono molte varianti della rappresentazione con una lista delle adiacenze a seconda dell'implementazione. Questa struttura dati consente la memorizzazione di dati aggiuntivi sui vertici ed è molto efficiente quando il grafo contiene solo pochi archi (cioè il grafo è rado (sparse)).

Esempio di lista delle adiacenze di un grafo orientato

          ╔═══╗
          ║ 0 ║
          ╚═══╝             ╔═══╗
        ■      \            ║ 4 ║
       /        \           ╚═══╝
      /          ■            ■
  ╔═══╗           ╔═══╗       |
  ║ 2 ║■---------■║ 1 ║       |
  ╚═══╝           ╚═══╝       |
       ■                      ■
        \                   ╔═══╗
         \                  ║ 5 ║
          ╔═══╗             ╚═══╝
          ║ 3 ║
          ╚═══╝

lista = ((0 (1)) (1 (2)) (2 (0 1)) (3 (2)) (4 (5)) (5 (4)))


---------------------------
Lanciare N volte una moneta
---------------------------

Lanciando una moneta equa N volte, qual'è la probabilità che gli ultimi due risultati siano uguali?

Se la moneta è equa, cioè i suoi risultati hanno una distribuzione uniforme, allora i lanci da i a (N-2) non hanno importanza. Dobbiamo considerare solo gli ultimi due lanci e possiamo farlo in due modi.

1) Teorema della probabilità composta, la probabilità che due eventi indipendenti accadano insieme è pari al prodotto delle probabilità dei singoli eventi:

  P(2T) = P(T) * P(T) = 1/2 * 1/2 = 1/4 = 25%

La probabilità che due risultati siano due Teste vale il prodotto delle singole probabilità.
Poichè anche due croci sono risultati uguali dobbiamo aggiungere anche questo caso alla probabilità totale:

  P(2C) = P(C) * P(C) = 1/2 * 1/2 = 1/4 = 25%

Quindi la probabilità totale vale:

  P(2uguali) = P(2C) + P(2B) = 1/4 + 1/4 = 1/2 = 50%

2) Teorema fondamentale della probabilità, la brobabilità di un evento è data dal rapporto tra casi favorevoli e casi possibili:

           numero casi favorevoli
  P(E) = --------------------------
           numero casi possibili

Nel nostro caso abbiamo:
casi possibili  = 4: (T T), (T C), (C T), (C C) = 4
casi favorevoli = 2: (T T) (C C)

  P(2uguali) = 2/4 = 1/2 = 50%

Per gli scettici come me scriviamo una funzione:

(define (flip-coin num)
  (local (val a b)
    (for (i 1 num)
      (setq val (rand 2))
      (cond ((= i (- num 1)) (setq a val))
            ((= i (- num 2)) (setq b val))
      )
    )
    (= a b)))

(for (i 1 10) (print (flip-coin 10) { }))
;-> nil true nil nil true nil true true nil nil

(define (test-coin num iter)
  (let (out 0)
    (for (i 1 iter)
      (if (flip-coin num) (++ out))
    )
    (div out iter)))

(test-coin 10 10000)
;-> 0.5011
(test-coin 100 100000)
;-> 0.50122
(test-coin 100 1000000)
;-> 0.499789


-----------------------------------------------
Problema dei fiammiferi di Banach con N scatole
-----------------------------------------------

Una persona ha N scatole di fiammiferi nello zaino ognuna contenente M fiammiferi. Ogni volta che ha bisogno di un fiammifero lo prende da una delle N scatole (cioè, ha la stessa probabilità di scegliere una delle N scatole). Ad un certo punto (N-1) scatole saranno diventate vuote: in media, quanti fiammiferi ci sono nell'unica scatola rimasta?
Una scatola è considerata vuota quando viene selezionata e contiene 0 fiammiferi.
Ci sono due modi di simulare il problema a seconda del seguente comportamento:
1) le scatole vuote non vengono gettate e quindi possono essere riselezionate
2) le scatole vuote vengono gettate e quindi non possono essere riselezionate

Vediamo di scrivere un programma che simula il primo caso:

(setq n 5 m 10)

Funzione che verifica se esistono fiammiferi da estrarre dalle scatole:

(define (exist-fiam fiam)
  (let (conta 0)
    (dolist (f fiam)
      ; scatola vuota = -1
      (if (= f -1)
          (++ conta)))
    ; se tutti gli elementi (tranne uno) valgono -1,
    ; allora non esistono fiammiferi da estrarre
    (!= conta (- (length fiam) 1))))

(exist-fiam '(-1 3 -1 -1 -1))
;-> nil
(exist-fiam '(-1 3 0 -1 -1))
;-> true
(exist-fiam '(-1 20 20 20 20 20 20 20 20 20 20))
;-> true
(exist-fiam '(-1 2))
;-> nil
(exist-fiam '(2))
;-> nil

Funzione che effettua una simulazione completa del processo di estrazione e calcola quanti fiammiferi rimangono nell'ultima scatola (quando le altre sono tutte vuote):

(define (banach1 n m)
  (local (fiam box-num)
    ; lista delle scatole
    ; vettore di n+1 elementi tutti con valore m
    (setq fiam (array (+ n 1) (list m)))
    ; (fiam 0) = -1
    (setf (fiam 0) -1)
    ; affinchè esistono fiammiferi da estrarre..
    (while (exist-fiam fiam)
       ; seleziona una scatola
      (setq box-num (+ (rand n) 1))
      ; se la scatola scelta non è vuota (-1)
      (if (!= (fiam box-num) -1)
          ; toglie un fiammifero dalla scatola
          (-- (fiam box-num))
      )
      ;(println fiam)
      ;(read-line)
    )
    ; cerca valore non uguale a -1
    ; nella lista/vettore delle scatole
    (catch
      (dolist (f fiam)
        (if (!= f -1) (throw f))
      ))))

(for (i 1 10) (print (banach1 5 10) { }))
;-> 3 1 1 1 2 0 2 1 1 0

Funzione che esegue la simulazione un determinato numero di volte e restituisce una lista con le frequenze dei fiammiferi rimasti:

(define (banach1-test n m iter)
  (local (out)
    (setq out (array (+ m 1) '(0)))
    (for (i 1 iter)
      (++ (out (banach1 n m)))
    )
    out))

(setq sol (banach1-test 5 10 10000))
;-> (3184 2409 1871 1199 708 388 149 69 18 5 0)

Quindi, 3233 volte sono rimasti 0 fiammiferi, 2443 volte è rimasto 1 fiammifero, 1870 volte sono rimasti 2 fiammiferi, ... e 0 volte sono rimasti 10 fiammiferi.

Vediamo le percentuali di frequenza:

(map (fn(x) (mul 100 (div x (apply + sol)))) sol)
;-> (31.84 24.09 18.71 11.99 7.08
;->  3.88 1.49 0.69 0.18 0.05 0)

Aumentiamo il numero di simulazioni:

(setq sol (banach1-test 5 10 1e6))
;-> (315275 248335 180842 120336 71935 37678 17220 6297 1711 334 37)
(map (fn(x) (mul 100 (div x (apply + sol)))) sol)
;-> (31.5275 24.8335 18.0842
;->  12.0336 7.1935 3.7678
;->  1.722 0.6297 0.1711
;->  0.0334 0.0037)

(setq sol (banach1-test 5 10 1e7))
;-> (3146012 2488151 1814325 1205730 718858
;->  375560 168454 61827 17359 3412 312)
(map (fn(x) (mul 100 (div x (apply + sol)))) sol)
;-> (31.46012 24.88151 18.14325
;->  12.0573 7.18858 3.7556
;->  1.68454 0.61827 0.17359
;->  0.03412 0.00312)

Adesso vediamo di simulare il secondo caso:

(define (banach2 n m)
  (local (fiam box-num b)
    ; lista delle scatole
    ; vettore di n+1 elementi tutti con valore m
    (setq fiam (array (+ n 1) (list m)))
    (setf (fiam 0) -1)
    ; lista delle scatole
    (setq box-num (sequence 1 n))
    ; affinchè ci sono almeno due scatole...
    (while (> (length box-num) 1)
      ; seleziona una scatola
      ; (un numero casuale da 1 al numero delle scatole)
      (setq b (first (select box-num (rand (length box-num)))))
      ; se il valore della scatola è zero,
      ; (non ci sono più fiammiferi)
      (if (= (fiam b) 0)
          ; allora rimuove la scatola
          (pop box-num (find b box-num))
          ; altrimenti toglie un fiammifero dalla scatola
          (-- (fiam b))
      )
    )
    ; il risultato è il numero di fiammiferi
    ; della scatola rimasta
    (fiam (first box-num))
    ))

(for (i 1 10) (print (banach2 5 10) { }))
;-> 0 2 2 0 0 1 3 0 5 0

Funzione che esegue la simulazione un determinato numero di volte e restituisce una lista con le frequenze dei fiammiferi rimasti:

(define (banach2-test n m iter)
  (local (out)
    (setq out (array (+ m 1) '(0)))
    (for (i 1 iter)
      (++ (out (banach2 n m)))
    )
    out))

Facciamo alcune prove:

(setq sol (banach2-test 5 10 10000))
;-> (3129 2553 1783 1218 718 362 158 61 13 4 1)
(map (fn(x) (mul 100 (div x (apply + sol)))) sol)
;-> (31.29 25.53 17.83 12.18 7.18 3.62 1.58 0.61 0.13 0.04 0.01)

(setq sol (banach2-test 5 10 1e6))
;-> (314822 248776 180943 121049 71350
;->  37623 16971 6254 1810 369 33)
(map (fn(x) (mul 100 (div x (apply + sol)))) sol)
;-> (31.4822 24.8776 18.0943 12.1049 7.135
;->  3.7623 1.6971 0.6254 0.181 0.0369 0.0033)

(setq sol (banach2-test 5 10 1e7))
;-> (3145292 2489280 1814241 1205993 718267
;->  376016 168057 61812 17443 3292 307)
(map (fn(x) (mul 100 (div x (apply + sol)))) sol)
;-> (31.45292 24.8928 18.14241 12.05993 7.182667
;->  3.76016 1.68057 0.61812 0.17443 0.03292 0.00307)

I due casi ottengono lo stesso risultato nelle simulazioni:

(map sub
 '(31.46012 24.88151 18.14325 12.0573 7.18858
   3.7556 1.68454 0.61827 0.17359 0.03412 0.00312)
 '(31.45292 24.8928 18.14241 12.05993 7.182667
   3.76016 1.68057 0.61812 0.17443 0.03292 0.00307))
;-> (0.007200000000000983 -0.01129000000000247 0.0008399999999966212
;->  -0.00262999999999991 0.005912999999999613 -0.00456000000000012
;->  0.003970000000000029 0.0001499999999999835 -0.0008400000000000074
;->  0.0012 5.000000000000013e-005)

Verifichiamo che questa funzione sia congruente con i risultati ottenuti nel paragrafo "Problema dei fiammiferi di Banach" con due scatole:

  (8.8874 8.9236 8.756500000000001 8.5153 8.262600000000001
  7.7165 7.2776 6.6639 6.0641 5.3545 4.7031 4.0201 3.3735
  2.7765 2.2529 1.7751 1.3587 1.0171 0.7549 0.5440999999999999
  0.3697 0.2397 0.1619 0.1025 0.05860000000000001 0.0335 0.0198
  0.0086 0.0043 0.0021 0.0006000000000000001 0.0004 9.999999999999999e-005
  9.999999999999999e-005 9.999999999999999e-005 0 0 0 0 0 0)

(setq sol (banach2-test 2 40 1e6))
;-> (88666 88925 87689 85645 82462 78072 73074 67090
;->  60151 53463 46363 40217 33591 27990 22455 17826
;->  13485 10417 7356 5314 3657 2327 1546 944 597 309
;->  203 82 46 23 9 3 1 2 0 0 0 0 0 0 0)
(map (fn(x) (mul 100 (div x (apply + sol)))) sol)
;-> (8.8666 8.8925 8.7689 8.564500000000001 8.2462
;->  7.8072 7.3074 6.709 6.0151 5.3463 4.6363 4.0217 3.3591
;->  2.799 2.2455 1.7826 1.3485 1.0417 0.7355999999999999 0.5314
;->  0.3657 0.2327 0.1546 0.0944 0.0597 0.0309 0.0203
;->  0.008200000000000001 0.0046 0.0023 0.0009 0.0003 9.999999999999999e-005
;->  0.0002 0 0 0 0 0 0 0)

Le due soluzioni sono congruenti.

Per finire vediamo un modo alternativo di selezionare i fiammiferi dalle scatole.
Possiamo creare una lista con tutti i valori possibili del nostro universo che è rappresentato dalle estrazioni di un fiammifero da una delle scatole a disposizione. Supponiamo di avere N scatole con M fiammiferi, allora il nostro universo vale N volte la lista (1 2 ... M):

                      (x M volte)
  (1 2 ... N) (1 2 ... N) ... (1 2 ... N) =

= (1 1 ... 1) (2 2 ... 2) ... (N N ... N)
   (M volte)

Cioè dobbiamo estrarre M volte la scatola X per estrarre tutti i fiammiferi. Mettendo insieme tutti i valori possibili otteniamo una lista del tipo:

(1 1 .. 1 2 2 .. 2 ... N N .. N)

Un esempio chiarisce meglio il concetto:

(setq n 3 m 5)
(setq rnd (randomize (flat (dup (sequence 1 n) (+ m 1)))))
;-> (3 1 2 2 1 3 3 3 3 1 3 1 2 1 1 2 2 2)

Questa lista rappresenta l'ordine (casuale) con cui devono essere estratti i fiammiferi dalle scatole: scatola 3, poi 1, poi 2, ecc. e infine rimane la scatola 2.
Abbiamo usato (m+1) perchè la scatola deve arrivare a -1 e non a 0 per essere considerata vuota.
In questo caso il numero di fiammiferi rimasti nell'ultima scatola è pari al numero di valori uguali consecutivi in "rnd" (partendo dal fondo) meno uno. Ad esempio nel caso precedente abbiamo 3 valori uguali (2) alla fine di "rnd", quindi ci sono (3 - 1) = 2 fiammiferi rimasti nell'ultima scatola.

(define (banach3 n m)
  (local (rnd fiam box idx conta)
    ; creazione di tutte le estrazioni casuali
    (setq rnd (randomize (flat (dup (sequence 1 n) (+ m 1)))))
    ; ultima scatola da estrarre
    (setq box (rnd -1))
    ; posizione indice
    (setq idx -2)
    ; numero fiammiferi rimasti nell'ultima scatola
    (setq conta 0)
    (while (= (rnd idx) box)
      ; aggiorna indice
      (-- idx)
      ; aumenta numero di fiammiferi
      (++ conta)
    )
    conta))

(define (banach3-test n m iter)
  (local (out)
    (setq out (array (+ m 1) '(0)))
    (for (i 1 iter)
      (++ (out (banach3 n m)))
    )
    out))

(setq sol (banach3-test 5 10 10000))
;-> (8137 1543 277 36 6 1 0 0 0 0 0)
(map (fn(x) (mul 100 (div x (apply + sol)))) sol)
;-> (81.37000000000001 15.43 2.77 0.36 0.06 0.01
;->  0 0 0 0 0)

(setq sol (banach3-test 5 10 1e6))
;-> (814717 153676 26567 4410 565 57 7 1 0 0 0))
(map (fn(x) (mul 100 (div x (apply + sol)))) sol)
;-> (81.4717 15.3676 2.6567 0.441 0.0565 0.0057
;->  0.0007 9.999999999999999e-005 0 0 0)

In questo caso i risultati sono diversi dalle prime due simulazioni perchè la funzione di casualità viene applicata a tutta la simulazione e non ad ogni singolo passo della simulazione (cioè ad ogni estrazione di un fiammifero).


-----------------------------------------------------
Conflitti read-write nelle transazioni di un database
-----------------------------------------------------

Dato un elenco di transazioni di database, trovare tutti i conflitti di lettura-scrittura tra di loro. Si supponga che non esista un protocollo (es. Strict 2PL) per prevenire conflitti di read-write (lettura-scrittura).

Ogni transazione del database è data sotto forma di tupla. La tupla ('T', 'A', 't', 'R') indica che una transazione T ha avuto accesso a un record del database A all'istante t e che viene eseguita un'operazione di lettura R sul record.

Supponiamo che si verifichi un conflitto di dati quando due transazioni accedono allo stesso record nel database entro un intervallo di 5 unità. Sul record viene eseguita almeno un'operazione di scrittura.

Per esempio, il seguente gruppo di transazioni di input:

  (T1, A, 0, R)
  (T2, A, 2, W)
  (T3, B, 4, W)
  (T4, C, 5, W)
  (T5, B, 7, R)
  (T6, C, 8, W)
  (T7, A, 9, R)

Dovrebbe produrre il seguente output:

  Le transazioni T1 e T2 sono coinvolte nel conflitto RW
  Le transazioni T3 e T5 sono coinvolte nel conflitto WR
  Le transazioni T4 e T6 sono coinvolte nel conflitto WW

Breve panoramica sui conflitti di lettura-scrittura
---------------------------------------------------
Nei database può verificarsi un conflitto di dati durante un'operazione di lettura o scrittura da parte delle diverse transazioni sugli stessi dati durante la vita della transazione, portando a uno stato finale del database incoerente. Esistono tre tipi di conflitti di dati coinvolti nelle transazione di un database.

1) Conflitto tra scrittura e lettura (WR) (lettura sporca)
----------------------------------------------------------
Questo conflitto si verifica quando una transazione legge i dati scritti dall'altra transazione, ma non ancora confermati.

2) Conflitto di lettura-scrittura (RW)
--------------------------------------
Questo conflitto si verifica quando una transazione scrive i dati che sono stati precedentemente letti dall'altra transazione.

3) Conflitto di scrittura-scrittura (WW) (operazione di scrittura cieca)
------------------------------------------------------------------------
Questo conflitto si verifica quando i dati aggiornati da una transazione vengono sovrascritti da un'altra transazione che potrebbe portare alla perdita dell'aggiornamento dei dati.
Si noti che non vi è alcun conflitto di lettura-lettura (RR) nel database poiché nessuna informazione viene aggiornata nel database durante l'operazione di lettura.

Per risolvere il nostro problema, l'idea è di ordinare tutte le transazioni in ordine crescente di record del database e del relativo tempo di accesso. Per ogni record del database, considerare tutte le coppie di transazioni che hanno avuto accesso al record corrente entro un intervallo di 5 unità. Infine, memorizziamo tutte le coppie di transazioni in conflitto per le quali viene eseguita almeno un'operazione di scrittura sul record corrente.

(define (check-conflict transaction)
  (local (tr out)
    (setq tr '() out '())
    ; per ogni transazione Tx sposta
    ; il nome della transazione all'ultimo posto
    (dolist (t transaction)
      (setq el (select t '(1 2 3 0)))
      (push el tr -1)
    )
    ; ordina le transazioni per record e tempo di accesso
    (sort tr)
    ; ricerca dei conflitti nelle operazioni di lettura e scrittura
    (for (i 0 (- (length tmp) 1))
      (setq j (- i 1))
      (while (and (>= j 0) (= (tmp i 0) (tmp j 0)) (<= (tmp i 1) (+ 5 (tmp j 1))))
        ; per l'esistenza di un conflitto,
        ; almeno una operazione deve essere di scrittura (W)
        (if (or (= 'W (tmp i 2)) (= 'W (tmp j 2)))
            (push (list (tmp j) (tmp i)) out -1)
        )
        (-- j)
      )
    )
    out))

Proviamo la funzione:

(setq transact '(
  (T1 A 0 R)
  (T2 A 2 W)
  (T3 B 4 W)
  (T4 C 5 W)
  (T5 B 7 R)
  (T6 C 8 W)
  (T7 A 9 R)))

(check-conflict transact)
;-> (((A 0 R T1) (A 2 W T2))
;->  ((B 4 W T3) (B 7 R T5))
;->  ((C 5 W T4) (C 8 W T6)))

Le transazioni T1 e T2 sono coinvolte nel conflitto RW.
Le transazioni T3 e T5 sono coinvolte nel conflitto WR.
Le transazioni T4 e T6 sono coinvolte nel conflitto WW.


-----------------------------------
Unico elemento diverso in una lista
-----------------------------------

Dato una lista di interi in cui tutti gli elementi sono uguali tranne uno, trovare l'unico elemento diverso nella lista.

Esempi:
Input: lst = (10 10 10 20 10 10)
Output: 20

Input: lst = (30 10 30 30 30)
Output: 10

Una soluzione semplice è attraversare la lista. Per ogni elemento, controllare se è diverso dagli altri o meno. La complessità temporale di questa soluzione sarebbe O(n^2)
Una soluzione migliore è usare l'hashing. Contiamo le frequenze di tutti gli elementi. La tabella hash avrà due elementi. La soluzione è l'elemento con valore (o frequenza) uguale a 1. Questa soluzione opera in tempo O(n), ma richiede O(n) spazio extra.
Una soluzione più efficiente consiste nell'iniziare a controllare i primi tre elementi. Ci possono essere due casi:
1) Due elementi sono uguali, cioè uno è diverso a seconda delle condizioni definite. In questo caso, l'elemento diverso è tra i primi tre, quindi restituiamo l'elemento diverso.
2) Tutti e tre gli elementi sono uguali. In questo caso, l'elemento diverso si trova nell'array rimanente. Quindi attraversiamo l'array dal quarto elemento e controlliamo semplicemente se il valore dell'elemento corrente è diverso dal precedente o meno.

Vediamo di implementare quest'ultimo metodo con una funzione che restituisce l'indice dell'elemento diverso.

(define (find-unique lst)
(catch
  (let (len (length lst))
    ; se la lista ha meno di due elementi,
    ; allora restituisce nil
    (cond ((= len 0) nil)
          ((= len 1) nil)
          ; se la lista ha due elementi,
          ; allora possiamo restituire l'indice 0 o l'indice 1
          ((= len 2) 0) ; oppure 1
          (true ; se la lista ha più di due elementi
            (cond ((and (= (lst 0) (lst 1)) (!= (lst 0) (lst 2))) throw 2)
                  ((and (= (lst 0) (lst 2)) (!= (lst 0) (lst 1))) throw 1)
                  ((and (= (lst 1) (lst 2)) (!= (lst 0) (lst 1))) throw 0)
                  (true
                    (for (i 3 (- len 1))
                      (if (!= (lst i) (lst (- i 1)))
                          (throw i)
                      )
                    )
                  )
            )
          )
    ))))

(find-unique '())
;-> nil
(find-unique '(1))
;-> nil
(find-unique '(3 1 1 1 1 1 1 1))
;-> 0
(find-unique '(1 3 1 1 1 1 1 1))
;-> 1
(find-unique '(1 1 3 1 1 1 1 1))
;-> 2
(find-unique '(1 1 1 1 1 1 3 1))
;-> 6


-----
1 o 2
-----

Scrivere una funzione che restituisce 1 quando viene passato 2 e restituisce 2 quando viene passato 1.

(define (f12a x)
  (if (= x 1) 2 1))

(f12a 1)
;-> 2
(f12a 2)
;-> 1

Scrivere la stessa funzione senza utilizzare la primitiva "if" o "cond".

(define (f12b x)
  (- 3 x))

(f12b 1)
;-> 2
(f12b 2)
;-> 1

Scrivere la stessa funzione senza utilizzare le operazioni aritmetiche elementari "+", "-", "*", "/".

(define (f12c x)
  (^ x 1 2))

(f12c 1)
;-> 2
(f12c 2)
;-> 1

Vediamo quale delle tre funzioni è la più veloce:

(time (f12a 2) 1e7)
;-> 685.196
(time (f12b 2) 1e7)
;-> 567.46
(time (f12c 2) 1e7)
;-> 610.196


-------------------------------------------------
Generare tutte le coppie di elementi di una lista
-------------------------------------------------

Scrivere una funzione per generare tutte le coppie diverse degli elementi di una lista.
Per esempio, la lista (a b c) genera la lista di coppie ((a b) (a c) (b c)).
Nota: le coppie (a b) e (b a) sono uguali.

La funzione è abbastanza semplice:

(define (pair-bind lst)
  (let (out '())
    (for (i 0 (- (length lst) 2))
      (for (j (+ i 1) (- (length lst) 1))
        (push (list (lst i) (lst j)) out -1)
      )
    )
    out))

(setq lst '(1 2 3 4 5))
(pair-bind lst)
;-> ((1 2) (1 3) (1 4) (1 5) (2 3) (2 4) (2 5) (3 4) (3 5) (4 5))

Adesso possiamo usare questo risultato per calcolare, ad esempio, le somme delle coppie di elementi:

(map (fn(x) (+ (first x) (last x))) (pair-bind lst))
;-> (3 4 5 6 5 6 7 7 8 9)

Oppure possiamo scrivere una funzione simile a "pair-bind" per calcolare la somma delle coppie di elementi:

(define (pair-sum lst)
  (let (out '())
    (for (i 0 (- (length lst) 2))
      (for (j (+ i 1) (- (length lst) 1))
        (push (+ (lst i) (lst j)) out -1)
      )
    )
    out))

(pair-sum lst)
;-> (3 4 5 6 5 6 7 7 8 9)

Notiamo che le due funzioni "pair-bind" e "pair-sum" sono uguali tranne la funzione che viene applicata ad ogni coppia di elementi, allora possiamo scrivere una funzione generica che prende come parametro la funzione da applicare (list, +, -, *, ecc.):

(define (pair-func f lst)
  (let (out '())
    (for (i 0 (- (length lst) 2))
      (for (j (+ i 1) (- (length lst) 1))
        (push (f (lst i) (lst j)) out -1)
      )
    )
    out))

Vediamo di simulare la funzione "pair-bind":

(pair-func list lst)
;-> ((1 2) (1 3) (1 4) (1 5) (2 3) (2 4) (2 5) (3 4) (3 5) (4 5))

Adesso la funzione "pair-sum":

(pair-func + lst)
;-> (3 4 5 6 5 6 7 7 8 9)

Calcoliamo la potenza di ogni coppia:

(pair-func pow lst)
;-> (1 1 1 1 8 16 32 81 243 1024)

Adesso un problema inverso, data una lista i cui elementi sono le coppie di elementi di un'altra lista, determinare la lista originale.
Per esempio, data la lista ((1 2) (1 3) (1 4) (1 5) (2 3) (2 4) (2 5) (3 4) (3 5) (4 5)), allora la lista originale vale (1 2 3 4 5).

(setq lst '((1 2) (1 3) (1 4) (1 5) (2 3) (2 4) (2 5) (3 4) (3 5) (4 5)))

(define (pair-inverse lst)
  (local (palo out)
    ; il primo valore è il palo (sentinella)
    (setq palo (lst 0 0))
    ; inserisce il primo valore
    (setq out (list palo))
    (dolist (el lst)
      ; se il valore è diverso,
      ; allora lo inserisce nella lista e
      ; aggiorna il valore del palo
      (if (!= (el 0) palo)
          (begin
          (setq palo (el 0))
          (push palo out -1))
      )
    )
    ; inserisce l'ultimo valore
    (push (lst -1 1) out -1)
  out))

(pair-inverse lst)
;-> (1 2 3 4 5)

Adesso un problema più complesso, data una lista i cui elementi sono la somma dele coppie di elementi di un'altra lista, determinare la lista originale.
Per esempio, data la lista (3 4 5 6 5 6 7 7 8 9), allora la lista originale vale (1 2 3 4 5).

In generale, la lista delle somme delle coppie della lista lst[0..n-1] vale (lst[0]+lst[1], lst[0]+lst[2], ..., lst[1]+lst[2], lst[1]+lst[3], ..., lst[2]+lst[3], lst[2]+lst[4], ..., lst[n-2]+lst[n-1]).

Supponiamo che la lista data sia "pair" e che ci siano n elementi nella lista originale. Se diamo un'occhiata ad alcuni esempi, possiamo osservare che lst[0] è la metà di pair[0] + pair[1] – pair[n-1]. Nota che il valore di pair[0] + pair[1] – pair[n-1] è (lst[0] + lst[1]) + (lst[0] + lst[2]) – (lst[1] + lst[2]). Una volta valutato lst[0], possiamo valutare altri elementi sottraendo lst[0]. Ad esempio lst[1] può essere valutato sottraendo lst[0] da pair[0], lst[2] può essere valutato sottraendo lst[0] da pair[1].
Possiamo ricavare la lunghezza della lista originale notando che è legata all'equazione dei numeri triangolari:

  (length pair) = (Triangular((length lst) - 1))
  Triangular(n) = n*(n-1)/2

dove:

  n = (length lst) - 1

quindi possiamo scrivere:

  (length (pair) = n*(n-1)/2 ==> 2*(length pair) = n*n - n

e ricavare n, cioè (length lst) - 1, risolvendo l'equazione di secondo grado:

(length lst) = (+ 1 (sqrt(1 + (8 * (length pair)))))/2

Adesso possiamo scrivere la funzione:

(define (pair-sum-inverse pair)
  (local (base len out)
    (setq out '())
    ; lunghezza della lista originale
    (setq len (/ (+ 1 (sqrt (+ 1 (* 8 (length pair))))) 2))
    ; valore base
    (setq base (/ (+ (pair 0) (pair 1) (- (pair (- len 1)))) 2))
    (push base out -1)
    (for (i 1 (- len 1))
      (push (- (pair (- i 1)) base) out -1)
    )
    out))

(pair-sum-inverse (pair-sum '(1 2 3 4 5)))
;-> (1 2 3 4 5)
(pair-sum-inverse (pair-sum '(1 2 3 4 5 6 7 8 9)))
;-> (1 2 3 4 5 6 7 8 9)
(pair-sum-inverse (pair-sum '(2 2 1 1 3 3 4 4 5)))
;-> (2 2 1 1 3 3 4 4 5)
(pair-sum-inverse (pair-sum '(2 1 2)))
;-> (2 1 2)


---------------------------------
Numero di partite nel Tic-Tac-Toe
---------------------------------

Quante partite diverse di Tic-Tac-Toe sono possibili?

http://www.se16.info/hgb/tictactoe.htm

Abbiamo 9 modi possibili per posizionare il primo segno, 8 modi per posizionare il secondo, 7 modi il terzo, ... e 1 per il nono. Quindi risulta 9*8*7*6*5*4*3*2*1 = 9! = 362880.

Ma nelle 362880 partite esistono anche quelle che dovrebbero essere terminate prima a causa della vittoria di uno dei due giocatori. Quindi le sole partite valide (cioè le partite che devono essere considerate terminate) sono quelle che terminano appena qualcuno ottiene tre simboli uguali in fila oppure quelle partite che hanno tutti le caselle riempite e senza nessun tris. Da notare che la partita di lunghezza minima ha 5 caselle occupate.
Possiamo trovare il numero totale di partite calcolando quante partite finiscono con cinque caselle, sei caselle, sette caselle, otto caselle e nove casella e poi sommando il tutto.

Nel caso di nove caselle ci sono due possibilità: o qualcuno ha vinto alla nona mossa, o è un pareggio senza tre di fila.

Supponiamo che il primo giocatore inizi con una X e il secondo usi una O.

Numero di partite che terminano alla quinta mossa
ci sono 8 linee di tre quadrati (tre verticali, tre orizzontali e due diagonali) e non importa in quale ordine sono state messe le tre X, e le due O potrebbero essere andate in due delle altre sei quadrati in qualsiasi ordine. Quindi abbiamo 8*3!*6*5 = 1440 partite che finiscono con una vittoria alla quinta mossa.

Numero di partite che terminano alla sesta mossa
ci sono ancora 8 righe di tre quadrati, e non importa in quale ordine sono state disposte le tre O, e le tre X avrebbero potuto essere inserite in tre degli altri sei quadrati in qualsiasi ordine (a condizione che le X siano non tre di fila). Ignorando la frase tra parentesi, questo ci dà 8*3!*6*5*4 = 5760 possibilità. Per tener conto della parentesi dobbiamo escludere i casi in cui ci sono tre O di fila e tre X di fila: nessuna di esse può essere una diagonale, e se si prende una riga particolare, ci sono solo altre due righe possibili , quindi dobbiamo escludere 6*3!*2*3! = 432 casi. Quindi stiamo guardando 5760-432 = 5328 partite che finiscono con una vittoria alla sesta mossa.

Numero di partite che terminano alla settima mossa
ci sono ancora 8 linee di tre quadrati, ma questa volta importa in quale ordine sono state poste le quattro X, poiché la quarta deve essere sulla linea, mentre le tre O potrebbero essere andate in tre delle altre cinque quadrati in qualsiasi ordine (a condizione che le O non siano tre di fila). Ignorando la frase tra parentesi, questo ci dà 8*3*6*3!*5*4*3 = 51840 possibilità. Per tener conto della parentesi dobbiamo escludere i casi in cui ci sono tre O di fila e tre X di fila: nessuna di esse può essere una diagonale, e se una determinata riga viene presa con X, ci sono solo altre due possibili righe di cui una ha una X, quindi dobbiamo escludere 6*3*6*3!*3! = 3888 casi. Quindi abbiamo 51840-3888 = 47952 partite che finiscono con una vittoria alla settima mossa.

Numero di partite che terminano all'ottava mossa
ci sono di nuovo 8 linee di tre quadrati, ma anche in questo caso non importa in quale ordine sono state disposte le quattro O, poiché la quarta deve essere sulla linea, mentre le quattro X potrebbero essere andate in quattro delle altre cinque quadrati in qualsiasi ordine (a condizione che le X non siano tre di fila). Ignorando la frase tra parentesi, questo ci dà 8*3*6*3!*5*4*3*2 = 103680 possibilità. Per tener conto della condizione tra parentesi, dobbiamo escludere i casi in cui ci sono tre O di fila e tre X di fila: nessuna di esse può essere una diagonale, e se una determinata riga viene presa con O, ci sono solo altre due possibili righe di cui una ha una O e due posti rimanenti per una X, quindi dobbiamo escludere 6*3*6*3!*2*4! = 31104 casi. Quindi sono 103680-31104 = 72576 partite che finiscono con una vittoria all'ottava mossa.

Numero di partite che terminano alla nona mossa
Questo potrebbe essere facilmente calcolato sottraendo le possibilità già coperte da 9!. Ma lo terremo da parte per un controllo finale e useremo la forza bruta. La partita potrebbe concludersi con una vittoria o un pareggio, e li calcoleremo entrambi.

Per vincere, ci sono molte di possibilità:
non solo dobbiamo assicurarci che non ci siano tre O in fila prima che la quinta X sia posizionata, ma anche che non ci sia già una linea distinta di tre X in fila. Per prima cosa consideriamo una vittoria che coinvolge solo una diagonale: ce ne sono due e la quinta X deve essere sulla diagonale. Questo significa che le altre due X possono trovarsi solo in 8 delle restanti 15 possibili coppie di quadrati fuori dalla diagonale: questo porta a 2*3*8*4!*4! = 27648 possibilità. In secondo luogo consideriamo una vincita che coinvolge solo un tre di fila verticale o orizzontale: le altre due X possono essere in 10 delle restanti 15 possibili coppie di quadrati fuori dalla fila per evitare altri tre X di fila, solo 4 su 10 evitano tre O di fila, ancora la quinta X deve trovarsi nella riga desiderata, questo porta a 6*3*4*4!*4! = 41472 possibilità. Terzo,bisogna considerare la possibilità che la quinta X completi due distinti tre di fila dove si intersecano: ci sono 22 possibili coppie di tre intersecanti di fila, la quinta X deve essere l'intersezione, questo porta a 22*1*4!*4! = 12672 possibilità. Quindi stiamo guardando 27648+41472+12672 = 81792 possibilità di partite che terminano con una vittoria alla nona mossa.

Per un pareggio:
ci sono un totale di 16 possibili modelli per le cinque X e quattro O che non hanno tre simboli in fila (ci sono tre modelli di base che aumentano a 8+4+4 con riflessioni e rotazioni). Quindi abbiamo 16*5!*4! = 46080 possibilità di partite che finiscono in parità alla nona mossa.

Quindi in totale abbiamo 81792+46080 = 127872 partite che durano fino alla nona mossa.

Controllo sul calcolo
Avremmo potuto calcolare la possibilità della nona mossa come 9! -4!*(quinta mossa vince) -3!*(sesta mossa vince) -2!*(settima mossa vince) -1!*(otto mossa vince) = 362880-24*1440-6*5328-2*47952 -1*72576 = 127872. Questo è lo stesso risultato di prima, quindi nonostante la possibilità di errori di compensazione, possiamo avere una certa fiducia nel risultato.

Quanti giochi di Tic-Tac-Toe (zero e croci) sono possibili?
Sommando tutte queste cifre si ottiene il risultato desiderato: 1440+5328+47952+72576+81792+46080 = 255168 possibili partite in totale .

Questa tabella riporta i risultati:

  Mosse            Partite         %
--------------------------------------
  Vittoria in 5     1440          0,6%
  Vittoria in 6     5328          2,1%
  Vittoria in 7    47952         18,8%
  Vittoria in 8    72576         28,4%
  Vittoria in 9    81792         32,1%
  Pareggio         46080         18,1%
--------------------------------------
  Totale           255168       100.0%

Comunque se entrambi i giocatori giocano in modo perfetto, allora le partite terminano sempre in pareggio.

Vediamo di implementare una simulazione.
Generiamo tutte le permutazioni delle 9 mosse.
Per ogni permutazione giochiamo la partita e vediamo come finisce, ad esempio, la permutazione/partita (2 7 6 5 1 4 9 3 8) si gioca nel modo seguente:
X occupa la casella 2
fine partita? (-1 X -1 -1 -1 -1 -1 -1 -1)
O occupa la casella 7
fine partita? (-1 X -1 -1 -1 -1 O -1 -1)
X occupa la casella 6
fine partita? (-1 X -1 -1 -1 X O -1 -1)
O occupa la casella 5
fine partita? (-1 X -1 -1 O X O -1 -1)
...
Per ogni partita memorizziamo il risultato e mettiamo la posizione finale in una lista.

Scriviamo alcune funzioni.

Generate tutte le permutazioni senza ripetizioni:

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
    out))

(length (perm '(1 2 3 4 5 6 7 8 9)))
;-> 362880

(silent (setq all-game (perm '(1 2 3 4 5 6 7 8 9))))
(all-game 21)
;-> (4 2 3 1 5 6 7 8 9)

Funzione che controlla se e come è terminata una partita:

(define (game-over? pos)
          ; controllo righe
    (cond ((or (and (!= (pos 0) -1) (= (pos 0) (pos 1) (pos 2)))
               (and (!= (pos 3) -1) (= (pos 3) (pos 4) (pos 5)))
               (and (!= (pos 6) -1) (= (pos 6) (pos 7) (pos 8))))
           '1)
          ; controllo colonne
          ((or (and (!= (pos 0) -1) (= (pos 0) (pos 3) (pos 6)))
               (and (!= (pos 1) -1) (= (pos 1) (pos 4) (pos 7)))
               (and (!= (pos 2) -1) (= (pos 2) (pos 5) (pos 8))))
           '1)
          ; controllo diagonali
          ((or (and (!= (pos 0) -1) (= (pos 0) (pos 4) (pos 8)))
               (and (!= (pos 2) -1) (= (pos 2) (pos 4) (pos 6))))
           '1)
          ; controllo caselle tutte occupate (partita terminata patta)
          ((zero? (first (count '(-1) pos)))
           '0)
          ; partita non finita
          (true '2)))

(setq pos '(1 0 1
            0 0 1
            0 1 -1))
(game-over? pos)
;-> 2
(setq pos '(1 0 1
            0 0 1
            0 1 0))
(game-over? pos)
;-> 0
(setq pos '(1 1 1
            0 -1 -1
            0 -1 -1))
(game-over? pos)
;-> 1
(setq pos '(0 1 1
            0 1 -1
            0 -1 1))
(game-over? pos)
;-> 1
(setq pos '(0 1 1
            1 1 -1
            0 -1 1))
(game-over? pos)
;-> 2
(setq pos '(-1 1 1
            1 -1 -1
            0 -1 -1))
(game-over? pos)
;-> 2

Funzione che gioca una posizione (per esempio (8 7 2 3 5 4 1 9 6)):

(define (play pos)
  (local (cur res stop)
    (setq cur (dup -1 9))
    (for (i 0 3)
      (if (even? i)
          (setf (cur (- (pos i) 1)) '1)
          (setf (cur (- (pos i) 1)) '0)
      )
    )
    ;(println "partita iniziale: ")
    ;(print-board cur)
    ;(read-line)
    (for (i 4 8 1 stop)
      (if (even? i)
          (setf (cur (- (pos i) 1)) '1)
          (setf (cur (- (pos i) 1)) '0)
      )
      ; res -> (1=win 0=draw 2=play)
      (setq res (game-over? cur))
      ;(println "partita attuale: ")
      ;(print-board cur)
      ;(println "risultato: " res)
      ;(read-line)
      (cond ((or (= res 1) (= res 0))
             (setq stop true)
             (if (= res 1) (push cur out -1))
             (++ (freq res)))
            ((= res 2) nil)
            (true (println "error:" res))
      ))))

Funzione che stampa una posizione:

(define (print-board pos)
  (println (format "%2d %2d %2d" (pos 0) (pos 1) (pos 2)))
  (println (format "%2d %2d %2d" (pos 3) (pos 4) (pos 5)))
  (println (format "%2d %2d %2d" (pos 6) (pos 7) (pos 8))))

(print-board pos)
;->  1  1  1
;->  0 -1 -1
;->  0 -1 -1

Nota: per provare la funzione play occorre definire: (setq freq '(0 0))

Funzione che gestisce tutta la simulazione:

(define (num-ttt)
  (local (freq out)
    (setq out '())
    (setq freq '(0 0))
    (setq all-game (perm '(1 2 3 4 5 6 7 8 9)))
    (dolist (game all-game)
      (play game)
    )
    (println freq)
    out))

(silent (setq allwin (num-ttt)))
;-> (46080 316800)

(allwin 1)
;-> (0 1 1 0 1 0 1 -1 -1)

(print-board (allwin 1))
;->  0  1  1
;->  0  1  0
;->  1 -1 -1

(game-over? (allwin 1))
;-> 1

(length allwin)
;-> 316800

Adesso contiamo le vittorie in base al numero delle mosse (5,6,7,8 o 9):

(define (contawin lst)
  (local (fwin num)
    (setq fwin '(0 0 0 0 0 0 0 0 0 0))
    (dolist (el lst)
      ; conta quanti -1 esistono nella posizione
      ; e poi aggiorna la lista delle frequenza
      (setq num (- 9 (first (count '(-1) el))))
      (++ (fwin num))
    )
    fwin))

(contawin allwin)
;-> (0 0 0 0 0 34560 31968 95904 72576 81792)

Questo significa che tra tutte le partite vinte:

34560 partite terminano in 5 mosse
31968 partite terminano in 6 mosse
95904 partite terminano in 7 mosse
72576 partite terminano in 8 mosse
81792 partite terminano in 9 mosse

Ricordiamo dal Controllo del calcolo precedente che risulta:

(* 24 1440)
;-> 34560
(* 6 5328)
;-> 31968
(* 2 47952)
;-> 95904
(* 1 72576)
;-> 72576
(* 1 81792)
;-> 81792

Numero di partite patte:

(- 362880 (+ 34560 31968 95904 72576 81792))
;-> 46080

Nota: una posizione finale può derivare da molte partite diverse.

Quindi le posizioni della lista allwin contengono anche molte posizioni doppie. Vediamo di calcolare solo le posizioni finali univoche:

(setq allvalidwin (unique allwin))

(length allvalidwin)
;-> 942

Adesso contiamo le vittorie delle posizioni finali uniche in base al numero delle mosse (5,6,7,8 o 9):

(contawin allvalidwin)
;-> (0 0 0 0 0 120 148 444 168 62)

Questo significa che ci sono:

120 posizioni finali univoche di vittoria in 5 mosse
148 posizioni finali univoche di vittoria in 6 mosse
444 posizioni finali univoche di vittoria in 7 mosse
168 posizioni finali univoche di vittoria in 8 mosse
 62 posizioni finali univoche di vittoria in 9 mosse

=============================================================================

