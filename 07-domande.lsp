====================================================

 DOMANDE PROGRAMMATORI (CODING INTERVIEW QUESTIONS)

====================================================

---------------
Notazione Big-O
---------------

Valori della notazione Big-O in funzione del numero di ingresso

 n  costante logaritmo  lineare   nlogn      quadrato   cubo    esponenziale
 1    O(1)   O(log(n))   O(n)   O(n*log(n))   O(n^2)   O(n^3)       O(2^n)
 2     1        1          1        1             1        1            1
 4     1        1          2        2             4        8            4
 8     1        3          8       24            64      512          256
16     1        4         16       64           256     4096        65536
32     1        5         32      160          1024    32768   4294967296
64     1        6         64      384          4096   262144   1.84x10^19


-----------------------------------
Contare i bit di un numero (McAfee)
-----------------------------------

Dato un numero intero positivo n, contare il numero di bit che valgono 1 nella sua rappresentazione binaria.

Possiamo trasformare il numero in binario e contare quanti bit hanno valore 1.
Le funzioni di conversione decimale e binario sono le seguenti:

(define (bin2dec n)
  (if (zero? n) n
      (+ (% n 10) (* 2 (bin2dec (/ n 10))))))

(define (dec2bin n)
   (if (zero? n) n
       (+ (% n 2) (* 10 (dec2bin(/ n 2))))))

Siccome non dobbiamo ricreare il numero binario, ci limiteremo a contare i bit con valore 1.

Con l'operazione modulo (% n 2), estraiamo il bit più a destra del numero n (il bit meno significativo).
Esempio: consideriamo il numero 25

(dec2bin 25)
;-> 11001

Calcoliamo (% 25 2):
(% 25 2)
;-> 1

Poi calcoliamo (% 12 2), con 25/2 = 12
(% 12 2)
;-> 0

(% 6 2)
;-> 0

(% 3 2)
;-> 1

(% 1 2)
;-> 1

Ed ecco la funzione per contare i bit con valore 1:

(define (bit1 n)
  (let (conta 0)
    (while (> n 0)
       (if (= (% n 2) 1) (++ conta))
       (setq n (/ n 2))
    )
    conta
  )
)

(bin2dec 10001011001)
;-> 1113
(bit1 1133)
;-> 6

(bin2dec 1110011010001)
;-> 7377
(bit1 7377)
;-> 7

Per estrarre il bit più a destra di un numero possiamo usare anche le funzioni bitwise:
Usando l'operatore bitwise AND "&", l'espressione (n & 1) produce un valore che è 1 o 0, a seconda del bit meno significativo di x: se l'ultimo bit è 1 allora il risultato di (x & 1) vale 1, altrimenti vale 0.
Usando l'operatore SHIFT ">>", l'espressione (n >> 1) sposta (shifta) di un bit verso destra il valore del numero n. In altre parole, divide il numero n per 2.
La funzione diventa:

(define (nbit1 n)
  (let (conta 0)
    (if (< n 0) (setq n (sub 0 n))) ; altrimenti il ciclo non termina
    (while (> n 0)
      (if (= (& n 1) 1) (++ conta))
      (setq n (>> n))
    )
    conta
  )
)

(bin2dec 10001011001)
;-> 1113
(nbit1 1133)
;-> 6

(bin2dec 1110011010001)
;-> 7377
(nbit1 7377)
;-> 7
(nbit1 -1133)
;-> 6
(int "-10001101101" 0 2)
;-> -1133

Nota: il valore del bit più significativo dopo lo spostamento è zero per i valori di tipo senza segno (unsigned). Per i valori di tipo con segno (signed), il bit più significativo viene copiato dal bit del segno del valore prima dello spostamento come parte dell'estensione del segno, quindi il ciclo non termina mai se n è di tipo con segno e il valore iniziale è negativo.

Ora vediamo quale metodo è più veloce:

(bit1 123456789)
;-> 16

(time (bit1 123456789) 100000)
;-> 527.479

(nbit1 123456789)
;-> 16

(time (nbit1 123456789) 100000)
;-> 494.247

La funzione che usa gli operatori bitwise è leggermente più veloce.


---------------------------------------------
Scambiare il valore di due variabili (McAfee)
---------------------------------------------

Come scambiare il valore di due variabili (swap) senza utilizzare una variabile di appoggio?

Primo metodo (somma/sottrazione):

Vediamo il funzionamento algebrico:
a = 1
b = 2

a = a + b --> a = a + b = 3 e b = 2
b = a - b --> b = ((a + b) - b) = 1 e a = 3
a = a - b --> a = (a + b) - ((a + b) - b) = 2

(setq a 1 b 2)
(println {a = } a { - b = } b)
;-> a = 1 - b = 2
(setq a (+ a b))
(setq b (- a b))
(setq a (- a b))
(println {a = } a { - b = } b)
;->  a = 2 - b = 1

(define (scambia x y)
  (setq x (+ x y))
  (setq y (- x y))
  (setq x (- x y))
  (list x y)
)

(scambia 2 3)
;-> (3 2)
(scambia -2 -3)
;-> (-3 -2)

Secondo metodo (map):

