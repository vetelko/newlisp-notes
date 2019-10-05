=============

 NOTE LIBERE

=============

----------------
Perchè newLISP ?
----------------

LISP è uno dei linguaggi di programmazione più antichi del mondo, risalente agli anni '50 (progettato da John MacCarthy e sviluppato da Steve Russel nel 1958). Sorprendentemente è sopravvissuto fino ai giorni nostri, ed è ancora vivo e vegeto, anche dopo la nascita di nuovi linguaggi come Python, Ruby o Julia. newLISP è una versione di LISP rivolta principalmente allo scripting, ma in grado di realizzare anche programmi completi. Ecco le principali caratteristiche del linguaggio:

- facile da installare
- veloce
- open-source
- multipiattaforma
- librerie integrate
- espandibile con moduli e shared C-library
- compatibile con il web
- documentazione ottima

Inoltre, infastidisce i puristi del LISP, ed è spesso una buona cosa sfidare lo status quo.
Il creatore del linguaggio è Lutz Mueller (Don Lucio) e la seguente è la cronologia delle release:

Version Year  Changes and Additions
1.0     1991  First version running on Sun4 with SunOS/BSD 4.1
1.3     1993  Windows 3.0 Win16 version released on Compuserve
2.11    1994  Windows 3.0 Win16
3.0     1995  Windows 95 Win32 version
6.0     1999  Open Source UNIX multi platform, licensed GPL
6.3     2001  newLISP-tk Tcl/Tk IDE
6.5.8   2002  PCRE regular expressions
7.1-4   2003  Mac OS X and Solaris support. PDF manual, catch and throw, context variables, Win32 DLL
8.0-3   2004  Arrays, UTF-8 support, forked processes, semaphores, shared memory, default function
8.4-7   2005  Implicit indexing, comma locales, signals and timers, net-eval distributed computing
8.8-9   2006  Prolog-like unify, macro-like variable expansion, more implicit indexing support
9.0     2006  64-bit arithmetic and file support, more array functions, HTTP server mode
9.1     2007  Full 64-bit compile flavor, HTTP/CGI server mode, functors in ref, ref-all, find, replace
9.2     2007  newLISP-GS a Java based GUI library for writing platform independent user interfaces in newLISP
9.3     2008  FOOP – Functional Object Oriented Programming
9.4     2008  Cilk - multiprocessing API implemented in newLISP
10.0    2009  General API cleanup, reference passing, new unified destructive API with setf
10.1    2009  Actor messaging API on Mac OS X, Linux and other UNIX
10.2    2010  FOOP redone with Mutable Objects
10.3    2011  Switchable Internet Protocol between IPv4 and IPv6
10.4    2012  Rewritten message queue interface and extended import API using libffi
10.5    2013  Unlimited precision, integer arithmetic
10.5.2  2013  KMEANS cluster analysis
10.5.7  2014  newLISP in a web browser compiled to JavaScript with good performance
10.6.0  2014  native expansion macro function
10.6.2  2015  minor new functionality
10.7.0  2016  minor new functionality
10.7.1  2017  minor new functionality
10.7.5  2019  minor new functionality and fixed bugs

Indirizzi web:
Home: http://www.newlisp.org
Forum: http://www.newlispfanclub.alh.net/forum/


--------------
newLISP facile
--------------

In newLISP tutto è una lista (o s-expression).
Una lista è un insieme di elementi racchiusi da parentesi tonde "(" ")".
Gli elementi di una lista possono essere un'altra lista.
Il primo elemento della lista è "speciale" (funzione).
Il resto della lista sono "normali" (argomenti).
Tutte le liste vengono valutate tranne quelle quotate.

--------------------------
Commentare righe di codice
--------------------------

Per commentare una singola riga utilizzare il carattere ";" ad inizio riga:

;  (println 1 { })

Per commentare una sezione di codice (gruppo di righe) racchiudere la sezione con le parole "[text]" e "[/text]":

[text]
  (print 3 { })
  (print 4 { })
[/text]

(define (test)
;  (println 1 { })
  (print 2 { })
  [text]
  (print 3 { })
  (print 4 { })
  [/text]
  (println 5 { })
)

(test)
;-> 2 5

Per commentare una sezione di codice (gruppo di righe) racchiudere la sezione con i caratteri"{" e "}"

(define (test1)
;  (println 1 { })
  (print 2 { })
{
  (print 3 { })
  (print 4 { })
}
  (println 5 { })
)

(test1)
;-> 2 5

Il risultato è corretto, ma perdiamo il match visivo con le parentesi "{" "}" che si trovano nella sezione commentata. Per risolvere il problema usiamo il carattere doppio apice al posto delle parentesi graffe.

(define (test2)
;  (println 1 " ")
  (print 2 " ")
{
  (print 3 " ")
  (print 4 " ")
}
  (println 5 " ")
)


------------------------
Stile del codice newLISP
------------------------

Ogni linguaggio ha un proprio stile generale nella scrittura el codice. Comunque anche ogni programmatore ha uno stile proprio che deriva dalla sua esperienza. Fortunatamente newLISP permette di scrivere con stili diversi basta che si rispetti la sintassi delle liste (parentesi).
Lo stile non è uno standard, ma solo il modo preferito di scrivere e leggere i programmi. Il problema nasce quando diversi programmatori lavorano sullo stesso codice. In questo caso occorrono delle regole comuni per evitare di avere stili diversi nello stesso programma. Poichè newLISP deriva dal LISP vediamo quali indicazioni vengono raccomandate per questo linguaggio (Common LISP) e quanto sono aderenti a newLISP (e comunque sta a voi scegliere quale stile di scittura si adatta di più al vostro modo di programmare).

REGOLE GENERALI

Funzioni di primo ordine
------------------------
Tutte le funzioni di primo ordine devono iniziare dalla colonna 1.

Chiusura parentesi
Le parentesi chiuse non devono essere precedute dal carattere newline.

Esempio:

;; errato
(define (f x)
  (when (< x 3)
    (++ x)
  )
)

;; corretto
(define (f x)
  (when (< x 3)
    (++ x)))

Nota: questa indicazione può non essere la migliore per newLISP.

Diversi programmatori newLISP si allontanano lentamente dalla regola "newline non deve precedere una parentesi chiusa", per usare lo stile di identazione del linguaggio "C". Non solo per una migliore corrispondenza tra le parentesi, ma anche perché è più facile modificare il codice. Nella funzione seguente:

(define (f x)
  (when (< x 3)
    (++ x)
  )
  (pippo x)
)

è molto più facile eliminare o inserire codice prima o dopo le righe in cui le parentesi di chiusura si trovano su righe diverse. Puoi eliminare o inserire una nuova riga senza preoccuparti molto di distruggere l'equilibrio della parentesi. Questo metodo aiuta a gestire programmi con molto codice e la forma visuale delle parentesi facilita l'individuazione dei blocchi di codice.

Comunque è anche vero che lo stile funzionale genera molte parentesi chiuse alla fine di ogni espressione. Quindi ci sono alcuni casi in cui è preferibile chiudere le parentesi sulla stessa linea.

Esempio:

(define (f x)
  (if (< x 3)
    (++ x)
    (begin (pippo x) (++ x))
  )
)

In questo caso la parentesi che chiude "begin" si trova sulla stessa linea.

Per alcuni, il metodo "parentesi chiuse sulla nuova linea" non deve esse usato perchè la lettura dei programmi LISP non deve seguire la corrispondenza delle parentesi, ma seguire l'indentazione. Inoltre  questo metodo richiede più righe per lo stesso codice. In generale, è bene mantenere basso il numero di righe, in modo che più codice si adatti a una pagina o una schermata.

Livello di indentazione
-----------------------
Il livello di indentazione (TAB) dovrebbe essere relativamente piccolo. In genere vengono usati due caratteri spazio per ogni rientro.

Esempio:

;; errato
(define (f x)
    (when (< x 3)
        (++ x)
    )
    (pippo x)
)

