===============

 NOTE LIBERE 7

===============

------------------------------
Hash-Map Quick Reference Guide
------------------------------

Creazione di una hash-map:

(new Tree 'myhash)
;-> myhash

(for (i 16 256) (println (char i)))

Funzione per creare una hash-map:

(define (new-hash str) (new Tree (sym str)))

(new-hash "pippo")

oppure:

;(new-hash 'pippo)

(pippo "1" "a")
;-> "a"
(pippo)
;-> (("1" "a"))

Altra funzione per creare un contesto/hash-map (Lutz):

(define (create-context-from-name str)
   (sym str (sym str MAIN))
)

Eliminazione di una hash-map:

(delete 'myhash)
;-> true

Funzione per eliminare una hash-map:

(define (del-hash str) (delete (sym str)))
(del-hash "pippo")
;-> true
(pippo)
;-> ERR: invalid function : (pippo)

(del-hash "boh")
;-> true

Inserimento di una coppia (chiave-valore) nella hash-map:

(new Tree 'myhash)
(myhash "1" "a")
;-> "a"
(myhash "2" "b")
;-> "b"

Aggiornamento di un valore di una chiave utilizzando il valore attuale:

(myhash "2" (string "a" (myhash "2")))
;-> "ab"

Elenco delle coppie in una hash-map:

(myhash)
;-> (("1" "a") ("2" "ab"))

Aggiornamento di un valore di una chiave:

(myhash "2" "b")
;-> "b"

Eliminazione di una coppia (chiave-valore) nella hash-map:

(myhash "1" nil)
;-> nil
(myhash)
;-> (("2" "b"))

(myhash "1" "a")
;-> "a"

Lunghezza di una hash-map:

(length (myhash))
;-> 2

Funzione che elenca le coppie chiave-valore di una hash-map:

(define (list-hash str)
  (eval-string (append "(" (string str) ")")))

(list-hash myhash)
;-> (("1" "a") ("2" "b"))

Creazione di hash-map da una variabile:

(setq a "demo")
(new Tree (sym (eval a)))
(demo)
;-> ()

(setq a "prova")
(new-hash a)
(prova)
;-> ()

Ricerca di una chiave sulla hash-map:

(myhash "1")
;-> "a"
(myhash 1)
;-> "a"
(myhash "a")
;-> nil
(myhash "4")
;-> nil
(true? (myhash "1"))
;-> true

Una hash-map non è una lista, ma possiamo usare lo stesso dolist per elencare tutte le coppie chiave-valore:

(list? myhash)
;-> nil
(dolist (cp (myhash)) (println (list (cp 0) (cp 1))))
;-> ("1" "a")
;-> ("2" "b")

Per creare una lista di associazione da una hash-map basta assegnare la valutazione della hash-map ad una variabile:

(setq alst (myHash))
;-> (("#1234" "hello world") ("1" "uno") ("_y" (1 2))
;->  ("il numero" 123) ("var" (a b c d)) ("x" "stringa"))

(list? alst)
;-> true

Per popolare una hash-map possiamo anche usare una lista associativa (chiave valore):

(myhash '((3 4) (5 6)))
;-> myhash

(myhash)
;-> (("1" "a") ("2" "b") ("3" 4) ("5" 6))

Nota: le chiavi del dizionario sono ordinate in maniera lessicografica.

Cosa accade alle liste che hanno valori della chiave ripetuti?

Nella lista seguente le chiavi "1" e "3" sono ripetute:

(setq lst '(("4" 4) ("1" 0) ("2" 2) ("3" 0) ("1" 1) ("3" 3) ("5" 5)))

Quando assegniamo la lista ad una hash-map i valori con chiave multipla vengono memorizzati soltanto una volta...ma quali elementi sceglie e quali elimina newLISP?
Facciamo una prova:

(new Tree 'hash)
(hash lst)
;-> hash
(hash)
;-> (("1" 1) ("2" 2) ("3" 3) ("4" 4) ("5" 5))

Gli elementi ("1" 0) e ("3" 0) sono stati eliminati... cioè quelli che si trovavano prima.
In newLISP la hash-map inserisce gli elementi partendo dal fondo della lista (poi nella hash-map gli elementi sono ordinati in base alla chiave). Quindi quando incontra elementi multipli prende l'ultimo che compare nella lista (cioè il primo partendo dal fondo della lista).

Lista di tutti i simboli di una hash-map (contesto):

(symbols myhash)
;-> (myhash:_1 myhash:_2 myhash:_3 myhash:_5 myhash:myhash)

Nota: Le chiavi (simboli) vengono memorizzate precedute dal contesto e dal carattere underscore "_".

le espressioni hash restituiscono un riferimento al loro contenuto che può essere modificato direttamente:

(pop (myHash "var"))
;-> a

(myHash "var")
;-> (b c d)

(push 'z (myHash "var"))
;-> (z b c d)

(myHash "var")
;-> (z b c d)

Quando si impostano i valori hash, la variabile anaforica di sistema "$it" può essere utilizzata per riferirsi al vecchio valore quando si imposta il nuovo:

(myhash "bar" "hello world")
;-> "hello world"

(myhash "bar" (upper-case $it))
;-> "HELLO WORLD"

(myhash "bar")
;-> "HELLO WORLD"

Le hash-map possono essere salvate in un file e ricaricate in un secondo momento:

; save dictionary
(save "myhash.lsp" 'myhash)
;-> true

Caricamento di una hash-map dal file "myhash.lsp":

(load "myhash.lsp")
;-> MAIN
(myhash)
(("1" "a") ("2" "b") ("3" 4) ("5" 6) ("bar" "HELLO WORLD"))

Per ulteriori informazioni, vedere "Hash-map e contesti" nel file "13-note-libere-5.lsp".


-------------------------------------
Hash-Map General management functions
-------------------------------------

Alcune funzioni generali per la gestione delle hash-map:

HASH-CREATE: Creazione di una hash-map
HASH-SET: Inserimento di una coppia (chiave-valore)
HASH-GET-VAL: Lettura di un valore tramite chiave
HASH-GET-KEY: Lettura di una chiave tramite valore
HASH-KEYS: Lista di tutte le chiavi
HASH-VALUES: Lista di tutti i valori
HASH-ITEMS: Lista associativa di tutti gli elementi (coppie chiave-valore)
HASH-DEL: Eliminazione di un valore tramite chiave
HASH-SIZE: Numero di elementi (coppie chiave-valore)
HASH-KEY?: Chiave esistente?
HASH-VALUE?: Valore esistente?
HASH-EMPTY?: Hash-Map vuota?
HASH-CLEAR: Eliminazione di tutti gli elementi (coppie chiave-valore)
HASH-DESTROY: Eliminazione di una hash-map
HASH-SET-LIST: Inserimento degli elementi (coppie chiave-valore) di una lista associativa
HASH?: Hash-map esistente?
HASH-MAP-LAMBDA: Applica una funzione (kv-fn) agli elementi (coppie chiave-valore)

--------------------------------------
HASH-CREATE: Creazione di una hash-map
--------------------------------------
(define (hash-create x)
  (new Tree (sym x)))

Esempi:
(hash-create 'hh)
;-> hh

;(hash-create "hh")

---------------------------------------------------
HASH-SET: Inserimento di una coppia (chiave-valore)
---------------------------------------------------
(define (hash-set hash key value)
  (hash key value))

Esempi:
(hash-set hh 1 "a")
;-> "a"
(hash-set hh 2 "b")
;-> "b"
(hash-set hh 3 "c")
;-> "c"
(hash-set hh 4 "d")
;-> "d"

-------------------------------------------------
HASH-GET-VAL: Lettura di un valore tramite chiave
-------------------------------------------------
(define (hash-get-val hash key)
  (hash key))

Esempi:
(hash-get-val hh "1")
;-> "a"
(hash-get-val hh 1)
;-> "a"
(hash-get-val hh 5)
;-> nil

--------------------------------------------------
HASH-GET-KEY: Lettura di una chiave tramite valore
--------------------------------------------------
(define (hash-get-key hash value)
  (local (key break)
    (dolist (item (hash) break)
      (if (= (last item) value)
          (set 'key (first item) 'break true)
      )
    )
    key))

Esempi:
(hash-get-key hh "c")
;-> "3"
(hash-get-key hh "z")
;-> nil

Versione alternativa (più lenta):

(define (hash-get-key2 hash value)
    (if (ref value (hash))
        ((hash) (first (ref value (hash))) 0)
        nil))

Nota: questa funzione è molto lenta, come risulta dal seguente esempio,

Creiamo una nuova hash-map:
(new Tree 'ab)
;-> ab

Creiamo una lista di coppie:
(setq lst (map list (map string (randomize (sequence 1 1000))) (sequence 1 1000)))

Assegniamo i valori (1000 coppie) della lista alla hash-map:
(ab lst)

Vediamo il valore associato alla chiave "300":
(ab "300")
;-> 926

Vediamo la chiave associata al valore 926:
(hash-get-key ab 926)
;-> "300"
(hash-get-key2 ab 926)
;-> "300"

Calcoliamo la velocità delle due funzioni:

(time (hash-get-key ab 926) 10000)
;-> 963.984
(time (hash-get-key2 ab 922) 10000)
;-> 2886.201

La funzione inversa, che trova il valore data una chiave, "hash-get-val" è molto più veloce (quasi immediata):

(hash-get-val ab "300")
;-> 926
(time (hash-get-val ab "300") 10000)
;-> 15.585

-----------------------------------
HASH-KEYS: Lista di tutte le chiavi
-----------------------------------
(define (hash-keys hash)
  (map first (hash)))

Esempi:
(hash-keys hh)
;-> ("1" "2" "3" "4")

------------------------------------
HASH-VALUES: Lista di tutti i valori
------------------------------------
(define (hash-values hash)
  (map last (hash)))

Esempi:
(hash-values hh)
;-> ("a" "b" "c" "d")

--------------------------------------------------------------------------
HASH-ITEMS: Lista associativa di tutti gli elementi (coppie chiave-valore)
--------------------------------------------------------------------------
(define (hash-items hash)
  (hash))

Esempi:
(hash-items hh)
;-> (("1" "a") ("2" "b") ("3" "c") ("4" "d"))

--------------------------------------------------
HASH-DEL: Eliminazione di un valore tramite chiave
--------------------------------------------------
(define (hash-del hash key)
  (hash key nil))

Esempi:
(hash-del hh "1")
;-> nil
(hash-del hh 2)
;-> nil
(hash-del hh 5)
;-> nil
(hash-items hh)
;-> (("3" "c") ("4" "d"))

----------------------------------------------------
HASH-SIZE: Numero di elementi (coppie chiave-valore)
----------------------------------------------------
(define (hash-size hash)
  (length (hash)))

Esempi:
(hash-size hh)
;-> 2

----------------------------
HASH-KEY?: Chiave esistente?
----------------------------
(define (hash-key? hash key)
  (if (hash (string key)) true nil))

Esempi:
(hash-key? hh 1)
;-> nil
(hash-key? hh 3)
;-> true
(hash-key? hh "4")
;-> true

------------------------------
HASH-VALUE?: Valore esistente?
------------------------------
(define (hash-value? hash value)
  (let (out nil)
    (dolist (item (hash) out)
      (if (= (last item) value)
          (setq out true)
      )
    )
    out))

Esempi:
(hash-value? hh 3)
;-> nil
(hash-value? hh "c")
;-> true

----------------------------
HASH-EMPTY?: Hash-Map vuota?
----------------------------
(define (hash-empty? hash)
  (empty? (hash)))

Esempi:
(hash-empty? hh)
;-> nil

---------------------------------------------------------------------
HASH-CLEAR: Eliminazione di tutti gli elementi (coppie chiave-valore)
---------------------------------------------------------------------
(define (hash-clear hash)
  (map delete (symbols hash))
  nil)

Esempi:
(hash-create 'aa)
;-> aa
(hash-set aa 1 "x")
;-> "x"
(hash-set aa 2 "y")
;-> "y"
(hash-set aa 3 "z")
;-> "z"
(aa)
;-> (("1" "x") ("2" "y") ("3" "z"))
(hash-clear aa)
;-> nil
(aa)
;-> ()

------------------------------------------
HASH-DESTROY: Eliminazione di una hash-map
------------------------------------------
(define (hash-destroy hash)
  (delete hash) (delete hash))

Esempi:
(aa)
;-> ()
(hash-set aa 1 "x")
;-> "x"
(hash-set aa 2 "y")
;-> "y"
(aa)
;-> (("1" "x") ("2" "y"))
(hash-destroy 'aa)
;-> true
(aa)
;-> ERR: invalid function : (aa)

-----------------------------------------------------------------------------------------
HASH-SET-LIST: inserimento degli elementi (coppie chiave-valore) di una lista associativa
-----------------------------------------------------------------------------------------
(define (hash-set-list hash lst)
  (hash lst))

Esempi:
(hh)
;-> (("3" "c") ("4" "d"))
(setq lista '((1 "A") ("2" "B")))
(hash-set-list hh lista)
;-> hh
(hh)
;-> (("1" "A") ("2" "B") ("3" "c") ("4" "d"))

----------------------
HASH?: hash esistente?
----------------------
(define (hash? hash)
  (and (context? (eval hash))
       (not (list? (eval (sym (term hash) hash nil))))))

Esempi:
(hash? hh)
;-> true
(hash? aa)
;-> nil
(hash? xx)
;-> nil

Come funziona?
Cerchiamo tutti i contesti il cui funtore non è una funzione (list?).
L'espressione (sym (term hash) hash nil) restituisce il funtore hash:hash e poi verifichiamo se tale funtore sia una funzione (in questo caso list? restituisce true) oppure no (in questo caso list? restituisce nil).
Questo metodo identifica correttamente tutte le hash-map create con la funzione "new Tree" (fortemente consigliato).

----------------------------------------------------------------------------------
HASH-MAP-LAMBDA: applica una funzione (kv-fn) agli elementi (coppie chiave-valore)
----------------------------------------------------------------------------------
(define (hash-map-lambda kv-fn hash)
  (let (acc)
    (dotree (h hash true)
      (push (kv-fn (rest (term h)) (eval h)) acc -1))
    acc))

Questa funzione permette di applicare una funzione lambda ("kv-fn") a tutti gli elementi (cioè a tutte le coppie chiave-valore) di una hash-map  (kv-fn --> KeyValue-Function). Il risultato è una lista associativa.

Esempi:
(define (hm-keys hash)
  ;;(map first (hash))
  (hash-map-lambda (fn (key _) key) hash))

(hm-keys hh)
;-> ("1" "2" "3" "4")

(define (hm-values hash)
  (hash-map-lambda (fn (_ value) value) hash))

(hm-values hh)
;-> ("A" "B" "c" "d")

(define (hm-items hash)
  (hash-map-lambda (fn (key value) (list key value)) hash))

(hm-items hh)
;-> (("1" "A") ("2" "B") ("3" "c") ("4" "d"))


-------------------
KiloByte e KibiByte
-------------------

Il computer lavora con un sistema binario (0 e 1) e per consuetudine si è deciso di unire le cifre a gruppi di otto. Ogni gruppo di 8 bit prende il nome di "byte".

Un byte può assumere 256 valori, da 0 (00000000) a 255 (11111111).

Nota: Esiste anche il raggruppamento a 4 bit che prende il nome di "nibble" (mezzo byte).

Come per tutte le grandezze comunemente utilizzate, anche per i byte si utilizzano i moltiplicatori che agevolano la scrittura di numeri grandi, con una piccola differenza: mentre nel caso dei Grammi, dei Metri, dei Volt e di tante altre grandezze fisiche, i prefissi K, M, G, ecc... moltiplicano per un fattore 1000 (che è una potenza di 10), nel caso dei byte il fattore di moltiplicazione è 1024 (che è una potenza di 2).

Quindi, fino al 1998, in informatica si utilizzavano i seguenti moltiplicatori:

1 KByte (KiloByte o KB) = 1024 Byte
1 MByte (MegaByte o MB) = 1024 KByte
1 GByte (GigaByte o GB) = 1024 MByte
1 TByte (TeraByte o TB) = 1024 GByte
ecc...

Quando compriamo una memoria di massa la sua capacità viene espressa con questi moltiplicatori. Però quando inseriamo la nostra memoria su un computer, questo ci informa che la capacità è inferiore. Perchè?
I produttori di memorie dichiarano un hard disk da 2 TB utilizzando il fattore 1000 del sistema decimale (cioè circa 2.000.000.000.000 = duemila miliardi di byte), ma quando viene utilizzato dal computer che, più correttamente, fa i conti nel sistema binario, si ottiene uno spazio libero di 1,82 TB, cioè 2.000.000.000.000∕1024∕1024∕1024∕1024 = 1,818989403545856.

A partire dal 1998, sono stati creati dei moltiplicatori appositi per i Byte (in base 2 anziché base 10) che sono identificati dal suffisso bi (binary):

1 KibiByte (KiB) = 1024 Byte
1 MebiByte (MiB) = 1024 KibiByte
1 GibiByte (GiB) = 1024 MebiByte
1 TebiByte (TiB) = 1024 GibiByte
ecc...

Con questi nuovi moltiplicatori l'informatica dispone delle unità di misura corrette della memoria, mentre i costruttori di memorie di massa continuano ad utilizzare i moltiplicatori in base 10 anziché quelli in base 2.
Comunque i nuovi moltiplicatori non sono entrati nell'uso comune e ognuno continua ad usare il sistema che più gli conviene.

Scriviamo una funzione che converte tra queste due unità di misura (e relativi moltiplicatori):

(setq unit-name '("TB" "GB" "MB" "KB" "Byte"
                  "TiB" "GiB" "MiB" "KiB"))

(setq unit-value '(1e12 1.e9 1e6 1e3 1
      1099511627776 1073741824 1048576 1024))

(define (byte val unit)
  (local (idx scala)
    (setq idx (find unit unit-name))
    (setq scala (mul val (unit-value idx)))
    (println val " " unit " is:")
    (dolist (el unit-name)
      (cond ((!= el unit)
            (println (format "%.6f %s" (div scala (unit-value $idx)) el)))
      )
    )))

(byte 2 "TB")
;-> 2 TB is:
;-> 2000.000000 GB
;-> 2000000.000000 MB
;-> 2000000000.000000 KB
;-> 2000000000000.000000 Byte
;-> 1.818989 TiB
;-> 1862.645149 GiB
;-> 1907348.632813 MiB
;-> 1953125000.000000 KiB


--------------------
Blog di Cyril Zlobin
--------------------

Cyril Zlobin scrive un blog su newLISP al seguente indirizzo web:

https://slobin.livejournal.com/tag/lispa%C4%B5oj

Purtoppo non è di facile consultazione perchè è scritto in russo.

Vediamo un post interessante:

Le parentesi non spaventano un vero fanatico di Lisp. Eppure, a volte, in alcuni contesti, sembrano superflue. Proviamo a mettere in evidenza un metodo utile. Scriviamo una macro di sei righe:

(define-macro (make-pass)
  (doargs (arg)
    (letex ((Old arg)
      (New (sym (append (string arg) "&"))))
      (define-macro (New)
        (Old (eval (args)))))))

Trattiamo le funzioni di cui abbiamo bisogno:

(make-pass catch not print)

catch&
;-> (lambda-macro () (catch (eval (args))))
not&
;-> (lambda-macro () (not (eval (args))))
print&
;-> (lambda-macro () (print (eval (args))))

E poi le usiamo in questo modo:

(catch& while (read-line)
  (setq line (current-line))
  (if (not& empty? line)
    (print& format "%s \n" line)
  (throw 'empty)))

Possiamo pensare che le funzioni che terminano con il carattere ampersand "&" combinano due funzioni in una.


-------------------
Lambda the Ultimate
-------------------

Traduzione da "Lambda the Ultimate" di William Cushing

https://softwareengineering.stackexchange.com/questions/107687/what-is-the-origin-and-meaning-of-the-phrase-lambda-the-ultimate

Lambda The Ultimate si riferisce all'idea che le funzioni lambda del lambda-calcolo possono implementare efficacemente ogni concetto di ogni linguaggio di programmazione. Classi, Moduli, Package, Oggetti, Metodi, Flussi di controllo, Strutture dati, MAcro, Continuazioni, Coroutine, Generatori, List comprehensions, Stream, ecc.

Guarda caso, quella natura ultima consiste nella creazione di una funzione anonima (Anonymous Function). Ma le lambda non sono, in sostanza, limitate alle sole funzioni anonime. Viene insegnato in questo modo, ma l'essenza di lambda va molto più in profondità delle funzioni matematiche senza nomi. In altre parole, parliamo di:

  "Capisco cosa significhi "lambda", l'idea di una funzione anonima è sia semplice che potente, ma non riesco a capire cosa significhi "the ultimate" in questo contesto".

In pratica, l'uso di lambda come astrazioni sintattiche ("macro"), che non sono call-by-value (quali sono le funzioni matematiche), è assolutamente cruciale per accettare l'idea che le lambda possano davvero fungere da nucleo di ogni sistema di elaborazione del linguaggio di programmazione.

Per la teoria: c'è un collegamento interessante con il paradosso di Bertrand Russell e gli assiomi di comprensione (ed estensione) nella teoria degli insiemi. Un lambda è per le funzioni ciò che la notazione del generatore di insiemi è per gli insiemi: i lambda sono una notazione per generare funzioni. C'è una differenza importante, solitamente ignorata, tra (lambda (x) (* x x)) e ciò che restituisce (la funzione che calcola il quadrato). Se non si riesce in generale a distinguere tra i due, cioè tra la notazione e la denotazione (un errore commesso anche da Church e Frege), allora si entra in conflitto con i paradossi. Per gli insiemi e per Frege, è il Barbiere di Siviglia di Bertrand Russell a illustrare l'errore, mentre per le funzioni e Church, è l'oracolo di halting di Alan Turing.

Nota che i paradossi sono cose buone, pratiche. Vogliamo che EVAL sia esprimibile e vogliamo che lambda significhi qualcosa di più delle semplici funzioni. Che supporre il contrario porti alla contraddizione è il risultato desiderabile, serve come un bel test di sanità mentale: i lambda difficilmente possono essere definitivi/fondamentali se esprimono solo mere funzioni.

"Racket" (precedentemente PLT Scheme) continua a perseguire l'idea che i linguaggi di programmazione pratici possano davvero essere costruiti, da zero, con "just lambda" (http://racket-lang.org/).

"Kernel", di Shutt, sostiene che lambda non è davvero l'astrazione definitiva. Sostiene che esiste un concetto ancora più primitivo (soprannominato vau) che era noto a Sussman come FEXPR (http://www.wpi.edu/Pubs/ETD/Available/etd-090110-124904/).

Felleisen e compagnia (per Racket) ottengono gran parte della potenza del vau di Shutt usando il concetto di fasi, o metalivelli, che approssimativamente significa eseguire il codice sorgente attraverso più fasi di traduzione (come con la preelaborazione C, ma usando la stessa linguaggio in ogni 'passo' e i 'passi' non sono in realtà del tutto distinti nel tempo). (Quindi, sostengono che un lambda in una fase superiore approssima abbastanza bene un vau). In effetti, sostengono che le fasi sono migliori delle FEXPR, proprio per essere più limitate: in breve, "le FEXPR sono troppo potenti" (vedi il lavoro di Wand, contro il quale Shutt si oppone).

Il Lisp-3 di Brian Smith, "Procedural reflection in programming languages", tenta una rigorosa riformulazione della teoria dei linguaggi simili a LISP lungo le linee di una netta distinzione tra le notazioni (simboli/linguaggio/programmi) e le denotazioni (cose/riferimenti/valori/risultati). http://dspace.mit.edu/handle/1721.1/15961

"The Theory of FEXPRs is Trivial" di Mitchell Wand manda più chiodi nella bara (temporanea?) che Kent Pittman ha costruito per i FEXPR (che, come Felleisen, si oppone ai FEXPR perché rendono la compilazione troppo difficile).

Paul Graham sostiene con forza e a lungo in "On Lisp" che il vero potere sono i lambda come trasformatori di sintassi (macro), piuttosto che come trasformatori di valori (funzioni matematiche). Lo sviluppo di Plotkin del calcolo lambda applicativo potrebbe essere considerato in qualche modo contrastante, perché Plotkin limita il calcolo di Church al suo sottoinsieme call-by-value/applicativo. Naturalmente, gestire la parte applicativa in modo efficiente è molto importante, quindi è importante sviluppare una teoria specializzata per quell'uso di lambda. (Plotkin e Graham non discutono l'uno contro l'altro.)

In effetti, in generale, la nozione di Lambda come Ultimate è solo una questione nell'eterno dibattito tra efficienza ed espressività. La posizione è che lambda è lo strumento definitivo per l'espressività e, con uno studio sufficiente, alla fine si rivelerà anche lo strumento definitivo per l'efficienza. In altre parole, possiamo, se vogliamo, vedere il futuro dei linguaggi di programmazione come niente di più e niente di meno che lo studio di come implementare in modo efficiente tutti i frammenti praticamente rilevanti del calcolo lambda.

"The Next 700 Programming Languages" di Landin, http://www.cs.cmu.edu/~crary/819-f09/Landin66.pdf, è un riferimento accessibile che contribuisce allo sviluppo del concetto che Lambda è Ultimate.


-------------------------------------
Stati, Transizioni e catene di Markov
-------------------------------------

Una catena di Markov può essere pensata come descrizione probabilistica che alcuni eventi si verifichino seguiti da altri eventi. Più matematicamente, descrive le probabilità associate ad uno stato di un sistema di passare a qualsiasi altro stato.
Ad esempio, supponiamo che un sistema con tre stati abbia le seguenti probabilità di transizione:

  (A, A, 0.9)
  (A, B, 0.075)
  (A, C, 0.025)
  (B, A, 0.15)
  (B, B, 0.8)
  (B, C, 0.05)
  (C, A, 0.25)
  (C, B, 0.25)
  (C, C, 0.5)

Ciò indica che se iniziamo con lo stato A, dopo una transizione c'è una probabilità del 90% che lo stato rimanga in A, una probabilità del 7,5% che lo stato cambi in B e un 2,5% che lo stato cambi in C.

Dato uno stato iniziale, una lista con le probabilità di transizione e un numero di transizioni, eseguire la catena di Markov associata fino al numero di transizioni dato e determinare lo stato finale.

Inoltre, calcolare la frequenza di ogni stato per un dato numero di iterazioni della catena di Markov.

Sostituiamo A,B e C con 0,1,2 e rappresentiamo la catena con un grafo:

                       0.025
        >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        |                                 |
        |      0.15     0.8     0.25      |
      +---+ <--------- +---+ <--------- +---+
  0.9 | 0 |            | 1 |            | 2 | 0.5
      +---+ ---------> +---+ ---------> +---+
        |     0.075             0.05      |
        |              0.25               |
        <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

Le probabilità di transizione sono:

  0 -> 0 con probabilità = 0.9
  0 -> 1 con probabilità = 0.075
  0 -> 2 con probabilità = 0.025
  1 -> 0 con probabilità = 0.15
  1 -> 1 con probabilità = 0.8
  1 -> 2 con probabilità = 0.05
  2 -> 0 con probabilità = 0.25
  2 -> 1 con probabilità = 0.25
  2 -> 2 con probabilità = 0.5

Nota: la somma delle probabilità di transizione associate ad ogni stato deve essere uguale ad 1:

  P(0) = 0.9 + 0.075 + 0.025 = 1
  P(1) = 0.15 + 0.8 + 0.05 = 1
  P(2) = 0.25 + 0.25 + 0.5 = 1

Rappresentiamo gli stati e le relative probabilità di transizione con la lista seguente:

(setq states '((0 (0.9 0.075 0.025))
               (1 (0.15 0.8 0.05))
               (2 (0.25 0.25 0.5))))

Nota: in genere le probabilità di transizione vengono rappresentate con una matrice.

Definiamo una funzione che passa da uno stato ad un altro stato:

(define (next-state cur-state probs)
  (local (rnd stop prob res)
    ; generiamo un numero random
    ; diverso da 1
    (while (= (setq rnd (random)) 1))
    (setq stop nil)
    (setq prob (last (states cur-state)))
    (dolist (p prob stop)
      ; sottraiamo la probabilità corrente al numero random...
      (setq rnd (sub rnd p))
      ; se il risultato è minore di zero, 
      ; allora restituiamo l'indice della probabilità
      (if (< rnd 0)
          (set 'res $idx 'stop true)
      )
    )
    res))

(define (markov states start step iter)
  (local (probs freq)
    ; estrazione lista delle probabilità
    (setq probs '())
    (dolist (s states)
      (push (last s) probs -1)
    )
    ; vettore delle frequenze degli stati finali
    (setq freq (array (length states) '(0)))
    (for (i 1 iter)
      (setq cur-state start)
      (for (t 1 step)
        ;(setq prob (lookup cur-state states))
        ;(setq prob (last (states cur-state)))
        (setq cur-state (next-state cur-state prob))
      )
      ; aggiorna frequenza dello stato finale
      (++ (freq cur-state))
    )
    ; controllo di correttezza
    ;(println (apply + freq))
    freq))

Testiamo la funzione con degli stati che hanno probabilità di transizione su se stessi pari a 1. In questo modo dopo qualunque numero di transizioni deve risultare lo stesso stato iniziale.

(setq test '((0 (0 1 0))
             (1 (0 1 0))
             (2 (0 1 0))))

(markov test 0 100 100000)
;-> (100000 0 0)
(markov test 1 100 100000)
;-> (0 100000 0)
(markov test 2 100 100000)
;-> (0 0 100000)

Altro test con probabilità di transizione verso altri stati pari a 0.5:

(setq test '((0 (0   0.5 0.5))
             (1 (0.5 0   0.5))
             (2 (0.5 0.5 0))))

(markov test 0 100 100000)
;-> (33229 33450 33321)
(markov test 1 100 100000)
;-> (33299 33437 33264)
(markov test 2 100 100000)
;-> (33226 33430 33344)

Adesso proviamo la funzione con i valori di probabilità del problema:

(setq states '((0 (0.9 0.075 0.025))
               (1 (0.15 0.8 0.05))
               (2 (0.25 0.25 0.5))))

Con 100 transizioni partendo da ogni stato otteniamo:

(markov states 0 100 100000)
;-> (62389 31312 6299)
62389 volte stato finale = 0
31312 volte stato finale = 1
 6299 volte stato finale = 2

(markov states 1 100 100000)
;-> (62418 31220 6362)

(markov states 2 100 100000)
;-> (62627 31239 6134)


------------------------------------
Modifica di una lista con un pattern
------------------------------------

Supponiamo di avere una lista con degli elementi qualsiasi:

(setq lst '(A 1 B 2 "1" "2" A 1 2 B 3.14))

Un pattern, cioè una lista di elementi:

(setq pat '(A 1))

E una lista di sostituzione (replace):

(setq rep '(X Y))

Quello che vogliamo ottenere è una nuova lista dove tutte le sequenze del pattern (A 1) sono sostituite dalla lista di sostituzione (replace):

  (X Y B 2 "1" "2" X Y 2 B 3.14)

La funzione è la seguente con le spiegazioni nei commenti:

(define (replace-pattern pat lst rep)
  ; se il pattern è un carattere,
  ; allora usiamo la funzione built-in "replace"
  (if (= (length pat) 1)
      (replace (first pat) lst (first rep))
      ; altrimenti...
  (local (idx end found end-pat stop)
    (setq idx 0)
    (setq end (- (length lst) (length pat)))
    ; ciclo per tutta la lista lst
    (while (<= idx end)
      ; se elemento corrente = primo elemento pattern
      (if (= (lst idx) (pat 0))
        (begin
          ; controlla se sono uguali i successivi elementi
          ; della lista con i successivi elementi del pattern
          (setq end-pat (- (length pat) 1))
          (setq found true)
          (setq stop nil)
          (setq k 1)
          (for (i (+ idx 1) (+ idx end-pat) 1 stop)
            ; basta un elemento diverso per 
            ; stabilire che il pattern è diverso
            (if (!= (lst i) (pat k))
                (set 'found nil 'stop true)
            )
            ; aumenta indice della lista pat
            (++ k)
          )
          ; se il pattern è stato trovato,
          ; allora modifichiamo gli elementi della lista lst
          ; con gli elementi della lista rep
          (if found
            (begin
              (setq k 0)
              (for (i idx (+ idx end-pat))
                (setf (lst i) (rep k))
                ; aumenta indice della lista pat
                (++ k)
              )
            )
          )
        )
      )
      ; aumenta indice della lista lst
      (++ idx)
    )
    lst)))

Facciamo alcune prove:

(setq lst '(A 1 B 2 "1" "2" A 1 2 B 3.14))
(setq pat '(A 1))
(setq rep '(X Y))
(replace-pattern pat lst rep)
;-> (X Y B 2 "1" "2" X Y 2 B 3.14)

(setq lst '(A 1 B 2 "1" "2" A 1 2 B 3.14))
(setq pat '(B 3.14))
(setq rep '(X Y))
(replace-pattern pat lst rep)
;-> (A 1 B 2 "1" "2" A 1 2 X Y)

(setq lst '(A 1 B 2 "1" "2" A 1 2 B 3.14))
(setq pat '(2 "1"))
(setq rep '(X Y))
(replace-pattern pat lst rep)

(setq lst '(-8 6 -4 8 3 4 0 2 4 8 3))
(setq pat '(4 8 3))
(setq rep '(0 0 0))
(replace-pattern pat lst rep)
;-> (-8 6 -4 8 3 4 0 2 0 0 0)

(setq lst '(-8 6 4 8 3 4 0 2 4 8 3))
(setq pat '(4 8 3))
(setq rep '(0 0 0))
(replace-pattern pat lst rep)
;-> (-8 6 0 0 0 4 0 2 0 0 0)

(setq lst '(-8 6 4 8 3 4 0 2 4 8 3))
(setq pat '(-8 6 4 8 3 4 0 2 4 8))
(setq rep '(0 0 0 0 0 0 0 0 0 0))
(replace-pattern pat lst rep)
;-> (0 0 0 0 0 0 0 0 0 0 3)

(setq lst '(-8 6 4 8 3 4 0 2 4 8 3))
(setq pat '(-8 6 4 8 3 4 0 2 4 8 3))
(setq rep '(0 0 0 0 0 0 0 0 0 0 0))
(replace-pattern pat lst rep)
;-> (0 0 0 0 0 0 0 0 0 0 0)

(setq lst '(-8 6 4 8 3 4 0 2 4 8 3))
(setq pat '(4 8 1))
(setq rep '(0 0 0))
(replace-pattern pat lst rep)
;-> (-8 6 4 8 3 4 0 2 4 8 3)

(setq lst '(-8 6 4 8 3 4 0 2 4 8 3))
(setq pat '(4))
(setq rep '(A))
(replace-pattern pat lst rep)
;-> (-8 6 A 8 3 A 0 2 A 8 3)

(setq lst '(-8 6 4 8 3 4 0 2 4 8 4 8))
(setq pat '(4 8))
(setq rep '(B B))
(replace-pattern pat lst rep)
;-> (-8 6 B B 3 4 0 2 B B B B)


--------------------
Fisher-Yates shuffle
--------------------

Data una lista di n elementi, scrivere una funzione che "mescola" gli elementi della lista in modo casuale (uniforme).

Come primo approccio usiamo la seguente procedura:

- attraversare la lista (con indice idx)
- generare un numero random j tra 0 e (n - 1) (compreso)
- scambiare i valori di lst(idx) e lst(j)

(define (shuffle1 lst)
  (local (len j)
    (setq len (length lst))
    (for (idx 0 (- len 1))
      (setq j (rand len))
      (swap (lst idx) (lst j))
    )
    lst))

Proviamo la funzione:

(setq lst (sequence 1 10))
;-> (1 2 3 4 5 6 7 8 9 10)
(shuffle1 lst)
;-> (1 3 6 7 5 2 9 10 8 4)
(shuffle1 lst)
;-> (7 10 8 3 6 2 4 5 9 1)
(shuffle1 lst)
;-> (2 3 5 6 4 8 1 7 10 9)

Sembra che i risultati siano corretti, ma dobbiamo ancora verificare se la procedura genera risultati uniformi. Per fare questo usiamo una lista con tre elementi:

(setq lst '(1 2 3))

Applichiamo la funzione "shuffle1" per "iter" volte e calcoliamo la frequenza dei risultati che possono essere 6: (1 2 3), (1 3 2), (2 1 3), (2 3 1), (3 1 2), (3 2 1)

(define (test1 iter)
  (local (res freq out)
    (setq res '((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1)))
    (setq freq (array 6 '(0)))
    (for (i 1 iter)
      (++ (freq (find (shuffle1 lst) res)))
    )
    freq))

(test1 100000)
;-> (14742 18437 18564 18587 14913 14757)

Il risultato non sembra uniforme. Perchè?
La procedura scambia tre volte (cioè quanti sono gli elementi), quindi ci sono 3^3 = 27 possibili risultati (di cui alcuni uguali). Abbiamo visto che gli unici risultati possibili sono 6, un numero che non divide esattamente 27, quindi alcuni risultati sono in numero maggiore.

Per rendere la funzione uniforme occorre che la probabilità di scegliere un qualunque indice/elemento valga 1/n. Questo può essere fatto con la seguente procedura (algoritmo di Fisher-Yates):

- attraversare la lista (con indice idx)
- generare un numero random j tra idx e (n - 1) (compreso)
- scambiare i valori di lst(idx) e lst(j)

(define (shuffle2 lst)
  (local (len j)
    (setq len (length lst))
    (for (idx 0 (- len 1))
      (setq j (+ idx (rand (- len idx))))
      (swap (lst idx) (lst j))
    )
    lst))

Proviamo la funzione:

(setq lst (sequence 1 10))

(shuffle2 lst)
;-> (4 9 5 2 6 3 8 1 7 10)
(shuffle2 lst)
;-> (7 8 3 5 10 1 4 9 6 2)
(shuffle2 lst)
;-> (4 1 6 5 10 7 9 2 8 3)

Adesso proviamo l'uniformità:

(setq lst '(1 2 3))

(define (test2 iter)
  (local (res freq out)
    (setq res '((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1)))
    (setq freq (array 6 '(0)))
    (for (i 1 iter)
      (++ (freq (find (shuffle2 lst) res)))
    )
    freq))

(test2 100000)
;-> (16571 16829 16710 16567 16678 16645)

(test2 1000000)
;-> (166943 166926 166139 166296 167037 166659)

Quindi questo algoritmo garantisce anche l'uniformità dei risultati. Perchè?

Per provarlo abbiamo bisogno di utilizzare un "invariante del ciclo" (loop invariant).
L'invariante è il seguente: ad ogni indice idx del ciclo, tutti gli indici prima di idx hanno la stessa probabilità di contenere un qualuanque elemento della lista.
Consideriamo idx = 0: poichè scambiamo lst(0) con un indice casuale cha varia per tutta la lunghezza della lista, lst(0) ha una probabilità uniforme di essere un qualunque elemento della lista. Quindi l'invariante è vero per il caso base.
Ora consideriamo che il nostro invariante sia vero fino a idx e consideriamo il ciclo a (idx + 1). Dobbiamo calcolare la probabilità che alcuni elementi si trovino all'indice (idx + 1). Questa è uguale alla probabilità di non selezionare quell'elemento fino a idx e poi prenderlo a (idx + 1). 
Tutti i potenziali elementi rimanenti non devono essere stati ancora selezionati, il che significa che non sono stati prelevati da 0 a idx, e questa probabilità vale:

   (n - idx)     (n - 2)           (n - idx -1)
  ----------- * --------- * ... * --------------
      n          (n - 1)            (n - idx) 

Adesso dobbiamo scegliere effettivamente l'elemento. Poichè rimangono (n - idx - 1) elementi per la scelta, questa probabilità è pari a:

        1
  --------------
   (n - idx -1)

Mettendo tutto insieme, la probabilità cercata vale:

   (n - idx)     (n - 2)           (n - idx -1)          1           1
  ----------- * --------- * ... * -------------- * -------------- = ---
      n          (n - 1)            (n - idx)       (n - idx -1)     n

Quindi l'invariante è sempre valido e la dimostrazione è terminata.


----------------------------------------
Una funzione trigonometrica interessante
----------------------------------------

Nel libro "Calculus early transcendentals" di Stewart, Clegg, Watson viene riportata questa funzione trigonometrica:

               Sin(Tan x) - Tan(Sin x)
f(x) = ---------------------------------------
         ArcSin(ArcTan x) - ArcTan(ArcSin x)

(define (func x)
  (div (sub (sin (tan x)) (tan (sin x)))
      (sub (asin (atan x)) (atan (asin x)))))

Calcolare la funzione nei seguenti valori di x: 1, 0.1, 0.01, 0,001 e 0.0001:

(func 1)
;-> 1.183831989375579
Valore vero:
1.183831989375580

(func 0.1)
;-> 1.016735904116213
Valore vero:
1.016735904116213

(func 0.01)
;-> 0.9896373056994818
Valore vero:
0.989637305699482

(func 0.001)
;-> 0
Valore vero:
0.

(func 0.0001)
;-> -1#IND
Valore vero: 
ComplexInfinity

(func 0)
;-> -1#IND
Valore vero: 
Indeterminate

Calcolare il limite della funzione per x->0:

Valore vero:
lim f(x) = 1
 x->0

Proviamo ad avvicinarsi a 0:

(setq x-val '(0.002 0.001 0.0009 0.0008 0.0007 0.0006 0.0005 
              0.0004 0.0003 0.0002 0.0001 0.00001))

(map (fn(x) (list x (func x))) x-val)
;-> ((0.002 -1.#IND) 
;->  (0.001 0) 
;->  (0.0009 -0) 
;->  (0.0008 -1.#IND) 
;->  (0.0007 -1.#IND) 
;->  (0.0006 -1)
;->  (0.0005 -1.#IND)
;->  (0.0004 0)
;->  (0.0003 -1)
;->  (0.0002 -1.#IND)
;->  (0.0001 -1.#IND)
;->  (1e-005 -1.#IND))


Per capire la "variabilità" di questa funzione vedere il grafico "trigo-funzione.png" nella cartella "data".


-----------------------------------
Modificare le liste di associazione
-----------------------------------

Suppuniamo di voler utilizzare una lista di associazione (key value) come una hash-map. Per esempio,

(setq alst '((1 "a") (3 "f") (6 "b") (-1 "x")))

Primo problema: come modificare il valore associato ad una chiave?

(define (update key value)
  (setf (assoc key alst) (list key value)))

(update 1 "k")
;-> (1 "k")
alst
;-> ((1 "k") (3 "f") (6 "b") (-1 "x"))

Ma se la chiave non esiste otteniamo un errore:

(update 11 "z")
;-> ERR: no reference found : nil
;-> called from user function (update 11 "z")

Quindi prima di aggiornare il valore dobbiamo verificare se esiste la chiave:

(define (update key value)
  (if (lookup key alst)
      (setf (assoc key alst) (list key value))))

(update 1 "y")
;-> (1 "y")
alst
;-> ((1 "y") (3 "f") (6 "b") (-1 "x"))

Proviamo con una chiave inesistente:

(update 21 "p")
;-> nil
alst
((1 "y") (3 "f") (6 "b") (-1 "x"))

Nota: anche la seguente funzione opera correttamente perchè la lista "alst" non è un parametro della funzione (quindi non viene copiata in una variabile locale della funzione).

(define (update1 key value)
  (let (item (assoc key alst))
       (if item
           (setf (assoc key alst) (list key value)))))

(update1 1 "aa")
;-> (1 "aa")
alst
;-> ((1 "aa") (3 "f") (6 "b") (-1 "x"))

Secondo problema: poichè una hash-map non contiene chiavi multiple, come impedire l'inserimento di chiavi multiplde nella lista di associazione?

Modifichiamo la funzione "update" in modo che, se la chiave esiste, allora viene aggiornato il valore associato (anche se è lo stesso), altrimenti (cioè quando la chiave non esiste) viene aggiunta una coppia (chiave valore) alla lista.

(define (update key value)
  (if (lookup key alst)
      (setf (assoc key alst) (list key value))
      (push (list key value) alst -1)))

Aggiorniamo il valore con chiave 6:

(update 6 "new")
;-> (6 "new")
alst
;-> ((1 "aa") (3 "f") (6 "new") (-1 "x"))

Aggiorniamo il valore con chiave -1:

(update -1 "xyz")
;-> (-1 "xyz")
alst
;-> ((1 "aa") (3 "f") (6 "new") (-1 "xyz"))

Aggiungiamo una coppia (chiave valore):

(update 21 "ventuno")
;-> (21 "ventuno")
alst
;-> ((1 "aa") (3 "f") (6 "new") (-1 "xyz") (21 "ventuno"))

Per finire scriviamo una funzione per eliminare una coppia (chiave valore) dalla lista di associazione.
In questo caso dovremmo prima verificare se la chiave esiste e poi, eventualmente, eliminare la coppia (chiave valore). Però newLISP ha una funzione integrata "pop-assoc" per eliminare un elemento (chiave valore) di una lista associativa utilizzando la chiave come parametro (la funzione restituisce nil se la chiave non esiste).

(define (remove key) (pop-assoc key alst))

(remove 44)
;-> alst
((1 "aa") (3 "f") (6 "new") (-1 "xyz") (21 "ventuno"))
(remove 21)
;-> (21 "ventuno")
alst
;-> ((1 "aa") (3 "f") (6 "new") (-1 "xyz"))

Nota: per utilizzare una lista associativa conme parametro delle funzioni "update" e "remove" occorre utilizzare i funtori dei contesti come contenitori delle liste (es. (setq alst:alst '(1 "a") (3 "f"))). In questo modo le liste vengono passate per riferimento e non per valore.

From StackOverflow: modifying association list
----------------------------------------------

-------
0: Jakub M.
-------
I have a problem with modifying entries of an association list. 
When I run this code:

Example A
(set 'Dict '(("foo" "bar")))
(letn (key "foo"
       entry (assoc key Dict))
  (setf (assoc key Dict) (list key "new value")))
(println Dict)

the result is:

(("foo" "new value")) ; OK

which is expected. With this code

Example B
(set 'Dict '(("foo" "bar")))
(letn (key "foo"
       entry (assoc key Dict))
  (setf entry (list key "new value"))) ; the only change is here
(println Dict)

the result is:

(("foo" "bar")) ; huh?

Why the Dict is not being updated in the second case?

What I want is to check if an entry is in the Dict and if it is - update it, otherwise leave it alone. With letn I want to avoid a duplicated code

(letn (key "foo"
       entry (assoc key Dict))
  (if entry ; update only if the entry is there
    (setf entry (list key "new value")))

-------
1: newlisp
-------
In the letn expression the variable entry contains a copy of the association not a reference. Set the association directly as shown in Cormullion's example:

(setf (assoc key Dict) (list key "new value"))

In the newLISP programming model everything can be referenced only once. Assignment always makes a copy.

-------
2: cormullion
-------
My understanding of association lists is that they work like this:

> (set 'data '((apples 123) (bananas 123 45) (pears 7)))
((apples 123) (bananas 123 45) (pears 7))
> (assoc 'pears data)
(pears 7)
> (setf (assoc 'pears data) '(pears 8))
(pears 8)
> data
((apples 123) (bananas 123 45) (pears 8))
> (assoc 'pears data)
(pears 8)
>

If you want to check for the existence of a key and update its value, do something like this:

(letn (key "foo")
   (if (lookup key Dict)
       (setf (assoc key Dict) (list key "new value"))))


--------------------------------------------------
Estrazione di elementi con probabilità predefinite
--------------------------------------------------

Data una lista con dei valori di probabilità associati ai rispettivi indici, scrivere una funzione che estrae casualmente un indice della lista seguendo le probabilità assegnate.

Nota: per maggiori informazioni vedi "Numeri casuali con distribuzione discreta predefinita" nel capitolo "02-funzioni-varie" in cui abbiamo definito la seguente funzione per risolvere il problema:

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
    ;(print inter)
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

Adesso vediamo un metodo migliore che viene spiegato nei commenti della funzione seguente:

(define (rand-pick lst)
  (local (rnd stop out)
    ; generiamo un numero random diverso da 1 
    ; (per evitare errori di arrotondamento)
    (while (= (setq rnd (random)) 1))
    (if (= rnd 1) (println rnd))
    (setq stop nil)
    (dolist (p lst stop)
      ; sottraiamo la probabilità corrente al numero random...
      (setq rnd (sub rnd p))
      ; se il risultato è minore di zero, 
      ; allora restituiamo l'indice della probabilità corrente
      (if (< rnd 0)
          (set 'out $idx 'stop true)
      )
    )
    out))

(setq p '(0.05 0.15 0.35 0.45))

Nota: la somma delle probabilità deve valere 1.
(apply add p)
;-> 1

(rand-pick p)
;-> 2

Facciamo alcune prove per verificare la correttezza della funzione:

(setq p '(0.05 0.15 0.35 0.45))
(apply add p)
;-> 1
(setq vet (array 4 '(0)))
;-> (0 0 0 0)
(for (i 0 999999) (++ (vet (rand-pick p))))
vet
;-> (50087 150175 349614 450124)
(apply + vet)
;-> 1000000

(setq p '(0.02 0.08 0.7 0.2))
(apply add p)
;-> 1
(setq vet (array 4 '(0)))
;-> (0 0 0 0)
(for (i 0 999999) (++ (vet (rand-pick p))))
vet
;-> (19943 80205 700466 199386)

Vediamo la differenza di velocità delle due funzioni:

1) "rand-prob"
(setq p '(0.02 0.08 0.7 0.2))
(setq vet (array 4 '(0)))
;-> (0 0 0 0)
(time (for (i 0 999999) (++ (vet (rand-prob p)))))
;-> 3427.212
vet
;-> (20243 79942 699964 199851)

2) "rand-pick"
(setq p '(0.02 0.08 0.7 0.2))
(setq vet (array 4 '(0)))
;-> (0 0 0 0)
(time (for (i 0 999999) (++ (vet (rand-pick p)))))
;-> 724.643
vet
;-> (19974 80153 699845 200028)


--------------------------------------------------------------
Disporre i numeri di una lista nella forma: basso->alto->basso
--------------------------------------------------------------

Data una lista di numeri interi, riorganizzarla in modo che i numeri rispettino la seguente regola:

  basso -> alto -> basso -> alto -> basso -> alto -> ...

In altre parole, ogni elemento pari deve essere maggiore dei suoi elementi a sinistra e destra.

Nota: Supponiamo che nella lista non siano presenti elementi duplicati.

Una soluzione è quella di ordinare prima la lista in ordine crescente. Quindi usare un vettore ausiliario e riempirlo con gli elementi della lista ordinata partendo dai due estremi di quest'ultima e in ordine alternato. Ecco l'algoritmo completo:

  a) Ordinare la lista in ordine crescente.
  b) Inizializzare due indici "i" (inizio lista) e "j" (fine lista) (es. i = 0 e j = n-1).
  c) Creare un vettore "vet" con lunghezza pari a quella della lista.
  d) Inizializzare un indice k = 0 (indice del vettore).
  e) Riempire il vettore con il seguente ciclo:
     (while (i < j)
         vet[k++] = lst[i++]
         vet[k++] = lst[j–-]
     )
  f) Se la lista contiene un numero dispari di elementi,
     allora bisogna aggiungere l'ultimo elemento della lista ordinata al vettore.
  g) Restituire il vettore "vet"

Complessita temporale: O(n*log(n))
Complessita spaziale: O(n)

(define (high-low lst)
  (local (i j k out)
    (setq out (array (length lst) '(0)))
    (setq i 0)
    (setq j (- (length lst) 1))
    (sort lst)
    (setq k 0)
    (while (< i j)
      (setf (out k) (lst i))
      (++ k) (++ i)
      (setf (out k) (lst j))
      (++ k) (-- j)
    )
    ; se la lista contiene un numero dispari di elementi
    ; bisogna aggiungere l'ultimo elemento
    ; della lista ordinata al risultato (out)
    (if (= i j)
        (setf (out (+ i j)) (lst i))
    )
    out))

Proviamo la funzione:

(setq nums '(1 6 5 7 9 2))
(high-low nums)
;-> (1 9 2 7 5 6)

(setq nums '(9 6 8 3 7))
(high-low nums)
;-> (3 9 6 8 7)

Una soluzione più efficiente è quella di iniziare dal secondo elemento della lista e incrementare l'indice di 2 ad ogni passo del ciclo. Se il precedente elemento è maggiore dell'elemento corrente, allora scambiare gli elementi. Allo stesso modo, se l'elemento successivo è maggiore dell'elemento corrente, scambiare gli elementi. Alla fine del ciclo, otterremo la lista nella forma voluta.

Complessita temporale: O(n)
Complessita spaziale: O(n)

(define (h-l lst)
  ; inizia dal secondo elemento e incrementa l'indice
  ; di 2 ad ogni passo del ciclo
  (for (i 1 (- (length lst) 1) 2)
    ; se l'elemento precedente è maggiore dell'elemento corrente,
    ; allora scambia gli elementi  
    (if (> (lst (- i 1)) (lst i))
        (swap (lst (- i 1)) (lst i))
    )
    ; se l'elemento successivo è maggiore dell'elemento corrente,
    ; allora scambia gli elementi
    ; prima controlla che non abbia raggiunto
    ; la fine della lista
    (if (and (< (+ i 1) (length lst))
             (> (lst (+ i 1)) (lst i)))
        (swap (lst (+ i 1)) (lst i)
    )
  )
  lst))

Proviamo la funzione:

(setq nums '(1 6 5 7 9 2))
(h-l nums)
;-> (1 6 5 9 2 7)

(setq nums '(9 6 8 3 7))
(h-l nums)
;-> (6 9 3 8 7)

Vediamo i tempi di esecuzione:

(setq nums (randomize (sequence 1 500)))

(time (high-low nums) 1000)
;-> 247.437

(time (h-l nums) 1000)
;-> 622.307

Malgrado la funzione "h-l" non prevede l'ordinamento della lista o l'uso di un vettore aggiuntivo, risulta più lenta della funzione "high-low". Questo perchè le operazioni di indicizzazione di una lista sono lente.
Infatti se proviamo le funzioni utilizzando un vettore (che ha un tempo di accesso molto più basso di quello di una lista), otteniamo i risultati previsti:

(setq numsvet (array (length nums) nums))

(time (high-low numsvet) 1000)
;-> 105.825

(time (h-l numsvet) 1000)
;-> 76.606


------------
Poker d'assi
------------

Calcolare la probabilità di avere un poker d'assi servito.

numero carte          --> n = 52
insieme degli assi    --> a = 4
insieme non-assi      --> r = n - a = 48
numero carte estratte --> e = 5

Utilizziamo la distribuzione ipergeometrica per trovare la probabilità che estrando 5 carte dal mazzo (senza reinserimento) si ottengano k = 4 assi:

                       binom(a k) * binom((n-a) (e-k))
  P(poker) = P(k=4) = --------------------------------- =
                                binom(n e)

     binom(4 4) * binom(48 1)     1 * 48        1
  = -------------------------- = --------- = ------- = 
          binom(52 5))            2598960     54145
  
  = 1.846892603195124e-005

Quindi,in media, si verifica un poker di assi servito ogni 54145 mani.

Formula per il calcolo del binomiale:

(define (binom num k)
  (cond ((> k num) 0)
        ((zero? k) 1)
        (true
          (let (r 1L)
            (for (d 1 k)
              (setq r (/ (* r num) d))
              (-- num)
            )
          r))))

Vediamo di scrivere una funzione di simulazione:

(define (poker-servito iter)
  (local (deck sum)
    (seed (time-of-day))
    (setq sum 0)
    (setq deck (sequence 1 52))
    (for (i 1 iter)
      (if (= (difference '(1 2 3 4) (slice (randomize deck) 0 5)) '())
          (++ sum)
      )
    )
    (println sum)
    (div sum iter)))

Dalla formula teorica vediamo quante volte deve uscire un poker di assi servito ogni 1e7 mani:

(div 1e7 54145)
;-> 184.6892603195124

Verifichiamo la funzione di simulazione:

(poker-servito 1e7)
;-> 183
;-> 1.83e-005

Sembra che i risultati concordino.


-------------
Sparse matrix
-------------

Una matrice sparsa (sparse matrix) è una matrice in cui la maggior parte degli elementi ha valore zero.
In genere risulta conveniente rappresentare queste matrici con strutture dati particolari ed utilizare algoritmi specifici. Infatti le operazioni matriciali standard sono molto lente quando abbiamo una sparse-matrix (e sprechiamo anche una grande quantità di memoria). 

Possiamo pensare di comprimere i dati di una sparse-matrix in una struttura dati come una hash-map.
Un elemento (cioè una coppia chiave-valore) della hash-map rappresenta un elemento non-nullo della sparse-matrix, ad esempio se abbiamo un valore 3 alla riga 125 e alla colonna 450 possiamo scrivere:

  ("125-450" 3)

In altre parole, comprimiamo i dati memorizzando nella hash-map solo i valori della matrice diversi da zero.

Scriviamo le funzioni di base per la gestione di una sparse.matrix con una hash-map.

Funzione per creare una sparse-matrix vuota:

(define (sm-new sm-str matrix)
    ; create sparse matrix as hash-table
    (new Tree (sym sm-str)))
    ;((eval (sym sm-str)) (string row "-" col) (list row col))

(sm-new "test")
(test)
;-> ()

Funzione per inserire o modificare o eliminare un valore in una sparse-matrix:

(define (sm-set sm row col value)
  (let (idx (string row "-" col))
       (if (zero? value)
           (sm idx nil)      ; delete value from sm
           (sm idx value)))) ; add/modify value to sm

(sm-set test 2 41 128)
;-> 128
(test)
;-> (("2-41" 128))

Se la chiave (row-col) non esiste, allora crea l'elemento (row-col value).
Se la chiave (row-col) esiste allora aggiorna il valore.
Se il valore vale 0 (zero), allora l'elemento viene eliminato.

Nota: la funzione "sm-set" non controlla se row o col superano i limiti della matrice

Funzione per recuperare un valore da una chiave (row-col):

(define (sm-get sm row col)
  (let (idx (string row "-" col))
       (sm idx)))

(sm-get test 3 4)
;-> nil
(sm-get test 2 41)
;-> 128

Funzione che copia una matrice in una sparse-matrix:

(define (sm-init sm matrix)
  (local (row col val)
    (setq row (length matrix))
    (setq col (length (matrix 0)))
    (for (r 0 (- row 1))
      (for (c 0 (- col 1))
        (if (!= (setq val (matrix r c)) 0)
            (sm (string r "-" c) val)
        )
      )
    )
    (sm)))

(silent (setq m (array 1000 1000 '(0))))
(setf (m 342 28) 1)
(setf (m 213 672) 1)
(setf (m 0 0) 1)
(setf (m 912 421) 1)

(sm-init test m)
;-> (("0-0" 1) ("2-41" 128) ("213-672" 1) ("342-28" 1) ("912-421" 1))

Vediamo meglio la funzione "sm-set":

Aggiorna il valore di una chiave (row e col) esistente:

(sm-set test 0 0 256)
;-> 256
(test)
;-> (("0-0" 256) ("2-41" 128) ("213-672" 1) ("342-28" 1) ("912-421" 1))

Elimina l'elemento con chiave (row-col) dalla sparse-matrix se il valore vale 0:

(sm-set test 213 672 0)
;-> nil
(test)
;-> (("0-0" 256) ("2-41" 128) ("342-28" 1) ("912-421" 1))

Funzione per eliminare tutti gli elementi di una sparse-matrix:

(define (sm-clear sm)
  (map delete (symbols sm))
  nil)

(sm-clear test)
;-> nil
(test)
;-> ()

Funzione per eliminare una sparse-matrix:

(define (sm-destroy sm)
  (delete sm) (delete sm))

(sm-destroy 'test)
;-> true
(test)
;-> ERR: invalid function : (test)

Vediamo alcuni confronti tra una matrice e la relativa sparse-matrix:

Creiamo una nuova sparse-matrix:
(sm-new "demo")

Creiamo una matrice con alcuni valori:
(silent (setq m (array 1000 1000 '(0))))
(setf (m 342 28) 1)
(setf (m 213 672) 1)
(setf (m 0 0) 1)
(setf (m 912 421) 1)

Inizializziamo la sparse-matrix:
(sm-init demo m)
;-> (("0-0" 1) ("213-672" 1) ("342-28" 1) ("912-421" 1))

Sommiamo tutti i valori della matrice:
(apply add (flat (array-list m)))
;-> 4

Sommiamo tutti i valori della sparse-matrix:
(apply add (map last (demo)))
;-> 4

Vediamo i tempi di esecuzione:

(time (apply add (flat (array-list m))) 100)
;-> 3209.517

(time (apply add (map last (demo))) 100)
;-> 0

Con 1000000 di elementi nella matrice e 4 elementi nella sparse-matrix era ovvio che la sommatoria sarebbe stata più veloce nel secondo caso.
Vediamo allora il caso in cui le due strutture contengono lo stesso numero di elementi.

Creiamo una nuova sparse-matrix:

(sm-new "demo1")
;-> (demo1)

Creiamo una matrice con alcuni valori:

(silent (setq m1 (array 1000 1000 '(1))))

Inizializziamo la sparse-matrix:

(silent (sm-init demo1 m1))
(length (demo1))
;-> 1000000

Sommianmo tutti i valori e vediamo i tempi di esecuzione in entrambi i casi:

(apply add (flat (array-list m1)))
;-> 1000000

(apply add (map last (demo1)))
;-> 1000000

(time (apply add (flat (array-list m1))) 100)
;-> 5881.547

(time (apply add (map last (demo1))) 100)
;-> 85486.121

In questo caso la sparse-matrix è molto più lenta. Quindi esiste un limite superiore al numero degli elementi non-nulli della matrice affinchè la sparse-matrix relativa risulti conveniente.
Se i tempi fossero lineari (direttamente proporzionali) con il numero degli elementi, allora potremmo calcolare tale limite nel modo seguente:

Tempo per processare un elemento nella matrice
(div 5188 1e6)
;-> 0.005188

Tempo per processare un elemento nella sparse-matrix

(div 85486 1e6)
;-> (0.085486)

Quindi nel tempo necessario alla matrice di processare tutti gli elementi (5188) la sparse-matrix processa circa 60688 elementi:

(div 5188 0.085486)
;-> 60688.29983857006

Vediamo di verificare questo limite superiore con una matrice che ha 60688 elementi non-nulli.

Creiamo una nuova sparse-matrix:

(sm-new "demo2")
;-> (demo2)

Creiamo una matrice 250*250 = 62500 valori non-nulli:

(silent (setq m2 (array 1000 1000 '(0))))
(for (i 0 249) (for (j 0 249) (setf (m2 i j) 1)))
(count '(1) (flat (array-list m2)))
;-> (62500)

Inizializziamo la sparse-matrix:

(silent (sm-init demo2 m2))
(length (demo2))
;-> 62500

Sommianmo tutti i valori e vediamo i tempi di esecuzione in entrambi i casi:

(apply add (flat (array-list m2)))
;-> 62500

(apply add (map last (demo2)))
;-> 62500

(time (apply add (flat (array-list m2))) 100)
;-> 3545.95

(time (apply add (map last (demo2))) 100)
;-> 1304.68

In questo caso la sommatoria della sparse-matrix è quasi 3 volte più veloce.

Proviamo con una matrice che ha 100000 elementi non-nulli.

Creiamo una nuova sparse-matrix:

(sm-new "demo3")
;-> (demo3)

Creiamo una matrice 316*316 = 99856 valori non-nulli:

(silent (setq m3 (array 1000 1000 '(0))))
(for (i 0 315) (for (j 0 315) (setf (m3 i j) 1)))
(count '(1) (flat (array-list m3)))
;-> (99856)

Inizializziamo la sparse-matrix:

(silent (sm-init demo3 m3))
(length (demo3))
;-> 99856

Sommiamo tutti i valori e vediamo i tempi di esecuzione in entrambi i casi:

(apply add (flat (array-list m3)))
;-> 99856

(apply add (map last (demo3)))
;-> 99856

(time (apply add (flat (array-list m3))) 100)
;-> 3944.996

(time (apply add (map last (demo3))) 100)
;-> 2883.198

Anche in questo caso la sommatoria della sparse-matrix è più veloce.

Anche se il tempo di esecuzione non è proprio lineare con il numero degli elementi possiamo concludere che la sparse-matrix è conveniente in termini di velocità quando il numero di elementi non-nulli è inferiore al 10% di tutti gli elementi della matrice.

Per maggior rigore il confronto di velocità tra le due strutture dovrebbe essere effettuato dopo aver sviluppato e tenuto conto anche le altre operazioni sulle matrici:

  1) Addizione di uno scalare
  2) Addizione e Sottrazione di matrici
  3) Moltiplicazione tra matrici
  4) Trasposta di una matrice
  5) Inversa di una matrice
  6) Determinante di una matrice
  7) ecc.

=============================================================================