(setq a 1 b 2)
(println {a = } a { - b = } b)
;-> a = 1 - b = 2
(map set '(a b) (list b a))
(println {a = } a { - b = } b)
;-> a = 2 - b = 1

Terzo metodo (xor):

(setq a 5 b 10)
(setq a (^ a b))
;-> 15
(setq b (^ a b))
;-> 5
(setq a (^ a b))
;-> 10

Ricordiamo che lo XOR ha la seguente tabella di verità:

x y | out
---------
0 0 |  0
0 1 |  1
1 0 |  1
1 1 |  0

Quando si applica lo XOR a due variabili, i bit della prima variabile vengono utilizzati per alternare i bit nell'altro. A causa della natura di questo cambiamento, non importa quale variabile venga usata per alternare l'atra poichè i risultati sono gli stessi. Lo stesso bit nella stessa posizione in entrambi i numeri produce uno 0 in quella posizione nel risultato. I bit opposti producono un 1 in quella posizione.

(setq a (^ a b))
a è ora impostato sulla maschera di bit combinata di a e b. b ha ancora il valore originale.

(setq b (^ a b))
b è ora impostato sulla maschera di bit combinata di (a XOR b) e b. La b si cancella, quindi ora b è impostato sul valore originale di a. a è ancora impostato sulla maschera di bit combinata di a e b.

(setq a (^ a b))
a è ora impostato sulla maschera di bit combinata di (a XOR b) e a. (ricorda, b contiene effettivamente il valore originale di a adesso) La a si cancella, e quindi a è ora impostato sul valore originale di b.

Scriviamo la funzione (dobbiamo controllare che le variabili non contengano lo stesso numero, altrimenti il risultato sarebbe zero per entrambe):

(define (scambia x y)
  (cond ((= x y) (list x y))
        (true (setq x (^ x y))
              (setq y (^ x y))
              (setq x (^ x y))
              (list x y)
        )
  )
)

(scambia 5 25)
;-> (25 5)

(scambia 15 5)
;-> (5 15)

Quarto metodo (newLISP):

(setq a 1 b 2)
;-> 2
(swap a b)
;-> 1
(list a b)
;-> (2 1)


------------------------
Funzione "atoi" (McAfee)
------------------------

La funzione "atoi" del linguaggio C converte una stringa in un numero intero.
Implementare la funzione "atoi".

Per una corretta implementazione devono essere considerati i seguenti casi:

1. stringa di input vuota o nulla
2. spazi vuoti nella stringa di input
3. segno +/-
4. calcolare il valore della stringa
5. trattare i valori min & max

(define (atoi s)
  (local (flag i val)
    (cond ((or (null? s) (< (length s) 1)) 0) ; stringa nulla, valore nullo
          (true
            (setq s(trim s))
            (setq flag "+")
            (setq i 0)
            ; acquisizione segno
            (if (= (s 0) "-")
                (begin (setq flag "-") (++ i))
                (if (= (s 0) "+") (++ i))
            )
            (setq val 0)
            (while (and (> (length s) i) (>= (s i) "0") (<= (s i) "9"))
              (setq val (add (mul val 10) (sub (char (s i)) (char "0"))))
              (++ i)
            )
            ; controllo segno del risultato
            (if (= flag "-") (setq val (sub 0 val)))
            ; controllo overflow
            (if (> val 9223372036854775807) (setq val -9223372036854775808))
            (if (< val -9223372036854775808) (setq val 9223372036854775807))
          );true
    );cond
    (int val)
  );local
)

(atoi "9223372036854775808")
;-> -9223372036854775808
(int "9223372036854775808")
;-> -9223372036854775808

(atoi "-9223372036854775809")
;-> 9223372036854775807
(int "-9223372036854775809")
;-> 9223372036854775807

(atoi "123")
;-> 123
(int "123")
;-> 123

(atoi " -345hj5")
;-> -345
(int " -345hj5")
;-> -345

(atoi "")
;-> nil
(int "")
;-> nil

(atoi nil)
;-> nil
(int nil)
;-> nil


-------------------------------------
Somma di numeri in una lista (Google)
-------------------------------------

Data una lista di numeri e un numero k, restituire se due numeri dalla lista si sommano a k.
Ad esempio, dati (10 15 3 7) e k di 17, restituisce true da 10 + 7 che vale 17.
Bonus: puoi farlo in un solo passaggio?

Se vogliamo trovare la somma di ogni combinazione di due elementi di una lista il metodo più ovvio è quello di creare due for..loop sulla lista e verificare se soddisfano la nostra condizione.
Tuttavia, in questi casi, puoi sempre ridurre la complessità O(n^2) a O(log(n)) avviando il secondo ciclo dal corrente elemento della lista, perché, ad ogni passo del primo ciclo, tutti gli elementi precedenti sono già confrontati tra loro.
Quindi la soluzione è iterare sulla lista e per ogni elemento cercare se qualsiasi elemento della lista successiva somma fino a 17.

(define (sol lst n)
  (local (out ll)
    (setq out nil)
    (setq ll (- (length lst) 1))
    (for (i 0 ll 1 (= out true)) ; se out vale true, allora esce dal for..loop
      (for (j i ll)
        (if (= n (add (nth i lst) (nth j lst)))
          (setq out true)
        )
      )
    )
    out
  )
)

(sol '(10 15 3 7) 17)
;-> true

(sol '(3 15 10 7) 17)
;-> true

(sol '(3 15 10 7) 21)
;-> nil


---------------------------------
Aggiornamento di una lista (Uber)
---------------------------------

Data una lista di interi, restituire una nuova lista in modo tale che ogni elemento nell'indice i della nuova lista sia il prodotto di tutti i numeri nella lista originale tranne quello in i.
Ad esempio, se il nostro input fosse (1 2 3 4 5), l'uscita prevista sarebbe (120 60 40 30 24).
Se il nostro input fosse (3 2 1), l'output atteso sarebbe (2 3 6).
Se il nostro input fosse (3 2 1 0), l'output previsto sarebbe (0 0 0 6).
Se il nostro input fosse (0 3 2 1 0), l'output previsto sarebbe (0 0 0 0).

La soluzione intuitiva porta alla funzione seguente:

(define (sol1 lst)
  (setq out '())
  (dolist (i lst)
    (setq p 1)
    (setq idx $idx)
    (dolist (j lst)
      (if (!= idx $idx)
          (setq p (mul p j)))
    )
    ;(push p out)
    (push p out -1)
  )
)

(sol1 '(1 2 3 4 5))
;-> (120 60 40 30 24)

(sol1 '(1 0 3 4 5))
;-> (0 60 0 0 0)

(sol1 '(3 2 1 0))
;-> (0 0 0 6)

(sol1 '(1 0 3 0 5))
;-> (0 0 0 0 0)

Un altro metodo deriva dalla seguente osservazione: nella nuova lista il valore dell'elemento i vale il prodotto di tutti i numeri diviso il numero dell'elemento i. Ad esempio con una lista di tre elementi (a b c) otteniamo:

primo elemento:    a * b * c / a = b * c
secondo elemento:  a * b * c / b = a * c
terzo elemento:    a * b * c / c = a * b

Quindi dobbiamo calcolare il prodotto di tutti gli elementi della lista e poi dividere questo valore con il valore di ogni elemento. In questo modo otteniamo il prodotto di tutti gli elementi tranne quello corrente.
Adesso dobbiamo tenere conto degli elementi con valore zero:

1. Uno zero nella lista.
In questo caso, il risultato dovrebbe essere tutti zero tranne l'elemento che ha valore 0: questo elemento dovrebbe contenere il prodotto di tutti gli altri.

2. Due zeri o più nella lista.
Questo caso è più o meno come il primo, ma la lista risultante contiene sempre solo zeri. Perché 'cè sempre uno zero nel prodotto.

Per considerare questi due casi calcoliamo il prodotto di tutti gli elementi tranne quelli che hanno valore zero e contiamo anche quanti zeri ci sono nella lista.
Quindi se abbiamo due o più zeri nella lista iniziale, possiamo restituire una list con tutti zeri.
Altrimenti, iteriamo la lista per sostituire gli elementi che valgono zero con il prodotto che abbiamo calcolato e assegnare il valore zero a tutti gli altri elementi.

La funzione è la seguente:

(define (sol2 lst)
  (local (prod numzeri out)
    (if (< (length lst) 2) (setq out lst) ; lista con meno di due elementi --> lista
        (begin
          (setq out '())
          (setq prod 1)
          (setq numzeri 0)
          ; calcolo del prodotto degli elementi e del numero di zeri
          (dolist (el lst)
            (if (zero? el) (++ numzeri)
                (setq prod (mul prod el))
            )
          )
          (cond ((> numzeri 1) (setq out (dup 0 (length lst)))) ; restituisco una lista con tutti zeri
                ((= numzeri 1) (dolist (el lst)
                                  (if (zero? el) (push prod out -1) ; valore del prodotto sugli elementi che hanno valore zero
                                      (push 0 out -1) ; valore zero su tutti gli altri elementi
                                  )
                               )
                )
                (true (dolist (el lst)
                        (push (div prod el) out -1) ; assegnazione di prodotto / elemento
                      )
                )
          )
        );begin
    );if
    out
  );local
)

(sol2 '(1 2 3 4 5))
;-> (120 60 40 30 24)

(sol2 '(3 2 1))
;-> (2 3 6)

(sol2 '(3 2 1 0))
;-> (0 0 0 6)

(sol2 '(0 3 2 1 0))
;-> (0 0 0 0 0)


------------------------------------
Ricerca numero su una lista (Stripe)
------------------------------------

Data una lista di numeri interi, trova il primo intero positivo mancante in tempo lineare e spazio costante. In altre parole, trova il numero intero positivo più basso che non esiste nelll lista. La lista può contenere anche duplicati e numeri negativi.
Ad esempio, l'input (3 4 -1 1) dovrebbe dare 2.
L'input (1 2 0) dovrebbe dare 3.
È possibile modificare la lista di input.

Possiamo notare che gli indici di una lista e i numeri interi sono la stessa cosa.
Quindi inseriamo ogni numero intero positivo di una lista al suo posto e poi iteriamo di nuovo per trovare il primo numero mancante. Se non troviamo il numero mancante (la lista è completa di tutti i numeri), allora restituiamo la lunghezza della lista.

(define (sol lst)
  (local (out ll)
    (setq out -1)
    (setq ll (- (length lst) 1))
    (dolist (el lst)
      (cond ((< el 0) nil) ; numero negativo: non fare niente
            ((>= el (length lst)) nil) ; numero oltre la lista: non fare niente
            (true   (setf (nth el lst) el))
      )
    )
    (for (x 1 ll 1 (!= out -1))
      (if (!= (nth x lst) x) (setq out x))
    )
    (if (= out -1) (setq out (+ ll 1)))
    (list out lst)
  )
)

(sol '(6 5 4 3 2 1 0))
;-> (7 (0 1 2 3 4 5 6))

(sol '(4 4 -1 1))
;-> (2 (4 1 -1 1))

(sol '(4 0 -1 1 2 5 7 9))
;-> (3 (0 1 2 1 4 5 7 7))


-------------------------------------
Decodifica di un messaggio (Facebook)
-------------------------------------

Data la mappatura a = 1, b = 2, ... z = 26 e un messaggio codificato, contare il numero di modi in cui può essere decodificato.
Ad esempio, il messaggio "111" restituirebbe 3, poiché potrebbe essere decodificato come "aaa" (1)(1)(1), "ka" (11)(1) e "ak" (1)(11).
Puoi presumere che i messaggi siano decodificabili. Per esempio, "001" non è permesso.

Molti dei problemi di analisi delle liste e delle stringhe sono basati sulla ricorsione.
Per iniziare è sempre utile risolvere manualmente alcuni casi banali, cercando di utilizzare i risultati di un caso precedente:

- se la lunghezza di una stringa è uno, c'è sempre un modo per decodificarlo,

"1": ("1")
----------
F ("1") = 1

- se la lunghezza è 2, abbiamo sempre un modo con tutte le cifre separatamente, più uno se un numero è inferiore a 26.

"12": ("1","2") e ("12")
------------------------
F ("12 ") = f ("12") + 1

- se la lunghezza è 3, possiamo usare i risultati del precedente calcoli, perché sappiamo già come affrontare le stringhe più brevi.

F ("123") = f ("1") * F ("23 ") + F ("12") * f ("3") = 3

- Tutti i casi successivi possono essere calcolati utilizzando le definizioni precedentemente definite:

F ("4123") = f ("4") * F ("123") + f ("41") * F ("23") = 3

Inoltre utilizzeremo una funzione (decodifica?) che ritorna "1" se la stringa è decodificabile e "0" altrimenti.

(define (sol s)
  (local (lun p)
    (setq lun (length s))
    (setq p (s 0))
    (cond ((= 1 lun) (decodifica? s))
          ((= 2 lun) (if (= p "0") (decodifica? s) (add (decodifica? s) 1)))
          (true (add (mul (decodifica? (slice s 0 1)) (sol (slice s 1)))
                     (mul (decodifica? (slice s 0 2)) (sol (slice s 2)))))
    )
  )
)

(define (decodifica? ss)
  (setq v (int ss 0 10))
  (if (= (s 0) "0") ; la forma "01" non è valida
      0
      (if (and (> v 0) (<= v 26))
          1
          0
      )
  )
)

(sol "111")
;-> 3

(sol "111233423421")
;-> 32

(sol "4123")
;-> 3

(sol "101")
;-> 1


-------------------------------------------
Implementazione di un job-scheduler (Apple)
-------------------------------------------


Implementare un job scheduler che prende come parametri una funzione "f" e un intero "n" e chiama "f" dopo "n" millisecondi.

Definiamo una funzione che rende un numero pari o dispari in maniera casuale.

(define (g)
  (if (zero? (rand 2))
      ; se esce 0, allora diventa o rimane pari
      (if (odd? num)  (println "diventa pari: " (++ num))
                      (println "rimane pari: " num))
      ; se esce 1, allora diventa o rimane dispari
      (if (even? num) (println "diventa dispari: " (++ num))
                      (println "rimane dispari: " num))
  )
)

Definiamo il valore iniziale del numero:

(define num 1)

E infine scriviamo il nostro job-scheduler:

(define (job f n)
  ; funziona anche in questo modo perchè "num" è una variabile globale
  ; e viene vista anche dalla funzione "g".
  ;(setq num 1)
  (while true
    (sleep n)
    (g)
  )
)

Lanciamo il nostro job-scheduler che eseguirà la funzione "g" ogni 2 secondi:

(job fun 2000)
;-> rimane dispari: 1
;-> rimane dispari: 1
;-> diventa pari: 2
;-> diventa dispari: 3
;-> rimane dispari: 3
;-> diventa pari: 4
;-> rimane pari: 4
;-> diventa dispari: 5
;-> rimane dispari: 5
;-> rimane dispari: 5
;-> diventa pari: 6
;-> diventa dispari: 7
;-> rimane dispari: 7
;-> rimane dispari: 7
;-> diventa pari: 8
;-> rimane pari: 8
;-> rimane pari: 8
;-> rimane pari: 8
;-> rimane pari: 8
;-> rimane pari: 8
;-> diventa dispari: 9
;-> diventa pari: 10


---------------------------------------
Massimo raccoglitore d'acqua (Facebook)
---------------------------------------

Dati n numeri interi non negativi a1, a2, ..., an, dove ognuno rappresenta un punto di coordinate
(i, ai), n linee verticali sono disegnate in modo tale che i due estremi della linea i siano ad (i, ai)
e (i, 0). Trova due linee, che insieme all'asse x formano un contenitore, in modo tale che il
il contenitore contenga più acqua.

Esempio:
                           6
     6         5           |
     5         |     4     |
     4      3  |  3  |  3  |  3
     3   2  |  |  |  |  |  |  |
     2   |  |  |  |  |  |  |  |
     1   |  |  |  |  |  |  |  |
         ----------------------
         0  1  2  3  4  5  6  7

(setq lst '(2 3 5 3 4 3 6 3))

Questa è la soluzione grafica:

                         6
   6         5           |
   5         |OOOOOOOOOOO|
   4      3  |OOOOOOOOOOO|  3
   3   2  |  |OOOOOOOOOOO|  |
   2   |  |  |OOOOOOOOOOO|  |
   1   |  |  |OOOOOOOOOOO|  |
       ----------------------
       0  1  2  3  4  5  6  7

In questo caso le linee del contenitore che contengono più acqua sono la 2 (con valore 5) e la 6 (con valore 6).
L'altezza h del contenitore è data dal valore minore, cioè quello della linea 2 che vale 5.
La larghezza d del contenitore è la distanza tra le due linee (cioè la differenza degli indici), che vale (6 - 2) = 4.
L'area del contenitore massimo vale A = h*d = 5*4 = 20.

Attenzione: l'area massima non sempre è delimitata dai due valori massimi. Il seguente esempio mostra un caso in cui i valori massimi non delimitano l'area massima:

                                       9
     9                                 |     8
     8                              7  |     |
     7                              |  |     |
     6         5                    |  |     |
     5         |     4     4        |  |     |
     4      3  |  3  |  3  |  3  3  |  |  3  |
     3   2  |  |  |  |  |  |  |  |  |  |  |  |
     2   |  |  |  |  |  |  |  |  |  |  |  |  |
     1   |  |  |  |  |  |  |  |  |  |  |  |  |
        ---------------------------------------
         0  1  2  3  4  5  6  7  8  9  10 11 12

(setq lst '(2 3 5 3 4 3 4 3 3 7 9 3 8))

Questa è la soluzione grafica:

                                       9
     9                                 |     8
     8                              7  |     |
     7                              |  |     |
     6         5                    |  |     |
     5         |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
     4      3  |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
     3   2  |  |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
     2   |  |  |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
     1   |  |  |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
        ---------------------------------------
         0  1  2  3  4  5  6  7  8  9  10 11 12

Poniamo l'area del contenitore a 0.
Iniziamo a scansionare la lista di numeri da sinistra (sx) e da destra (dx).
Se (valore di sinistra) < (valore di destra), allora spostarsi da sinistra verso destra e trovare un valore maggiore del (valore di sinistra).
Se (valore di sinistra) > (valore di destra), allora spostarsi da destra verso sinistra e trovare un valore maggiore del (valore di destra).
Durante la scansione occorre tenere traccia del valore massimo dell'area del contenitore.
Tale area è data dalla moltiplicazione tra differenza degli indici correnti (larghezza) e il valore minimo dei valori correnti (altezza).

Possiamo scrivere la soluzione:

(define (sol lst)
  (local (areamax dx sx i1 i2 v1 v2 dmax vmax d h)
    (setq areamax 0)
    (setq sx 0)
    (setq dx (sub (length lst) 1))
    (while (< sx dx)
      (setq d (sub dx sx))
      (setq h (min (lst sx) (lst dx)))
      (if (> (mul d h) areamax)
        (begin  (setq areamax (mul d h))
                (setq i1 sx i2 dx)
                (setq v1 (lst i1))
                (setq v2 (lst i2))
                (setq vmax h)
                (setq dmax d)
        )
      )
      (if (< (lst sx) (lst dx))
          (++ sx)
          (-- dx)
      )
      ;(println "isx = " sx " - idx" dx)
    )
    (list areamax dmax vmax i1 i2 v1 v2)
  )
)

(sol '(2 3 5 3 4 3 6 3))
;-> (20 4 5 2 6 5 6)
; 5 e 6 --> h=5, distanza indici tra 5 e 6 d = (6-2) = 4  ==> area = h*d = 5*4 = 20

(sol '(2 8 5 3 4 3 7 3))
;-> (35 5 7 1 6 8 7)
;-> 35 ; 7 e 8 --> h=7, distanza indici tra 7 e 8 d = (6-1) = 5  ==> area = h*d = 7*5 = 35

(sol '(2 3 5 3 4 3 4 3 3 7 9 3 8))
;-> (50 10 5 2 12 5 8)

Se vogliamo sapere solo l'area massima, allora la soluzione è la seguente:

(define (sol lst)
  (local (areamax dx sx)
    (setq areamax 0)
    (setq sx 0)
    (setq dx (sub (length lst) 1))
    (while (< sx dx)
      (setq areamax (max areamax (mul (sub dx sx) (min (lst sx) (lst dx)))))
      (if (< (lst sx) (lst dx))
          (++ sx)
          (-- dx)
      )
    )
    areamax
  )
)

(sol '(1 5 4 3))
;-> 6

(sol '(3 1 2 4 5))
;-> 12

(sol '(2 3 5 3 4 3 6 3))
;-> 20

(sol '(2 8 5 3 4 3 7 3))
;-> 35

(sol '(2 3 5 3 4 3 4 3 3 7 9 3 8))
;-> (50)

Consideriamo nuovamente questo ultimo esempio:

                                       9
     9                                 |     8
     8                              7  |     |
     7                              |  |     |
     6         5                    |  |     |
     5         |     4     4        |  |     |
     4      3  |  3  |  3  |  3  3  |  |  3  |
     3   2  |  |  |  |  |  |  |  |  |  |  |  |
     2   |  |  |  |  |  |  |  |  |  |  |  |  |
     1   |  |  |  |  |  |  |  |  |  |  |  |  |
        ---------------------------------------
         0  1  2  3  4  5  6  7  8  9  10 11 12

(setq lst '(2 3 5 3 4 3 4 3 3 7 9 3 8))

(sol '(2 3 5 3 4 3 4 3 3 7 9 3 8))
;-> (50 10 5 2 12 5 8)

Come abbiamo visto questa è la soluzione grafica:

                                       9
     9                                 |     8
     8                              7  |     |
     7                              |  |     |
     6         5                    |  |     |
     5         |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
     4      3  |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
     3   2  |  |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
     2   |  |  |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
     1   |  |  |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
        ---------------------------------------
         0  1  2  3  4  5  6  7  8  9  10 11 12

Ma se invece vogliamo considerare la soluzione seguente:

                                       9
     9                                 |     8
     8                              7  |     |
     7                              |  |     |
     6         5                    |  |     |
     5         |OOOOOOOOOOOOOOOOOOOO|  |     |
     4      3  |OOOOOOOOOOOOOOOOOOOO|  |  3  |
     3   2  |  |OOOOOOOOOOOOOOOOOOOO|  |  |  |
     2   |  |  |OOOOOOOOOOOOOOOOOOOO|  |  |  |
     1   |  |  |OOOOOOOOOOOOOOOOOOOO|  |  |  |
        ---------------------------------------
         0  1  2  3  4  5  6  7  8  9  10 11 12

allora dobbiamo scrivere una nuova funzione per calcolare la soluzione.


----------------------------------------
Quantità d'acqua in un bacino (Facebook)
----------------------------------------

Dati n interi non negativi che rappresentano una mappa di elevazione in cui la larghezza di ciascuna barra è 1, calcolare la quantità massima di acqua che è in grado di contenere

Esempi:

lista = (2 0 2)
acqua = 2

   202
2  |x|
1  |x|
0  ---
   012

Possiamo avere "2 unità di acqua" (x) nello spazio intermedio.

lista: (3 0 0 2 0 4)
acqua: 10

  300204
       |
3 |xxxx|
2 |xx|x|
1 |xx|x|
0 ------
  012345

"3 * 2 unità" di acqua tra 3 e 2,
"1 unità" in cima alla barra 2,
"3 unità" tra 2 e 4.

lista: (0 1 0 2 1 0 1 3 2 1 2 1)
acqua: 6

  010210132121
3        |
2    |xxx||x|
1  |x||x||||||
0 ------------
  012345678901

"1 unità" tra i primi 1 e 2,
"4 unità" tra i primi 2 e 3,
"1 unità" in cima alla barra 9 (tra il penultimo 1 e l'ultimo 2).

Un elemento dell'array può immagazzinare acqua se ci sono barre più alte a sinistra e a destra. Possiamo trovare quantità di acqua da immagazzinare in ogni elemento trovando l'altezza delle barre sui lati sinistro e destro. L'idea è di calcolare la quantità d'acqua che può essere immagazzinata in ogni elemento dell'array. Ad esempio, considera l'array (3 0 0 2 0 4), possiamo memorizzare due unità di acqua agli indici 1 e 2, e una unità di acqua all'indice 2.

Una soluzione semplice consiste nel percorrere ogni elemento dell'array e trovare le barre più alte sui lati sinistro e destro. Prendere la minore delle due altezze. La differenza tra altezza minima e altezza dell'elemento corrente è la quantità di acqua che può essere immagazzinata in questo elemento dell'array. La complessità temporale di questa soluzione è O(n^2).

Una soluzione efficiente consiste nel pre-calcolare la barra più alta a sinistra e a destra di ogni barra nel tempo O(n). Quindi utilizzare questi valori pre-calcolati per trovare la quantità di acqua in ogni elemento dell'array. Di seguito vediamo l'implementazione di questa ultima soluzione.

(define (bacino lst)
  (local (lun sx dx acqua)
      (setq lun (length lst))
      (setq sx (array lun))
      (setq dx (array lun))
      (setq acqua 0)
      ; riempimento sx
      (setf (sx 0) (lst 0))
      (for (i 1 (sub lun 1))
        (setf (sx i) (max (sx (sub i 1)) (lst i)))
      )
      ; riempimento dx
      (setf (dx (sub lun 1)) (lst (sub lun 1)))
      (for (i (sub lun 2) 0 -1)
        (setf (dx i) (max (dx (add i 1)) (lst i)))
      )
      ; bar vale min(sx[i], dx[i]) - arr[i]
      (for (i 0 (sub lun 1))
        (setq bar-acqua (sub (min (sx i) (dx i)) (lst i)))
        (print bar-acqua { })
        (setq acqua (add acqua bar-acqua))
      )
   )
)

(bacino '(2 0 2))
;-> 2 0 2

(bacino '(3 0 0 2 0 4))
;-> 0 3 3 1 3 0 10

(bacino '(0 1 0 2 1 0 1 3 2 1 2 1))
;-> 0 0 1 0 1 2 1 0 0 1 0 0 6

(bacino '(1 1 1 1 1 1 1 1 1 1 1 1)) ; bacino piatto
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0

Vediamo un altro esempio:

lista: (2 3 5 3 4 3 4 3 3 7 9 3 8))

         2353434337938
     9             |
     8             | |
     7            || |
     6            || |
     5     |      || |
     4     | | |  || |
     3    ||||||||||||
     2   |||||||||||||
     1   |||||||||||||
        ---------------
         0123456789012

Soluzione:
acqua: 15

         2353434337938
     9             |
     8             |x|
     7            ||x|
     6            ||x|
     5     |xxxxxx||x|
     4     |x|x|xx||x|
     3    ||||||||||||
     2   |||||||||||||
     1   |||||||||||||
        ---------------
         0123456789012

Totale x = 15

(bacino '(2 3 5 3 4 3 4 3 3 7 9 3 8))
;-> 0 0 0 2 1 2 1 2 2 0 0 5 0 15

Un ultimo esempio:

lista: (2 0 3 0 5 0 3 0 4 0 3 0 4 0 3 0 3 0 7 0 9 0 3 0 8)

         2030503040304030307090308

     9                       |
     8                       |   |
     7                     | |   |
     6                     | |   |
     5       |             | |   |
     4       |   |   |     | |   |
     3     | | | | | | | | | | | |
     2   | | | | | | | | | | | | |
     1   | | | | | | | | | | | | |
        ---------------------------
         0123456789012345678901234

Soluzione:
acqua: 78

         2030503040304030307090308

     9                       |
     8                       |xxx|
     7                     |x|xxx|
     6                     |x|xxx|
     5       |xxxxxxxxxxxxx|x|xxx|
     4       |xxx|xxx|xxxxx|x|xxx|
     3     |x|x|x|x|x|x|x|x|x|x|x|
     2   |x|x|x|x|x|x|x|x|x|x|x|x|
     1   |x|x|x|x|x|x|x|x|x|x|x|x|
        ---------------------------
         0123456789012345678901234

Totale x = 78

(bacino '(2 0 3 0 5 0 3 0 4 0 3 0 4 0 3 0 3 0 7 0 9 0 3 0 8))
;-> 0 2 0 3 0 5 2 5 1 5 2 5 1 5 2 5 2 5 0 7 0 8 5 8 0 78


--------------------------
Sposta gli zeri (LeetCode)
--------------------------

Data una lista di numeri, scrivere una funzione per spostare tutti gli 0 alla fine della lista mantenendo l'ordine relativo degli elementi diversi da zero.
Ad esempio, data la lista (0 1 0 3 12), dopo aver chiamato la funzione, la lista dovrebbe essere (1 3 12 0 0).

Risolviamo questo problema in due modi: il primo con le funzioni predefinite di newLISP e il secondo considerando la lista come un vettore ed utilizzando gli indici

Nel primo caso notiamo che:

con find-all possiamo creare la lista degli zeri:
(setq zeri (find-all 0 '(0 1 0 3 12)))
;-> (0 0)

con filter possiamo creare la lista di tuti inumeri diversi da zero:
(define (pos? x) (> x 0))
(setq numeri (filter pos? '(0 1 0 3 12)))
;-> (1 3 12)

infine uniamo le due liste con append:
(append numeri zeri)
;-> (1 3 12 0 0)

Quindi la funzione è la seguente:

(define (sol lst)
  (define (pos? x) (> x 0))
  (append (filter pos? lst) (find-all 0 lst))
)

(sol '(0 1 0 3 12))
;-> (1 3 12 0 0)
(sol '(1 0 1 0 3 0 4 0 0))
;-> (1 1 3 4 0 0 0 0 0)

Nel secondo caso utilizziamo due cicli con due indici "i" e "j". Il primo ciclo salta gli zeri e sposta in numeri nella lista, mentre il secondo ciclo scrive gli zeri alla fine della lista. L'indice "i" tiene conto della posizione dove vanno spostati i numeri (e implicitamente conta anche il numero di zeri), mentre l'indice "j" scansiona la lista.

(define (sol lst)
  (local (lun i j)
    (setq i 0 j 0)
    (setq lun (length lst))
    ; ciclo che salta gli zeri e sposta i numeri
    (while (< j lun)
      (if (!= 0 (lst j))
        (begin (setq (lst i) (lst j)) (++ i))
      )
      (++ j)
    )
    ; ciclo che scrive gli zeri alla fine della lista
    (while (< i lun)
      (setq (lst i) 0)
      (++ i)
    )
    lst
  )
)

(sol '(0 1 0 3 12))
;-> (1 3 12 0 0)
(sol '(1 0 1 0 3 0 4 0 0))
;-> (1 1 3 4 0 0 0 0 0)


---------------------------------------
Intersezione di segmenti (byte-by-byte)
---------------------------------------

La soluzione è basata su un algoritmo del libro di Andre LeMothe "Tricks of the Windows Game Programming Gurus".
In generale, una linea ha una delle forme seguenti (interscambiabili):

Y-Intercetta:  y=m*x+b
Pendenza:      (y–y0)=m*(x–x0)
Due punti:     (y–y0)=(x–x0)*(y1–y0)/(x1–x0)
Generale:      a*x+b*y=c
Parametrica:   P=p0+V*t

Il caso generale dell'intersezione è il seguente:

     y
     |                 (x1,y1)
     |                    /
     |                   /
     |                  /
     |      (x2,y2)    / p0
     |         \      /
     |          \    /
     |        p1 \  /
     |            \/ (ix,iy)
     |            /\
     |           /  \
     |          /    \
     |       (x0,y0)  \
     |                 \
     |               (x3,y3)
    -|-------------------------------- x

Il primo segmento di linea p0 ha coordinate (x0, y0) e (x1, y1).
Il secondo segmento di linea p1 ha coordinate (x2, y2) e (x3, y3).
Comunque p0 e p1 possono avere qualsiasi orientamento.

Equazione 1 - Pendenza del punto di p0: (x - x0) = m0 * (y - y0)
Data da m0 = (y1 - y0) / (x1 - x0) e (x - x0) = m0 * (y - y0)

Equazione 2 - Pendenza del punto di p2: Equazione 2: (x - x2) = m1 * (y - y2)
data da m1 = (y3 - y2) / (x3 - x2) e (x - x2) = m1 * (y - y2)

Ora abbiamo un sistema di due equazioni in due incognite:
Equazione 1: (x - x0) = m0 * (y - y0)
Equazione 2: (x - x2) = m1 * (y - y2)

Risolvendo il sistema con le matrici o per sostituzione otteniamo la seguente soluzione:

Equazione 3:
x = (-m0 / (m1 - m0)) * x2 + m0 * (y2 - y0) + x0

Equazione 4:
y = (m0 * y0 - m1 * y2 + x2 - x0) / (m0 - m1)

Prima di vedere come trattare i casi particolari (ad esempio m0 = m1) scriviamo la funzione:

(define (intersect-line p0x p0y p1x p1y p2x p2y p3x p3y)
  (local (ix iy s1x s1y s2x s2y s t)
    (setq s1x (sub p1x p0x))
    (setq s1y (sub p1y p0y))
    (setq s2x (sub p3x p2x))
    (setq s2y (sub p3y p2y))
    (println "numer = " (add (mul (sub 0 s1y) (sub p0x p2x)) (mul s1x (sub p0y p2y))))
    (println "denom = " (add (mul (sub 0 s2x) s1y) (mul s1x s2y)))
    (setq s (div (add (mul (sub 0 s1y) (sub p0x p2x)) (mul s1x (sub p0y p2y)))
                (add (mul (sub 0 s2x) s1y) (mul s1x s2y))))
    (setq t (div (sub (mul s2x (sub p0y p2y)) (mul s2y (sub p0x p2x)))
                (add (mul (sub 0 s2x) s1y) (mul s1x s2y))))
    (println "s = " s)
    (println "t = " t)
    (cond ((and (>= s 0) (<= s 1) (>= t 0) (<= t 1)) ;intersezione
           (setq ix (add p0x (mul t s1x)))
           (setq iy (add p0y (mul t s1y)))
          )
          (true (setq ix nil) (setq iy nil))
    )
    (list ix iy)
  )
)

Vediamo come si comporta la funzione nei casi normali e nei casi particolari:

; intersezione
(intersect-line 0 0 2 2 0 1 1 0)
;-> numer = -2
;-> denom = -4
;-> s = 0.5
;-> t = 0.25
;-> (0.5 0.5)

; no intersezione
(intersect-line 1 1 3 3 2 3 2 5)
;-> numer = -2
;-> denom = 4
;-> s = -0.5
;-> t = 0.5
;-> (nil nil)

; no intersezione
(intersect-line 1 1 5 6 3 1 4 0)
;-> numer = 10
;-> denom = -9
;-> s = -1.111111111111111
;-> t = 0.2222222222222222
;-> (nil nil)

; paralleli
(intersect-line 1 1 3 1 1 3 3 3)
;-> numer = -4
;-> denom = 0
;-> s = -1.#INF
;-> t = -1.#INF
;-> (nil nil)

; collineari (senza sovrapposizione)
(intersect-line 1 2 3 2 5 2 7 2)
;-> numer = 0
;-> denom = 0
;-> s = -1.#IND
;-> t = -1.#IND
;-> (nil nil)

; collineari (con sovrapposizione)
(intersect-line 1 2 3 2 4 2 6 2)
;-> numer = 0
;-> denom = 0
;-> s = -1.#IND
;-> t = -1.#IND
;-> (nil nil)

; collineari uniti (senza sovrapposizione)
(intersect-line 1 1 2 2 2 2 3 3)
;-> numer = 0
;-> denom = 0
;-> s = -1.#IND
;-> t = -1.#IND
;-> (nil nil)

; uniti (punto-punto)
(intersect-line 1 2 3 2 3 2 5 4)
;-> numer = 0
;-> denom = 4
;-> s = 0
;-> t = 1
;-> (3 2)

; uniti (segmento-punto)
(intersect-line 1 1 3 3 2 2 5 1)
;-> numer = 0
;-> denom = -8
;-> s = -0
;-> t = 0.5
;-> (2 2)

Se vogliamo trattare i casi particolari in modo diverso da (nil nil) possiamo utilizzare i seguenti predicati:

; indeterminato (0/0)
(NaN? (div 0 0))
;-> true

; infinito (inf)
(NaN? (div 5 0))
;-> nil

; infinito (inf)
(inf? (div 5 0))
;-> true

; indeterminato (inf/inf)
(NaN? (div (div 5 0) (div 5 0)))
;-> true


--------------------------------------
Trovare l'elemento mancante (LeetCode)
--------------------------------------

Abbiamo due liste con gli stessi elementi, ma una lista ha un elemento in meno. Trovare l'elemento mancante della lista più corta.
Esempio:
lista 1: (1 3 4 6 8)
lista 2: (3 1 6 8)
Elemento mancante: 4

Invece di usare due cicli for annidati per trovare l'elemento, possiamo notare che sottraendo la somma degli elementi della lista più corta alla somma degli elementi di quella più lunga otteniamo il valore dell'elemento mancante.

(define (sol lst1 lst2)
  (abs (sub (apply + lst1) (apply + lst2)))
)

(sol '(1 3 4 6 8) '(3 1 6 8))
;-> 4

Possiamo usare anche la funzione difference:

(difference '(1 3 4 6 8) '(3 1 6 8))
;-> (4)

Nota: Dati due valori di una lista con tre scelte (1 2 3), individuare il terzo valore.

(define (altro x y)
    (- 6 (+ x y))
)

(altro 1 2)
;-> 3


--------------------------------
Verifica lista/sottolista (Visa)
--------------------------------

Date due liste A e B composte da n e m interi, verificare se la lista B è una sottolista della lista A.
Esempi:

Lista A (2 3 0 5 1 1 2)
Lista B (3 0 5 1)
B sottolista di A? si

Lista A (1 2 3 4 5)
Lista B (2 5 6)
B sottolista di A? no

Utilizziamo due indici "i" e "j" per attraversare contemporaneamentele le liste A e B.
Se gli elementi delle due liste sono uguali, allora incrementiamo entrambi gli indici (e controllo anche che la lista B non sia terminata);
altrimenti incrementiamo l'indice "i" della lista A e resettiamo a zero l'indice "j" della lista B.
Ecco la funzione:

(define (sol lstA lstB)
  (local (i j lunA lunB out)
    (setq i 0 j 0)
    (setq lunA (length lstA))
    (setq lunB (length lstB))
    (while (and (< i lunA) (< j lunB))
      (cond ((= (lstA i) (lstB j))
             (++ i)
             (++ j)
             (if (= j lunB) (setq out true))
            )
            (true (setq j 0) (++ i))
      )
    )
    out
  )
)

(sol '(2 3 0 5 1 1 2) '(3 0 5 1))
;-> true

(sol '(1 2 3 4 5) '(2 5 6))
;-> nil

(time (sol '(2 3 0 5 1 1 2) '(3 0 5 1)) 100000)
;-> 203

Oppure:

(define (sol A B)
  (if (or (= B (intersect A B)) (= B '())) ;() è sempre una sottolista
    true nil))

(sol '(2 3 0 5 1 1 2) '(3 0 5 1))
;-> true

(sol '(1 2 3 4 5) '(2 5 6))
;-> nil

(time (sol '(2 3 0 5 1 1 2) '(3 0 5 1)) 100000)
;-> 140


----------------------------------
Controllo ordinamento lista (Visa)
----------------------------------

Scrivere una funzione per controllare se una lista è ordinata o meno. La funzione deve avere un parametro che permette di specificare il tipo di ordinamento (crescente o decrescente).

Usiamo la tecnica della ricorsione per risolvere il problema: applico l'operatore di confronto tra il primo e il secondo elemento e poi richiamo la stessa funzione con il resto della lista.
L'operatore di confronto può avere i seguenti valori:
1) >= (lista crescente)
2) >  (lista strettamente crescente)
3) <= (lista decrescente)
4) <  (lista strettamente decrescente)
5) =  (lista con elementi identici)

(define (ordinata? lst operatore)
      (cond ((null? lst) true)
            ((= (length lst) 1) true)
            ; se l'attuale coppia di elementi rispetta l'operatore...
            ((operatore (first (rest lst)) (first lst))
              ; allora controlla la prossima coppia
              (ordinata? (rest lst) operatore))
              ; altrimenti restituisce nil
            (true nil))
)

; lista crescente ?
(ordinata? '(1 1 2 3) >=)
;-> true

; lista strettamente crescente ?
(ordinata? '(1 1 2 3) >)
;-> nil

; lista decrescente ?
(ordinata? '(3 2 1 1) <=)
;-> true

; lista strettamente decrescente ?
(ordinata? '(3 2 1 1) <)
;-> nil

; lista con elementi identici ?
(ordinata? '(1 1 1 1) =)
;-> true

; lista con elementi identici ?
(ordinata? '(3 2 1 1) =)
;-> nil

Per verificare se una lista ha tutti gli elementi identici possiamo usare la seguente funzione:

(define (lista-identica? lst)
  (apply = lst))

; lista con elementi identici ?
(lista-identica? '(2 2 2 2))
;-> true

; lista con elementi identici ?
(lista-identica? '(3 2 1 1))
;-> nil

Possiamo scrivere una funzione più generale che non necessita del parametro relativo all'operatore di confronto e restituisce il tipo di ordinamento della lista.
Usiamo la funzione apply per applicare tutti gli operatori di confronto alla lista:

(apply > '(8 5 3 2))
;-> true

(define (order? lst)
  (cond ((apply =  lst) '= ) ;lista con elementi uguali
        ((apply >  lst) '> ) ;lista decrescente
        ((apply <  lst) '< ) ;lista decrescente
        ((apply >= lst) '>=) ;lista strettamente decrescente
        ((apply <= lst) '<=) ;lista strettamente crescente
        (true nil)           ;lista non ordinata
  )
)

(order? '(-1 -1 -1 -1))
;-> =
(order? '(1 2 3 4))
;-> <
(order? '(4 3 2 1))
;-> >
(order? '(4 3 2 1 1))
;-> >=
(order? '(-1 -1 3 4))
;-> <=


----------------
Caramelle (Visa)
----------------

Ci sono N bambini in fila. Ad ogni bambino viene assegnato un punteggio.
Devi distribuire caramelle questi bambini in base ai seguenti vincoli:
1. Ogni bambino deve avere almeno una caramella.
2. I bambini con punteggio maggiore ottengono più caramelle rispetto a quelli con punteggio minore (almeno una caramella in più).
3. I bambini che hanno punteggi uguali ottengono lo stesso numero di caramelle
Qual'è il numero minimo di caramelle da distribuire?

Una soluzione semplice è quella di ordinare i punteggi in ordine crescente e poi assegnare le caramelle dando una caramella al punteggio più basso, due caramelle al successivo , tre a quello successivo e così via fino all'ultimo bambino.

(define (caramelle lst)
  (local (somma num doppio)
    (sort lst <)
    (println lst)
    (setq somma 1)
    (setq doppio nil)
    (setq num 1)
    (for (i 1 (sub (length lst) 1))
      (cond ((= (lst i) (lst (sub i 1)))
             (setq doppio true)
             (setq somma (add somma num))
            )
            (true
             (setq doppio nil)
             (++ num) ;aumento le caramelle da distribuire per questo bambino
             (setq somma (add somma num))
            )
      );cond
      ;(println i { } num { } somma)
    );for
    somma
  );local
)

(caramelle '(1 3 3 4))
;-> 8

(caramelle '(0 1 1 1))
;-> 7

(caramelle '(10 2 1 1 1 3 5 4))


-----------------------------------
Unire due liste ordinate (Facebook)
-----------------------------------

L'ordinamento delle liste può essere sia crescente che decrescente. Useremo un parametro "op" con il seguente significato:
- se "op" vale ">" le liste sono ordinate in modo crescente
- se "op" vale "<" le liste sono ordinate in modo decrescente

(define (unisce lst1 lst2 op)
  (local (i j k m n out)
    (if (< (length lst1) (length lst2)) (swap lst1 lst2)) ;la prima lista deve essere più lunga
    (setq m (length lst1))
    (setq n (length lst2))
    (setq i (sub m 1))
    (setq j (sub n 1))
    (setq k (add m n -1))
    (setq out (array (add m n))) ; vettore risultato
    (while (>= k 0)
      (if (or (< j 0) (and (>= i 0) (op (lst1 i) (lst2 j))))
          (begin (setf (out k) (lst1 i))
                 (-- k)
                 (-- i))
          (begin (setf (out k) (lst2 j))
                 (-- k)
                 (-- j))
      )
    )
    (array-list out) ;converte il vettore risultato in lista
  ); local
)

(unisce '(1 2 3 4 5) '(4 5) >)
;-> (1 2 3 4 4 5 5)

(unisce '(4 5) '(1 2 3 4 5) >)
;-> (1 2 3 4 4 5 5)

(unisce '(7 5 4 1) '(6 5 3) <)
;-> (7 6 5 5 4 3 1)


------------------------
Salire le scale (Amazon)
------------------------

Esiste una scala con N scalini e puoi salire di 1 o 2 passi alla volta. Dato N, scrivi una funzione che restituisce il numero di modi unici in cui puoi salire la scala. L'ordine dei passaggi è importante.

Ad esempio, se N è 4, esistono 5 modi unici: (1, 1, 1, 1) (2, 1, 1) (1, 2, 1) (1, 1, 2) (2, 2).

Cosa succede se, invece di essere in grado di salire di 1 o 2 passi alla volta, è possibile salire qualsiasi numero da un insime di interi positivi X? Ad esempio, se X = {1, 3, 5}, potresti salire 1, 3 o 5 passi alla volta.

QUesto è un classico problema ricorsivo. Iniziamo con casi semplici e cercando di trovare una regola di calcolo (relazione).

N = 1: [1]
N = 2: [1, 1], [2]
N = 3: [1, 2], [1, 1, 1], [2, 1]
N = 4: [1, 1, 2], [2, 2], [1, 2, 1], [1, 1, 1, 1], [2, 1, 1]

Qual è la relazione?

Gli unici modi per arrivare a N = 3, è di arrivare prima a N = 1, e poi salire di 2 passi, oppure di arrivare a N = 2 e salire di 1 passo. Quindi f(3) = f(2) + f(1).

Questo vale per N = 4? Sì. Dal momento che possiamo arrivare al 4° scalino solo partendo dal 3° scalino e salendo di uno oppure partendo dal 2° scalino e salendo di due. Quindi f(4) = f(3) + f(2).

Generalizziamo, f (n) = f (n - 1) + f (n - 2). Questa è la nota sequenza di Fibonacci.

Versione ricorsiva:

(define (fibo n)
  (if (< n 2) 1
    (+ (fibo (- n 1)) (fibo (- n 2)))))


(fibo 35)
;-> 14930352

(time (fibo 35))
;-> 4456.463

Questa è molto lenta perchè stiamo facendo molti calcoli ripetuti: O(2^N).

Vediamo di velocizzare il calcolo scrivendo una versione ricorsiva memoized e una versione iterativa.

Versione ricorsiva memoized:

(define-macro (memoize mem-func func)
  (set (sym mem-func mem-func)
    (letex (f func c mem-func)
      (lambda ()
        (or (context c (string (args)))
        (context c (string (args)) (apply f (args))))))))

(memoize fibo-m
  (lambda (n)
    (if (< n 2) 1
      (+ (fibo-m (- n 1)) (fibo-m (- n 2))))))

(fibo-m 35)
;-> 14930352

(time (fibo-m 35))
;-> 0

Versione iterativa (che funziona anche per i big integer):

(define (fibo-i n)
  (local (a b c)
    (setq a 0L b 1L c 0L)
    (for (i 0 n)
      (setq c (+ a b))
      (setq a b)
      (setq b c)
    )
    a
  )
)

(fibo-i 35)
;-> 14930352L

(time (fibo-i 35))
;-> 0

Proviamo a generalizzare questo metodo in modo che funzioni usando un numero di passi dall'insieme X.
Un ragionamento simile ci dice che se X = {1, 3, 5}, allora il nostro algoritmo dovrebbe essere f(n) = f(n - 1) + f(n - 3) + f(n - 5).
Se n < 0, allora dobbiamo restituire 0 poiché non possiamo iniziare da un numero negativo di passi.
Se n = 0, allora dobbiamo restituire 1.
Altrimenti dobbiamo restituire ricorsivamente la somma di tutti i risultati delle chiamate alla funzione.

scala(n, X):
    if n < 0:      return 0
    elseif n == 0: return 1
    else: return sum(staircase(n - x, X) for x in X)

Tradotto in newLISP:

(define (scala n lst)
    (if (< n 0)
        0
         (if (= n 0)
            1
            (apply + (map (lambda (x) (scala (sub n x) lst)) lst))
         )
    )
)

(scala 4 '(1 2))
;-> 5

(scala 8 '(4))
;-> 1

(scala 10 '(1 2 3))
;-> 274

(scala 25 '(1 2 3))
;-> 2555757

(time (scala 25 '(1 2 3)))
;-> 2508.452

Anche questo funzione è lenta O(|X|^N), poichè ripetiamo molti calcoli.

Velocizziamo i calcoli scrivendo una versione ricorsiva memoized e una versione iterativa.

Versione ricorsiva memoized:

(define-macro (memoize mem-func func)
  (set (sym mem-func mem-func)
    (letex (f func c mem-func)
      (lambda ()
        (or (context c (string (args)))
        (context c (string (args)) (apply f (args))))))))

(memoize scala-m
  (lambda (n lst)
     (if (< n 0)
        0
         (if (= n 0)
            1
            (apply + (map (lambda (x) (scala-m (sub n x) lst)) lst))
         )
    )
  )
)

(scala-m 4 '(1 2))
;-> 5

(scala-m 8 '(4))
;-> 1

(scala-m 10 '(1 2 3))
;-> 274

(scala-m 25 '(1 2 3))
;-> 2555757

(time (scala-m 25 '(1 2 3)))
;-> 0

Varsione iterativa (programmazione dinamica):

Ogni i-esimo elemento della lista cache conterrà il numero di modi in cui possiamo arrivare al punto i con l'insieme X. Quindi costruiremo la lista da zero utilizzando i valori precedentemente calcolati per trovare quelli successivi:

(define (scala-i num lst)
  (local (ca)
    (setq ca (dup 0 (add num 1)))
    (setf (ca 0) 1)
    (for (i 1 num)
      (dolist (x lst)
        (if (>= (sub i x) 0)
          ;(begin (println "i= " i { } "x= " x)
            (setf (ca i) (add (ca i) (ca (sub i x))))
          ;)
        )
      )
    )
    (ca num)
  );local
)

(scala-i 4 '(1 2))
;-> 5

(scala-i 8 '(4))
;-> 1

(scala-i 10 '(1 2 3))
;-> 274

(scala-i 25 '(1 2 3))
;-> 2555757

(time (scala-i 25 '(1 2 3)))
;-> 0


-----------------------------------------
Numeri interi con segni opposti (MacAfee)
-----------------------------------------

Determinare se due numeri interi hanno segni opposti (true).

Applicando l'operatore bitwise XOR "^" ai quattro casi possibili si ottiene:

(^ -2 3)
;-> -3
(^ -2 -3)
;-> 3
(^ 2 3)
;-> 1
(^ 2 -3)
;-> -1

Vediamo la tavola della verità:

   a   |   b  | XOR | segno
   -----------|-----|-------
  -2   |   3  | -3  | diverso
  -2   |  -3  |  3  | uguale
   2   |   3  |  1  | uguale
   2   |  -3  | -1  | diverso

Possiamo notare che:
- se il risultato dello XOR tra i numeri a e b è negativo, allora i numeri hanno segno diverso.
- se il risultato dello XOR tra i numeri a e b è positivo, allora i numeri hanno segno uguale.

Possiamo scrivere la funzione:

(define (opposti a b)
  (if (> (^ a b) 0) nil true))

(opposti -2 3)
;-> true

(opposti -2 -3)
;-> nil

(opposti 2 3)
;-> nil

(opposti 2 -3)
;-> true


----------------------------
Parità di un numero (McAfee)
----------------------------

Parità: la parità di un numero si riferisce al numero di bit che valgono 1.
Il numero ha "parità dispari", se contiene un numero dispari di 1 bit ed è "parità pari" se contiene un numero pari di 1 bit.

Se n non vale zero, allora creiamo un ciclo che, affinchè n non diventa 0, disattiva a destra uno dei bit impostati a 1 e inverte la parità.
L'algoritmo è il seguente:

A. Inizialmente parità = 0
B. Ciclo while n! = 0
       1. Invertire la parità
          parità = not parità
       2. Annullare il bit 1 più a destra del numero con l'operatore bitwise AND "&"
          n = n & (n-1)
C. Restituire parità (pari o dispari)

Scriviamo la funzione:

(define (parita n)
  (local (out)
    (setq out nil)
    (while (!= n 0)
      (setq out (not out))
      ; annulla il bit più a destra del numero
      (setq n (& n (- n 1))) ; "&" = operatore bitwise AND
      (println n)
    )
    (if (= out true) 'dispari 'pari)
  )
)

Vediamo come funziona (con l'epressione print attivata):

(parita 22) ; 22 -> 10110
;-> 20      ; 20 -> 10100
;-> 16      ; 16 -> 10000
;-> 0       ;  0 -> 0

Per controllare la correttezza utilizziamo le funzioni di conversione tra numero decimale e binario.

(define (bin2dec n)
  (if (zero? n) n
      (+ (% n 10) (* 2 (bin2dec (/ n 10))))))

(define (dec2bin n)
   (if (zero? n) n
       (+ (% n 2) (* 10 (dec2bin(/ n 2))))
   )
)

(dec2bin 1133)
;-> 10001101101

(parita 1133)
;-> pari

(dec2bin 1113)
;-> 10001011001

(parita 1113)
;-> dispari


---------------------------------------
Minimo e massimo di due numeri (McAfee)
---------------------------------------

Scrivere due funzioni per calcolare il minimo e il massimo tra due numeri utilizzando gli operatori bitwise.

Le formule per trovare il minimo e il massimo tra due numeri sono le seguenti:

minimo  = y + ((x - y) & ((x - y) >> (sizeof(int) * CHAR_BIT - 1)))

Questo metodo shifta la sottrazione di x e y di 31 (se la dimensione dell'intero è 32). Se (x-y) è minore di 0, allora ((x-y) >> 31) sarà 1. Se (x-y) è maggiore o uguale a 0, allora ((x - y) >> 31) sarà 0. Quindi se (x >= y), otteniamo il minimo come (y + ((x-y) & 0)) che è y.
Se x < y, otteniamo il minimo come (y + ((x-y) & 1)) che è x.

Allo stesso modo, per trovare il massimo utilizzare la formula:

massimo = x - ((x - y) & ((x - y) >> (sizeof(int) * CHAR_BIT - 1)))

Per interi a 64 bit:

(define (minimo x y)  (+ y (& (- x y) (>> (- x y) 63))))

(define (massimo x y) (- x (& (- x y) (>> (- x y) 63))))

(minimo 10 30)
;-> 10
(minimo 100 30)
;-> 30

Nota: queste funzioni producono un risultato errato per valori maggiori di (2^62 - 1) = 4611686018427387903 o minori di -(2^62 - 1) = -4611686018427387903.


------------------------------
Numero potenza di due (Google)
------------------------------

Determinare se un numero intero positivo n è una potenza di due.

Primo metodo:
Il logaritmo in base 2 di un numero che è una potenza di due è un numero intero.

(define (isPower2 n)
  (if (zero? n) nil
      (= (log n 2) (int (log n 2)))
  )
)

(isPower2 1024)
;-> true

(isPower2 1000)
;-> nil

Secondo metodo:
Un numero potenza di due ha un solo 1 nella sua rappresentazione binaria.

(define (dec2bin n)
   (if (zero? n) n
       (+ (% n 2) (* 10 (dec2bin(/ n 2))))))

(dec2bin 256)
;-> 100000000

(dec2bin 2048)
;-> 100000000000

Questa funzione conta i bit del numero n che hanno valore 1:

(define (bit1 n)
  (let (conta 0)
    (while (> n 0)
       (if (= (% n 2) 1) (++ conta))
       (setq n (/ n 2))
    )
    conta
  )
)

(setq n 1024)
(& n (sub n 1))

(setq n 1000)

(define (isPower2 n)
  (if (= (bit1 n) 1) true nil)
)

(isPower2 1024)
;-> true

(isPower2 1000)
;-> nil

Terzo metodo:
Se sottraiamo il valore 1 ad un numero che è potenza di due, l'unico bit con valore 1 viene posto a 0 e i bit con valore 0 vengono posti a 1:

(dec2bin 1024)
;-> ;-> 10000000000

(dec2bin (sub 1024 1))
;-> 1111111111 ; senza lo zero in testa

Quindi applicando l'operatore bitwise AND "&" ai numeri n e (n - 1) otteniamo 0 se e solo se n è una potenza di due: (n & (n -1)) == 0 se e solo se n è una potenza di due.
Nota: L'espressione n & (n-1) non funziona quando n vale 0.

(define (isPower2 n)
  (if (zero? n) nil
      (if (zero? (& n (sub n 1)) true nil))
  )
)

(isPower2 1024)
;-> true

(isPower2 1000)
;-> nil


----------------------------
Stanze e riunioni (Snapchat)
----------------------------

Data una serie di intervalli di tempo (inizio, fine) per delle riunioni (con tempi che si possono sovrapporre), trovare il numero minimo di stanze richieste.
Ad esempio, la lista ((30 75) (0 50) (60 150)) dovrebbe restituire 2.

Creiamo e ordiniamo due liste "inizio" e "fine", poi le visitiamo in ordine crescente di tempo.
Se troviamo un inizio aumentiamo il numero di stanze, se invece troviamo una fine, allora diminuiamo il numero di stanze.
Inoltre dobbiamo tenere conto del numero massimo di stanze raggiunto.

 | inizio | fine |  tipo  | stanze |
-------------------------------------
 |    0   |      | inizio |    1   |
 |   30   |      | inizio |    2   |
 |        |  50  |  fine  |    1   |
 |   60   |      | inizio |    2   |
 |        |  75  |  fine  |    1   |
 |        | 150  |  fine  |    0   |

(define (min-stanze lst)
  (local (inizio fine stanze_richieste massimo_stanze i j n)
    (setq inizio '())
    (setq fine '())
    (dolist (el lst)
      (push (first el) inizio -1)
      (push (last el) fine -1)
    )
    (sort inizio)
    (sort fine)
    (setq stanze_richieste 0)
    (setq massimo_stanze 0)
    i = j = 0
    (setq i 0 j 0)
    (setq n (length lst))
    (while (and (< i n) (< j n))
      (if (< (inizio i) (fine j))
        (begin
          (++ stanze_richieste)
          (setq massimo_stanze (max stanze_richieste massimo_stanze))
          (++ i))
        (begin
          (-- stanze_richieste)
          (++ j))
      )
    )
    massimo_stanze
  );local
)

(min-stanze '((20 30) (0 20) (30 40)))
;-> 1

(min-stanze '((30 75) (0 50) (60 150)))
;-> 2

(min-stanze '((90 91) (94 120) (95 112) (110 113) (150 190) (180 200)))
;-> 3

Questo metodo risponde anche ad un'altra domanda:
Data una serie di intervalli di tempo, una persona può assistere a tutte le riunioni?
Se il numero minimo di stanze è pari a uno, allora la risposta è affermativa, altrimenti ci sono due o più riunioni che si sovrappongono.
Possiamo risolvere questo problema in modo più semplice.
Se una persona può partecipare a tutte le riunioni, non deve esserci alcuna sovrapposizione tra una riunione e l'altra.
Dopo aver ordinato gli intervalli, possiamo confrontare la "fine" attuale con il prossimo "inizio".

public boolean canAttendMeetings(Interval[] intervals) {
    Arrays.sort(intervals, new Comparator<Interval>(){
        public int compare(Interval a, Interval b){
            return a.start-b.start;
        }
    });

    for(int i=0; i<intervals.length-1; i++){
        if(intervals[i].end>intervals[i+1].start){
            return false;
        }
    }

    return true;
}


----------------------------------
Bilanciamento parentesi (Facebook)
----------------------------------

Data una stringa contenente parentesi tonde, quadre e graffe (aperte e chiuse), restituire
se le parentesi sono bilanciate (ben formate) e rispettano l'ordine ("{}" > "[]" > "()").
Ad esempio, data la stringa "[()] [] {()}", si dovrebbe restituire true.
Data la stringa "([]) [] ({})", si dovrebbe restituire false (le graffe non ossono stare dentro le tonde).
Data la stringa "([)]" o "((()", si dovrebbe restituire false.

Usiamo un contatore per ogni tipo di parentesi e verifichiamo la logica corretta durante la scansione della stringa.

La seguente funzione controlla la correttezza delle parentesi:

(define (par s op)
  (local (out p1o p2o p3o ch)
    (setq out true)
    (dostring (c s (= out nil))
      (setq ch (char c))
      (cond ((= ch "(")
              (++ p1o)
            )
            ((= ch "[")
              ; esiste una par "(" non chiusa
              (if (> p1o 0)
                  (setq out nil)
                  (++ p2o)
              )
            )
            ((= ch "{")
              ; esiste una par "(" o "[" non chiusa
              (if (or (> p1o 0) (> p2o 0))
                  (setq out nil)
                  (++ p3o)
              )
            )
            ((= ch ")")
              ; nessuna par "(" da chiudere
              (if (= p1o 0)
                  (setq out nil)
                  (-- p1o)
              )
            )
            ((= ch "]")
              ; esiste una par ")" da chiudere OR
              ; nessuna par "[" da chiudere
              (if (or (> p1o 0) (= p2o 0))
                  (setq out nil)
                  (-- p2o)
              )
            )
            ((= ch "}")
              ; esiste una par ")" da chiudere OR
              ; esiste una par "]" da chiudere OR
              ; nessuna par "{" da chiudere
              (if (or (> p1o 0) (> p2o 0) (= p3o 0))
                  (setq out nil)
                  (-- p3o)
              )
            )
      );cond
    );dostring
    ; controllo accoppiamento parentesi ed errore
    (if (and (zero? p1o) (zero? p2o) (zero? p3o) (= out true))
      true
      nil
    )
  );local
)

(par "{ { ( [ [ ( ) ] ] ) } }")
;-> nil
(par "{ { ( [ [ ( ( ) ] ] ) } }")
;-> nil
(par "{ { [ [ [ ( ) ] ] ] } }")
;-> true
(par "{ { [ [ } } [ ( ) ] ] ]")
;-> nil
(par "{ { [ [ [ ( ) ] ] ] } { [ ( ) ] } }")
;-> true
(par "{ { [ [ [ ( [ ] ) ] ] ] } { [ ( ) ] } }")
;-> nil


------------------------------------------------
K punti più vicini (K Nearest points) (LinkedIn)
------------------------------------------------

Data una lista di N punti (xi, yi) sul piano cartesiano 2D, trova i K punti più vicini ad un punto centrale C (xc, yc). La distanza tra due punti su un piano è la distanza euclidea.
È possibile restituire la risposta in qualsiasi ordine.
Esempi
Input:  punti = ((0,0), (5,4), (3,1)), P=(1,2), K = 2
Output: ((0,0), (3,1))

   5 |
     |
   4 |              X
     |
   3 |  X
     |
   2 |  C
     |
   1 |
     |
   0 X---------------------------
     0  1  2  3  4  5  6  7  8  9

Input:  punti = ((3,3), (5,-1), (-2,4)), P=(0,0), K = 2
Output: ((3,3), (-2,4))

Soluzione A: Ordinamento semplice
Creare una lista con tutte le distanze di ogni punto dal punto centrale. Ordinare la lista delle distanze. Selezionare i primi k punti dalla lista ordinata.

Nota: meglio non usare la funzione sqrt (radice quadrata) nel calcolo della distanza. Le operazioni saranno molto più veloci, soprattutto se i punti hanno coordinate intere.

Lista di punti: ((x0 y0) (x1 y1)...(xn yn))
Punto centrale: P = (xp yp)
Elementi da selezionare: k

;calcola il quadrato della distanza tra due punti
(define (qdist P0 P1)
  (local (x0 y0 x1 y1)
    (setq x0 (first P0))
    (setq y0 (last P0))
    (setq x1 (first P1))
    (setq y1 (last P1))
    ; no radice quadrata (l'ordine dei punti rimane invariato)
    (+ (* (sub x1 x0) (sub x1 x0)) (* (sub y1 y0) (sub y1 y0)))
  )
)

(qdist '(0 0) '(1 1))
;-> 2

(qdist '(1 1) '(1 3))
;-> 4

(define (kClosest punti C k)
  (local (distlst n out)
    (setq out '())
    (setq distlst '())
    (setq n (length punti))
    ; creo la lista delle distanze
    (for (i 0 (- n 1))
      (push (list (qdist (punti i) C) (punti i)) distlst -1)
    )
    (sort distlst) ; sort usa il primo elemento di ogni sottolista
    ;k deve essere minore o uguale a n
    (if (> k n) (setq k n))
    ;trova i k punti con distanza minore dal punto centrale
    (for (i 0 (- k 1))
      (push (distlst i) out -1)
    )
    out
  )
)

(kClosest '((1 1) (8 9) (4 5) (32 12)) '(0 0) 2)
;-> ((2 (1 1)) (41 (4 5)))

Complessità temporale: O(NlogN), dove N è il numero di punti.
Complessità spaziale: O(N).

Soluzione B: Algoritmo Quickselect
Memorizzare tutte le distanze in un array. Trovare l'indice che fornisce l'elemento Kth più piccolo usando un metodo simile al quicksort. Quindi l'elemento dall'indice 0 a (K-1) darà tutti i K punti cercati. Vediamo come funziona questo algoritmo.

Cerchiamo un algoritmo più veloce di NlogN. Chiaramente, l'unico modo per farlo è usare il fatto che i K elementi possono essere in qualsiasi ordine, altrimenti dovremmo fare l'ordinamento che è almeno NlogN.

Supponiamo di scegliere un elemento casuale x = A [i] e di dividere l'array in due parti: una parte con tutti gli elementi minori di x e una parte con tutti gli elementi maggiori o uguali a x. Questo metodo è noto come "quickselect con il pivot x".

L'idea è che selezionando alcuni pivot, ridurremo il problema a metà della dimensione originale in tempo lineare (in media).

La funzione work(i, j, K) ordina parzialmente la sottolista (punti [i], punti [i + 1], ..., punti [j]) in modo che i K elementi più piccoli di questa sottolista si trovino nelle prime posizioni K (i, i + 1, ..., i + K-1).

Innanzitutto, selezioniamo dalla sottolista un elemento casuale da usare come pivot. Per farlo, utilizziamo due puntatori i e j, per spostarsi sugli elementi che si trovano nella parte sbagliata e poi scambiamo questi elementi.

Dopo, abbiamo due parti [oi, i] e [i + 1, oj], dove (oi, oj) sono i valori originali (i, j) quando si chiama work(i, j, K). Supponiamo che la prima parte abbia 10 articoli e che la seconda contenga 15 elementi. Se stessimo cercando di ordinare parzialmente, ad esempio K = 5 elementi, allora abbiamo bisogno di ordinare parzialmente soltanto la prima parte: work(oi, i, 5). Altrimenti, se provassimo a ordinare in parte, K = 17 elementi, allora i primi 10 elementi sono già parzialmente ordinati e abbiamo solo bisogno di ordinare parzialmente i successivi 7 elementi: work(i + 1, oj, 7).

(setq pun '((1 2)(2 2)(4 5)))

(define (kClosest punti C k)
  (local (out)
    ;
    ; Funzione che scambia i valori di due punti
    (define (scambia i j)
      (swap (punti i) (punti j))
    )
    ;
    ; Funzione che calcola il quadrato della distanza
    ; tra il punto C e il punto p(i)
    (define (qdist i)
      (+ (* (sub (first (punti i)) (first C)) (sub (first (punti i)) (first C)))
         (* (sub (last (punti i)) (last C)) (sub (last (punti i)) (last C))))
    )
    ;
    ; Funzione che ordina parzialmente A[i:j+1]
    ; in modo che i primi K elementi siano i più piccoli
    (define (ordina i j k)
      (local (r mid leftH)
        (if (< i j)
            (begin
              ; calcola il pivot
              (setq r (add (rand (+ i 1 (- j))) j))
              (scambia i r)
              (setq mid (partition i j))
              (setq leftH (+ mid 1 (- i)))
              (if (< k leftH)
                  (sort i (- mid 1) k)
              ;else
                  (if (> k leftH)
                    (sort (+ mid 1) j (- k leftH))
                  )
              )
            )
        )
      ); local
    ); ordina
    ;
    ; Partizionamento con il pivot A[i]
    ; Restituisce un indice "mid" tale che:
    ; A[i] <= A[mid] <= A[j] per i < mid < j.
    (define (partition i j)
      (local (oi pivot continua)
        (setq oi i)
        (setq pivot (qdist i))
        (++ i)
        (setq continua true)
        (while continua
          (while (and (< i j) (< (qdist i) pivot))
            (++ i))
          (while (and (<= i j) (> (qdist j) pivot))
            (-- j))
          (if (>= i j)
              (setq continua nil)
              ;(scambia (punti i) (punti j))
              (scambia i j)
          )
        )
        ;(scambia (punti oi) (punti j))
        (scambia oi j)
        j
      )
    );partition
    (ordina 0 (- (length punti) 1) k)
    (slice punti 0 k)
  )
)

(kClosest '((0 0)  (5 4)  (3 1))  '(1 2) 2)
;-> ((0,0), (3,1))

(kClosest '((3 3)  (5 -1) (-2 4)) '(0 0)  2)
;-> ((3 3 ) (-2 4)

(kClosest '((1 1) (8 9) (4 5) (32 12)) '(0 0) 2)
;-> ((1 1) (4 5))

Complessità temporale: in media O(N), dove N è il numero di punti.
Complessità spaziale: O(N)


-----------------------------
Ordinamento colori (LeetCode)
-----------------------------

Data una lista con n elementi che hanno uno dei seguenti valori: "verde", "bianco", "rosso" o "blu". Restituire un'altra lista in modo che gli stessi colori siano adiacenti e l'ordine dei colori sia "verde", "bianco", "rosso" e "blu".
Un colore può non comparire nella lista (es. lista = ("rosso" "verde" "verde" "blu")
Esempio:
Input:  lista = ("rosso" "verde" "bianco" "bianco" "verde" "rosso" "rosso")
Output: lista = ("verde" "verde" "bianco" "bianco" "rosso" "rosso" "rosso")

Per semplificare i calcoli usiamo i numeri 0, 1, 2 e 3 per rappresentare rispettivamente i colori "verde", "bianco",  "rosso" e "blu".

(define (ordinaColori lst)
  (local (val numcolors vec out )
    (setq numcolors (length (unique lst)))
    (setq vec (array numcolors '(0)))
    (setq out '())
    ; riempio il vettore con le frequenze dei numeri (colori)
    (dolist (el lst)
      ; aumentiamo di uno il valore del vettore che si trova all'indice "el"
      (++ (vec el))
    )
    ; per ogni valore del vettore "vec" (vec[i])
    ; inseriamo nella lista l'elemento "i" per vec[i] volte.
    (for (i 0 (- numcolors 1))
      (setq val (vec i))
      (for (j 1 val)
        (push i out -1)
      )
    )
    out
  );local
)

(ordinaColori '(1 2 2 1 1 2 0 0 0 2 2 1))
;-> (0 0 0 1 1 1 1 2 2 2 2 2)

(ordinaColori '(0 1 2 3 0 1 2 3 0 1 2 3))
;-> (0 0 0 1 1 1 2 2 2 3 3 3)


-----------------------------
Unione di intervalli (Google)
-----------------------------

Dato un insieme di intervalli (inizio fine), unire tutti gli intervalli sovrapposti.
Per esempio,

intervalli di ingresso: (8 10) (2 6) (1 3) (15 18)

intervalli di uscita: (1 6) (8 10) (15 18)

     -------
        -------------
                          --------             -----------
  0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18
     ----------------     --------             -----------

(define (unisci-intervalli lst)
  (local (t out)
    (sort lst)
    (setq out '())
    (setq t (first lst))
    (dolist (el lst)
      (if (> $idx 0) ; il primo elemento non ha confronti precedenti
        (begin
          ; confronto tra l'inizio dell'intervallo corrente
          ; e la fine di quello precedente
          (if (<= (first el) (last t))
              (setf (last t) (max (last t) (last el)))
              (begin (push t out -1) (setq t el))
          )
        )
      )
    )
    ; aggiunge l'ultimo invervallo calcolato
    (push t out -1)
    out
  );local
)

(setq lst '((8 10) (2 6) (1 3) (15 18)))

(unisci-intervalli lst)
;-> ((1 6) (8 10) (15 18))

Esempio:

     -------
        -------------
                          --------             -----------
           -------------------
  0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18
     -----------------------------             -----------

(setq lst '((8 10) (1 3) (2 6) (3 9) (15 18)))

(unisci-intervalli lst)
;-> ((1 10) (15 18))


-------------------------------
Somma dei numeri unici (Google)
-------------------------------

In una lista di numeri interi, trovare la somma dei numeri che compaiono una sola volta. Ad esempio, nella lista (4 2 3 1 7 4 2 7 1 7 5), i numeri 1, 2, 4 e 7 appaiono più di una volta, quindi sono esclusi dalla somma e la risposta corretta è 3 + 5 = 8.

Soluzione 1 (ordinamento)

(define (somma-unici lst)
  (local (base conta out)
    (setq out '())
    (sort lst)
    (setq base (first lst))
    (setq conta 1)
    (for (i 1 (- (length lst) 1))
      (if (!= (lst i) base)
        (begin
          (if (= conta 1) (push base out -1))
          (setq base (lst i))
          (setq conta 1)
        )
        (++ conta)
      )
    )
    (apply + out)
  )
)

(somma-unici '(1 2 2 3 4 4 5 5 6 6 6))
;-> 4
(somma-unici '(4 2 3 1 7 4 2 7 1 7 5))
;-> 8
(somma-unici '(1 1 1 2 3 6 6 7 8 8 8))
;-> 12

(time (somma-unici '(4 2 3 1 7 4 2 7 1 7 5)) 10000)
;-> 47.005

Soluzione 2 (hashmap)

(define (somma-unici-2 lst)
  (local (out somma)
    (setq out '())
    (setq somma 0)
    ;crea hashmap
    (new Tree 'myhash)
    ;aggiorna hashmap con i valori della lista (valore contatore)
    (dolist (el lst)
      (if (myhash el)
        ;se esiste il valore aumenta di uno il suo contatore
        (myhash el (+ (int $it) 1))
        ;altrimenti poni il suo contatore uguale a 1
        (myhash el 1)
      )
    )
    ;copia la hashmap su una lista associativa
    (setq out (myhash))
    ;azzera la hashmap
    ;(dolist (el (myhash)) (println el))
    ;(delete 'myhash) ;method 1
    (dolist (el lst) (myhash el nil)) ;method 2
    ;somma i valori unici della lista associativa
    (dolist (el out)
      ;(println (lookup (first el) out))
      (if (= (lookup (first el) out) 1)
        (setq somma (+ somma (int (first el))))
      )
    )
    somma
  )
)

(myhash)
(somma-unici-2 '(1 2 2 3 4 4 5 5 6 6 6))
;-> 4
(somma-unici-2 '(4 2 3 1 7 4 2 7 1 7 5))
;-> 8
(somma-unici-2 '(1 1 1 2 3 6 6 7 8 8 8))
;-> 12

(time (somma-unici-2 '(4 2 3 1 7 4 2 7 1 7 5)) 10000)
;-> 140.011

(time (somma-unici (sequence 1 10000)))
;-> 187.505

(time (somma-unici-2 (sequence 1 10000)))
;-> 406.431

La versione 2 (hashmap) è più lenta della versione 1, ma dovrebbe essere il contrario.
Probabilmente occorre ottimizzare l'uso delle hashmap.


-------------------------------------
Unione di due liste ordinate (Google)
-------------------------------------

Unire due liste ordinate in una terza lista ordinata.

Versione ricorsiva:

(define (merge lstA lstB)
  (define (loop result lstA lstB)
    (cond ((null? lstA) (append (reverse result) lstB))
          ((null? lstB) (append (reverse result) lstA))
          ((< (first lstB) (first lstA))
            (loop (cons (first lstB) result) lstA (rest lstB)))
          (true
            (loop (cons (first lstA) result) (rest lstA) lstB))))
  (loop '() lstA lstB)
)

(setq A '(1 2 3 4 5 6 7 8))
(setq B '(2 3 4 5 11 12 13))

(merge A B)
;-> (1 2 2 3 3 4 4 5 5 6 7 8 11 12 13)
(merge B A)
;-> (1 2 2 3 3 4 4 5 5 6 7 8 11 12 13)

(setq A '(4 5 6 7 8 18 19))
(setq B '(1 2 3 4 5 11 12 13))

(merge A B)
;-> (1 2 3 4 4 5 5 6 7 8 11 12 13 18 19)
(merge B A)
;-> (1 2 3 4 4 5 5 6 7 8 11 12 13 18 19)

Ma la funzione produce un risultato errato se le liste sono ordinate in modo decrescente:

(setq C '(4 3 2))
(setq D '(8 5 3 1))

(merge C D)
;-> (4 3 2 8 5 3 1) ; errore

Per ottenere il risultato corretto è sufficiente modificare l'operatore "<" nella riga:

((< (first lstB) (first lstA))

con l'operatore ">":

((> (first lstB) (first lstA))

Definiamo una funzione in cui l'operatore è un parametro della funzione:

(define (merge lstA lstB op)
  (define (ciclo out lstA lstB)
    (cond ((null? lstA) (extend (reverse out) lstB))
          ((null? lstB) (extend (reverse out) lstA))
          ((op (first lstB) (first lstA))
            (ciclo (cons (first lstB) out) lstA (rest lstB)))
          (true
            (ciclo (cons (first lstA) out) (rest lstA) lstB))))
  (ciclo '() lstA lstB)
)

Per liste ordinate crescenti:

(merge A B <)
;-> (1 2 3 4 4 5 5 6 7 8 11 12 13 18 19)
(merge B A <)
;-> (1 2 3 4 4 5 5 6 7 8 11 12 13 18 19)

Per liste ordinate decrescenti:

(merge C D >)
;-> (8 5 4 3 3 2 1)
(merge D C >)
;-> (8 5 4 3 3 2 1)

Da notare che questa versione ricorsiva produce un errore di stack overflow anche con valori non molto grandi (> 1000):

(merge (sequence 1 1000) (sequence 1 1000) <)
;-> ERR: call or result stack overflow in function < : first
;-> called from user function (loop (cons (first lstB) result) lstA (rest lstB))

Versione iterativa:

(define (merge-i lstA lstB op)
  (local (i j out)
    (setq i 0 j 0 out '())
    ; attraversiamo entrambe le liste
    (while (and (< i (length lstA)) (< j (length lstB)))
      ; troviamo l'elemento minore/maggiore
      ; tra gli elementi correnti delle due liste.
      ; Aggiungiamo l'elemento alla lista out
      ; e incrementiamo l'indice della lista corrispondente
      (if (op (lstA i) (lstB j))
        (begin (push (lstA i) out -1) (++ i))
        (begin (push (lstB j) out -1) (++ j))
      )
    )
    ; Aggiungiamo gli elementi rimanenti della lista lstA (veloce)
    (if (< i (length lstA))
      (extend out (slice lstA i))
    )
    ; Aggiungiamo gli elementi rimanenti della lista lstA (lenta)
    ;(while (< i (length lstA))
    ;  (push (lstA i) out -1)
    ;  (++ i)
    ;)
    ; Aggiungiamo gli elementi rimanenti della lista lstB (veloce)
    (if (< j (length lstB))
      (extend out (slice lstB j))
    )
    ; Aggiungiamo gli elementi rimanenti della lista lstB (lenta)
    ;(while (< j (length lstB))
    ;  (push (lstB j) out -1)
    ;  (++ j)
    ;)
    out
  )
)

(setq A '(1 2 3 4 5 6 7 8))
(setq B '(2 3 4 5 11 12 13))

(merge-i A B <)
;-> (1 2 2 3 3 4 4 5 5 6 7 8 11 12 13)
(merge-i B A <)
;-> (1 2 2 3 3 4 4 5 5 6 7 8 11 12 13)

(setq C '(4 3 2))
(setq D '(8 5 3 1))

(merge-i C D >)
;-> (8 5 4 3 3 2 1)
(merge-i D C >)
;-> (8 5 4 3 3 2 1)

Vediamo la differenza di velocità tra le due funzioni:

(time (merge (sequence 1 500) (sequence 1 200) <) 500)
;-> 1751.43

(time (merge-i (sequence 1 500) (sequence 1 200) <) 500)
;-> 474.117

La versione iterativa è circa 3.5 volte più veloce.

Da notare che la funzione ricorsiva genera un problema con la funzione "time". Infatti ripetendo l'operazione di timing, il tempo di esecuzione aumenta (dovrebbe rimanere costante).

(time (merge (sequence 1 500) (sequence 1 200) <) 500)
;-> 1766.856
(time (merge (sequence 1 500) (sequence 1 200) <) 500)
;-> 2224.526
(time (merge (sequence 1 500) (sequence 1 200) <) 500)
;-> 2720.155
(time (merge (sequence 1 500) (sequence 1 200) <) 500)
;-> 3047.918

Sul forum di newLISP ralph.ronnquist ha proposto la seguente spiegazione:

"Molto probabilmente il problema è nella definizione interna define, che probabilmente finisce per far crescere in qualche modo la tabella dei simboli per ogni nuova definizione.
Prova a risolvere il problema utilizzando la seguente funzione temporanea che viene memorizzata nello heap."

(define (mergeH lstA lstB op)
  (let ((ciclo (fn (out lstA lstB)
                 (cond ((null? lstA) (extend (reverse out) lstB))
                       ((null? lstB) (extend (reverse out) lstA))
                       ((op (first lstB) (first lstA))
                        (ciclo (cons (first lstB) out) lstA (rest lstB)))
                       (true
                        (ciclo (cons (first lstA) out) (rest lstA) lstB))))
               ))
    (ciclo '() lstA lstB)
    ))

"Ciò dovrebbe dare lo stesso risultato, tranne per il fatto che la funzione interna è semplicemente un elemento heap e non si aggiunge alla tabella dei simboli."

Proviamo:

(time (merge (sequence 1 500) (sequence 1 200) <) 500)
;-> 1842.392
(time (merge (sequence 1 500) (sequence 1 200) <) 500)
;-> 2290.107
(time (merge (sequence 1 500) (sequence 1 200) <) 500)
;-> 2831.184
(time (merge (sequence 1 500) (sequence 1 200) <) 500)
;-> 2993.474

Purtroppo anche questa soluzione non risolve il problema.

Il creatore di newLISP Lutz ha scritto:

"Come puoi verificare, stampando con (sys-info) non c'è alcun aumento nei livelli di stack o nelle celle lisp tra le chiamate della funzione "merge". Immagino che la risposta sia nello stack e nella gestione della memoria del sistema operativo."

(dotimes (i 5)
   (println (time (merge (sequence 1 500) (sequence 1 200) <) 500))
   (println (sys-info)))

;-> 1797.074
;-> (1186 576460752303423488 431 3 0 2048 0 2948 10705 1414)
;-> 2265.725
;-> (1186 576460752303423488 431 3 0 2048 0 2948 10705 1414)
;-> 2734.743
;-> (1186 576460752303423488 431 3 0 2048 0 2948 10705 1414)
;-> 3031.553
;-> (1186 576460752303423488 431 3 0 2048 0 2948 10705 1414)
;-> 3437.808
;-> (1186 576460752303423488 431 3 0 2048 0 2948 10705 1414)

Nota: Usare "sys-info" per controllare quello che accade a newLISP dopo o durante l'esecuzione del programma.

Invece rickyboy ha proposto la seguente funzione per "aggirare" il problema:

(define (merge-via-loop lstA lstB op)
  (let (out '())
    (until (or (null? lstA) (null? lstB))
      (push (if (op (first lstB) (first lstA))
                (pop lstB)
                (pop lstA))
            out -1))
    (extend out (if (null? lstA) lstB lstA))))

(merge-via-loop A B <)
;-> (1 2 2 3 3 4 4 5 5 6 7 8 11 12 13)

Vediamo la velocità di esecuzione:

(time (merge-via-loop (sequence 1 500) (sequence 1 200) <) 500)
;-> 46.965

Questa funzione è 10 volte più veloce della versione iterativa.

Infine la versione proposta da ralph.ronnquist:

(define (mergeRR lstA lstB op) (sort (append lstA lstB) op))

(mergeRR A B <)
;-> (1 2 2 3 3 4 4 5 5 6 7 8 11 12 13)

Vediamo la velocità di esecuzione:

(time (mergeRR (sequence 1 500) (sequence 1 200) <) 500)
;-> 203.121

Questa funzione è 2 volte più veloce della versione iterativa.


------------------------------------------------------
Prodotto massimo di due numeri in una lista (Facebook)
------------------------------------------------------

Una soluzione efficiente attraversa la lista una sola volta. La soluzione è quella di attraversare la lista e tenere traccia dei seguenti quattro valori:

1) Valore positivo massimo
2) Secondo valore positivo massimo
3) Valore negativo massimo, ovvero un valore negativo con valore assoluto massimo
4) Secondo valore negativo massimo.

Alla fine del ciclo, confrontare i prodotti dei primi due e degli ultimi due e stampare il massimo di due prodotti.

(setq MAXINT 9223372036854775807)
(setq MININT -9223372036854775808)

(define (pairmax lst)
  (local (a b c d)
    (setq a -9223372036854775808 b -9223372036854775808)
    (setq c -9223372036854775808 d -9223372036854775808)
    (dolist (el lst)
      ; controllo se aggiornare i due valori positivi massimi
      (if (> el a)
          (setq b a a el)
          (if (> el b) (setq b el))
      )
      ; controllo se aggiornare i due valori negativi massimi
      (if (and (< el 0) (> (abs el) (abs c)))
          (setq d c c el)
          (if (and (< el 0) (> (abs el) (abs d))) (setq d el))
      )
    )
    (if (> (* c d) (* a b))
        (list c d (* c d))
        (list a b (* a b))
    )
  )
)

(pairmax '(12 13 11 3 4 -3 -4 45 -34 -15 4))
;-> 45 13 585

(pairmax '(12 13 11 3 4 -3 -4 45 -34 -18 4))
;-> (-34 -18 612)

Complessità temporale: O(n) (lineare)


----------------------------
Invertire le vocali (Google)
----------------------------

Scrivere una funzione che data una stringa ne inverte solo le vocali.
Usiamo due puntatori che attraversono l'array nelle due direzioni.

(define (vocali str)
  (local (i j t)
    (setq i 0 j (- (length str) 1))
    ; fino a che l'indice da sinistra è minore dell'indice da destra...
    (while (< i j)
      ; avanti fino ad una vocale (o indici uguali)
      (until (or (find (str i) "aeiouAEIOU") (= i j)) (++ i))
      ; indietro fino ad una vocale (o indici uguali)
      (until (or (find (str j) "aeiouAEIOU") (= i j)) (-- j))
      ; scambiamo di posto le due vocali trovate
      (setq t (str i))
      (setf (str i) (str j))
      (setf (str j) t)
      (++ i)
      (-- j)
    )
    str
  )
)

(vocali "pippo")
;-> "poppi"

(vocali "eva")
;-> "ave"

(vocali "sfgchjkv")
;-> sfgchjkv

(vocali "stra")
;-> "stra"

(vocali "")
;-> ""


------------------------------------
Distanza di Hamming tra DNA (Google)
------------------------------------

Date due sequenze di DNA (stringhe), determinare la distanza di Hamming. In pratica, occorre calcolare il numero di caratteri diversi tra due stringhe della stessa lunghezza.

La struttura canonica del DNA ha quattro basi: Adenina (Adenine) (A), Citosina (Cytosine) (C), Guanina (Guanine) (G), e Timina (Thymine) (T).

(define (hamming-dist dna1 dna2)
  (let ((nl1 (explode dna1)) (nl2 (explode dna2)))
    (cond ((= (length nl1) (length nl2)) (length (filter not (map = nl1 nl2))))
          (true (println "Error: different length of DNA.")))))

(setq dna1 "AATCCGCTAG")
(setq dna2 "AAACCCTTAG")

(hamming-dist dna1 dna2)
;-> 3


-------------------------------
Controllo sequenza RNA (Google)
-------------------------------

Verificare se una sequenza RNA (stringa) contiene caratteri diversi da "A", "C", "G" e "U".
La funzione deve restituire la lista dei caratteri diversi (i caratteri multipli devono comparire una sola volta).

La struttura canonica del RNA ha quattro basi: Adenina (Adenine) (A), Citosina (Cytosine) (C), Guanina (Guanine) (G), e Uracile (Uracile) (U).

Il primo algoritmo che viene in mente è quello di scorrere la stringa e collezionare in una lista tutti i caratteri che sono diversi da "A", "C", "G" e "U" (al termine occorre eliminare dalla lista i caratteri multipli).

(define (check-rna rna)
  (let (out '())
    (dolist (el (explode rna))
      (cond ((or (= el "A") (= el "C") (= el "G") (= el "U")) out)
            (true (push el out -1)))) (unique out)))

(setq rna1 "AAUCCGCUAG")
(check-rna rna1)
;-> ()

(setq rna2 "AAACCCUUAG")
(check-rna rna2)
;-> ()

(setq rna3 "ACCGTB ABABAUKL")
(check-rna rna3)
;-> ("T" "B" " " "K" "L")

Utilizzando le funzioni built-in sugli insiemi possiamo scrivere la funzione in un modo diverso:

(define (checkrna dna)
  (difference (explode dna) '("A" "C" "G" "U")))

(checkrna rna1)
;-> ()
(checkrna rna2)
;-> ()
(checkrna rna3)
;-> ("T" "B" " " "K" "L")

Vediamo la differenza di velocità:

(setq rna4
 "AGCBFHTGHFGFHSGBCVGTSGAFSRFDUGDTFGRGFGDGRKIDUHFGUAACGTAGCUBFHTGHFGFHSGBCVGTSGAFSRFDGDTFGR")

(time (check-rna rna4) 25000)
;-> 1174.073

(time (checkrna rna4) 25000)
;-> 524.879

Le funzioni built-in sono sempre molto veloci.


-------------------------
Somma di due box (Amazon)
-------------------------

Un box è una lista di coppie chiave/conteggio: ad esempio, un bag contenente due dell'articolo T, tre dell'articolo K e tre dell'articolo Z può essere scritto T2K3Z3. L'unione di due box è un singolo box contenente un elenco di coppie chiave/conteggio di entrambi i box: se esistono chiavi ripetute tri i due box, allora la coppia risultante ha il suo conteggio sommato: ad esempio, l'unione dei box T2K3Z3 e B1R3K2 vale T2K5Z3B1R3. L'ordine degli articoli nei box non è significativo.

Rappresentiamo un box con una lista associativa.

(setq box1 '((T 2) (K 3) (Z 3)))
(setq box2 '((B 1) (R 3) (K 2)))

(lookup 'K box1)
;-> 3

(lookup 'B box1)
;-> nil

(define (sum-box b1 b2)
  (local (out val)
    ; aggiungiamo il primo box al risultato
    (setq out b1)
    (dolist (el b2)
          ;se la chiave dell'elemento di b2 esiste in out
      (if (lookup (first el) out)
          ; allora somma i due valori in out
          ;(setf (lookup (first el) out) (+ (lookup (first el) out) (last el)))
          ; usiamo la varibile anaforica $it di setf
          (setf (lookup (first el) out) (+ $it (last el)))
          ; altrimenti aggiungi l'elemento di b2 in out
          (push el out -1)
      )
    )
    out
  )
)

(sum-box box1 box2)
;-> ((T 2) (K 5) (Z 3) (B 1) (R 3))

(setq box1 '((T 2) (K 3) (Z 3)))
(setq box2 '((B 1) (R 3) (K 2) (K 2) (B 3)))
(sum-box box1 box2)
;-> ((T 2) (K 7) (Z 3) (B 4) (R 3))


----------------------------
Punti vicini a zero (Amazon)
----------------------------

Dato un milione di punti (x, y), scrivere una funzione per trovare i 100 punti più vicini a (0, 0).

La formula della distanza al quadrato tra due punti in cui uno vale (0 0) è la seguente:

(define (dist0 x y) (add (mul x x) (mul y y)))

La soluzione più semplice (ma non la più veloce) è quella di calcolare la distanza al quadrato per ogni punto e poi ordinare il risultato. La lsita che dovremo ordinare è composta da elementi con la seguente struttura:

(distanza coord-x coord-y)

(define (cento lst)
  (let (out '())
    (dolist (el lst)
      (push (list (dist0 (first el) (last el)) (first el) (last el)) out -1)
    )
    (slice (sort out) 0 99)
  )
)

Proviamo con una lista di 10000 punti:

(setq lst (map (fn(x) (list (+ (rand 10000) 1) (+ (rand 10000) 1))) (sequence 1 10000)))

(cento lst)
;-> ((132994 363 35) (133613 322 173) (142322 331 181)
;-> ...
;-> (12966169 3580 387) (13184525 2830 2275) (13267610 3629 313))

Proviamo con una lista di un milione di punti:

(silent (setq lst (map (fn(x) (list (+ (rand 10000) 1) (+ (rand 10000) 1))) (sequence 1 1000000))))

(time (cento lst))
;-> 1984.666

La funzione impiega quasi due secondi per risolvere il problema. Questo risultato è dovuto principalmente alla velocità della funzione built-in "sort".
Un altro metodo sarebbe quello di inserire i punti mantenendo la lista ordinata durante la costruzione (heap). In questo modo non sarebbe necessario il sort finale, ma solo l'estrazione dei primi cento elementi della lista. Poichè newLISP non ha una struttura heap, la creazione di una struttura heap con le liste sarebbe, probabilmente, più lenta dell'uso della funzione "sort".


------------------------
Trova la Funzione (Uber)
------------------------

Scrivere una funzione f in modo che f(f(n)) = -n per ogni numero intero n.

La prima soluzione che mi è venuta in mente...

(define (nega n) (if (>= n 0) (- n) n))

(nega (nega 3))
;-> -3

Ma la prova con i numeri negativi fallisce (il risultato dovrebbe essere +3):

(nega (nega -3))
;-> -3

L'intuizione è stata quella di separare il segno e la grandezza del numero dalla parità del numero.
Quindi ci sono tre regole:

1) Se il numero è pari, mantenere lo stesso segno e avvicinarsi di 1 a 0 (quindi, sottrarre 1 da un numero pari positivo e aggiungere 1 a un numero pari negativo).

2) Se il numero è dispari, cambiare il segno e spostarsi di 1 più lontano da 0 (quindi, moltiplicare per -1 e sottrarre 1 da un numero dispari positivo e moltiplicare per -1 e aggiungere 1 a un numero pari negativo).

3) Nel caso in cui n vale 0, tutto rimane invariato (lo zero non ha segno, quindi non possiamo cambiarlo)

Ecco la funzione:

(define (f n)
  (cond ((and (> n 0) (even? n)) (- n 1))
        ((and (> n 0) (odd? n))  (- (- n) 1))
        ((and (< n 0) (even? n)) (+ n 1))
        ((and (< n 0) (odd? n))  (+ (- n) 1))
        (true 0)))

(f (f 1))
;-> -1
(f (f -1))
;-> 1

(f (f 3))
;-> -3
(f (f -3))
;-> 3

(f (f 0))
;-> 0

Un altro metodo è quello di considerare il numero n come una lista:

(define (f1 n)
 (if (list? n)
     (- (first n))
     (list n)))

(f1 (f1 -1))
;-> 1
(f1 (f1 1))
;-> -1

(f1 (f1 3))
;-> -3
(f1 (f1 -3))
;-> 3

(f1 (f1 0))
;-> 0

Soluzione proposta da "fdb":

(define-macro (f n) (- (n 1)))

(f (f -1))
;-> 1
(f (f 1))
;-> -1

(f (f 3))
;-> -3
(f (f -3))
;-> 3

(f (f 0))
;-> 0



------------------------------------------
Prodotto scalare minimo e massimo (Google)
------------------------------------------

Siano date due liste L1 = (a1 a2 ... an) e L2 = (b1 b2 ... bn). Il prodotto scalare delle due liste vale:

PS = (a1*b1 + a2*b2 + ... + an*bn)

Scrivere due funzioni che, modificando la posizione degli elementi delle due liste, producano il prodotto scalare minimo e il prodotto scalare massimo.

Prima scriviamo una funzione che realizza il prodotto scalare tra due liste:

(define (scalare lst1 lst2) (apply + (map * lst1 lst2)))

(scalare '(1 2) '(3 4))
;-> 11

Il prodotto scalare minimo si ha quando una lista viene ordinata in ordine crescente e l'altra lista viene ordinata in ordine decrescente.

Quindi scriviamo la funzione che calcola il prodotto scalare minimo:

(define (ps-min lst1 lst2) (scalare (sort lst1 <) (sort lst2 >)))

(ps-min '(1 3 -5) '(-2 4 1))
;-> -25

(ps-min '(1 2 3 4 5) '(1 0 1 0 1))
;-> 6

Il prodotto scalare massimo si ha quando entrambe le liste vengono ordinate allo stesso modo (crescente o decrescente).

Quindi scriviamo la funzione che calcola il prodotto scalare massimo:

(define (ps-max lst1 lst2) (scalare (sort lst1 >) (sort lst2 >)))

(ps-max '(1 3 -5) '(-2 4 1))
;-> 23

(ps-max '(1 2 3 4 5) '(1 0 1 0 1))
;-> 12


-------------------
25 numeri (Wolfram)
-------------------

Data una lista di 25 numeri positivi diversi, sceglierne due di questi in modo tale che nessuno degli altri numeri sia uguale alla loro somma o alla loro differenza.

Invece utilizzare un metodo brute-force possiamo ordinare in modo crescente la lista in modo che risulti:
 x(1) < x(2) < ... < x(n)
Se x(n) non è disponibile per essere preso come uno dei desiderati numeri, deve risultare che per ogni numero inferiore x(i), c'è un altro x(j) tale che x(i) + x(j) = x(n). Pertanto, i primi 24 numeri sono associati in modo tale che x(i) + x(n-i-1) = x(n). Ora considera x(n-1) accoppiato ad uno qualsiasi dei numeri x(2), ... ,x(n-2): queste coppie sommano a più di x(n) = x(n-i) + x(1) e quindi anche x2, ..., x(n-2) deve essere accoppiato, questa volta risultando x(2+i) + x(n-2-i) = x(n-1).
Ma questo lascia x((n-1)/2) accoppiato con se stesso, quindi i numeri x(n-1) e x((n-1)/2) risolvono il problema.
Poichè le liste di newLISP sono zero-based (il primo elemento ha indice zero), i numeri che risolvono il problema sono x(23) e x(11).

Scriviamo le funzioni:

Genera un numero compreso tra "a" e "b":

(define (rand-range a b)
  (if (> a b) (swap a b))
  (+ a (rand (+ (- b a) 1))))

Crea una lista con tutti i valori di una hashmap:

(define (getValues hash)
  (local (out)
    (dolist (cp (hash))
      (push (cp 1) out -1)
    )
  out
  )
)

Genera una lista con ordinata in modo crescente con 25 numeri casuali diversi e compresi tra "a" e "b":

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
;-> (2 5 9 15 24 57 58 64 92 93 109 120 142 143 148 152
;->  166 167 169 175 194 206 210 226 236 267 273 276 298
;->  302 304 346 351 353 362 365 376 378 386 393 426 427
;->  446 451 458 463 469 480 485 492 505 514 518 520 532
;->  540 564 572 573 586 588 600 602 608 609 612 658 664
;->  678 692 693 700 711 727 736 744 745 747 752 780 784
;->  803 809 823 838 841 844 859 863 876 896 906 919 926
;->  950 956 989 990 997 1000)

(setq lst '(2 5 9 15 24 57 58 64 92 93 109 120 142 143 148 152
 166 167 169 175 194 206 210 226 236 267 273 276 298
 302 304 346 351 353 362 365 376 378 386 393 426 427
 446 451 458 463 469 480 485 492 505 514 518 520 532
 540 564 572 573 586 588 600 602 608 609 612 658 664
 678 692 693 700 711 727 736 744 745 747 752 780 784
 803 809 823 838 841 844 859 863 876 896 906 919 926
 950 956 989 990 997 1000))

Funzione che risolve il problema:

(define (solve lst)
  (list (lst 23) (lst 11)))

Proviamo:

(solve lst)
;-> (226 120)

Quindi la soluzione vale a = 226 e b = 120

Per verificare la soluzione generiamo una lista con tutte le somme e le differenze tra tutti i numeri della lista (Per fare questo usiamo una versione modificata della funzione che calcola il prodotto scalare tra due liste) e poi controlliamo se (a - b) o (a + b) o (b - a) si trovano o meno nella lista.

(define (make-calc lst1 lst2 func)
  (let (out '())
    (if (or (null? lst1) (null? lst2))
        nil
        (dolist (el1 lst1)
          (dolist (el2 lst2)
            (push (func el1 el2) out -1))))))

(make-calc '(1 2 3) '(1 2 3) +)
;-> (2 3 4 3 4 5 4 5 6)
(make-calc '(1 2 3) '(1 2 3) -)
;-> (0 -1 -2 1 0 -1 2 1 0)

Funzione che controlla se (a + b) o (a - b) o (b - a) sono presenti nella lista completa di tutte le somme e di tutte le differenze dei 25 numeri della lista iniziale:

(define (check-num lst a b)
  (local (calc)
    (setq calc (union (make-calc lst lst +) (make-calc lst lst -)))
    (cond ((= true (find (- a b) calc)) true)
          ((= true (find (- b a) calc)) true)
          ((= true (find (+ a b) calc)) true)
          (true nil))))

(check-num lst 226 120)
;-> nil

Proviamo il tutto con un nuovo esempio:

(setq lst (sample 50 1 100))
;-> (1 2 4 6 9 10 11 13 14 17 26 28 29 30 31 32 33 34
;->  35 41 42 43 44 46 48 52 53 54 55 57 58 62 63 64
;->  66 67 68 69 70 71 73 77 79 81 86 89 92 93 95 99)

(setq sol (solve lst))
;-> (46 28)

(setq a (first sol))
;-> 46

(setq b (last sol))
;-> 28

(check-num lst a b)
;-> nil


------------------------
Le cento porte (Wolfram)
------------------------

Date cento porte tutte chiuse, cento studenti affettuano la seguente operazione:

lo studente i-esimo cambia lo stato (apre o chiude) della porta i-esima e di tutte le porte multiple di i.

In altre parole,
lo studente 1 cambia lo stato (apre) la porta 1 e tutte le porte multiple di 1 (cioè tutte le porte)
lo studente 2 cambia lo stato (chiude) della porta 2 e di tutte le porte multiple di 2
lo studente 3 cambia lo stato (apre o chiude) della porta 3 e di tutte le porte multiple di 3
...
lo studente 100 cambia lo stato (apre o chiude) della porta 100

Quali porte rimangono aperte? Perchè?

Scriviamo prima la funzione considerando una lista di cento elementi in cui "1" rappresenta la porta chiusa e "0" rappresenta la porta aperta:

(define (porte? n stampa)
  (local (porte)
    ; partiamo con centouno porte tutte aperte
    ; cioè con valore 1
    ; (consideriamo il primo studente già passato)
    (setq porte (dup 1 (+ n 1)))
    ; tranne la porta 0 che non ci serve
    (setf (porte 0) 0)
    ; per ogni studente...
    (for (s 2 n) ; il primo studente è passato
      ; per ogni porta multipla di s...
      (for (p s n s)
        ; cambiamo lo stato della porta
        (if (= (porte p) 1)
          (setf (porte p) 0)
          (setf (porte p) 1))
      )
      ; stampa dello stato delle porte ad ogni passaggio
      (if stampa (println s { -> } porte))
    )
    porte))

Proviamo a vedere cosa accade con 10 porte:

(porte? 10 true)
;->  2 -> (0 1 0 1 0 1 0 1 0 1 0)
;->  3 -> (0 1 0 0 0 1 1 1 0 0 0)
;->  4 -> (0 1 0 0 1 1 1 1 1 0 0)
;->  5 -> (0 1 0 0 1 0 1 1 1 0 1)
;->  6 -> (0 1 0 0 1 0 0 1 1 0 1)
;->  7 -> (0 1 0 0 1 0 0 0 1 0 1)
;->  8 -> (0 1 0 0 1 0 0 0 0 0 1)
;->  9 -> (0 1 0 0 1 0 0 0 0 1 1)
;-> 10 -> (0 1 0 0 1 0 0 0 0 1 0)
;-> (0 1 0 0 1 0 0 0 0 1 0)

Quindi rimangono aperte le porte 1, 4 e 9.

Proviamo con 100 porte stampando solo gli indici degli elementi che hanno valore 1 (cioè stampiamo i numeri di tutte le porte aperte):

(dolist (el (porte? 100 nil)) (if (= el 1) (print $idx { })))
;-> 1 4 9 16 25 36 49 64 81 100 " "

Si nota che rimangono solo i numeri che sono quadrati perfetti.

Spiegazione:
Lo stato della porta n-esima cambia con lo studente k-esimo per tutti i valori in cui k è divisore di n. I divisori di un numero sono accoppiati (k e j) poichè risulta  n = k * j, cioè k = n / j e j = n / k. Quindi ogni coppia cambia due volte lo stato di una porta (una volta con lo studente k e una volta con lo studente j) lasciando lo stato finale invariato.
Osserviamo che la coppia non esiste quando abbiamo un quadrato perfetto in quanto n = k * k e non esistono studenti con lo stesso numero k. In altre parole, quando lo studente k-esimo passa sulla porta k*k non ha uno studente con il valore corrispondente (k) che cancella la sua modifica. Le porte che sono un quadrato perfetto ricevono un numero dispari di cambiamenti di stato e quindi al termine dei passaggi restano aperte.


-------------------------------------
Insiemi con la stessa somma (Wolfram)
-------------------------------------

Verificare la seguente affermazione:

" Ogni insieme di 10 numeri distinti nell'intervallo [1..100] ha due sottoinsiemi disgiunti non vuoti cha hanno la stessa somma."

Per esempio, l'insieme (1 3 7 76 34 36 4 55 71 88) ha due sottoinsiemi non vuoti (a1 a2...) e (b1 b2...) che hanno la stessa somma.

Il numero di sottoinsiemi di un insieme con n elementi vale (2^n - 1). Si tratta del numero di elementi dell'insieme delle parti (powerset) meno l'insieme vuoto.

Per generare tutti i sottoinsiemi utilizziamo la funzione "powerset-i":

(define (powerset-i lst)
  (define (loop res s)
    (if (empty? s)
      res
      (loop (append (map (lambda (i) (cons (first s) i)) res) res) (rest s))))
  (loop '(()) lst))

(powerset-i '(1 2 3))
;-> ((3 2 1) (3 2) (3 1) (3) (2 1) (2) (1) ())

(length (powerset-i '(1 3 7 76 34 36 4 55 71 88)))
;-> 1024

Adesso dobbiamo sommare tutti i numeri di ogni sottoinsieme e verificare se esiste almeno una coppia di elementi con lo stesso valore.

Mentre scrivevo la funzione che verifica se esiste una coppia di valori uguali in una lista, ho avuto l'intuizione per dimostrare matematicamente l'affermazione del problema.

Ma andiamo con ordine.

Per verificare se esistono elementi doppi in una lista possiamo utilizzare diversi metodi:

1) doppio ciclo sulla lista (il primo prende un elemento alla volta e il secondo controlla se quell'elemento si trova sulla lista)

2) ciclo unico (ogni elemento viene inserito in una hashmap se non è già presente)

3) ciclo unico con una lista di controllo che ha dimensione pari al valore del numero massimo della lista (inizializzo la lista di controllo con tutti 0, poi, per ogni elemento della lista dei numeri imposto il valore 1 all'elemento della lista di controllo che ha indice pari al numero).

Il problema di questa ultima tecnica è che per conoscere il valore massimo contenuto nella lista dei numeri occorrerebbe utilizzare un altro ciclo. Inoltre tale valore massimo potrebbe essere talmente grande da richiedere una lista di controllo enorme.
Per fortuna possiamo calcolare a priori questo valore massimo, senza effettuare alcun ciclo sulla lista. In una lista di 10 numeri in cui i numeri sono diversi e possono variare da 1 a 100, il valore massimo (somma massima) è dato dalla lista (100 99 98 87 96 95 94 93 92 91), la cui somma vale:

(+ 100 99 98 87 96 95 94 93 92 91)
;-> 945

Quindi possiamo scrivere la funzione per la ricerca degli elementi doppi utilizzando una lista di controllo con 1000 elementi.

(define (checkdouble lst)
  (local (board found out)
    (setq board (dup 0 1001))
    (setq found nil)
    (setq out '())
    (dolist (el lst found)
      (if (= (board el) 1)
        (setq found true out el)
        (setf (board el) 1)))
    out))

(checkdouble '(1 2 4 5 6 7 8 9))
;-> ()

(checkdouble '(1 2 4 5 6 1 7 8 9 2))
;-> 1

(define (checksum lst)
  (local (somme)
    ; generiamo il powerset e calcoliamo la somma di ogni sottoinsieme
    (setq somme (map (fn(x) (apply + x)) (powerset-i lst)))
    ; verifichiamo se esistono elementi doppi)
    (checkdouble somme)))

(checksum (randomize (slice (sequence 1 100) 1 10)))
;-> 50

(checksum (randomize (slice (sequence 1 100) 1 10)))
;-> 55

Adesso proviamo 10000 volte per vedere se la funzione restituisce sempre un valore (cioè, se esiste sempre almeno un elemento doppio):

(for (i 1 10000)
  (if (= (checksum (randomize (slice (sequence 1 100) 1 10))) '())
    (println "error")))
;-> nil

Sembra che l'affermazione sia vera.
Adesso dovremmo verificare che gli insiemi che hanno la stessa somma siano disgiunti (cioè non abbiamo elementi in comune). Ma non è necessario scrivere codice, perchè anche se gli insiemi avessero degli elementi in comune, possiamo sempre eliminare questi elementi da entrambi gli insiemi mantenendo uguali le somme dei numeri di entrambi gli insiemi (e rendendo in questo modo gli insiemi disgiunti).

La funzione che abbiamo scritto non prova che l'affermazione sia vera. Possiamo provarla con il seguente ragionamento:

- il numero di somme possibili vale il numero di elementi del powerset (meno l'insieme vuoto), cioè (2^10 - 1) = 1023

- il numero di somme diverse può essere al massimo 945 (che è il valore massimo di una somma)

Quindi abbiamo 1023 somme con 945 valori diversi, per il "principio dei cassetti" ci deve essere per forza almeno due somme con lo stesso valore.

Il principio dei cassetti (pigeon-hole principle), detto anche legge del buco della piccionaia, afferma che se (n + k) oggetti sono messi in n cassetti, allora almeno un cassetto deve contenere più di un oggetto. Formalmente, il principio afferma che se A e B sono due insiemi finiti e B ha cardinalità strettamente minore di A, allora non esiste alcuna funzione iniettiva da A a B.

Nel nostro caso non possiamo riempire 1023 cassetti con solo 945 somme diverse, qualche cassetto deve per forza contenere una somma uguale a quella di un altro cassetto.

Spesso il ragionamento evita di scrivere codice inutile.


------------------------------------
Tripartizione di un intero (Wolfram)
------------------------------------

Quesito A
---------
Dato un numero intero positivo n, trovare i numeri interi positivi x, y e z tale che

1) x * y * z = n

2) x + y + z sia minimo

Ad esempio, dato n = 1890, la risposta corretta è (9 14 15).

Risolviamo il problema con un metodo brute-force: due cicli per x e y che vanno da 1 a n (con alcune piccole ottimizzazioni).

(define (solve n)
  (local (minimo out)
    (setq out 0)
    (setq minimo 999999999)
    ; i arriva fino (sqrt n) + 1
    (for (i 1 (+ (int (sqrt n) 1)))
      ; j parte da i e arriva fino (sqrt n) + 1
      (for (j i (+ (int (sqrt n) 1)))
        (if (zero? (% n (* i j)))
            (if (< (+ i j (/ n (* i j))) minimo)
                (begin
                  (setq out (list i j (/ n (* i j))))
                  (setq minimo (+ i j (/ n (* i j))))))))) out))

(solve 1890)
;-> (9 14 15)

(solve 10000)
;-> (20 20 25)

(solve 1000001)
;-> (1 101 9901)

(solve 123456789)
;-> (9 3607 3803)

(time (solve 123456789))
;-> 6270.58

Nota: Il programma dovrebbe avere un controllo per verificare se n è un numero primo, nel qual caso la soluzione vale (1 1 n).

(solve 48611)
;-> (1 1 48611)

Quesito B
---------
Dato un numero intero positivo n, trovare i numeri interi positivi x, y e z tale che

1) x * y * z = n

2) x + y + z = n

Le soluzioni al sistema (intere e reali/complesse) sono le seguenti:

1) x = 0, z = -y, n = 0

2) x != 0
   y = (n Sqrt[x] - x^(3/2) - Sqrt[-4 n + n^2 x - 2 n x^2 + x^3])/(2 Sqrt[x])
   z = (n Sqrt[x] - x^(3/2) + Sqrt[-4 n + n^2 x - 2 n x^2 + x^3])/(2 Sqrt[x])

3) x != 0
   y = (n Sqrt[x] - x^(3/2) + Sqrt[-4 n + n^2 x - 2 n x^2 + x^3])/(2 Sqrt[x])
   z = (n Sqrt[x] - x^(3/2) - Sqrt[-4 n + n^2 x - 2 n x^2 + x^3])/(2 Sqrt[x])

Invece di utilizzare le soluzioni sopra, modifichiamo la funzione solve per controllare se x + y + x = n:

(define (solve2 n)
  (local (tri val)
    (setq tri '())
    (for (i 1 (+ (int (sqrt n) 1)))
      (for (j i (+ (int (sqrt n) 1)))
        (setq val (% n (* i j)))
        (if (zero? val)
          (if (= (+ i j (/ n (* i j))) n)
            (push (list i j (/ n (* i j))) tri -1)))) tri)))

(solve2 3)
;-> '()

Calcoliamo solve2 con valori da 1 a 1000 per vedere se esiste qualche soluzione:

(define (test100) (for (k 3 1000) (if (!= (solve k) '()) (println (solve k)))))

(test100)
;-> ((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1))

Intuitivamente, l'unico numero n per cui risulta (x*y*z = x+y+z = n) vale sei (6), con x = 1, y = 2 e z = 3. Per dimostrarlo supponiamo che risulti (a<=b<=c), quindi (a*b*c = a+b+c <= 3*c). Adesso abbiamo due casi:

1) c = 0, quindi a = b = c = 0

2) a*b <= 3, quindi le quattro possibilità sono (a=0), (a=1, b=1), (a=1, b=2), (a=1, b=3).

Per esclusione, l'unica soluzione vale: (a=1, b=2, c=3).


---------------------
Cifre stampate (Uber)
---------------------

Quesito 1
---------
Quante cifre occorrono per numerare N pagine (facciate) di un libro?

Esempio:
Libro di 10 pagine => 1 2 3 4 5 6 7 8 9 10 => 12345678910 ==> 11 cifre

Nota: la funzione "length" di newLISP restituisce anche la lunghezza di un numero intero.

(define (num-cifre pagine)
  (let (cifre 0)
    (for (i 1 pagine)
      (setq cifre (+ cifre (length i))))))

(num-cifre 562)
;-> 1578

Altro metodo:

(define (num-cifre pagine)
  (apply + (map length (sequence 1 pagine))))

Quesito 2
---------
Quante pagine (facciate) sono state numerate se abbiamo utilizzato D cifre?

Vediamo una soluzione con la forza bruta.

(define (num-pagine cifre)
  (let ((pagine 0) (found nil))
    (until found
      (++ pagine)
      (if (>= (num-cifre pagine) cifre) (setq found true))
    )
    (list pagine (- cifre (num-cifre pagine)))))

(num-pagine 1578)
;-> (562 0) ; 562 pagine esatte

(num-pagine 12300)
;-> (3352 -1) ; manca una cifra per numerare 3352 pagine

(num-pagine 14998)
;-> (4027 -3) ; mancano tre cifre per numerare 4027 pagine

(num-pagine 100000)
;-> (22222 -4) ; mancano 4 cifre per numerare 22222 pagine

