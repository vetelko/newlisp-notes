==========

 LIBRERIE

==========

===================================
 OPERAZIONI CON I NUMERI COMPLESSI
===================================

newLISP non fornisce alcun tipo di numeri e operazioni per gestire i calcoli con i numeri complessi.
Possiamo scrivere alcune funzioni per supportare alcuni calcoli con questi numeri.
Ogni numero complesso (a + ib), dove a = parte_reale e b = parte_immaginaria o complessa, viene rappresentato con una lista (a b).
Per esempio, il numero (2 + i3) viene rappresentata dalla lista (2 3).

Definiamo due funzioni che estraggono la parte reale e quella immaginaria di un numero complesso:

Funzione estrazione parte reale "re"
------------------------------------
(define (re num) (first num))

Funzione estrazione parte immaginaria "im"
------------------------------------------
(define (im num) (last num))

(setq n1 '(3 -12))
(setq n2 '(-2 8))

(re n1)
;-> 3

(im n2)
;-> 8

I numeri complessi possono essere rappresentati in due modi:
1) forma cartesiana (o algebrica) -->  (a + ib)
2) forma esponenziale             -->  |z|*e^it (dove z = modulo, t = angolo)

Vediamo le formule che permettono di trasformare un numero complesso tra le due forme:

Cartesiana --> Esponenziale
Dato il numero complesso z = a + ib:

|z| = sqrt(a^2 + b^2)

    +arccos(a/|z|)   se b >= 0
t =
    -arccos(a/|z|)   se b < 0

Esponenziale --> Cartesiana
Dato il numero complesso z = |z|*e^it:

a = Re(z) = |z|*cos(t)
b = Im(z) = |z|*sin(t)

Adesso dobbiamo scrivere due funzioni che convertono un numero complesso tra le forme cartesiana ed esponenziale. Anche il numero complesso in forma esponenziale può essere rappresentato da una lista con due valori:

 |z|e^it  -->  (z t)

dove z è il valore del modulo e t è il valore dell'angolo.

Anche in questo caso scriviamo due funzioni che estraggono il modulo e l'angolo da un numero complesso in forma esponenziale:

Funzione estrazione modulo "|z|"
------------------------------------
(define (z num) (first num))

Funzione estrazione angolo "t"
------------------------------------------
(define (t num) (last num))

Inoltre utilizziamo anche la costante di Eulero e la costante pi greco:

(constant '*e*  2.7182818284590451)
(constant '*pi* 3.1415926535897931)

Adesso possiamo scrivere le funzioni di conversione tra le due forme:

Conversione Cartesiana --> Esponenziale
---------------------------------------

(define (ccx2ecx num)
  (let (z (sqrt (add (mul (re num) (re num)) (mul (im num) (im num)))))
       (list z
             (if (< (im num) 0)
                 (acos(div (re num) z))
                 (sub 0 (acos(div (re num) z)))
             )
       )
  )
)

cartesiana: sqrt(3) + 1i

(setq num (list (sqrt 3) 1))
;-> (1.732050807568877 1)

(ccx2ecx num)
;-> (2 -0.5235987755982987)

esponenziale: 2*e^-0.5235987755982987i
(dove -0.5235987755982987 = *pi*/6)

(div *pi* 6)
;-> 0.5235987755982988

Conversione Esponenziale --> Cartesiana
---------------------------------------

(define (ecx2ccx num)
  (list (mul (z num) (cos (t num)))
        (mul (z num) (sin (t num))))
)

esponenziale: 2*e^-0.5235987755982987i

(setq num (list 2 -0.5235987755982987))
;-> (2 -0.5235987755982987)

(ecx2ccx num)
;-> (1.732050807568877 -0.9999999999999997)

cartesiana: 1.732050807568877 -0.9999999999999997i
(dove 1.732050807568877 = sqrt(3))

(sqrt 3)
;-> 1.732050807568877

Siamo pronti per scrivere le funzioni di base per la gestione di calcoli con i muneri complessi:
1) addizione
2) sottrazione
3) moltiplicazione
4) divisione
5) reciproco (o inverso)
6) potenza

Addizione di due numeri complessi "+cx"
---------------------------------------

(define (+cx n1 n2)
  (list (add (re n1) (re n2)) (add (im n1) (im n2)))
)

(+cx n1 n2)
;-> (1 -4)

Sottrazione di due numeri complessi "-cx"
-----------------------------------------

(define (-cx n1 n2)
  (list (sub (re n1) (re n2)) (sub (im n1) (im n2)))
)

(-cx n1 n2)
;-> (5 -20)

Moltiplicazione di due numeri complessi "*cx"
---------------------------------------------

(define (*cx n1 n2)
  (list (sub (mul (re n1) (re n2)) (mul (im n1) (im n2)))
        (add (mul (im n1) (re n2)) (mul (re n1) (im n2))))
)

(*cx n1 n2)
;-> (90 48)

(*cx n2 n1)
;-> (90 48)

Divisione di due numeri complessi "/cx"
---------------------------------------

(define (/cx n1 n2)
  (if (and (zero? (re n2)) (zero? im n2))
    (list nil nil())
    (list (div (add (mul (re n1) (re n2)) (mul (im n1) (im n2)))
               (add (mul (re n2) (re n2)) (mul (im n2) (im n2))))
          (div (sub (mul (im n1) (re n2)) (mul (re n1) (im n2)))
               (add (mul (re n2) (re n2)) (mul (im n2) (im n2)))))
  )
)

(/cx n1 n2)
;->(-1.5 0)

(/cx n2 n1)
;->

Reciproco di un numero complesso "|cx"
-------------------------------------