;; corretto
(define (f x)
  (when (< x 3)
    (++ x)
  )
  (pippo x)
)

;; corretto
(define (f x)
  (when (< x 3)
    (++ x))
  (pippo x))

Con un livello di indentazione piccolo si diminuisce la lunghezza delle righe del programma.

Commenti
--------
1) Numero di punti e virgola ";" (semicolon)
Un singolo punto e virgola viene utilizzato per un commento relativo a una singola riga di codice e si trova sulla stessa riga del codice, ad esempio:

(if (< x err)     ; se x è minore dell'errore
    (calc x)      ; calcola una funzione
    (prova x))    ; altrimenti prova di nuovo

Nota: La funzione "if" è una forma speciale e segue una indentazione differente: le espressioni che devono essere eseguite (calc x) o (prova x) sono allineate alla condizione (< x err).

Due punti e virgola sono usati per un commento che si riferisce a diverse righe di codice. La riga di commento è allineata con le righe di codice e le precede, in questo modo:

(when (< x 2)
  ;; abbandona tutto e ricomincia
  (setq x 0)
  (prova x))

Tre punti e virgola sono usati per i commenti che descrivono una funzione. Tali commenti iniziano sempre nella colonna 1, in questo modo:

;;; Calcola la quantità di spazio tra i simboli
;;; in una lista di valori interi
(define (calcola-spazi-simboli)
  (map calcola (symbols)))

2) Contenuto dei commenti
Come al solito, cerchiamo di essere brevi, senza perdere il contenuto delle informazioni. Affinché i commenti funzionino con le definizioni, una buona idea è usare la forma imperativa del verbo. In questo modo è possibile evitare espressioni ridondanti come "questa funzione...".

Non scrivere:

;;; Questa funzione calcola lo spazio tra i simboli
;;; in una lista di valori interi
(define (calcola-spazi-simboli)

Invece, scrivere in questo modo:

;;; Calcola la quantità di spazio tra i simboli
;;; in una lista di valori interi
(define (calcola-spazi-simboli)
  (map calcola (symbols)))

In genere i commenti di una funzione includono anche l'elenco e la spiegazione dei parametri di input/output e i limiti di applicazione degli stessi.

Al seguente indirizzo web potete trovare la guida sullo stile LISP raccomandato da Google:

https://google.github.io/styleguide/lispguide.xml

Un altra lettura molto interessante è "Tutorial on Good Lisp Programming Style" di Peter Norvig:

https://www.cs.umd.edu/~nau/cmsc421/norvig-lisp-style.pdf

Nota: i programmatori Lisp esperti leggono e comprendono il codice in base all'indentazione invece che al controllo del livello/numero delle parentesi.

La mia idea è che ognuno deve creare ed affinare con il tempo il proprio stile di programmazione, sia in termini di scrittura che di logica. Inoltre consiglio di studiare i programmi dei programmatori esperti (questo è uno dei metodi migliori per imparare).


---------------------------------------------
Controllare l'output della REPL (prettyprint)
---------------------------------------------

*************************
>>>funzione PRETTY-PRINT
*************************
sintassi: (pretty-print [int-length [str-tab [str-fp-format]])

Riformatta le espressioni per la stampa, il salvataggio o il sorgente e quando si stampa in una console interattiva (REPL). Il primo parametro, int-length, specifica la lunghezza massima della linea e str-tab specifica la stringa utilizzata per indentare le linee. Il terzo parametro str-fp-format descrive il formato predefinito per la stampa di numeri in virgola mobile. Tutti i parametri sono opzionali. pretty-print restituisce le impostazioni correnti o le nuove impostazioni quando vengono specificati i parametri.

(pretty-print)  → (80 " " "%1.15g")  ; default setting

(pretty-print 90 "\t")  → (90 "\t" "%1.15g")

(pretty-print 100)  → (100 "\t" "%1.15g")

(sin 1)    → 0.841470984807897
(pretty-print 80 " " "%1.3f")
(sin 1)    → 0.841

(set 'x 0.0)
x   → 0.000

Il primo esempio riporta le impostazioni predefinite di 80 colonne per la lunghezza massima della linea e uno spazio per il rientro. Il secondo esempio modifica la lunghezza della linea in 90 e il rientro in un carattere TAB. Il terzo esempio modifica solo la lunghezza della linea. L'ultimo esempio modifica il formato predefinito per i numeri in virgola mobile. Ciò è utile quando si stampano numeri in virgola mobile non formattati senza parti frazionarie e questi numeri dovrebbero essere comunque riconoscibili come numeri in virgola mobile. Senza il formato personalizzato, x verrebbe stampato come 0 indistinguibile dal numero in virgola mobile. Sono interessate tutte le situazioni in cui sono stampati numeri in virgola mobile non formattati.

Si noti che pretty-print non può essere utilizzato per impedire la stampa di interruzioni di riga. Per sopprimere completamente la stampa "pretty print", utilizzare la funzione string per convertire l'espressione in una stringa raw non formattata come nell'esempio seguente:

;; print without formatting

(print (string my-expression))

Esempio base:

(pretty-print)
;-> (80 " " "%1.16g")

(pretty-print 70 " " "%1.16g")
;-> (70 " " "%1.16g")


----------------
File e cartelle
----------------

Cartella --> Directory o Folder

Per vedere la cartella corrente della REPL di newLISP:

!cd
;-> f:\Lisp-Scheme\newLisp\MAX

Per cambiare la cartella corrente della REPL di newLISP:

(change-dir "c:\\util")
;-> true

(change-dir "c:/util")
;-> true

Verifichiamo:

!cd
;-> c:\\util

Ritorniamo alla cartella precedente:

(change-dir "f:\\Lisp-Scheme\\newLisp\\MAX")
;-> true

(change-dir "f:/Lisp-Scheme/newLisp/MAX")
;-> true

Vediamo ora alcune funzioni per stampare la lista dei file e delle cartelle.

"show-tree" mostra tutti i file e le cartelle ricorsivamente:

(define (show-tree dir)
  (dolist (nde (directory dir))
    (if (and (directory? (append dir "/" nde)) (!= nde ".") (!= nde ".."))
          (show-tree (append dir "/" nde))
          (println (append dir "/" nde)))))

(show-tree "c:\\")

(show-tree "c:/")

(env "newLISPDIR")
;-> "C:\\newlisp"

(show-tree (env "newLISPDIR")) ;; also works on Win32

"show-dir" mostra cartelle dalla cartella corrente:

(define (show-dir dir)
  (dolist (nde (directory dir))
    (if (and (directory? (append dir "/" nde)) (!= nde ".") (!= nde ".."))
          (if (directory? (append dir "/" nde))
            (println (append dir "/" nde))))))

(show-dir (env "newLISPDIR"))

"show-file" mostra file e cartelle dalla cartella corrente:

(define (show-file dir)
  (dolist (nde (directory dir))
    (println (append dir "/" nde))))

(show-file (env "newLISPDIR"))

(show-file "c:\\")

(show-file "C:\\newlisp\\util")
(show-file "C:/newlisp/util")


----------------
Funzioni e liste
----------------

Definiamo una funzione che somma due numeri:

(define (somma a b) (add a b))
;-> (lambda (a b) (add a b))

La variabile "somma" contiene la definizione (come lista) della funzione lambda:

somma
;-> (lambda (a b) (add a b))

La funzione viene restituita come lista:
(list? somma)
;-> true

Ma è anche una funzione lambda:
(lambda? somma)
;-> true

Quindi una funzione lambda può essere trattata come una lista.
Vediamo i parametri della funzione:

(first somma)
;-> (a b)

Vediamo il corpo della funzione:
(last somma)
;-> (add a b)

Modifichiamo la funzione in modo che calcoli la differenza invece che la somma delle variabili a e b:
(setf (first (last somma)) 'sub)
;-> sub

Controlliamo la modifica:
somma
;-> (lambda (a b) (sub a b))

Eseguiamo la funzione somma:
(somma 6 2)
;-> 4 ; abbiamo ottenuto la differenza

Mi piace questo aspetto del linguaggio: automodificante.

Nota: La funzione "define" è solo "syntactic sugar". Infatti le seguenti espressioni sono equivalenti:

(define (somma a b) (add a b))
;-> (lambda (a b) (add a b))

(setq somma '(lambda (a b) (add a b)))
;-> (lambda (a b) (add a b))

Definiamo la funzione "getdef" che prende come parametro il nome di una funzione utente e restituisce (come lista) la definizione lambda della funzione:

(define (getdef func) (if (lambda? func) func nil))

(getdef somma)
;-> (lambda (a b) (+ a b))

(getdef pow)
;-> nil

Adesso definiamo la funzione "funcall" che esegue la funzione passata.

(define (funcall func) (eval (func (args))))

I parametri di funcall non devono essere valutati quando viene chiamata, quindi quotiamo il parametro (lista) "func":

(funcall '(somma 10 20))
;-> 30

(funcall '(somma (somma 10 20) 6))
;-> 36

(funcall '(sin 12))
;-> -0.5365729180004349

Questo è uno dei motivi per cui mi piace newLISP.


----------
4-4 Puzzle
----------

Definire i seguenti simboli:

zero, uno, due, tre quattro, cinque, sei, sette, otto, nove

utilizzando per ogni numero una espressione matematica che contiene quattro volte il numero 4.
L'espressione può contenere: + add , - sub , * mul , / div , (), separatore decimale, potenza, radice quadrata, fattoriale e numero periodico (es. .4~ = .444444444444444...)

0 - (setq zero (- 44 44))
0 - (setq zero (+ 4 4 (- 4) (- 4)))
0 - (setq zero (+ 4 4 (- (+ 4 4))))
1 - (setq one (/ 44 44))
1 - (setq one (+ (/ 4 4) (- 4 4)))
1 - (setq one (+ (/ 4 4) (+ 4 (- 4))))
2 - (setq due (/ (* 4 4) (+ 4 4)))
2 - (setq due (+ (/ 4 4) (/ 4 4)))
2 - (setq due (- 4 (/ (+ 4 4) 4)))
3 - (setq tre (/ (+ 4 4 4) 4))
4 - (setq quattro (+ 4 (* 4 (- 4 4))))
5 - (setq cinque (/ (+ 4 (* 4 4)) 4))
6 - (setq sei (+ 4 (/ (+ 4 4) 4)))
7 - (setq sette (- (/ 44 4) 4))
7 - (setq sette (- (+ 4 4) (/ 4 4)))
8 - (setq otto (/ (* 4 (+ 4 4)) 4))
8 - (setq otto (- (* 4 4) (+ 4 4)))
8 - (setq otto (- (+ 4 4 4) 4))
9 - (setq nove (+ (+ 4 4) (/ 4 4)))

Possiamo provare anche con altri numeri:

 42  - (setq quarantadue (+ 44 (sqrt 4) (- 4)))
100  - (setq cento (div 44 .44))
200  - (setq duecento (+ (fact 4) (* 4 44)))
666  - (setq beast (div 444 (sqrt .4444444444444444)))
1000 - (setq mille (- (* 4 (pow 4 4)) (fact 4)))


--------------
Il primo Primo
--------------

Non c'è dubbio che per tutto il XVII secolo e l'inizio del XX secolo molti matematici hanno considerato il numero 1 come primo, ma è anche chiaro che questa definizione non è mai stata una visone unificata dei matematici. Euclide, Mersenne, Eulero, Gauss, Dirichlet, Lucas e Landau tutti hanno omesso 1 dai primi. Gli ultimi matematici a considerare il numero 1 come primo sono stati Lebesgue (1899) e Hardy (1933).
Ad oggi, il primo numero Primo è il numero 2.
"What is the Smallest Prime?" Caldwell, Xiong - Journal of Integer Sequences, Vol.15 (2012)


--------------
Uso delle date
--------------

La data in formato ISO 8601: YYYY-MM-DD hh:mm:ss

2019-06-31 12:42:22

Purtroppo la funzione "date-parse" non funziona in windows.

; (date-parse "2019-06-15 12:42:22" "%Y-%m-%d %H:%M:%S")
; (date-parse "2019-06-31" "%Y-%m-%d")
; (date-parse "2007.1.3" "%Y.%m.%d")

(date)

"Thu Jul 18 11:36:02 2019"

Trasformiamo la data dal formato ISO al formato RFC822:

(apply date-value (map int (parse "2005-10-16 12:12:12" { |-|:} 0)))
;-> 1129464732

(apply date-value (map int (parse "2019-06-15 12:42:22" { |-|:} 0)))
;-> 1560602542

(apply date-value (map int (parse "2007.1.3" { |\.} 0)))
;-> 1167782400

(date (apply date-value (map int (parse "2005-10-16 12:12:12" { |-|:} 0)))  0 "%a, %d %b %Y %H:%M %Z")
;-> "Sun, 16 Oct 2005 14:12 W. Europe Daylight Time"

(date (apply date-value (map int (parse "2019-06-15 12:42:22" { |-|:} 0)))  0 "%a, %d %b %Y %H:%M %Z")
;-> "Sat, 15 Jun 2019 14:42 W. Europe Daylight Time"

(date (apply date-value (map int (parse "2007.1.3" { |\.} 0)))  0 "%a, %d %b %Y %H:%M %Z")
;-> "Wed, 03 Jan 2007 01:00 W. Europe Standard Time"


-------------------------------------------------
Chiusura transitiva e raggiungibilità in un grafo
-------------------------------------------------

ralph.ronnquist:
----------------
Vediamo come definire una "chiusura transitiva". Data una lista di coppie che rappresenta i link di un grafo, determinare le liste di tutti i nodi connessi transitivamente (in altre parole, unire tutte le sotto-liste che hanno in comune qualche elemento (transitivamente)).
↔↕
Esempio:

 19 ←→ 9 ←→ 4 ←→ 12    3 ←→ 15 ←→ 8    7 ←→ 5 ←→ 0 ←→ 11
            ↕
           13 ←→ 1

(setq grafo '((13 1) (9 19) (4 13) (4 12) (15 8) (3 15) (7 5) (9 4) (11 0) (0 5)))

Una soluzione ricorsiva potrebbe essere la seguente:

(define (trans s (x s) (f (and s (curry intersect (first s)))))
  (if s (trans (rest s) (cons (unique (flat (filter f x))) (clean f x))) x))

(trans grafo)
;-> ((7 5 0 11) (9 19 4 13 1 12) (15 8 3))

rickyboy:
---------
L'input s è una lista di insiemi in cui ogni membro è in relazione l'uno con l'altro. Ad esempio, se uno dei membri di s è (1 2 3) ciascuno di 1, 2 e 3 sono collegati a qualsiasi altro. In termini matematici, se l'input s descrive una relazione (simmetrica) R, allora risulta che 1R2, 2R1, 1R3, 3R1, 2R3 e 3R2 sono tutti veri.

Quindi, ad esempio, il primo membro dell'input di esempio (13 1) implica sia 13R1 che 1R13 (quando l'input di esempio descrive R). Questo perché, l'input di trans e il suo output sono simili, sono entrambi descrizioni di relazione - tranne che l'output è garantito per descriva una relazione di transitività.

Ora, guardando l'input invece come un insieme di link di un grafo, allora la funzione "trans" deve assumere che tutti i link che trova nell'input sono bidirezionali, cioè gli archi (collegamenti) del grafo non sono orientati.

La funzione "trans" unisce (cons) il membro che definisce le relazioni transitive parziali che contengono il link (first s) (per assorbimento/sussunzione) (cioè (unique (flat (filter f x)))), con il sottoinsieme dei membri che definiscono le relazioni transitive parziali in x che sono mutualmente esclusive al link (first s) (cioè clean f x)

Quando utilizziamo la funzione "trans" possiamo accoppiarla con la seguente funzione che crea un predicato per essa:

(define (make-symmetric-relation S)
  (letex ([S] S)
    (fn (x y)
      (exists (fn (s) (and (member x s) (member y s)))
              '[S]))))

Ecco un test che mostra la funzione in azione:

(define (test-trans input x y)
  (let (R     (make-symmetric-relation input)
        Rt    (make-symmetric-relation (trans input))
        yesno (fn (x) (if x 'yes 'no)))
    (list ;; is (x,y) in the original relation?
          (yesno (R x y))
          ;; is (x,y) in the transitive closure?
          (yesno (Rt x y)))))

Ad esempio,
(8 15) è nella relazione originale: quindi, sarà anche nella chiusura transitiva.
(9 13) non è nella relazione originale, ma è nella chiusura transitiva.
(9 15) non è in nessuna delle due.

(define input '((13 1) (9 19) (4 13) (4 12) (15 8) (3 15) (7 5) (9 4) (11 0) (0 5)))

(test-trans input 8 15)
;-> (yes yes)

(test-trans input 9 13)
;-> (no yes)

(test-trans input 9 15)
;-> (no no)

ralph.ronnquist:
----------------
Esatto, la funzione "trans" tratta la sua lista di input s come una raccolta di classi di equivalenza e combina quelle che si sovrappongono nelle più piccole collezioni di classi.

La funzione simile per le relazioni non riflessive (o per gli archi diretti) riguarderebbe piuttosto la "raggiungibilità transitiva", da un elemento a quelli che sono raggiungibili quando si segue l'articolata relazione (links) in un solo senso (in avanti).

Le seguenti due funzioni svolgono questi metodi: una che determina il raggiungimento individuale di un dato elemento, e una che determina il raggiungimento individuale di tutti gli elementi (mappa di raggiungibilità).

versione iniziale:
(define (reach s n (f (fn (x) (= n (x 0)))))
  (cons n (if s (flat (map (curry reach (clean f s))
                           (map (curry nth 1) (filter f s)))))))

Nota: usare la versione iniziale della funzione "reach".

============================================================================
versione finale (rimuove gli elementi multipli con "unique"):
(define (reach s n (f (fn (x) (= n (x 0)))))
  (cons n (if s (unique (flat (map (curry reach (clean f s))
                                   (map (curry nth 1) (filter f s))))))))
============================================================================

(define (reachability s)
  (map (fn (x) (reach s x)) (sort (unique (flat s)))))

 19 ← 9 → 4 → 12    3 → 15 → 8    7 → 5 ← 0 ← 11
          ↓
          13 → 1


(setq grafoD '((13 1) (9 19) (4 13) (4 12) (15 8) (3 15) (7 5) (9 4) (11 0) (0 5)))

(reachability grafoD)
;-> ((0 5) (1) (3 15 8) (4 13 1 12) (5) (7 5) (8)
 ;-> (9 19 4 13 1 12) (11 0 5) (12) (13  1) (15 8) (19))

La "mappa di raggiungibilità" in ogni sottolista indica quali elementi sono raggiungibili dal primo elemento secondo la relazione orientata originale. Per creare la chiusura transitiva basta creare le coppie di associazione dalla mappa di raggiungibilità.

(define (transD s)
  (flat (map (fn (x) (if (1 x) (map (curry list (x 0)) (1 x)) '())) (reachability s)) 1))

(transD grafoD)
;-> ((0 5) (3 15) (3 8) (4 13) (4 1) (4 12) (7 5) (9 19)
;->  (9 4) (9 13) (9 1) (9 12) (11 0) (11 5) (13 1) (15 8))

Il nuovo input (grafoD) crea nuove coppie: (3 8) (4 1) (9 13) (9 1) (9 12) (11 5)

Adesso, come andiamo nell'altra direzione? Ovvero, come si riduce al minor numero di coppie, o almeno si trova una sottolista in modo che le relazioni implicite vengano omesse dall'elenco?

rickyboy:
---------
Ecco la funzione "untransD" che rimuove le relazioni implicite. LAvora considerando ogni arco in s che può essere visto come coppia (src dst) (sebbene dst non è necessario). La funzione "clean" risponde alla domanda "Questo arco è implicato?", che sarà vero (true) quando la raggiungibilità di src, dopo che abbiamo rimosso l'arco da s, è la stessa della raggiungibilità di src sotto s.

(define (untransD s)
  (clean (fn (edge)
           (let (src (edge 0)
                 remove (fn () (apply replace (args))))
             (= (reach s src)
                (reach (remove edge s) src))))
         s))

Per quelli che non hanno familiarità con newLISP, notare la funzione di "remove" (definita nell'associazioni let). Sembra che stia facendo solo ciò che fa la funzione intrinseca "replace": allora, perché non dire semplicemente (replace edge s) invece di (remove edge s)?
La ragione di questo è sottile. La primitiva "replace" è distruttiva e non vogliamo che s cambi durante il runtime di untransD. Definire "remove" come abbiamo fatto qui lo trasforma in una funzione di rimozione non distruttiva (a causa del modello di chiamata di newLISP: la funzione riceve una copia e non il riferimento dell'oggetto).

Ma forse da un punto di vista dei contratti (di ingegneria del software), non dovremmo fare affidamento sull'ordine degli output delle chiamate raggiunte (cioè la sua stabilità).
Anche se possiamo vedere il codice di raggiungibilità, possiamo anche giocare "giocare sicuro" assumendo che non possiamo vedere l'implementazione e quindi sostituire l'uso di = con l'uso di un altro predicato di uguaglianza in cui l'ordine non ha importanza. Potrebbe esserci un modo migliore di quello proposto di seguito:

(define (set-equal? A B)
  (= (sort A) (sort B)))

Anche la primitiva "sort" è distruttiva. Tuttavia, non abbiamo bisogno di A e B (che sono copie anche loro) per qualsiasi altra cosa nell'ambito di questa funzione (dopo che abbiamo finito possiamo distruggerli). Fortunatamente, possiamo riutilizzare set-equal? nei nostri test.

Innanzitutto, ricordiamo cosa fa "transD" in esecuzione sui dati di esempio (input).

(setq input '((13 1) (9 19) (4 13) (4 12) (15 8) (3 15) (7 5) (9 4) (11 0) (0 5)))

(transD input)
;-> ((0 5) (3 15) (3 8) (4 13) (4 1) (4 12) (7 5) (9 19)
;->  (9 4) (9 13) (9 1) (9 12) (11 0) (11 5) (13 1) (15 8))

Adesso vediamo la funzione "untransD" in azione:

(untransD (transD input))
;-> ((0 5) (3 15) (4 13) (4 12) (7 5) (9 19) (9 4) (11 0) (13 1) (15 8))

L'output della funzione sembra uguale alla lista di ingresso.

Come facciamo a testare meglio queste funzioni? Sembra che dovremmo essere in grado di dire che transD e untransD sono una l'inversa dell'altra. Proviamo.

Innanzitutto, si noti che l'input di esempio stesso è privo di relazioni implicite.

(set-equal? input (untransD input))
;-> true

Questo significa che deve valere anche la seguente identità:

(set-equal? input (untransD (transD input)))
;-> nil

Esplorando tutto il codice, credo di aver trovato un bug.

La seguente identità dovrebbe essere vera: la raggiungibilità della chiusura transitiva dell'input è la stessa della raggiungibilità dell'input.

(set-equal? (reachability input)
            (reachability (transD input)))

;-> nil

Cosa succede?

(reachability (transD input))
;-> ((0 5) (1) (3 15 8 8) (4 13 1 1 12) (5) (7 5)
;->  (8) (9 19 4 13 1 1 12 13 1 1 12) (11 0 5 5)
;->  (12) (13 1) (15 8) (19))

Ok, sembra che alcune raggiungibilità non abbiano elementi unici. Eccone una in particolare.

(reach (transD input) 9)
;-> (9 19 4 13 1 1 12 13 1 1 12)

Sembra che abbiamo bisogno della funzione "unique" nella funzione "reach".

(define (reach s n (f (fn (x) (= n (x 0)))))
  (cons n (if s (unique (flat (map (curry reach (clean f s))
                                   (map (curry nth 1) (filter f s))))))))

Bene, adesso funziona.

(reach (transD input) 9)
;-> (9 19 4 13 1 12)

E l'identità viene rispettata, come atteso.

(set-equal? (reachability input)
            (reachability (transD input)))

;-> true

Grazie a ralph.ronnquist e rickyboy.


-----------
Stalin Sort
-----------

Ecco un algoritmo di ordinamento O(n) (single pass) chiamato StalinSort. L'algoritmo scorre l'elenco degli elementi controllando se sono in ordine. Qualsiasi elemento fuori ordine viene eliminato. Alla fine si ottiene un elenco ordinato.

(define (stalinsort lst op)
  (local (out)
    (setq out '())
    (cond ((null? lst) '())
          (true
            (let (base (first lst))
              (push (first lst) out -1)
              (for (i 1 (- (length lst) 1))
                (if (op (lst i) base)
                ;(if (not (op (lst i) base))
                  (begin
                  (push (lst i) out -1)
                  (setq base (lst i)))
                )
              )
              out
            )
          )
    )
  )
)

(stalinsort '(1 3 4 2 3 6 8 5) <=)
;-> (1)
(stalinsort '(1 3 4 2 3 6 8 5) >=)
;-> (1 3 4 6 8)
(stalinsort '(11 8 4 2 3 6 8 5) <=)
;-> (11 8 4 2)
(stalinsort '(11 8 4 2 3 6 8 5) >=)
;-> (11)
(stalinsort '(11 4 8 2 3 6 8 12) <=)
;-> (11 4 2)
(stalinsort '(11 4 8 2 3 6 8 12) >=)
;-> (11 12)


--------------------
Sequenza triangolare
--------------------

Consideriamo il seguente triangolo di numeri interi:

1
1 2
1 2 3
1 2 3 4
1 2 3 4 5
...

Quando il triangolo è appiattito (flattened), produce la lista (1 1 2 1 2 3 1 2 3 4 1 2 3 4 5 ...).
Il compito è scrivere un programma per generare la sequenza appiattita e per calcolare l'ennesimo elemento nella lista.

(define (triangle n idx)
  (local (out)
    (setq out '())
    (for (i 1 n)
      (push (sequence 1 i) out -1)
    )
    (setq out (flat out))
    (if idx (nth idx out) out)
  )
)

(triangle 3)
;-> (1 1 2 1 2 3)
(triangle 3 2)
;-> 2
(triangle 5)
;-> (1 1 2 1 2 3 1 2 3 4 1 2 3 4 5)
(triangle 5 10)
;-> 1


-------------------------
Vettore/lista di funzioni
-------------------------

Creiamo le funzioni:

(define (f0 x) (add x 1))
(define (f1 x) (mul x x))
(define (f2 x) (mul x x x))

Creiamo il vettore che contiene le funzioni:

(setq vet (array 3 (list f0 f1 f2)))
;-> ((lambda (x) (add x 1)) (lambda (x) (mul x x)) (lambda (x) (mul x x x)))

Ogni elemento del vettore contiene una funzione:

(vet 0)
;-> (lambda (x) (add x 1))

Possiamo chiamare le funzioni nel modo seguente:

((vet 0) 2)
;-> 3

((vet 1) 2)
;-> 4

((vet 2) 2)
;-> 8

Utilizzando una lista otteniamo lo stesso risultato:

(setq lst (list f0 f1 f2))
;-> ((lambda (x) (add x 1)) (lambda (x) (mul x x)) (lambda (x) (mul x x x)))

(dolist (el lst) (println (el 2)))
;-> 3
;-> 4
;-> 8


------------------------------------
Numeri dispari differenza di quadrati
-------------------------------------

Ogni numero dispari può essere espresso come differenza di due quadrati.

Dimostrazione:

Prendiamo il numero 5 e rappresentiamolo con delle O:
OOOOO

Dividiamo il numero in due parti:
OOO
O
O

Riempiamo il quadrato:
OOO
OXX
OXX

Quadrato totale (9) - quadrato interno (4) = 5

Scriviamo una funzione che calcola questi numeri:

(define (breaknum n)
  (if (even? n) nil
    (list (* (- n (/ n 2)) (- n (/ n 2))) (* (/ n 2) (/ n 2)) )
  )
)

(breaknum 11)
;-> (36 25)

(breaknum 9527)
;-> (22695696 22686169)


----------
Zero? test
----------

In newLISP abbiamo due modi per verificare se un numero n vale 0:

(zero? n) e (= n 0)

Vediamo se hanno la stesssa velocità. Scriviamo due funzioni che hanno una sola differenza: il modo con cui confrontiamo un valore con il numero zero.

(define (t1 num)
  (let (k 0)
    (dotimes (x num) (if (zero? (rand 2)) (++ k)))
    k))

(define (t2 num)
  (let (k 0)
    (dotimes (x num) (if (= 0 (rand 2)) (++ k)))
    k))

(time (map t1 (sequence 10 10000)))
;-> 5324.556

(time (map t2 (sequence 10 10000)))
;-> 5874.991

Il modo (zero? n) è più veloce.

Proviamo con un altro calcolo al posto di "rand":

(define (t1 num)
  (let (k 0)
    (dotimes (x num) (if (zero? (% num (+ x 1))) (++ k)))
    k))

(define (t2 num)
  (let (k 0)
    (dotimes (x num) (if (= 0 (% num (+ x 1))) (++ k)))
    k))

(time (map t1 (sequence 10 10000)))
;-> 5062.827

(time (map t2 (sequence 10 10000)))
;-> 5663.21

Quindi nei test numerici è meglio utilizzare la funzione "zero?"


-----------------------------------------------
Operazioni su elementi consecutivi di una lista
-----------------------------------------------

Supponiamo di voler calcolare la differenza tra gli elementi consecutivi della seguente lista: (7 11 13 17 19 23 29 31 37)

(setq a '(7 11 13 17 19 23 29 31 37))

(define (dist-lst lst) (map - (rest lst) (chop lst)))

(dist-lst a)
;-> (4 2 4 2 4 6 2 6)

(11 - 7 = 4) (13 - 11 = 2) (17 - 13 = 4)...(37 - 31 = 6)

Possiamo generalizzare la funzione per utilizzare anche altri operatori:

(define (calc-lst lst func ) (map func (rest lst) (chop lst)))

(calc-lst a +)
;-> (18 24 30 36 42 52 60 68)

(11 + 7 = 18) (13 + 11 = 24) (17 + 13 = 30)...(37 + 31 = 68)

Possiamo generalizzare ancora la funzione permettendo di stabilire l'ordine degli operandi. Quando il parametro rev vale true, allora viene effettuata l'operazione (el(n) func el(n+1)), altrimenti viene effettuata l'operazione (el(n+1) func el(n))

(define (calc-lst lst func rev)
  (if rev
      (map func (chop lst) (rest lst))
      (map func (rest lst) (chop lst))))

(calc-lst a -)
;-> (4 2 4 2 4 6 2 6)

(calc-lst a - true)
;-> (-4 -2 -4 -2 -4 -6 -2 -6)

(7 - 11 = -4) (11 - 13 = -2) (13 - 17 = -4)...(31 - 37 = -6)


---------------------------------------------------
Il loop implicito del linguaggio Scheme (named let)
---------------------------------------------------

La seguente funzione in linguggio Scheme converte un numero intero in una lista:

(define (number->list n)
  (let loop ((n n)
             (acc '()))
    (if (< n 10)
        (cons n acc)
        (loop (quotient n 10)
              (cons (remainder n 10) acc)))))

Viene definito un ciclo in cui la variabile n è uguale a n e la variabile acc è uguale all'elenco vuoto. Quindi se n è minore di 10, n viene inserito in acc. Altrimenti, "loop" viene applicato con n uguale a n/10 e acc uguale al cons del resto di n / 10 e della lista accumulata precedentemente, quindi chiama se stesso.
L'idea alla base di let è che permette di creare una funzione interna, che può chiamare se stessa e invocarla automaticamente. Possiamo utilizzare questa idea per scrivere in newLISP una funzione simile:

(define (number->list n)
  ; definiamo la funzione "loop" (può avere qualunque nome)
  (define (loop n acc)
    (if (< n 10)
        (cons n acc)
        (loop (/ n 10) (cons (% n 10) acc))
    )
  )
  ; chiamiamo la funzione "loop"
  (loop n '())
)

(number->list '1234)
;-> (1 2 3 4)

Viene chiamato "loop" perché la funzione chiama se stessa dalla posizione di coda. Questo è noto come ricorsione di coda (tail recursion). In Scheme, con la ricorsione di coda, la chiamata ricorsiva ritorna direttamente al chiamante, quindi non è necessario mantenere il frame di chiamata corrente. È possibile eseguire la ricorsione della coda tutte le volte che si desidera senza causare un overflow dello stack. In newLISP non esiste l'ottimizzazione della ricorsione di coda, quindi dobbiamo stare molto attenti a non causare un errore di stack overflow quando usiamo la tecnica della ricorsione.


------------------------------
Brainfuck string encode/decode
------------------------------

Brainfuck è un linguaggio di programmazione esoterico, creato da Urban Müller nel 1993.

Scrivere due funzioni che effettuano le seguenti operazioni:

1) Input -> Stringa, Output -> Programma Brainfuck per stampare la stringa

2) Input -> Programma Brainfuck per stampare la stringa, Output -> stringa

Questa funzione prende una stringa e restituisce un programma (stringa) in linguaggio Brainfuck che stampa la stringa:

(define (gen-bf str)
  (let (o "")
    (dolist (el (explode str))
      (setq o (join (list o (dup "+" (char el)) ".[-]")))
    )
    ;(silent (println o))
  )
)

(gen-bf "ciao")
;-> "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]"

(gen-bf "newLISP")
;-> "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]"

Questa funzione prende un programma (stringa) in linguaggio Brainfuck che stampa la stringa e restituisce la stringa da stampare:

(define (bf str)
  (local (cc)
    (setq cc 0)
    (dolist (el (explode str))
      ; conta i caratteri "+"
      (if (= el "+")
          (++ cc)
          ; e quando finiscono i "+", stampa il carattere relativo al numero dei "+"
          (if (!= cc 0) (begin (print (char cc)) (setq cc 0)))
      )
    )
    (silent (print (format "\n%s " "stop.")))
  )
)

(bf "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]")
;-> ciao
;-> stop.

(bf
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]")
;-> newLISP
;-> stop.

(bf (gen-bf "Controllo funzioni"))
;-> Controllo funzioni
;-> stop.


------------------------------------
Creare una utilità di sistema (.exe)
------------------------------------

Il codice sorgente e l'eseguibile newLISP.exe possono essere uniti tra loro per creare un'applicazione autonoma utilizzando il flag della riga di comando -x.

;; uppercase.lsp - Link example
(println (upper-case (main-args 1)))
(exit)

Il programma uppercase.lsp prende la prima parola dalla riga di comando e la converte in maiuscolo.

Per compilare questo programma come eseguibile autonomo, eseguire dal terminale la seguente procedura:

Su OSX, Linux e altri UNIX

newlisp -x uppercase.lsp uppercase

chmod 755 uppercase # give executable permission

Su Windows il file di destinazione richiede l'estensione .exe

newlisp -x uppercase.lsp uppercase.exe

newLISP troverà l'eseguibile "newLISP.exe" nel percorso di esecuzione dell'ambiente (PATH) e lo unirà ad una copia del codice sorgente "uppercase.lsp" per creare il programma "uppercase.exe".

Per eseguire il programma eseguire dal terminale il comando:

Su Linux e altri UNIX, se la cartella (directory) corrente si trova nel percorso eseguibile:

uppercase "convert me to uppercase"

Su Linux e altri UNIX, se la directory corrente non si trova nel percorso eseguibile:

./uppercase "convert me to uppercase"

Su windows:

uppercase "convert me to uppercase"

La console dovrebbe stampare:

;-> CONVERT ME TO UPPERCASE

Si noti che nessuno dei file di inizializzazione init.lsp né .init.lsp viene caricato durante l'avvio dei programmi creati in questo modo.

Vediamo come gestire i parametri passati alla linea di comando utilizzando la funzione "main-args".

**********************
>>>funzione MAIN-ARGS
**********************
sintassi: (main-args int-index)

main-args restituisce una lista con diversi elementi di tipo stringa, uno per l'invocazione del programma e uno per ciascuno degli argomenti della riga di comando.

newlisp 1 2 3

> (main-args)
("/usr/local/bin/newlisp" "1" "2" "3")

Dopo che newlisp 1 2 3 viene eseguito al prompt dei comandi, main-args restituisce una lista contenente il nome del programma chiamante e i tre argomenti della riga di comando.

Facoltativamente, main-args può prendere un int-index per l'indicizzazione della lista. Si noti che un indice fuori intervallo causerà la restituzione di zero, non l'ultimo elemento dell'elenco come nell'indicizzazione delle liste.

newlisp a b c

(main-args 0)
;-> "/usr/local/bin/newlisp"
(main-args -1)
;-> "c"
(main-args 2)
;-> "b"
(main-args 10)
;-> nil

Nota che quando newLISP viene eseguito da uno script, main-args restituisce anche il nome dello script come secondo argomento:

#!/usr/local/bin/newlisp
#
# script to show the effect of 'main-args' in script file

(print (main-args) "\n")
(exit)

# end of script file

;; execute script in the OS shell:

script 1 2 3

;-> ("/usr/local/bin/newlisp" "./script" "1" "2" "3")

Prova a eseguire questo script con diversi parametri della riga di comando.


----------------------------
Fattoriale, Fibonacci, Primi
----------------------------

(setq MAXINT 9223372036854775807)

Funzione di fattorizzazione:

(define (factorbig n)
  (local (f k i dist out)
    ; Distanze tra due elementi consecutivi della ruota (wheel)
    (setq dist (array 48 '(2 4 2 4 6 2 6 4 2 4 6 6 2 6 4 2 6 4
                           6 8 4 2 4 2 4 8 6 4 6 2 4 6 2 6 6 4
                           2 4 6 2 6 4 2 4 2 10 2 10)))
    (setq out '())
    (while (zero? (% n 2)) (push '2L out -1) (setq n (/ n 2)))
    (while (zero? (% n 3)) (push '3L out -1) (setq n (/ n 3)))
    (while (zero? (% n 5)) (push '5L out -1) (setq n (/ n 5)))
    (while (zero? (% n 7)) (push '7L out -1) (setq n (/ n 7)))
    (setq k 11L i 0)
    (while (<= (* k k) n)
      (if (zero? (% n k))
        (begin
        (push k out -1)
        (setq n (/ n k)))
        (begin
        ;(++ k (dist i))
        (setq k (+ k (dist i)))
        (if (< i 47) (++ i) (setq i 0)))
      )
    )
    (if (> n 1) (push (bigint n) out -1))
    out
  )
)

Funzione fattoriale:

(define (fact n) (if (= n 0) 1 (apply * (map bigint (sequence 1 n)))))

Definiamo una funzione che stampa il fattoriale e la sua scomposizione in fattori fino a n:

(define (test n)
  (local (f fp)
    (for (i 2 n)
      (setq f (fact i))
      (setq fp (factorbig f))
      (println i { } f)
      (println fp)
    )
  )
)

(test 14)
2 2L
(2L)
3 6L
(2L 3L)
4 24L
(2L 2L 2L 3L)
5 120L
(2L 2L 2L 3L 5L)
6 720L
(2L 2L 2L 2L 3L 3L 5L)
7 5040L
(2L 2L 2L 2L 3L 3L 5L 7L)
8 40320L
(2L 2L 2L 2L 2L 2L 2L 3L 3L 5L 7L)
9 362880L
(2L 2L 2L 2L 2L 2L 2L 3L 3L 3L 3L 5L 7L)
10 3628800L
(2L 2L 2L 2L 2L 2L 2L 2L 3L 3L 3L 3L 5L 5L 7L)
11 39916800L
(2L 2L 2L 2L 2L 2L 2L 2L 3L 3L 3L 3L 5L 5L 7L 11L)
12 479001600L
(2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 3L 3L 3L 3L 3L 5L 5L 7L 11L)
13 6227020800L
(2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 3L 3L 3L 3L 3L 5L 5L 7L 11L 13L)
14 87178291200L
(2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 3L 3L 3L 3L 3L 5L 5L 7L 7L 11L 13L)

(pretty-print)
;-> (80 " " "%1.16g")

(pretty-print 70 " " "%1.16g")

(factorbig (fact 100))
;-> (2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L
;->  3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L
;->  3L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L
;->  5L 7L 7L 7L 7L 7L 7L 7L 7L 7L 7L 7L 7L 7L 7L 7L 7L 11L 11L 11L 11L 11L
;->  11L 11L 11L 11L 13L 13L 13L 13L 13L 13L 13L 17L 17L 17L 17L 17L 19L 19L
;->  19L 19L 19L 23L 23L 23L 23L 29L 29L 29L 31L 31L 31L 37L 37L 41L 41L 43L
;->  43L 47L 47L 53L 59L 61L 67L 71L 73L 79L 83L 89L 97L)

Definiamo una funzione per calcolare i numeri di Fibonacci:

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

(fibo-i 3)
;-> 55L

Definiamo una funzione per verificare se un numero è primo:

(define (isprime? n)
  (if (< n 2) nil
    (= 1 (length (factorbig n)))))

(isprime? (fibo-i 20))
;-> nil

Definiamo una funzione che stampa il numero di Fibonacci e la sua scomposizione in fattori fino a n:

(define (test1 n)
  (local (f fp)
    (for (i 2 n)
      (setq f (fibo-i i))
      (setq fp (factorbig f))
      (println i { } f)
      (println fp)
    )
  )
)

(test1 100)
;-> 2 1L
;-> ()
;-> 3 2L
;-> (2L)
;-> 4 3L
;-> (3L)
;-> 5 5L
;-> (5L)
;-> 6 8L
;-> (2L 2L 2L)
;-> 7 13L
;-> (13L)
;-> 8 21L
;-> (3L 7L)
;-> 9 34L
;-> (2L 17L)
;-> 10 55L
;-> (5L 11L)
;-> 11 89L
;-> (89L)
;-> 12 144L
;-> (2L 2L 2L 2L 3L 3L)
;-> 13 233L
;-> (233L)
;-> ...
;-> 83 99194853094755497L
;-> (99194853094755497L)
;-> 84 160500643816367088L
;-> (2L 2L 2L 2L 3L 3L 13L 29L 83L 211L 281L 421L 1427L)
;-> 85 259695496911122585L
;-> (5L 1597L 9521L 3415914041L)
;-> 86 420196140727489673L
;-> (6709L 144481L 433494437L)
;-> 87 679891637638612258L
;-> (2L 173L 514229L 3821263937L)
;-> 88 1100087778366101931L
;-> (3L 7L 43L 89L 199L 263L 307L 881L 967L)
;-> 89 1779979416004714189L
;-> (1069L 1665088321800481L)
;-> 90 2880067194370816120L
;-> (2L 2L 2L 5L 11L 17L 19L 31L 61L 181L 541L 109441L)
;-> 91 4660046610375530309L
;-> (13L 13L 233L 741469L 159607993L)
;-> 92 7540113804746346429L
;-> (3L 139L 461L 4969L 28657L 275449L)
;-> 93 12200160415121876738L
;-> (2L 557L 2417L 4531100550901L)
;-> 94 19740274219868223167L
;-> (2971215073L 6643838879L)
;-> 95 31940434634990099905L
;-> (5L 37L 113L 761L 29641L 67735001L)
;-> 96 51680708854858323072L
;-> (2L 2L 2L 2L 2L 2L 2L 3L 3L 7L 23L 47L 769L 1103L 2207L 3167L)
;-> 97 83621143489848422977L
;-> (193L 389L 3084989L 361040209L)
;-> 98 135301852344706746049L
;-> (13L 29L 97L 6168709L 599786069L)
;-> 99 218922995834555169026L
;-> (2L 17L 89L 197L 19801L 18546805133L)
;-> 100 354224848179261915075L
;-> (3L 5L 5L 11L 41L 101L 151L 401L 3001L 570601L)
;-> (3L 5L 5L 11L 41L 101L 151L 401L 3001L 570601L)

Adesso cerchiamo i numeri di Fibonacci che sono anche primi fino a n.

(define (primi-fib n)
  (for (i 2 n)
    (if (= 1 (length (factorbig (fibo-i i))))
      (println i { } (fibo-i i))
    )
  )
)

(primi-fib 50)
;-> 3 2L
;-> 4 3L
;-> 5 5L
;-> 7 13L
;-> 11 89L
;-> 13 233L
;-> 17 1597L
;-> 23 28657L
;-> 29 514229L
;-> 43 433494437L
;-> 47 2971215073L

(time (primi-fib 100))
;-> 3 2L
;-> 4 3L
;-> 5 5L
;-> 7 13L
;-> 11 89L
;-> 13 233L
;-> 17 1597L
;-> 23 28657L
;-> 29 514229L
;-> 43 433494437L
;-> 47 2971215073L
;-> 83 99194853094755497L
;-> 514886.082 ; 8 minuti e 34 secondi

Definiamo una funzione che converte i millisecondi in minuti e secondi:

(define (ms2min ms)
  (let ((mins (/ ms 1000 60))
       (secs (% (/ ms 1000) 60)))
       (println (format "%d millisec = %d minuti e %d secondi." ms mins secs))
       (list mins secs)
  )
)

(ms2min 514886.082)
;-> 514886 millisec = 8 minuti e 34 secondi.

Sequenza OEIS dei numeri di Fibonacci primi:

2, 3, 5, 13, 89, 233, 1597, 28657, 514229, 433494437, 2971215073,
99194853094755497, 1066340417491710595814572169,
19134702400093278081449423917,

Nota: MAXINT = 9223372036854775807 e MININT = -9223372036854775808

Usiamo la funzione "factor" al posto di "factorbig", ma possiamo arrivare solo fino a n = 92:

(- (fibo-i 92) 9223372036854775807)
;-> -1683258232108429378L

(- (fibo-i 93) 9223372036854775807)
;-> 2976788378267100931L

(define (primi-fib2 n)
  (for (i 2 n)
    (if (= 1 (length (factor (fibo-i i))))
      (println i { } (fibo-i i))
    )
  )
)

(time (primi-fib2 92))
;-> 3 2L
;-> 4 3L
;-> 5 5L
;-> 7 13L
;-> 11 89L
;-> 13 233L
;-> 17 1597L
;-> 23 28657L
;-> 29 514229L
;-> 43 433494437L
;-> 47 2971215073L
;-> 83 99194853094755497L
;-> 1718.801

Il prossimo numero di Fibonacci primo vale:

(fibo-i 131)
;-> 1066340417491710595814572169L)

Vediamo quanto tempo impiega la funzione "factorbig" per verificarlo:

(time (println (factorbig 1066340417491710595814572169L)))

Tanto tanto tempo...


-----
Quine
-----

Un Quine è un programma autoreferenziale che stampa, senza alcun input, il proprio sorgente.
Il nome "quine" fu coniato da Douglas Hofstadter, nel suo famoso libro di scienze "Gödel, Escher, Bach: Un Eterna Ghirlanda Brillante", in onore del filosofo Willard Van Orman Quine (1908–2000), che i coniò l'espressione paradossale "Yields falsehood when appended to its own quotation", yields falsehood when appended to its own quotation, ovvero "Produce una falsità se preceduto dalla propria citazione" produce una falsità se preceduto dalla propria citazione.

Uno degli esempi più famosi (scritto da Chris Hruska) è il seguente:

((lambda (x) (list x (list 'quote x))) '(lambda (x) (list x (list 'quote x))))
;-> ((lambda (x) (list x (list 'quote x))) '(lambda (x) (list x (list 'quote x))))

Infatti valutando l'espressione nella REPL si ottiene come output l'espressione stessa.

Anche il creatore di LISP ha creato un quine (John McCarthy e Carolyn Talcott):

((lambda (x)
   (list x (list (quote quote) x)))
  (quote
     (lambda (x)
       (list x (list (quote quote) x)))))
;-> ((lambda (x) (list x (list (quote quote) x))) (quote (lambda (x) 
;->        (list x (list (quote quote) x)))))

Continuiamo con un altro esempio:

((lambda (x) (list x x)) (lambda (x) (list x x)))
;-> ((lambda (x) (list x x)) (lambda (x) (list x x)))

In newLISP, Lutz Mueller (il creatore del linguaggio) ha creato il più corto programma quine:

(lambda (x))
;-> (lambda (x))

Perché in newLISP le espressioni lambda valutano/ritornano a se stesse.

Anche il seguente potrebbe essere un quine (se fossero ammissibili i programmi errati):

ERR: context expected : ERR:
;-> ERR: context expected : ERR:

Invece il seguente è sicuramente un quine:

(lambda (s) (print (list s (list 'quote s))))
;-> (lambda (s) (print (list s (list 'quote s))))


-----------------------------
I buchi delle cifre numeriche
-----------------------------

Quale numero viene dopo la sequenza: 1, 4, 8, 48, 88, 488, ...

Notiamo che 1 non a buchi, 4 ha un buco, 8 ha due buchi, 48 ha tre buchi, 88 ha quattro buchi, 488 ha cinque buchi, quindi il prossimo numero è 888 perchè è il più piccolo numero che ha sei buchi.

Quindi il problema è quello di trovare il numero intero più piccolo con n buchi nelle sue cifre decimali.

Definiamo una lista associativa in cui ci sono due valori (x y), dove x è la cifra numerica e y è il numero di buchi della cifra:

(setq buchi '((0 1) (1 0) (2 0) (3 0) (4 1) (5 0) (6 1) (7 0) (8 2) (9 1)))
(lookup 1 buchi)
;-> 0
(lookup 8 buchi)
;-> 2

La seguente espressione converte un numero in una lista di cifre:

(map int (explode (string 1234)))
;-> (1 2 3 4)

Adesso scriviamo la funzione:

(define (holesequence num)
  (local (val out)
    (setq val 0 out '())
    (dotimes (n num)
      ;somma dei buchi di tutte le cifre che compongono il numero n
      (if (= val (apply +
            (map (fn (x) (lookup x buchi)) (map int (explode (string n))))))
          (begin (push (list val n) out -1) (++ val)))
    )
    out
  )
)

(holesequence 100000)
;-> ((0 1) (1 4) (2 8) (3 48) (4 88) (5 488)
;->  (6 888) (7 4888) (8 8888) (9 48888))

1  ha 0 (zero) buchi
4  ha 1 (uno) buco
8  ha 2 (due) buchi
48 ha 3 (tre) buchi
88 ha 4 (quattro) buchi
...


-------------------
Ordinare tre numeri
-------------------

Esercizio preso dal libro di Bjarne Stroustrup "Principles and Practice Using C++".

Scrivere una funzione che prende 3 valori interi e li stampa in ordine crescente.

Esempio: 
input = 10 4 6
output = 4 6 10

È possibile utilizzare solo le seguenti istruzioni:

1) if
2) cond
3) setq
4) println
5) local
6) let

(define (ordina x y z)
  (local (a b c)
    (setq a 0 b 0 c 0) ; al termine: a <= b <= c
    (cond ((and (<= x y) (<= x z)) ; x è minore di y e di z
           (setq a x) ; x è il più piccolo
           ; quale dei due numeri rimanenti è minore?
           (if (<= y z) (setq b y c z) (setq c y b z)))
          ((and (<= y x) (<= y z)) ; y è minore di x e di z
           (setq a y) ; y è il più piccolo
           ; quale dei due numeri rimanenti è minore?
           (if (<= x z) (setq b x c z) (setq c x b z)))
          (true                    ; z è minore di x e di y
           (setq a z) ; z è il più piccolo
           ; quale dei due numeri rimanenti è minore?
           (if (<= x y) (setq b x c y) (setq c x b y)))
    )
    (println a { } b { } c)
  )
)

(ordina 10 4 6)
;-> 4 6 10

(ordina 4 6 10)
;-> 4 6 10

(ordina 10 6 4)
;-> 4 6 10


----------------
Conteggio strano
----------------

Una bambina conta sulle dita di una mano partendo da 1 sul pollice, 2 sul dito indice, 3 sul medio, 4 sul dito anulare e 5 sul mignolo. Quindi torna indietro nella stessa mano, contando 6 sul'anulare, 7 sul medio, 8 sull'indice e 9 sul pollice. Poi continua indefinitamente contando sempre nello stesso modo. Scrivere un programma che, dato un numero intero n, determina su quale dito terminerà quando il  conteggio raggiunge n.

Il conteggio procede nel modo seguente:

 a   b   c   d   e
POL IND MED ANU MIG
 1   2   3   4   5
 9   8   7   6
    10  11  12  13
17  16  15  14
    18  19  20  21
25  24  23  22
    26  27  28  29
33  32  31  30
    34  35  36  37

Il pattern è il seguente:

  1       5   6     9      13  14      18    21  22    25      29  
("a b c d e" "d c b a b c d e" "d c b a b c d e" "d c b a b c d e")
              1 2 3 4 5 6 7 8   9    12      16  17    20  22  24   

A parte i primi cinque numeri, troviamo sempre una sequenza ripetuta: "d c b a b c d e".

Quindi risulta che ((n-5) mod 8) indica la posizione (indice) nella sequenza ripetuta:

resto:     1 2 3 4 5 6 7 0
sequenza: "d c b a b c d e"

Possiamo scrivere la funzione:

(define (mano n)
  (cond ((<= n 5) 
         (cond ((= n 1) 'pollice)
               ((= n 2) 'indice)
               ((= n 3) 'medio)
               ((= n 4) 'anulare)
               ((= n 5) 'mignolo)))
        ((= 1 (% (- n 5) 8)) 'anulare)
        ((= 2 (% (- n 5) 8)) 'medio)
        ((= 3 (% (- n 5) 8)) 'indice)
        ((= 4 (% (- n 5) 8)) 'pollice)
        ((= 5 (% (- n 5) 8)) 'indice)
        ((= 6 (% (- n 5) 8)) 'medio)
        ((= 7 (% (- n 5) 8)) 'anulare)
        (true 'mignolo)
  )
)

(mano 36)
;-> anulare

(mano 8)
;-> indice

(mano 1000)
;-> indice

Possiamo scrivere la funzione in maniera concisa:

(define (hand n)
  (let ((fingers1 '(pollice indice medio anulare mignolo))
        (fingers2 '(mignolo anulare medio indice pollice indice medio anulare)))
       (if (<= n 5)
           (fingers1 (- n 1))
           (fingers2 (% (- n 5) 8))
       )
  )
)

(hand 36)
;-> anulare

(hand 8)
;-> indice

(hand 1000)
;-> indice

(hand 5)
;-> mignolo