Il reciproco (o l'inverso) di un numero complesso z = a + i b ≠ 0 è quel numero che moltiplicato per z ha come risultato 1.

(define (|cx n)
  (if (and (= (re n) 0) (= (im n) 0))
      ; (list (nil nil)
      (list (div 1 0) (div 1 0))
      (list (div (re n) (add (mul (re n) (re n)) (mul (im n) (im n))))
            (div (sub 0 (im n)) (add (mul (re n) (re n)) (mul (im n) (im n))))))
)

(setq n '(3 4))
(add (mul (re n) (re n)) (mul (im n) (im n)))

(|cx '(3 4))
;-> (0.12 -0.16)

(*cx '(3 4) '(0.12 -0.16))
;-> (1 0)

Potenza di un numero complesso "^cx"
------------------------------------

(define (^cx n p)
  (cond ((zero? p) (if (= 0 (re n)) (list 0 0) (list 1 0))) ;potenza nulla
        ((= p 1) (list (re n) (im n))) ;potenza uguale ad 1
        ((> p 1) ;potenza positiva maggiore di 1
          (setq t n)
          (for (i 1 (sub p 1))
            (setq t (*cx (list (re t) (im t)) (list (re n) (im n))))
          )
          (list (re t) (im t))
        )
        ((< p 0) ;potenza negativa
          (setq t n)
          (setq p (abs p))
          (for (i 1 (sub p 1))
            (setq t (*cx (list (re t) (im t)) (list (re n) (im n))))
          )
          (|cx (list (re t) (im t))) ; calcolo numero inverso
        )
  )
)

(^cx '(4 2) 2)
;-> (12 16)

(^cx '(4 2) -2)
;-> (0.03 -0.04)

(^cx '(12 16) -2)
;-> (-0.0007 -0.0024)


============================
 OPERAZIONI CON LE FRAZIONI
============================

newLISP non fornisce alcun tipo di numeri e operazioni per gestire i calcoli con le frazioni.
Possiamo scrivere alcune funzioni per supportare il calcolo frazionario con numeri interi.

Ogni frazione numeratore e denominatore (N/D) viene rappresentata con una lista (N D).
Per esempio, la frazione 2/3 viene rappresentata dalla lista (2 3).
Prima di tutto scriviamo una funzione che semplifica una frazione (in altre parole, riduce una frazione ai minimi termini):

Funzione che semplifica una frazione "semplifica"
-------------------------------------------------

(define (semplifica frac)
  (local (num den n d temp, nums dens)
    (setq num (first frac))
    (setq den (last frac))
    (setq n (first frac))
    (setq d (last frac))
    ; calcola il numero massimo che divide esattamente numeratore e denominatore
    (while (!= d 0)
      (setq temp d)
      (setq d (% n temp))
      (setq n temp)
    )
    (setq nums (/ num n))
    (setq dens (/ den n))
    ; controllo del segno
    (cond ((or (and (< dens 0) (< nums 0)) (and (< dens 0) (> nums 0)))
           (setq nums (* nums -1))
           (setq dens (* dens -1))
          )
    )
    (list nums dens)
  )
)

(semplifica '(4 8))
;-> (1 2)

(semplifica '(1000 2500))
;-> (2 5)

(semplifica '(-2 -4))
;-> (1 2)

(semplifica '(-2 4))
;-> (-1 2)

Adesso possiamo scrivere le funzioni per le quattro operazioni.

Funzione che somma due frazioni "+f"
------------------------------------

(define (+f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (+ (* n1 d2) (* n2 d1)))
    (setq den (* d1 d2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

Se l'argomento "redux" vale true, allora il risultato non viene semplificato.

(+f '(3 4) '(2 3))
;-> (17 12)

(+f '(2 4) '(2 3))
;-> (7 6)

(+f '(2 4) '(2 3) true)
;-> (14 12)

(+f '(10 100) '(40 100))
;-> (1 2)

Funzione che sottrae due frazioni "-f"
--------------------------------------

(define (-f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (- (* n1 d2) (* n2 d1)))
    (setq den (* d1 d2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

(-f '(12 13) '(13 13))
;-> (-1 13)

(-f '(-12 -13) '(-13 -13))
;-> (-1 13)

(+f '(-12 -13) '(-14 -13) true)
;-> (338 169)

(+f '(-12 -13) '(-14 -13))
;-> (2 1)

Funzione che moltiplica due frazioni "*f"
-----------------------------------------

(define (*f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (* n1 n2))
    (setq den (* d1 d2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

(*f '(3 6) '(3 5))
;-> (3 10)

(*f '(-3 6) '(3 5) true)
;-> -9 30)

Funzione che divide due frazioni "/f"
-------------------------------------

(define (/f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (* n1 d2))
    (setq den (* d1 n2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

(/f '(2 4) '(1 -3))
;-> (-3 2)

(/f '(2 4) '(3 2) true)
;-> (4 12)

Funzione che calcola la potenza di una frazione "^f"
----------------------------------------------------

(define (^f frac power redux)
  (local (num den n d)
    (setq n (first frac))
    (setq d (last frac))
    (setq num (int (pow n power)))
    (setq den (int (pow d power)))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

(^f '(3 4) 4)
;-> (81 256)

(^f '(3 5) 2)
;-> (9 25)

Sul forum di newLISP, rickyboy ha fornito le seguenti funzioni equivalenti:

(define (rat n d)
  (let (g (gcd n d))
    (map (curry * 1L)
         (list (/ n g) (/ d g)))))

(define (+rat r1 r2)
  (rat (+ (* (r1 0) (r2 1))
          (* (r2 0) (r1 1)))
       (* (r1 1) (r2 1))))

(define (-rat r1 r2)
  (rat (- (* (r1 0) (r2 1))
          (* (r2 0) (r1 1)))
       (* (r1 1) (r2 1))))

(define (*rat r1 r2)
  (rat (* (r1 0) (r2 0))
       (* (r1 1) (r2 1))))

(define (/rat r1 r2)
  (rat (* (r1 0) (r2 1))
       (* (r1 1) (r2 0))))

Per generalizzare le funzioni che abbiamo scritto, dobbiamo permettere che queste siano in grado di gestire un numero variabile di argomenti (attualmente possiamo passare solo due frazioni alle nostre funzioni).
Usiamo le seguenti funzioni per estrarre il numeratore e il denominatore da una frazione (num den):

Numeratore di (num den)
-----------------------
(define (numf f) (first f))

Denominatore di (num den)
-------------------------
(define (denf f) (last f))

Poi riscriviamo la funzione che semplifica (riduce ai minimi termini) una frazione:

(define (redux f)
  (local (num den)
    (setq num (/ (numf f) (gcd (numf f) (denf f))))
    (setq den (/ (denf f)  (gcd (numf f) (denf f))))
    (cond ((or (and (< den 0) (< num 0)) (and (< den 0) (> num 0)))
            (setq num (* num -1))
            (setq den (* den -1)))
    )
    (list num den)
  )
)

Testiamo la funzione "redux":

(redux '(-30 5))
;-> (-6 1)

(redux '(-30 -5))
;-> (6 1)

(redux '(30 -5))
;-> (-6 1)

(redux '(30 5))
;-> (6 1)

Adesso riscriviamo (in modo più conciso) la funzione che somma due frazioni:

(define (+f-aux f1 f2)
  (redux (list (+ (* (numf f1) (denf f2)) (* (numf f2) (denf f1)))
               (* (denf f1) (denf f2))))
)

Si tratta di una funzione (ausiliaria) che prende come parametro due frazioni.
Adesso scriviamo una macro che permette di applicare la funzione "+f-aux" ad un numero qualunque di frazioni:

(define-macro (+f)
  ; somma tutte le frazioni passate come argomento a due a due
  (apply +f-aux (map eval (args)) 2))

Nota:
L'espressione (apply +f-aux (map eval (args)) 2) permette di chiamare la macro "+f" con gli argomenti quotati (es. (+f '(1 2) '(1 2) '(1 2))).
Se avessimo scritto (apply +f-aux (args) 2) dovremmo chiamare la macro "+f" con gli argomenti non quotati (es. (+f (1 2) (1 2) (1 2))).
Questo è dovuto al fatto che le macro non valutano gli argomenti, quindi è necessario utilizzare la funzione "eval" per valutare gli argomenti.
Vediamo un esempio:

(define-macro (a)
  (args))

(a (1 2) (1 2) (1 2))
;-> ((1 2) (1 2) (1 2))

(define-macro (a)
  (map eval (args)))

(a '(1 2) '(1 2) '(1 2))
;-> ((1 2) (1 2) (1 2))

Adesso possiamo testare la nostra nuova funzione "f+":

(+f '(1 2) '(1 3))
;-> (5 6)

(+f '(1 2) '(1 2) '(1 2))
;-> (3 2)

(+f '(20 2) '(-1 -2) '(1 2))
;-> (11 1)

Riscriviamo tutte le funzioni che operano sulle frazioni:
1) addizione
2) sottrazione
3) moltiplicazione
4) divisione
5) potenza

Funzioni varie
--------------

;numeratore di (num den)
(define (numf f) (first f))

;denominatore di (num den)
(define (denf f) (last f))

;riduzione minimi termini
(define (redux f)
  (local (num den)
    (setq num (/ (numf f) (gcd (numf f) (denf f))))
    (setq den (/ (denf f)  (gcd (numf f) (denf f))))
    (cond ((or (and (< den 0) (< num 0)) (and (< den 0) (> num 0)))
            (setq num (* num -1))
            (setq den (* den -1)))
    )
    (list num den)
  )
)

Addizione frazioni "+f"
-----------------------

;ausiliaria
(define (+f-aux f1 f2)
  (redux (list (+ (* (numf f1) (denf f2)) (* (numf f2) (denf f1)))
               (* (denf f1) (denf f2))))
)

;Addiziona tutte le frazioni passate come argomento a due a due
(define-macro (+f)
  (apply +f-aux (map eval (args)) 2))


========================
 OPERAZIONI CON I TEMPI
========================

In questo capitolo definiremo due funzioni che permettono di addizionare e sottrarre due o più tempi.
Un valore tempo viene definito in ore, minuti, secondi e lo rappresenteremo con una lista con tre valori (h m s). Ad esempio, il tempo 3 ore, 34 minuti e 20 secondi è rappresentato dalla lista (3 34 20). Cominciamo con la funzione che somma due tempi.

Addizione di due tempi "+t"
---------------------------

Definiamo alcune funzioni di estrazione delle ore, minuti e secondi da un tempo:

(define (hh t) (first t))
(define (mm t) (first (rest t)))
(define (ss t) (last t))

Definiamo una funzione che normalizza il tempo, cioè controlla e ricalcola i tempi che hanno valori di minuti e/o secondi maggiori o uguali a 60.

(define (redux-t t)
  (local (h m s)
    (setq h (hh t)) (setq m (mm t)) (setq s (ss t))
    ; normalizza secondi (il valore dei secondi deve essere minore di 60)
    (while (>= s 60) (setq s (sub s 60)) (++ m))
    ; normalizza minuti (il valore dei minuti deve essere minore di 60)
    (while (>= m 60) (setq m (sub m 60)) (++ h))
    (list h m s)
  )
)

(redux-t '(0 6000 12000))
;-> (103 20 0)

Nota: la funzione "redux-t" non riduce valori negativi

; redux-t non riduce valori negativi
(redux-t '(0 -61 0))
;-> (0 -61 0)

(define (+t t1 t2)
  (local (h m s ch)
    ; riduzione dei tempi ai minimi termini
    (setq t1 (redux-t t1))
    (setq t2 (redux-t t2))
    (setq h (add (hh t1) (hh t2)))
    (setq m (add (mm t1) (mm t2)))
    (setq s (add (ss t1) (ss t2)))
    (redux-t (list h m s))
  )
)

(+t '(10 60 60) '(10 30 30))
;-> (21 31 30)

(+t '(60 1200 1200) '(60 120 300))
;-> (142 25 0)

Adesso definiamo la funzione che sottrae due tempi (un pò più complicata).

Sottrazione di due tempi "+t"
-----------------------------

(define (-t t1 t2)
  (local (h m s h1 m1 s1 h2 m2 s2 ch)
    ; riduzione dei tempi ai minimi termini
    (setq t1 (redux-t t1))
    (setq t2 (redux-t t2))
    ; estrazione ore (h), minuti (m), secondi (s)
    (setq h1 (hh t1)) (setq m1 (mm t1)) (setq s1 (ss t1))
    (setq h2 (hh t2)) (setq m2 (mm t2)) (setq s2 (ss t2))
    ; trova il tempo maggiore
    (if (< (add s1 (mul m1 1000) (mul h1 10000))
           (add s2 (mul m2 1000) (mul h2 10000)))
        (begin (swap h1 h2) (swap m1 m2) (swap s1 s2) (setq ch true))
    )
    ; sottrazione dei tempi
    (if (<= s2 s1) (setq s (sub s1 s2))
        (begin (setq s (add 60 (sub s1 s2))) (++ m2))
    )
    (if (<= m2 m1) (setq m (sub m1 m2))
        (begin (setq m (add 60 (sub m1 m2))) (++ h2))
    )
    (setq h (sub h1 h2))
    ; se abbiamo scambiato i due tempi (perchè il primo tempo era minore)
    ; allora cambiamo il segno delle ore o dei minuti o dei secondi
    (if (= ch true)
      (begin
        (setq h (sub 0 h))
        (if (= h 0) (setq m (sub 0 m)))
        (if (and (= h 0) (= m 0) (setq s (sub 0 s))))
      )
    )
    ; risultato
    (list h m s)
  );local
)

(redux-t '(150 300 200))
;-> (155 3 20)

(redux-t '(120 130 201))
;-> (122 13 21)

(-t '(155 3 20) '(122 13 21))
;-> (32 49 59)

(-t '(150 300 200) '(120 130 201))
;-> (32 49 59)

(-t '(120 130 201) '(150 300 200))
;-> (-32 49 59)

(-t '(24 58 2) '(24 58 1))
;-> (0 0 1)

(-t '(24 58 1) '(24 58 2))
;-> (0 0 1)

(-t '(24 58 1) '(24 59 2))
;-> (0 -1 1)

(-t '(-3 0 0) '(-2 0 0))
;-> (-1 0 0)

(-t '(0 0 -1) '(0 0 -2))
;-> (0 0 1)

(+t '(0 0 -1) '(0 0 -2))
;-> (0 0 -3)

Adesso definiamo due macro che ci permettono di sommare o sottrarre un numero qualsiasi di tempi:

Addizione tempi "+tt"
---------------------

(define-macro (+tt)
  ; somma tutte i tempi passati come argomento a due a due
  (apply +t (map eval (args)) 2))

(+tt '(2 20 20) '(2 20 20) '(2 20 20))
;-> (7 1 0)

Sottrazione tempi "-tt"
-----------------------

(define-macro (-tt)
  ; sottrae tutti i tempi passati come argomento a due a due
  (apply -t (map eval (args)) 2))

(-tt '(2 20 20) '(2 20 20) '(2 20 20))
;-> (-2 20 20)

(+tt '(1 20 40) '(0 20 40) '(1 0 0))
;-> (2 41 20)

(-tt '(1 20 30) '(1 20 35) '(0 0 5))
;-> (0 0 -5)

(+tt '(0 0 -5) '(0 0 5))
;-> (0 0 0)

(-tt '(2 20 30) '(2 20 35))
;-> (0 0 -5)

(-tt '(2 20 30) '(2 20 35) '(0 0 5))
;-> (0 0 -10)


============================
 OPERAZIONI CON GLI INSIEMI
============================

newLISP fornisce alcune funzioni per operare sugli insiemi (set).
Vediamo quali sono e come implementare le funzioni che mancano (alcune di queste funzioni sono prese dal libro "A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015).

Definiamo due insiemi (liste) per i test:

 (setq A '(a b c d e))

 (setq B '(a c e f g))

;------------------------------------------------------
; intersect (built-in)
;------------------------------------------------------
sintassi 1: (intersect list-A list-B)
sintassi 2: (intersect list-A list-B bool)
output: list

Nella prima sintassi, ritorna una lista che contiene una copia di ogni elemento che si trova sia nella list-A che nella list-B.

(intersect '(3 0 1 3 2 3 4 2 1) '(1 4 2 5))
;-> (2 4 1)

Nella seconda sintassi, ritorna una lista con tutti gli elementi della list-A che si trovano anche nella list-B, senza eliminazione dei duplicati della list-A.
bool è un espressione che deve essere true o nil.
Questa funzione mantiene l'ordine degli elementi della lista originale.

(intersect '(3 0 1 3 2 3 4 2 1) '(1 4 2 5) true)
;-> (1 2 4 2 1)

(intersect '(3 0 1 3 2 3 4 2 1) '(1 4 2 5) nil)
;-> (1 2 4)

;------------------------------------------------------
; difference (built-in)
;------------------------------------------------------
sintassi 1: (difference list-A list-B)
sintassi 2: (difference list-A list-B bool)
output: list

Questa funzione mantiene l'ordine degli elementi della lista originale.

Nella prima sintassi, restituisce la differenza tra gli insieme list-A e list-B.
La lista risultante ha solo gli elementi che si trovano nella list-A, ma non nella list-B.
Tutti gli elementi della lista risultante sono unici, ma le liste possono anche essere non uniche
Gli elementi della lista possono essere qualunque espressione lisp.

(difference '(2 5 6 0 3 5 0 2) '(1 2 3 3 2 1))
;-> (5 6 0)
(difference '(1 1 2 3 4) '(2 4 6 8))
;->  (1 3)
(difference '(1 1 2 3 4) '(2 4 6 8) true)
;-> (1 1 3)

Nella seconda sintassi, la differenza funziona in modalità elenco
bool è un espressione che deve essere true o nil.
Nelle lista risultante, tutti gli elementi di list-B sono eliminati nella list-A, ma i duplicati che si trovano nella list-A vengono mantenuti.

(difference '(2 5 6 0 3 5 0 2) '(1 2 3 3 2 1) true)
;-> (5 6 0 5 0)

(difference '(2 5 6 0 3 5 0 2) '(1 2 3 3 2 1) nil)
;-> (5 6 0)

;------------------------------------------------------
; unique (built-in)
;------------------------------------------------------
sintassi: (unique list)
output: list

Restituisce una lista in cui tutti i duplicati vengono rimossi.
Questa funzione mantiene l'ordine degli elementi della lista originale.

(unique '(2 3 4 4 6 7 8 7))
;-> (2 3 4 6 7 8)

La lista può essere non ordinata, ma una lista ordinata rende il calcolo più veloce.

;------------------------------------------------------
; union (built-in)
;------------------------------------------------------
sintassi: (union list-1 list-2 [list-3 ... ])
output: list

Restituisce una lista con tutti i valori diversi trovati nelle liste passate come argomento.
Questa funzione mantiene l'ordine degli elementi della lista originale.

(union '(1 3 1 4 4 3) '(2 1 5 6 4))
;-> (1 3 4 2 5 6)

;------------------------------------------------------
; belongs?
; "A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015
;------------------------------------------------------
sintassi: (belongs? x A)
output: boolean

Restituisce true se un elemento x appartiene all'insieme A (nil altrimenti).

(define (belongs? x A)
  (if (or (intersect (list x) A) (= x '())) ;() is always a subset
    true nil))

(belongs? 'a '(a b c d e))
;-> true
(belongs? '() '(a b c d e))
;-> true

;------------------------------------------------------
; subset?
; "A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015
;------------------------------------------------------
sintassi (subset? A B)
output: boolean

Restituisce true se l'insieme A è sottoinsieme dell'insieme B (nil altrimenti).

(define (subset? A B)
  (if (or (= A (intersect A B)) (= A '())) ;() is always a subset
    true nil))

(subset? '(a b c d e) '(a c e f g))
;-> nil
(subset? '(a b c d e) '(a b c d e))
;-> true

;------------------------------------------------------
; cardinality
;"A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015
;------------------------------------------------------
sintassi: (cardinality A)
output: integer

Restituisce la cardinalità (numero degli elementi) di un insieme.

(define (cardinality S)
  (length S)
)

;------------------------------------------------------
; equivalent?
; "A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015
;------------------------------------------------------
sintassi: (equivalent? A B)
output: boolean

Restituisce true se due insiemi sono equipotenti, cioè se hanno lo stesso numero di elementi (nil altrimenti).

(define (equivalent? A B)
  (if (= (cardinality A) (cardinality B)))
)

;------------------------------------------------------
; idem?
;------------------------------------------------------
sintassi: (idem? A B)
output: boolean

Restituisce true se due insiemi hanno gli stessi elementi nello stesso ordine (nil altrimenti).

(define (idem? A B)
  (if (= A B))
)

;------------------------------------------------------
; equal?
;------------------------------------------------------
sintassi: (equal? A B)
output: boolean

Restituisce true se due insiemi hanno gli stessi elementi, anche in ordine diverso (nil altrimenti).

(define (equal? A B)
  (if (= (sort A) (sort B)))
)

(setq A '(a b c))
(setq B '(a c b))
a

(equal? '(a b c) '(b a c))
(equal? A B)
(sort B)
B

;------------------------------------------------------
; disjoint?
; "A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015
;------------------------------------------------------
sintassi: (disjoint? A B)
output: boolean

Restituisce true se due insiemi non hanno elementi in comune (nil altrimenti).

(define (disjoint? A B)
  (if (= (intersect A B) '()))
)

;------------------------------------------------------
; complement
; "A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015
;------------------------------------------------------
sintassi: (complement A U)
output: list

Restituisce il complemento di un insieme rispetto all'insieme universo U.

(define (complement A U, lU i set-out)
  (setq set-out '())
  (setq lU (cardinality U))
  (setq i 0)
  (while (< i lU)
    (if (!= (belongs? (nth i U) A) true)
      (setq set-out (cons (nth i U) set-out))
    )
    (++ i) ;this is equivalent to (setq i (+ 1 i))
  );end while
  (reverse set-out)
)

(setq U '(a b c d e f g h))
(setq A '(c d e b h g))

(complement A U)
;-> (a f)

(difference U A) it is the same
;-> (a f)

;------------------------------------------------------
; cartesian-product
;------------------------------------------------------
sintassi: (cartesian-product A B)
output: list

Restituisce il prodotto cartesiano di due insiemi.

; iterative
(define (cartesian-product A B , lA lB i j set-out)
  (setq lA (cardinality A))
  (setq lB (cardinality B))
  (setq i 0 j 0) ;initializes i and j at the same time to zero
  (setq set-out '())
  (while (< i lA)
    (while (< j lB)
    (setq set-out (cons (list (nth i A) (nth j B)) set-out))
      (++ j) ;equivalent to (setq j (+ 1 j))
    );end while j
    (++ i) ;equivalent to (setq i (+ 1 i))
    (setq j 0) ;reinitializes j
  );end while i
  (reverse set-out)
)

(cartesian-product '(a b) '(a c))
;-> ((a a) (a c) (b a) (b c))
(cartesian-product '(a b) '(a b c))
;-> ((a a) (a b) (a c) (b a) (b b) (b c))

; recursive
(define (cart-one x lst)
  (cond
   ((null? lst) '())
   (true (cons (list x (first lst))
               (cart-one x (rest lst))))))

(dist-one 'b '(x y z))
;-> ((b x) (b y) (b z))

(define (cartesian A B)
  (cond
    ((null? A) '())
    (true (append (cart-one (first A) B)
              (cartesian (rest A) B)))))

(cartesian '(a b) '(x y z))
;-> ((a x) (a y) (a z) (b x) (b y) (b z))

;------------------------------------------------------
; powerset
;------------------------------------------------------
sintassi: (powerset A)
output: list

Restituisce l'insieme potenza di un insieme.

(define (powerset lst)
  (if (empty? lst)
      (list '())
      (let ( (element (first lst))
             (p (powerset (rest lst))))
           (append (map (fn (subset) (cons element subset)) p) p) )))

(powerset '(a b c d))
;-> ((a b c) (a b) (a c) (a) (b c) (b) (c) ())


=================
 FUNZIONI WINAPI
=================

(context 'Win32API)

(import "user32.dll" "MessageBoxA")
(import "kernel32.dll" "GetShortPathNameA")
(import "kernel32.dll" "GetLongPathNameA")
(import "shell32.dll" "ShellExecuteA")

(define PATH_MAX 512)

(context MAIN)

;(define NULL 0)

(define (message-box text (title "newLISP"))
  (let ((MB_OK 0))
    (Win32API:MessageBoxA 0 text title MB_OK)))

(define (get-short-path-name pathname)
  (unless (file? pathname)
    (throw-error (list "No such file or directory" pathname)))
  (setq pathname (real-path pathname)) ; to fullpath
  (letn ((len Win32API:PATH_MAX)
         (buf (dup (char 0) (+ len 1)))
         (ret (Win32API:GetShortPathNameA pathname buf len)))
    (slice buf 0 ret)
    ;; (GetShortPathNameA pathname buf len) (get-string buf)
    ))

(define (get-longpathname pathname)
  (letn ((len Win32API:PATH_MAX)
         (buffer (dup (char 0) (+ len 1)))
         (r (Win32API:GetLongPathNameA pathname buffer len)))
    (if (= r 0) (throw-error '("GetLongPathNameA" "failure")))
    (slice buffer 0 r)))

(define (shell-execute app)
  (let ((SW_SHOWNORMAL 1) e)
    (setf e (Win32API:ShellExecuteA 0 "open" app 0 0 SW_SHOWNORMAL))
    ;(if (< e 32) )
    ))
;(shell-execute "C:\\PROGRA~1\\newLISP\\newLISP.exe")
;(shell-execute "C:/")
(shell-execute "http://www.newLISP.org/")

(context MAIN)
;;; EOF


==================================
 OPERAZIONI CON GLI ALBERI BINARI
==================================

Terminologia
------------

Un albero è un insieme finito di nodi tali che:
- esiste un nodo speciale chiamato "root" (radice)
- i nodi rimanenti sono partizionati in (n >= 0) insiemi disgiunti T(1)...T(n), dove ogni T(i) è un "sub-tree" (sotto-albero) della radice.

       radice
        /|\
       / | \
      /  |  \
     /   |   \
    /    |    \
  T(1) T(2)..T(n)

Supponiamo di avere il seguente albero:

              A                livello 1     altezza 0
             /|\
            / | \
           /  |  \
          /   |   \
         /    |    \
        B     C     D          livello 2     altezza 1
       / \    |    /|\
      /   \   |   / | \
     E     F  G  H  I  J       livello 3     altezza 2
    / \
   /   \
  K     L                      livello 4     altezza 3

Un nodo che ha sotto-alberi è il nodo "parent" (genitore) di quel sotto-albero (es. parent(B)).
Le radici di questi sotto-alberi sono i "children" (figli) di quel nodo (es. children(E, F))
I cildren dello stesso parent sono "sibling" (fratelli) (es. siblings(C, D).
La radice del nostro albero è il nodo A.
Il "grado" di un nodo è il numero di sotto-alberi di quel nodo. (es. grado(D) = 3)
La "profondità" (depth) di un nodo è la distanza dal nodo alla radice dell'albero.
Il "livello" (level) sono tutti i nodi che hanno la stessa profondità. Il livello della radice vale 1.
La "altezza" (height) la massima distanza di qualunque nodo dalla radice. Un albero con la sola radice ha altezza 0.

Rappresentazione
----------------

Un albero può essere rappresentato da una lista il cui primo elemento è la radice (root) e i rimanenti elementi sono sottoalberi.
Ad esempio, (A (B (E (K L)) F) (C (G)) (D (H (M)) I J))

Ogni nodo dell'albero può essere visto come un elemento della lista. Esistono tre tipi di nodi:

1) nodo radice (root node)
2) nodo ramo (branch node)
3) nodo foglia (leaf node)

Supponiamo di avere il seguente albero:

                             +-----> PS
                             +-----> AN
             + -----> MARCHE +-----> MC
             |               +-----> AP
             |               +-----> FM
             |
ITALIA ----> + -----> UMBRIA +-----> PG
             |               +-----> TR
             |
             |               +-----> FR
             |               +-----> LT
             + -----> LAZIO  +-----> RI
                             +-----> RM
                             +-----> VT

Un esempio di rappresentazione con una lista potrebbe essere il seguente:

(setq tree '(ITALIA
  (MARCHE (PS AN MC AP FM))
  (UMBRIA (PG TR))
  (LAZIO (FR LT RI RM VT))))
;-> (ITALIA (MARCHE (PS AN MC AP FM)) (UMBRIA (PG TR)) (LAZIO (FR LT RI RM VT)))

In questo caso abbiamo:

nodo radice: ITALIA
nodi ramo: MARCHE UMBRIA LAZIO
nodi foglia: PS AN MC AP FM PG TR FR LT RI RM VT

Possiamo creare questa lista anche in altri modi:

(setq tree (list 'ITALIA (list 'MARCHE (list 'PS 'AN 'MC 'AP 'FM))
                         (list 'UMBRIA (list 'PG 'TR))
                         (list 'LAZIO (list 'FR 'LT 'RI 'RM 'VT))))
;-> (ITALIA (MARCHE (PS AN MC AP FM)) (UMBRIA (PG TR)) (LAZIO (FR LT RI RM VT)))

(setq marche (list 'MARCHE (cons 'PS (cons 'AN (cons 'MC (cons 'AP (cons 'FM)))))))
(setq lazio  (list 'LAZIO  (cons 'FR (cons 'LT (cons 'RI (cons 'RM (cons 'VT)))))))
(setq umbria (list 'UMBRIA (cons 'PG (cons 'TR))))
(setq tree   (cons 'ITALIA (cons marche (cons umbria (cons lazio)))))
;-> (ITALIA (MARCHE (PS AN MC AP FM)) (LAZIO (FR LT RI RM VT)) (UMBRIA (PG TR)))

Altro esempio:

         A
        / \
       /   \
      B     C
     /     / \
    /     /   \
   D     E     F

Un altro tipo di rappresentazione dell'albero con una lista:

(setq lettere '(A (B (D () ())) (C (E () ()) (F () ()))))

nodo radice: A
nodi rami: B C
nodi foglie: D E F

Alberi binari
-------------

Un albero binario è vuoto o è composto da un elemento radice e due sotto-alberi, che sono essi stessi alberi binari. In Lisp rappresentiamo l'albero vuoto con il valore lista vuota '() e l'albero non vuoto dell'elenco (X L R), dove X indica il nodo radice e L e R indicano rispettivamente il sotto-albero sinistro (Left) e destro (Right).

Ad esempio il seguente albero:

           A
          / \
         /   \
        /     \
       B       C
      / \     / \
     /   \   /   \
    D     E ()    F
                 / \
                /   \
               G    ()

viene rappresentato dalla lista:

(A (B (D () ()) (E () ())) (C () (F (G () ()) ())))

Altri esempi sono un albero binario che consiste solo di un nodo radice: (A () ())

Oppure un albero binario vuoto: ()

Un albero binario di livello k è "pieno" quando ha (2^k - 1) nodi.
Un albero binario di livello k è "completo" quando tutti i nomi dei nodi corrispondono (posizionalmente) a quelli di un albero pieno di livello k.

Albero binario pieno    Albero binario completo    Albero binario inclinato

          A                       A                          A
         / \                     / \                        /
        /   \                   /   \                      B
       /     \                 /     \                    /
      B       C               B       C                  C
     / \     / \             / \                        /
    /   \   /   \           /   \                      D
   D     E F     G         D     E

Il seguente albero non è un albero binario completo (il nodo F non corrisponde a quello dell'albero pieno):

          A
         / \
        /   \
       /     \
      B       C
     / \       \
    /   \       \
   D     E       F


Il livello i-esimo di un albero binario può avere al massimo 2^(i-1) nodi.

Un albero binario con k livelli può avere al massimo Sum[1<=i<=k](2^(i-1)) = (2^k - 1) nodi.

In Lisp un albero binario viene rappresentato dalla lista: (T L R)
dove T = nome del nodo
     L = sotto-albero sinistro (Left)
     R = sotto-albero destro (Right)

Il nodo foglia viene rappresentato dalla lista: (T () ())

Esempio:
          A
         / \
        /   \
       B     C
      /     / \
     /     /   \
    D     E     F

(A (B (D nul nul) nul) (C (E nul nul) (F nul nul)))

radice: A
nodi: B C
foglie: D E F

(setq nul '())
(setq tree '(A (B (D nul nul) nul) (C (E nul nul) (F nul nul))))

Nome del nodo:
(first tree)
;-> A

sotto-albero sinistro
(first (rest tree))
;-> (B (D nul nul) nul)

sotto-albero destro
(first (rest (rest tree)))
(last (rest tree))
;-> (C (E nul nul) (F nul nul))

Le funzioni di base per gestire un albero binario sono le seguenti:

(define (empty-tree tree) --> Crea un albero vuoto
(define (empty-tree? tree) --> verifica se un albero è vuoto
(define (tree? lst) --> verifica se una lista è la rappresentazione di un albero binario
(define (make-tree data st-left st-right) --> crea un albero con radice di valore data e con i sottoalberi sinistro (st-left) e destro (st-right)
(define (name-tree tree) --> restituisce il valore/nome dell'albero
(define (left-tree tree) --> restituisce il sotto-albero sinistro dell'albero
(define (right-tree tree) --> restituisce il sotto-albero destro dell'albero

Le ultime tre funzioni potrebbero essere definite nel modo seguente:

(define (name-tree tree) (first tree))
(define (left-tree tree) (first (rest tree)))
(define (right-tree tree) (first (rest (rest tree))))

(name-tree tree)
;-> A

(left-tree tree)
;-> (B (D nul nul) nul)

(right-tree tree)
;-> (C (E nul nul) (F nul nul))

Attraversamento di alberi binari
--------------------------------

Per usare un albero binario dobbiamo essere in grado di visitare tutti i suoi nodi in un certo ordine.
Partendo dalla radice (o da un nodo) di un albero binario abbiamo tre azioni possibili:

        V
       / \
      /   \
     L     R

1) L --> muovi a sinistra (Left)
2) V --> visita il nodo (leggi il valore (Value) del nodo)
3) R --> muovi a destra (Right)

In base alla sequenza di queste azioni abbiamo i seguenti metodi principali di attraversamento:

Attraversamento "Inorder":   L-V-R

Attraversamento "Preorder":  V-L-R

Attraversamento "Postorder": L-R-V

Esempio (espressioni matematiche):

Applicando i metodi di attraversamento all'albero che rappresenta l'espressione aritmetica (A ^ B * C * D + E) otteniamo:

            +
           / \
          *   E
         / \
        *   D
       / \
      ^   C
     / \
    A   B

Inorder Traversal (infix expression) : A ^ B * C * D + E

Preorder Traversal (prefix expression) : + * * ^ A B C D E

Postorder Traversal (postfix expression) : A B ^ C * D * E +

A questo punto conosciamo le nozioni teoriche di base sugli alberi binari e possiamo scrivere alcune funzioni per gestirli:

Crea un albero binario (BST) vuoto "bst-create-empty"

(define (bst-create-empty) '())

Crea un albero binario "bst-create"

(define (bst-create value left-subtree right-subtree)
  (list value left-subtree right-subtree))

Verifica se un albero binario è vuoto "bst-isempty?"

(define (bst-isempty? BST) (null? BST))

Selezione del valore dell'albero binario "bst-value"

(define (bst-value BST) (first BST))

Selezione del sotto-albero sinistro dell'albero binario "bst-left-subtree"

(define (bst-left-subtree BST) (first (rest BST)))

Selezione del sotto-albero destro dell'albero binario "bst-right-subtree"

(define (bst-right-subtree BST) (first (rest (rest BST))))

Attraversamento Inorder "bst-traverse-inorder"

(define (bst-traverse-inorder BST)
    (cond
      ((bst-isempty? BST) '())
      (true (append
              (bst-traverse-inorder (bst-left-subtree BST))
              (list (bst-value BST))
              (bst-traverse-inorder (bst-right-subtree BST))))))

Attraversamento Preorder "bst-traverse-preorder"

(define (bst-traverse-preorder BST)
    (cond
      ((bst-isempty? BST) '())
      (true (append
              (list (bst-value BST))
              (bst-traverse-preorder (bst-left-subtree BST))
              (bst-traverse-preorder (bst-right-subtree BST))))))

Attraversamento Postorder "bst-traverse-postorder"

(define (bst-traverse-postorder BST)
    (cond
      ((bst-isempty? BST) '())
      (true (append
              (bst-traverse-postorder (bst-left-subtree BST))
              (bst-traverse-postorder (bst-right-subtree BST))
              (list (bst-value BST))))))

Vediamo un esempio:

           A
          / \
         /   \
        /     \
       B       C
      / \     / \
     /   \   /   \
    D     E ()    F
                 / \
                /   \
               G    ()

(setq tree '(A (B (D () ()) (E () ())) (C () (F (G () ()) ()))))

(bst-traverse-inorder tree)
;-> (D B E A C G F)

(bst-traverse-preorder tree)
;-> (A B D E C F G)

(bst-traverse-postorder tree)
;-> (D E B G F C A)

Vediamo l'espressione aritmetica precedente:

            +
           / \
          *   E
         / \
        *   D
       / \
      ^   C
     / \
    A   B

(setq arit '(+ (* (* (^ (A () ()) (B () ())) (C () ())) (D () ())) (E () ())))

infix
(bst-traverse-inorder arit)
;-> (A ^ B * C * D + E)

prefix
(bst-traverse-preorder arit)
;-> (+ * * ^ A B C D E) ;

postfix
(bst-traverse-postorder arit)
;-> (A B ^ C * D * E +) ;

Esistono anche altri due metodi di attraversamento degli alberi binari:

1) Breadth-First-Search (attraversamento livello per livello da sinistra a destra)

2) Depth-First-Search (attraversamento per profondità)

Scriviamo altre funzioni per la gestione degli alberi binari.

Verifica se una lista è la rappresentazione di un albero binario "bst-istree?"

(define (bst-istree? LST)
  (or (null? LST)
      (and (list? LST)
           (= (length LST) 3)
           (bst-istree? (bst-left-subtree LST))
           (bst-istree? (bst-right-subtree LST)))))

(setq tree '(A (B (D () ()) (E () ())) (C () (F (G () ()) ()))))
(bst-istree? tree)
;-> true

(setq arit '(+ (* (* (^ (A () ()) (B () ())) (C () ())) (D () ())) (E () ())))
(bst-istree? arit)
;-> true

(bst-istree? '(a (b) (c)))
;-> nil

(bst-istree? '(a b))
;-> nil

Conta il numero dei nodi di un albero binario "bst-count-nodes"

(define (bst-count-nodes BST)
  (if (bst-isempty? BST)
      0
      (+ 1 (bst-count-nodes (bst-left-subtree BST))
           (bst-count-nodes (bst-right-subtree BST)))))

(bst-count-nodes tree)
;-> 7

(bst-count-nodes arit)
;-> 9

Conta il numero di foglie di un albero binario "bst-count-leaves"

(define (bst-count-leaves BST)
  (if (bst-isempty? BST)
      0
      (if (and (bst-isempty? (bst-left-subtree BST)) (bst-isempty? (bst-right-subtree BST)))
          (+ 1 (bst-count-leaves (bst-left-subtree BST))
               (bst-count-leaves (bst-right-subtree BST)))
          (+   (bst-count-leaves (bst-left-subtree BST))
               (bst-count-leaves (bst-right-subtree BST))))))

(bst-count-leaves tree)
;-> 3

(bst-count-leaves arit)
;-> 5

Verifica se un albero binario è una foglia: "bst-isleaf?":

(define (bst-isleaf? BST)
    (and (bst-isempty? (bst-left-subtree BST))
         (bst-isempty? (bst-right-subtree BST))))

(bst-isleaf? '(a () ()))
;-> true

(bst-isleaf? '(a (b () ()) (c () ())))
;-> nil

(bst-isleaf? (bst-right-subtree '(a (b () ()) (c () ()))))
;-> true

(bst-isleaf? (bst-left-subtree '(a (b () ()) (c () ()))))
;-> true

Calcola l'altezza di un albero binario "bst-height"

(define (bst-height BST)
    (cond
      ; per convenzione l'altezza di un albero vuoto vale -1
      ((bst-isempty? BST) -1)
      (true (+ 1 (max (bst-height (bst-left-subtree BST))
                      (bst-height (bst-right-subtree BST)))))))

(bst-height tree)
;-> 3

(bst-height arit)
;-> 4

Cerca un valore in un albero binario "bst-find?"

(define (bst-find? BST value)
    (cond ((bst-isempty? BST) nil)
          ((= value (bst-value BST)) true)
          (true (or (bst-find? (bst-left-subtree BST) value)
                    (bst-find? (bst-left-subtree BST) value)))))

(bst-find? tree 'D)
;-> true

(bst-find? arit '^)
;-> true


Alberi binari di ricerca
------------------------

Un albero binario di ricerca (BST - Binary Search Tree) è un albero binario con le seguenti proprietà:

1) Il sottoalbero sinistro di un nodo x contiene soltanto i nodi con chiavi minori della chiave del nodo x
2) Il sottoalbero destro di un nodo x contiene soltanto i nodi con chiavi maggiori della chiave del nodo x
3) Il sottoalbero destro e il sottoalbero sinistro devono essere entrambi due alberi binari di ricerca.

Nota: poichè ogni nodo di un albero binario di ricerca è una "chiave" (key), non possono esistere due nodi con valori uguali.

Questa struttura permette di effettuare in maniera efficiente operazioni come: ricerca, inserimento e cancellazione di elementi.

Esempio:

           8
          / \
         /   \
        /     \
       3      10
      / \       \
     /   \       \
    1     6       14
         / \      /
        /   \    /
       4     7  13

(setq albero '(8 (3 (1 () ()) (6 (4 () ()) (7 () ()))) (10 () (14 (13 () ()) ()))))

(bst-count-nodes albero)
;-> 9

(bst-count-leaves albero)
;-> 4

Per verificare se un dato albero binario è un albero binario di ricerca (cioè soddisfa le proprietà elencate sopra), si può operare nel modo seguente:
- attraversare l'albero con il metodo "inorder"
- se la lista risultante è ordinata in modo crescente, allora è un albero binario di ricerca, altrimenti non lo è.

Nota: questo metodo è valido solo se l'albero non ha valori duplicati (ipotesi delle chiavi univoche)

Verifica se un albero binario è un albero binario di ricerca "bst-istreebst"

(define (bst-istreebst? BST)
  (apply < (bst-traverse-inorder BST)))

(setq albero '(8 (3 (1 () ()) (6 (4 () ()) (7 () ()))) (10 () (14 (13 () ()) ()))))

(bst-istreebst? albero)
;-> true

(bst-istreebst? tree)
;-> nil

(bst-istreebst? arit)
;-> nil

Esempio:

                |
          +--- 14 ---+
          |          |
    +--- 13    +--- 22 ---+
    |          |          |
    1         16    +--- 29 ---+
                    |          |
                   28         30

(setq numtree '(14 (13 (1 () ()) ()) (22 (16 () ()) (29 (28 () ()) (30 () ())))))

(bst-istreebst? numtree)
;-> true

Nota: Quando l'albero binario di ricerca ha valori duplicati possiamo mantenere le stesse funzioni utilizzando una struttura in cui un nodo può avere valori multipli.

Cerca un valore in un albero binario di ricerca "bst-member?"

(define (bst-member? BST value)
    (cond
      ((bst-isempty? BST) nil)
      ((= value (bst-value BST)) true)
      ((< value (bst-value BST)) (bst-member? (bst-left-subtree BST) value))
      (true (bst-member? (bst-right-subtree BST) value))))

Aggiunge un valore in un albero binario di ricerca "bst-add"

(define (bst-add BST value)   ; restituisce un bst con il valore aggiunto
    (cond
      ((bst-isempty? BST)           ; se vuoto, crea un nuovo nodo
       (bst-create value (bst-create-empty) (bst-create-empty)))
      ((< value (bst-value BST))    ; aggiunge il nodo al sotto-albero sinistro...
       (bst-create (bst-value BST)  ; ...aggiungendo un nuovo albero
                   (bst-add (bst-left-subtree BST) value)
                   (bst-right-subtree BST)))
      ((> value (bst-value BST))    ; aggiunge il nodo al sotto-albero destro
       (bst-create (bst-value BST)
                   (bst-left-subtree BST)
                   (bst-add (bst-right-subtree BST) value)))
      (true BST)))                  ; valore presente, non fare nulla anything

Esempio:

        5
       / \
      /   \
     4     6

(setq tri '(5 (4 () ()) (6 () ())))

(bst-add tri 2)
;-> (5 (4 (2 () ()) ()) (6 () ()))

Elimina un valore in un albero binario di ricerca "bst-delete"

(define (bst-delete BST value)   ; restituisce un bst con il valore eliminato
    (cond
      ((bst-isempty? BST) (bst-create-empty))
      ((= value (bst-value BST)) (bst-delete-root BST))
      ((< value (bst-value BST))
       (bst-create (bst-value BST)
                   (bst-delete (bst-left-subtree BST) value)
                   (bst-right-subtree BST)))
      (true ; (> value (bst-value BST))
       (bst-create (bst-value BST)
                   (bst-left-subtree BST)
                   (bst-delete (bst-right-subtree BST) value)))))

(define (bst-delete-root BST)   ; restituisce un bst con la radice eliminata
    (cond
      ; se la radice non ha figli, il risultato è un bst vuoto
      ((bst-isleaf? BST) (bst-create-empty))
      ; se la radice ha un figlio (destro o sinistro),
      ; il risultato è quel figlio (con i suoi sotto-alberi)
      ((bst-isempty? (bst-left-subtree BST)) (bst-right-subtree BST))
      ((bst-isempty? (bst-right-subtree BST)) (bst-left-subtree BST))
      ; se la radice ha due figli,
      ; sostituisci il valore con il figlio più a sinistra del sotto-albero destro
      (true (letn ((replacement-value (bst-value (bst-leftmost-child (bst-right-subtree BST))))
                   (new-right-subtree (bst-delete (bst-right-subtree BST) replacement-value)))
              (bst-create replacement-value (bst-left-subtree BST) new-right-subtree)))))

(define (bst-isleaf? BST)
    (and (bst-isempty? (bst-left-subtree BST))
         (bst-isempty? (bst-right-subtree BST))))

(define (bst-leftmost-child BST)
    (cond
      ((bst-isempty? BST) (bst-create-empty))
      ((bst-isempty? (bst-left-subtree BST)) BST)
      (true (bst-leftmost-child (bst-left-subtree BST)))))

Esempio:

           8
          / \
         /   \
        /     \
       3      10
      / \       \
     /   \       \
    1     6       14
         / \      /
        /   \    /
       4     7  13

(setq albero '(8 (3 (1 () ()) (6 (4 () ()) (7 () ()))) (10 () (14 (13 () ()) ()))))
;-> (8 (3 (1 () ()) (6 (4 () ()) (7 () ()))) (10 () (14 (13 () ()) ())))

(bst-member? albero 3)
;-> true

(setq newtree (bst-add albero 2))
;-> (8 (3 (1 () (2 () ())) (6 (4 () ()) (7 () ()))) (10 () (14 (13 () ()) ())))

                       |
              +--------8---------+
              |                  |
              |                  |
              3                  10
             / \                   \
            /   \                   \
           /     \                   \
          1       6                  14
           \     / \                 /
            \   /   \               /
             2 4     7             13


(bst-delete newtree 2)
;-> (8 (3 (1 () ()) (6 (4 () ()) (7 () ()))) (10 () (14 (13 () ()) ())))
Abbiamo ottenuto lo stesso albero di partenza.

(bst-istreebst? albero)
;-> true

(bst-istreebst? (bst-delete-root albero))
;-> true

Verifica se un albero binario è bilanciato "bst-balanced?"

(define (bst-balanced? BST)
    (cond
      ((bst-isempty? BST) true)
      (true (and (= (bst-height (bst-left-subtree BST)) (bst-height (bst-right-subtree BST)))
                 (bst-balanced? (bst-left-subtree BST))
                 (bst-balanced? (bst-right-subtree BST))))))

(setq albero '(8 (3 (1 () ()) (6 (4 () ()) (7 () ()))) (10 () (14 (13 () ()) ()))))
(bst-count-nodes albero)
;-> 9
(bst-height albero)
;-> 3
(bst-balanced? albero)
;-> nil

(setq albero2 '(8 (3 (1 () ()) (6 () ())) (10 (4 () ()) (5 () ()))))
(bst-count-nodes albero2)
;-> 7
(bst-height albero2)
;-> 2
(bst-balanced? albero2)
;-> true

Verifica se un albero binario è quasi bilanciato "bst-relatively-balanced?"

(define (bst-relatively-balanced? BST)
    (>= 1 (abs (- (bst-height BST) (bst-shortest-path-to-leaf BST)))))

Calcola il percorso minimo fino alla foglia "bst-shortest-path-to-leaf"

(define (bst-shortest-path-to-leaf BST)
    (cond
      ((bst-isempty? BST) -1)
      (true (+ 1 (min (bst-shortest-path-to-leaf (bst-left-subtree BST))
                      (bst-shortest-path-to-leaf (bst-right-subtree BST)))))))

(bst-relatively-balanced? albero)
;-> nil

(bst-relatively-balanced? albero2)
;-> true

(bst-shortest-path-to-leaf albero)
;-> 1

(bst-shortest-path-to-leaf albero2)
;-> 2

Trova il valore minimo di un albero binario di ricerca "bst-find-min"

(define (bst-find-min BST)
    (cond
      ((bst-isempty? BST) nil)
      ((bst-isempty? (bst-left-subtree BST)) (bst-value BST))
      (true (bst-find-min (bst-left-subtree BST)))))

(bst-find-min albero)
;-> 1

Trova il valore massimo di un albero binario di ricerca "bst-find-max"

(define (bst-find-max BST)
    (cond
      ((bst-isempty? BST) nil)
      ((bst-isempty? (bst-right-subtree BST)) (bst-value BST))
      (true (bst-find-max (bst-right-subtree BST)))))

(bst-find-max albero)
;-> 14

Vediamo come creare un albero binario di ricerca (BST) da una lista di numeri:

(define (bst-make lst)
  (let (BST '())
    (dolist (el lst)
      (setf BST (bst-add BST el)))))

(setq lst '(23 12 1 4 5 28 4 9 10 45 89))
(setq albero (bst-make lst))
;-> (23 (12 (1 () (4 () (5 () (9 () (10 () ()))))) ()) (28 () (45 () (89 () ()))))

(bt-istree? albero)
;-> true

(bst-istree? albero)
;-> true

TODO:
- Print ASCII tree on console
- Depth-First-Search
- Breadth-First-Search

Adesso possiamo raggruppare in una libreria tutte le funzioni che abbiamo scritto finira differenziando le funzioni in base al tipo di albero (binario oppure binario di ricerca).

;;
;; Library File: tree-library.lsp
;; Library load: (load "tree-library.lsp")
;;

;;
;;
;; Alberi Binari
;; Binary Tree (BT)
;;
;;

; (bt-create-empty)
; Crea un albero binario (BT) vuoto
; output: '() (un albero binario vuoto)
(define (bt-create-empty) '())


; (bt-create value left-subtree right-subtree)
; Crea un BT
; output: BT
(define (bt-create value left-subtree right-subtree)
  (list value left-subtree right-subtree))


; (bt-isempty? BT)
; Verifica se un BT è vuoto
; output: true o nil
(define (bt-isempty? BT) (null? BT))


; (bt-value BT)
; Selezione del valore del BT
; output: valore del BT (radice del BT)
(define (bt-value BT) (first BT))


; (bt-left-subtree BT)
; Selezione del sotto-albero sinistro del BT
; output: sotto-albero sinistro del BT
(define (bt-left-subtree BT) (first (rest BT)))


; (bt-right-subtree BT)
; Selezione del sotto-albero destro dell'albero binario
; output: sotto-albero destro del BT
(define (bt-right-subtree BT) (first (rest (rest BT))))


; (bt-istree? LST)
; Verifica se una lista è la rappresentazione di un BT
; output: true o nil
(define (bt-istree? LST)
  (or (null? LST)
      (and (list? LST)
           (= (length LST) 3)
           (bt-istree? (bt-left-subtree LST))
           (bt-istree? (bt-right-subtree LST)))))


; (bt-count-nodes BT)
; Conta il numero di nodi del BT
; output: numero di nodi del BT
(define (bt-count-nodes BT)
  (if (bt-isempty? BT)
      0
      (+ 1 (bt-count-nodes (bt-left-subtree BT))
           (bt-count-nodes (bt-right-subtree BT)))))


; (bt-count-leaves BT)
; Conta il numero di foglie del BT
; output: numero di foglie del BT
(define (bt-count-leaves BT)
  (if (bt-isempty? BT)
      0
      (if (and (bt-isempty? (bt-left-subtree BT)) (bt-isempty? (bt-right-subtree BT)))
          (+ 1 (bt-count-leaves (bt-left-subtree BT))
               (bt-count-leaves (bt-right-subtree BT)))
          (+   (bt-count-leaves (bt-left-subtree BT))
               (bt-count-leaves (bt-right-subtree BT))))))


; (bt-height BT)
; Calcola l'altezza del BT
; output: altezza del BT
(define (bt-height BT)
    (cond
      ; per convenzione l'altezza di un albero vuoto vale -1
      ((bt-isempty? BT) -1)
      (true (+ 1 (max (bt-height (bt-left-subtree BT))
                      (bt-height (bt-right-subtree BT)))))))


; (bt-member? BT value)
; Cerca un valore nel BT
; output: true o nil
(define (bt-member? BT value)
    (cond ((bt-isempty? BT) nil)
          ((= value (bt-value BT)) true)
          (true (or (bt-member? (bt-left-subtree BT) value)
                    (bt-member? (bt-left-subtree BT) value)))))


; (bt-isleaf? BT)
; Verifica se il BT è una foglia:
; output: true o nil
(define (bt-isleaf? BT)
    (and (bt-isempty? (bt-left-subtree BT))
         (bt-isempty? (bt-right-subtree BT))))


; (bt-traverse-inorder BT)
; Attraversamento Inorder
; output: lista con tutti i nodi del BT
(define (bt-traverse-inorder BT)
    (cond
      ((bt-isempty? BT) '())
      (true (append
              (bt-traverse-inorder (bt-left-subtree BT))
              (list (bt-value BT))
              (bt-traverse-inorder (bt-right-subtree BT))))))


; (bt-traverse-preorder BT)
; Attraversamento Preorder
; output: lista con tutti i nodi del BT
(define (bt-traverse-preorder BT)
    (cond
      ((bt-isempty? BT) '())
      (true (append
              (list (bt-value BT))
              (bt-traverse-preorder (bt-left-subtree BT))
              (bt-traverse-preorder (bt-right-subtree BT))))))


; (bt-traverse-postorder BT)
; Attraversamento Postorder
; output: lista con tutti i nodi del BT
(define (bt-traverse-postorder BT)
    (cond
      ((bt-isempty? BT) '())
      (true (append
              (bt-traverse-postorder (bt-left-subtree BT))
              (bt-traverse-postorder (bt-right-subtree BT))
              (list (bt-value BT))))))

;;
;;
;; Alberi Binari di Ricerca
;; Binary Search Tree (BST)
;;
;;

; (bst-create-empty)
; Crea un albero binario di ricerca (BST) vuoto
; output: '() (un albero binario di ricerca vuoto)
(define (bst-create-empty) '())


; (bst-create value left-subtree right-subtree)
; Crea un BST
; output: BST
(define (bst-create value left-subtree right-subtree)
  (list value left-subtree right-subtree))


; (bst-isempty? BST)
; Verifica se un BST è vuoto
; output: true o nil
(define (bst-isempty? BST) (null? BST))


; (bst-value BST)
; Selezione del valore del BST
; output: valore del BST (radice del BST)
(define (bst-value BST) (first BST))


; (bst-left-subtree BST)
; Selezione del sotto-albero sinistro del BST
; output: sotto-albero sinistro del BST
(define (bst-left-subtree BST) (first (rest BST)))


; (bst-right-subtree BST)
; Selezione del sotto-albero destro del BST
; output: sotto-albero destro del BST
(define (bst-right-subtree BST) (first (rest (rest BST))))


; (bst-istree? BST)
; Verifica se un albero binario è un BST
; output: true o nil
(define (bst-istree? BST)
  (apply < (bst-traverse-inorder BST)))


; (bst-count-nodes BST)
; Conta il numero di nodi del BST
; output: numero di nodi del BST
(define (bst-count-nodes BST)
  (if (bst-isempty? BST)
      0
      (+ 1 (bst-count-nodes (bst-left-subtree BST))
           (bst-count-nodes (bst-right-subtree BST)))))


; (bst-count-leaves BST)
; Conta il numero di foglie del BST
; output: numero di foglie del BST
(define (bst-count-leaves BST)
  (if (bst-isempty? BST)
      0
      (if (and (bst-isempty? (bst-left-subtree BST)) (bst-isempty? (bst-right-subtree BST)))
          (+ 1 (bst-count-leaves (bst-left-subtree BST))
               (bst-count-leaves (bst-right-subtree BST)))
          (+   (bst-count-leaves (bst-left-subtree BST))
               (bst-count-leaves (bst-right-subtree BST))))))


; (bst-height BST)
; Calcola l'altezza del BST
; output: altezza del BST
(define (bst-height BST)
    (cond
      ; per convenzione l'altezza di un albero vuoto vale -1
      ((bst-isempty? BST) -1)
      (true (+ 1 (max (bst-height (bst-left-subtree BST))
                      (bst-height (bst-right-subtree BST)))))))


;("bst-member? BST value)"
; Cerca un valore nel BST
; output: true o nil
(define (bst-member? BST value)
    (cond
      ((bst-isempty? BST) nil)
      ((= value (bst-value BST)) true)
      ((< value (bst-value BST)) (bst-member? (bst-left-subtree BST) value))
      (true (bst-member? (bst-right-subtree BST) value))))


; (bst-isleaf? BST)
; Verifica se il BST una foglia:
; output: true o nil
(define (bst-isleaf? BST)
    (and (bst-isempty? (bst-left-subtree BST))
         (bst-isempty? (bst-right-subtree BST))))


; (bst-traverse-inorder BST)
; Attraversamento Inorder
; output: lista con tutti i nodi del BST
(define (bst-traverse-inorder BST)
    (cond
      ((bst-isempty? BST) '())
      (true (append
              (bst-traverse-inorder (bst-left-subtree BST))
              (list (bst-value BST))
              (bst-traverse-inorder (bst-right-subtree BST))))))


; (bst-traverse-preorder BST)
; Attraversamento Preorder
; output: lista con tutti i nodi del BST
(define (bst-traverse-preorder BST)
    (cond
      ((bst-isempty? BST) '())
      (true (append
              (list (bst-value BST))
              (bst-traverse-preorder (bst-left-subtree BST))
              (bst-traverse-preorder (bst-right-subtree BST))))))


; (bst-traverse-postorder BST)
; Attraversamento Postorder
; output: lista con tutti i nodi del BST
(define (bst-traverse-postorder BST)
    (cond
      ((bst-isempty? BST) '())
      (true (append
              (bst-traverse-postorder (bst-left-subtree BST))
              (bst-traverse-postorder (bst-right-subtree BST))
              (list (bst-value BST))))))


; (bst-add BST value)
; Aggiunge un valore nel BST
; output: BST
(define bst-add
  (lambda (BST value)
    (cond
      ((bst-isempty? BST)           ; if empty, create a new node
       (bst-create value (bst-create-empty) (bst-create-empty)))
      ((< value (bst-value BST))    ; add node to left subtree
       (bst-create (bst-value BST)  ; (functionally, by building new tree)
                   (bst-add (bst-left-subtree BST) value)
                   (bst-right-subtree BST)))
      ((> value (bst-value BST))    ; add node to right subtree
       (bst-create (bst-value BST)
                   (bst-left-subtree BST)
                   (bst-add (bst-right-subtree BST) value)))
      (true BST))))                 ; it's already there;


; (bst-delete BST value)
; Elimina un valore nel BST
; output: BST
(define (bst-delete BST value)
    (cond
      ((bst-isempty? BST) (bst-create-empty))
      ((= value (bst-value BST)) (bst-delete-root BST))
      ((< value (bst-value BST))
       (bst-create (bst-value BST)
                   (bst-delete (bst-left-subtree BST) value)
                   (bst-right-subtree BST)))
      (true ; (> value (bst-value BST))
       (bst-create (bst-value BST)
                   (bst-left-subtree BST)
                   (bst-delete (bst-right-subtree BST) value)))))


; (bst-delete-root BST)
; Elimina la radice del BST
; output: BST
(define (bst-delete-root BST)   ; return tree with root deleted
    (cond
      ; If the root has no children, result is empty tree
      ((bst-isleaf? BST) (bst-create-empty))
      ; If the root has one child (right or left),
      ; result is that child (and descendants)
      ((bst-isempty? (bst-left-subtree BST)) (bst-right-subtree BST))
      ((bst-isempty? (bst-right-subtree BST)) (bst-left-subtree BST))
      ; If the root has two children,
      ; replace value with leftmost child of right subtree
      (true (letn ((replacement-value (bst-value (bst-leftmost-child (bst-right-subtree BST))))
                   (new-right-subtree (bst-delete (bst-right-subtree BST) replacement-value)))
              (bst-create replacement-value (bst-left-subtree BST) new-right-subtree)))))


; (bst-leftmost-child BST)
; Selezione del sotto-albero più a sinistra del BST
; output: BST
(define (bst-leftmost-child BST)
    (cond
      ((bst-isempty? BST) (bst-create-empty))
      ((bst-isempty? (bst-left-subtree BST)) BST)
      (true (bst-leftmost-child (bst-left-subtree BST)))))


; (bst-balanced? BST)"
; Verifica se un albero binario è bilanciato
; output: true o nil
(define (bst-balanced? BST)
    (cond
      ((bst-isempty? BST) true)
      (true (and (= (bst-height (bst-left-subtree BST)) (bst-height (bst-right-subtree BST)))
                 (bst-balanced? (bst-left-subtree BST))
                 (bst-balanced? (bst-right-subtree BST))))))


; (bst-relatively-balanced? BST)
; Verifica se un albero binario è quasi bilanciato
; output: true o nil
(define (bst-relatively-balanced? BST)
    (>= 1 (abs (- (bst-height BST) (bst-shortest-path-to-leaf BST)))))


; (bst-shortest-path-to-leaf BST)
; Calcola il valore del percorso minimo fino alla foglia del BST
; output: valore del percorso minimo (radice --> foglia)
(define (bst-shortest-path-to-leaf BST)
    (cond
      ((bst-isempty? BST) -1)
      (true (+ 1 (min (bst-shortest-path-to-leaf (bst-left-subtree BST))
                      (bst-shortest-path-to-leaf (bst-right-subtree BST)))))))


; (bst-find-min BST)
; Trova il valore minimo del BST
; output: valore minimo del BST
(define (bst-find-min BST)
    (cond
      ((bst-isempty? BST) nil)
      ((bst-isempty? (bst-left-subtree BST)) (bst-value BST))
      (true (bst-find-min (bst-left-subtree BST)))))


; (bst-find-max BST)
; Trova il valore massimo del BST
; output: valore massimo del BST
(define (bst-find-max BST)
    (cond
      ((bst-isempty? BST) nil)
      ((bst-isempty? (bst-right-subtree BST)) (bst-value BST))
      (true (bst-find-max (bst-right-subtree BST)))))


; (bst-make lst)
; Crea un BST da una lista di numeri
; output: BST
(define (bst-make lst)
  (let (BST '())
    (dolist (el lst)
      (setf BST (bst-add BST el)))))

;(setq lst '(23 12 1 4 5 28 4 9 10 45 89))
;(setq albero (bst-make lst))
;-> (23 (12 (1 () (4 () (5 () (9 () (10 () ()))))) ()) (28 () (45 () (89 () ()))))

'library-tree-loaded
;
; end of library
;

Per caricare la libreria nella REPL:

(load "tree-library.lsp")

