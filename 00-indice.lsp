
============================================================================
 Note su newLISP
 © copyright 2019-2023 Massimo Corinaldesi aka cameyo
 MIT License
============================================================================

========

 INDICE

========

newLISP IN GENERALE
===================
  Introduzione
  Installazione
  Eseguire newLISP
  Le funzioni utente
  Argomenti di una funzione
  Trasformare una funzione distruttiva in non-distruttiva
  Trasformare una funzione da due a n argomenti
  Applicare una funzione ad ogni sottolista di una lista
  Assegnazione globale: set, setq e setf (e define)
  Assegnazione locale: let, letn e local
  Effetti collaterali (side effect) di setq e let e local
  Passaggio per valore e passaggio per riferimento
  nil, true e lista vuota '()
  La funzione quote e il simbolo '
  Funzioni con memoria
  Generare funzioni da funzioni
  Tipi di numeri
  Punto decimale o virgola decimale
  Formattazione dell'output
  Operazioni aritmetiche elementari
  Incremento/decremento di variabili
  Uso dei numeri big integer
  Introspezione
  Conversioni di tipo: implicite ed esplicite
  Quanto sono precisi i numeri floating point?
  Quanto sono strani i numeri floating-point?
  Tipi di errore
  Propagazione degli errori
  Rappresentazione dei numeri floating point (32-bit)
  Machine epsilon
  Infinito e Not a Number (inf e NaN)
  Confronto tra numeri floating-point
  Verifica delle operazioni floating-point
  Una strana successione
  Operazioni sicure
  Quanto vale pi greco?
  Quanto vale il numero di eulero?
  Tempo di esecuzione
  Lista o vettore?
  Vettori
  Indicizzazione di stringhe, liste e vettori
  Attraversamento di liste e vettori
  Attraversamento di stringhe
  Uscita anticipata da funzioni, cicli e blocchi
  Lavorare con file di dati (file i/o)
  Salvare e caricare gli oggetti
  Struttura dati: il record
  Ambito (scope) dinamico e lessicale
  Contesti
  Uso dei moduli
    La variabile di ambiente NEWLISPDIR
    Il file di inizializzazione init.lsp
    Esempi sull'utilizzo dei moduli
  Hash-Map e dizionari
  CAR e CDR in newLISP
  Espressioni regolari
  Macro
  FOOP - Programmazione funzionale orientata agli oggetti
  XML e S-espressioni
  Analisi dei tempi di esecuzione delle funzioni
  Unificazione
  Stampare con print/println/format
  Codici ANSI ESCape
  Complessità temporale delle operazioni aritmetiche fondamentali
  Codifica Unicode e UTF-8

FUNZIONI VARIE
==============
  Tabella ASCII
  Pari o dispari
  Crono
  Cambiare di segno ad un numero
  Moltiplicazione solo con addizioni
  Divisione solo con sottrazioni
  Distanza tra due punti
  Conversione decimale <--> binario
  Conversione decimale <--> esadecimale
  Conversione decimale --> romano
  Conversione numero intero <--> lista
  Numeri casuali in un intervallo
  Calcolo proporzione
  Estrarre l'elemento n-esimo da una lista
  Verificare se una lista è palindroma
  Verificare se una stringa è palindroma
  Verificare se un numero è palindromo
  Zippare N liste
  Sostituire gli elementi di una lista con un determinato valore
  Raggruppare gli elementi di una lista
  Enumerare gli elementi di una lista
  Creare una stringa come ripetizione di un carattere/stringa
  Massimo annidamento di una lista ("s-espressione")
  Run Length Encode di una lista
  Run Length Decode di una lista
  Massimo Comun Divisore e Minimo Comune Multiplo
  Funzioni booleane
  Estrazione dei bit di un numero
  Conversione gradi decimali <--> gradi sessagesimali
  Conversione RGB <--> HSV
  Calcolo della media di n numeri
  Istogramma
  Stampare una matrice
  Retta passante per due punti
  Coordinate dei punti di una funzione
  Leggere e stampare un file di testo
  Criptazione e decriptazione di un file
  Funzioni per input utente
  Emettere un beep
  Disabilitare l'output delle espressioni
  Trasformare una lista di stringhe in lista di simboli
  Trasformare una lista di simboli in lista di stringhe
  Simboli creati dall'utente
  Il programma è in esecuzione? (progress display)
  Ispezionare una cella newLISP
  Informazioni sul sistema (sys-info)
  Valutazione di elementi di una lista
  Download tutti i file da una pagina web
  Conversione numero da cifre a lettere
  Punto a destra o sinistra di una linea
  Creazione di un poligono da una lista di punti
  Percorso minimo di una lista di punti
  Utilizzo del protocollo ftp
  Normalizzazione di una lista di numeri
  Trasformazione omografica 2D
  Numeri primi successivi e precedenti
  Giorno Giuliano (Julian day)
  Punto interno al poligono
  Prodotto cartesiano
  Insieme delle parti (powerset)
  Terne pitagoriche
  Calcolo di e con il metodo spigot
  Calcolo IVA
  Numeri casuali distinti
  Numeri casuali con distribuzione discreta predefinita
  Generatore di stringhe casuali
  Inverso di un numero
  Crivello di Atkin
  Esponenziazione modulare veloce
  random sample
  Funzioni di Mobius e di Mertens
  Quadruple pitagoriche
  Lista dei contesti attivi
  Conversione lista <--> stringa
  Funzione butlast
  Lista di tutte le partizioni di un numero
  Algoritmo di Euclide esteso
  Punti casuali in una circonferenza
  Esponenziazione (potenza) binaria
  Permutazioni circolari
  Crivello di Eratostene Lineare
  Area di un poligono semplice
  Rango di una matrice
  Operazioni tra coppie di elementi di una lista
  Polinomio interpolatore di Lagrange
  Moltiplicativo modulare inverso
  Radice n-esima di un numero
  Prodotto scalare (dot product)
  Prodotto vettoriale (cross-product)
  Angolo tra due direzioni (bearing)
  URL encoder/decoder
  Funzione gamma-ln
  select per i vettori
  Lunghezza di un numero intero
  Normalizzazione
  Papersize
  Verificare se due numeri hanno lo stesso segno
  Suddivisione di una lista
  Stampo di un numero
  Conversione vettore <--> lista
  one?
  Algoritmo Knuth-Morris-Pratt
  Heap binario (Binary Heap)
  Flood Fill
  Poligoni convessi
  Variazione percentuale
  Grafico di coppie di coordinate
  Sottosequenza crescente più lunga
  Conversione stringa <--> big-integer
  Dismutazioni (Derangements)
  Stampa lista come tabella

newLISP 99 PROBLEMI (28)
========================
  N-99-01 Estrarre l'ultimo elemento di una lista
  N-99-02 Estrarre il penultimo elemento di una lista
  N-99-03 Estrarre il k-esimo elemento di una lista
  N-99-04 Determinare il numero di elementi di una lista
  N-99-05 Invertire una lista
  N-99-06 Determinare se una lista è palindroma
  N-99-07 Appiattire una lista annidata
  N-99-08 Elimina gli elementi duplicati consecutivi di una lista
  N-99-09 Unire gli elementi duplicati consecutivi di una lista in sottoliste.
  N-99-10 Run-length encode di una lista
  N-99-11 Run-length encode di una lista (modificato)
  N-99-12 Run-length decode di una lista
  N-99-13 Run-length encode di una lista (diretto)
  N-99-14 Duplicare gli elementi di una lista
  N-99-15 Replicare per n volte gli elementi di una lista
  N-99-16 Eliminare gli elementi da una lista per ogni k
  N-99-17 Dividere una lista in due parti
  N-99-18 Estrarre una parte di una lista
  N-99-19 Ruotare una lista di N posti a sinistra
  N-99-20 Eliminare l'elemento k-esimo di una lista
  N-99-21 Inserire un elemento in una data posizione di una lista
  N-99-22 Creare una lista che contiene tutti i numeri interi di un intervallo
  N-99-23 Estrarre un dato numero di elementi da una lista in maniera casuale (random)
  N-99-24 Lotto: estrarre N numeri differenti da un intervallo 1..M
  N-99-25 Generare le permutazioni degli elementi di una lista
  N-99-26 Generare le combinazioni di K oggetti distinti tra gli N elementi di una lista
  N-99-27 Raggruppare gli elementi di un insieme in sottoinsiemi disgiunti
  N-99-28 Ordinare una lista in base alla lunghezza delle sottoliste

ROSETTA CODE
============
  FizzBuzz
  99 Bottles of Beer
  Numeri Primi
  Numeri di Smith
  Numeri di Hamming
  Numeri di Catalan
  Numeri di Kaprekar
  Numeri Felici
  Numeri Primoriali
  Numeri Perfetti
  Numeri Amicabili
  Numeri Perniciosi
  Numeri di Munchausen
  Sequenza di Collatz
  Permutazioni
  Combinazioni
  Regola di Horner
  Problema dello zaino (Knapsack)
  Giorno della settimana
  Triangolo di Pascal
  Codice Morse
  Problema di Babbage
  Cifrario di Cesare
  Cifrario di Vigenere
  Anagrammi
  Numeri primi cuban
  Data di Pasqua
  Equazione di Pell
  Punteggio numerico (ranking)
  Legge di Bendford
  Calendario
  Carte da gioco
  Generatore di password
  Calcolo di Pi greco
  Numeri di Lucas
  Logaritmo intero di un numero intero
  Numeri di Carmichael
  Radice quadrata intera di un numero intero
  Coppie di primi gemelli
  Numeri semiprimi
  Numeri coprimi
  Fattorizzazione di un numero intero (big integer)
  Potenza di due numeri interi (big integer)
  Numeri di Tribonacci
  Numeri Eureka
  Abitazioni multiple
  Toziente di Eulero
  Numeri Vampiri
  Il gioco del Nim
  Fibonacci sequenze di n-numeri
  Il problema dei matrimoni stabili
  Test Primi Miller-Rabin
  Il problema di Giuseppe (Josephus Problem)
  ROT-13
  Sudoku
  Chess960
  Percorso del cavallo
  Teorema cinese dei resti
  Numeri attraenti
  IBAN
  Estendere il linguaggio
  Composizione di funzioni
  Calcolo di una serie
  Numeri gapful
  Valutazione di una espressione RPN
  Il gioco del 24
  Sequenza fusc
  Algoritmo Damm
  Distanza tra due punti della terra
  Algoritmo Soundex
  Trasformata Discreta di Fourier (DFT)
  Numeri di Harshad
  Numeri Humble
  Persistenza di un numero
  Numeri Taxicab
  Codice Gray
  Game of Life
  Ackermann
  Sequenza Q di Hofstadter
  Sequenza Figura-Figura di Hofstadter
  Sequenza G di Hofstadter
  Sequenza Femmina (F) Maschio (M) di Hofstadter
  Convex Hull
  Sequenza Thue-Morse
  Numeri di Bell
  Numeri auto-descrittivi
  Jort sort
  Funzioni mutuamente ricorsive
  Numeri in base negativa
  Quaternioni
  Bioritmi
  Runge-Kutta
  ISBN13
  Insieme di Cantor
  Incremento-decremento di una stringa numerica
  Funzioni di prima classe
  Inversione frase
  Conteggio popolazione
  Selezione casuale da una lista
  Rappresentazione di Zeckendorf
  Vecchie unità di misura Russe

PROJECT EULERO
==============
  Problemi 1..105, 108..110, 112..115, 119..125,
           135, 145, 173, 188, 191, 206, 469

PROBLEMI VARI
=============
  BubbleSort
  QuickSort
  Simulare una matrice con un vettore
  Implementare una pila (stack) con un vettore
  Implementare una coda (queue) con un vettore
  Coda circolare (Ring Buffer)
  Fattoriale
  Coefficiente binomiale
  Lancio di dadi
  Quadrati magici
  Quadrati magici 3x3
  Mastermind numerico
  Algoritmo babilonese sqrt(x)
  Radice quadrata intera di un numero intero (2^64 bit)
  Ricerca binaria (Binary search)
  Frazione generatrice
  Il numero aureo
  Equazione di secondo grado
  Equazione di terzo grado
  Sistemi lineari (Cramer)
  Sistemi lineari (Gauss)
  Numeri Brutti
  Numeri Poligonali
  Torre di Hanoi
  Indovina il numero
  Il problema Monty Hall
  Il problema del compleanno
  Algoritmo di Karatsuba
  Formati A0, A1, A2, A3, A4, ...
  Moltiplicazione del contadino russo
  Distanza di Manhattan
  Modello di crescita di una popolazione di conigli
  The Game of Pig
  Il gioco dei salti
  Ricerca stringa in un testo (algoritmo base)
  Ricerca stringa in un testo (algoritmo Z)
  Distanza di Levenshtein
  Social Network
  Skyline
  Knuth-shuffle
  Bussola e direzioni
  Puzzle (a b c + a b c + a b c = c c c)
  Numero mancante
  Somma massima di una sottolista (Algoritmo Kadane)
  Prodotto massimo di una sottolista
  Problema delle N-Regine
  Somma delle cifre di un numero
  Coppia di punti più vicina (Closest pair of points)
  Moltiplicazione tra numeri interi (stringhe)
  Numeri pandigitali
  Somma dei divisori propri di un numero
  Labirinti (calcolo percorsi)
  Moltiplicazioni di fattori
  Problemi patologici dei numeri floating point
  Numerali di Church
  Creazione e valutazione di polinomi
  Quadrato perfetto di un numero
  Potenza perfetta di un numero
  Problema della segretaria
  Numeri con tre divisori
  Congettura di Goldbach
  Problema dei travasi ed equazioni diofantee
  Primi circolari
  Radici di un polinomio (Bairstow)
  Nomi ordinati
  Distanza di numeri in una lista
  Ascensore difettoso ed equazioni diofantine
  Monete e griglie
  Teorema di Pick
  Problema dei fiammiferi di Banach
  Window sliding
  Il gioco di Wythoff
  Ordinamento per rime
  Lista circolare
  Circuito automobilistico
  Il problema delle studentesse di Kirkman
  Contadino, lupo, capra e cavoli
  Ancora la congettura di Goldbach
  Triangolo di Steinhaus
  L'ago di Buffon
  La scimmia e le noci di cocco

DOMANDE PROGRAMMATORI (CODING INTERVIEW QUESTIONS)
==================================================
  Notazione Big-O
  Contare i bit di un numero (McAfee)
  Scambiare il valore di due variabili (McAfee)
  Funzione "atoi" (McAfee)
  Somma di numeri in una lista (Google)
  Aggiornamento di una lista (Uber)
  Ricerca numero su una lista (Stripe)
  Decodifica di un messaggio (Facebook)
  Implementazione di un job-scheduler (Apple)
  Massimo raccoglitore d'acqua (LeetCode)
  Quantità d'acqua in un bacino (Facebook)
  Sposta gli zeri (Facebook)
  Intersezione di segmenti (byte-by-byte)
  Trovare l'elemento mancante (LeetCode)
  Verifica lista/sottolista (Visa)
  Controllo ordinamento lista (Visa)
  Caramelle (Visa)
  Unire due liste ordinate (Facebook)
  Salire le scale (Amazon)
  Numeri interi con segni opposti (MacAfee)
  Parità di un numero (McAfee)
  Minimo e massimo di due numeri (McAfee)
  Numero potenza di due (Google)
  Stanze e riunioni (Snapchat)
  Bilanciamento parentesi (Facebook)
  K punti più vicini - K Nearest points (LinkedIn)
  Ordinamento Colori (LeetCode)
  Unione di intervalli (Google)
  Somma dei numeri unici (Google)
  Unione di due liste ordinate (Google)
  Prodotto massimo di due numeri in una lista (Facebook)
  Distanza di Hamming tra DNA (Google)
  Controllo sequenza RNA (Google)
  Somma di due box (Amazon)
  Punti vicini a zero (Amazon)
  Trova la Funzione (Uber)
  Prodotto scalare minimo e massimo (Google)
  25 numeri (Wolfram)
  Le cento porte (Wolfram)
  Insiemi con la stessa somma (Wolfram)
  Tripartizione di un intero (Wolfram)
  Cifre stampate (Uber)
  Travasi di liquidi (Facebook)
  Cambio monete 1 (LinkedIn)
  Cambio monete 2 (LinkedIn)
  Primi con cifre uguali (Wolfram)
  Intervalli di numeri (Facebook)
  Pattern Matching (Facebook)
  Percorsi su una griglia (Uber)
  Dadi e probabilità (Visa)
  Numeri casuali e fattori (Wolfram)
  Coprimi vicini (Wolfram)
  Unione di liste (LinkedIn)
  Tripla crescente (LeetCode)
  Stringhe isomorfe (Facebook)
  Raggruppamento codici (Google)
  Caratteri differenti (Amazon)
  Triple con una data somma (Uber)
  Somma perfetta (Amazon)
  Mescolare una lista (LeetCode)
  Lista somma (geeks4geeks)
  Ordinare una lista di 0, 1 e 2 (geeks4geeks)
  Stipendio giusto (geeks4geeks)
  Volo completo (Programming Praxis)
  Benzina e stazioni (Uber)
  Aggiungere uno (Google)
  Numeri romani (LeetCode)
  Numero singolo (McAfee)
  Matrici a spirale (Google)
  Lunghezza della sottostringa più lunga senza caratteri ripetuti (Amazon)
  Rendere palindroma una stringa (Google)
  Cifre diverse (Visa)
  Rapporto minimo (Wolfram)
  Quadrato binario (McAfee)
  Fattoriale e zeri finali (Wolfram)
  Massima ripetizione di un carattere in una stringa (Google)
  Leggere libri (Uber)
  Numero mancante (Wolfram)
  Lista strettamente crescente (Visa)
  Pile di monete (LinkedIn)
  Numero più grande formato da una lista (Amazon)
  Rettagoli e quadrati in una scacchiera (Google)
  Rettangolo perfetto (Google)
  Addizione per intervalli (Range addition) (Google)
  Ordinamento Wiggle (Google)
  Generare parentesi (Amazon)
  Maggiori a destra (Visa)
  Numero che raddoppia (Wolfram)
  Calcolatore rotto (Broken calculator) (LeetCode)
  Contare le isole (islands) (Google)
  Lista con prodotto 1 (Amazon)
  Somma delle monete (Visa)
  Boomerang (Visa)
  Ricerca in una matrice 2D (Wolfram)
  Invertire le vocali (Google)
  Intervalli mancanti (LeetCode)
  Numeri strobogrammatici (LeetCode)
  Bomba sul nemico (Visa)
  Pitturare una staccionata (Amazon)
  Palindroma più lunga in una stringa (algoritmo Manacher) (Amazon)
  Permutazioni Palindrome (Uber)

LIBRERIE
========
  Operazioni con i numeri complessi
  Operazioni con le frazioni
  Operazioni con i tempi
  Operazioni con gli insiemi
  Funzioni winapi
  Operazioni con gli alberi binari
  funlisp.lsp (by Dmitry Chernyak)
  The Little newLISPER (newlisper.lsp)
  MessageBox (by Dexter Santucci)
  default.lsp (by kazimir majorinc)

NOTE LIBERE 1
=============
  Perchè newLISP?
  newLISP facile
  Apprendere newLISP
  Commentare righe di codice
  Stile del codice newLISP
  Considerazioni sulle parentesi del LISP
  Controllare l'output della REPL (prettyprint)
  Gestione di file e cartelle
  Funzioni come liste
  4-4 Puzzle
  Il primo Primo
  Uso delle date
  Chiusura transitiva e raggiungibilità in un grafo
  Stalin sort
  Sequenza triangolare
  Vettore/lista di funzioni
  Numeri dispari differenza di quadrati
  Zero? test
  Operazioni su elementi consecutivi di una lista
  Il loop implicito del linguaggio Scheme (named let)
  Brainfuck string encode/decode
  Creare una utilità di sistema (.exe)
  Fattoriale, Fibonacci, Primi
  Quine
  I buchi delle cifre numeriche
  Ordinare tre numeri
  Conteggio strano
  Funzioni automodificanti
  I cicli (loops)
  L'alfabeto web "Leet"
  Autogrammi
  Ambito dinamico e ambito lessicale (statico)
  Uso delle espressioni condizionali
  select e unselect (antiselect)
  Generatori 1
  Generatori 2
  Shift logico e Shift aritmetico
  fold-left e fold-right
  La divisione di Feynman
  Il linguaggio di programmazione Fractran
  La funzione map semplificata
  Generazione della documentazione con newLISPdoc
  Ancora sui numeri primi
  Un algoritmo: matrice con somme positive
  Dadi e probabilità
  Test Vettori e Liste
  Un motore per espressioni regolari
  Insiemi (set) senza reinserimento
  Funzioni con parametri nominali
  La funzione command-event
  Massimo Comun Divisore (MCD)
  Indicizzazione implicita
  nil come valore e nil come risultato
  Simulare un iteratore
  "Don't underrate an iterate..."
  Simboli che iniziano con "$"
  Uso di map nelle liste annidate
  Funzioni ordinali con le liste
  gensym e macro igieniche
  La variabile anaforica $idx
  Gestione dei simboli
  Funzioni e contesti
  Buon 2020 (e 2021)
  Nascita della teoria della probabilità
  Fibonacci(104911)
  Conta e leggi
  Assegnazione parallela
  Generatore di numeri casuali
  Liste di associazione
  Funzione Z e ipotesi di Riemann
  Rotazione di stringhe, liste e numeri
  Quadrato di una lista ordinata
  Somma da due numeri
  Mescolamento perfetto
  Mergesort
  Cifre crescenti e decrescenti
  Somma di numeri
  Operatori logici
  Quick select
  Macchina di Turing

NOTE LIBERE 2
=============
  Creare una lista di frequenza
  Approssimazione razionale di un numero
  Modificare le liste annidate
  Criptare un file sorgente o un contesto
  Leggere e stampare un file
  Lisp reader
  Liste e vettori annidati
  Conversione di un numero da una base ad un'altra
  Convertire una stringa in un numero univoco
  Reduce
  Quadrati nascosti
  Push, cons e list
  Append esteso
  newLISP keywords (Parole riservate)
  Estrazione di dati da un file di testo
  File di testo windows e unix
  CRC32
  Mescolare le parole
  Parsing di stringhe
  Formattazione di elementi di una lista
  Slice mapping
  Valore minimo/massimo di una lista di numeri
  Sommare una stringa
  Numeri palindromi
  Frazioni continue
  Liste formate da coppie di elementi
  Liste quotate
  Il limite sulle stringhe: il tag [text]...[/text]
  Aggiunta di liste
  Liberare una variabile
  Massimo prodotto di due numeri
  Test di funzioni
  Sostituzioni multiple in liste o stringhe
  Cambio monete
  Funzione Harakiri
  Ciclo for con numeri float
  Nascondere la finestra DOS
  Funzioni come parametri
  Valutazione input utente
  Passare dati per riferimento
  Pagamento giornaliero
  Differenze tra let e letn
  Tecnica RAID
  Crypto XOR
  Lancio di una moneta
  Area massima
  Sole o pioggia
  Roulette russa
  Common LISP Quicksort
  Ambito dinamico e parametri delle funzioni
  Torte e tagli
  Il ciclo for
  Perché uno specchio inverte destra e sinistra invece che su e giù?
  Treni e mosche
  Gestione degli errori
  Effetto percentuali
  Teorema di Euclide (infinità dei numeri primi)
  Il programma più corto
  Frequenza cifre pi greco
  Conversione a big-integer
  Congettura 8424432925592889329288197322308900672459420460792433L
  floor, ceil e fract
  Multipli di nove
  fizzbuzz esteso
  Conversione tra liste, stringhe, caratteri e simboli
  Divisori di un numero
  Sequenza di Collatz
  Generatore
  Multiplo con tutti 1 e 0
  Risolvere i sistemi lineari
  Sudoku test
  Integrali definiti
  Fattorizzazione
  "setq" o "set"
  Memfrob
  Generatore di sequenze
  Massimo gap
  Simulazione di un cannone
  Ottimizzare il taglio di un tubo
  Generazione automatica di una hash-map

NOTE LIBERE 3
=============
  Generazione di un simbolo univoco
  Compromessi tra tempo e spazio
  Scambio di somme
  Evitare begin nella condizione if
  Frazioni continue (funzioni)
  Redditi e tasse
  Numero di eulero o di nepero
  map e filter multiplo
  Direct Acyclic Graph (DAG)
  Corde e cerchio
  Toziente
  Numeri permutati
  Numeri bouncy
  docstring
  Numeri sfenici
  Bilancia a due piatti
  Somma di 6s
  Serie ricorsiva
  Sei contro cinque
  Torneo ad eliminazione diretta
  Roulette
  Daniel Dennet Quinian Crossword
  Lista delle fattorizzazioni di un numero
  Algoritmo di Bellman-Ford
  Catene di Markov
  Contornare una matrice
  Stringa decimale infinita 12345678910111213141516...
  Numeri early-bird
  Zero elevato a zero
  Fattoriale di zero
  Somma delle potenze dei primi n numeri
  Cercaparole
  Generare frazioni proprie
  Somma di quadrati
  Somma di cubi (Taxicab)
  Somma numeri dispari (pari)
  Cavo sospeso
  Numeri automorfici
  Numeri trimorfici
  Funzioni come Stringhe
  Assegnazione multipla
  Doppio fattoriale
  0.999999999...
  Quadrati magici curiosi
  Serie infinite
  Il gioco del Pig
  Mandelbrot
  find per vettori
  Variabili libere
  Debug spartano
  Espressioni ABCDEFGHIJ
  Sequenza Juggler
  Limiti dei big-integer
  Valutazione di espressioni infisse
  Vincere 2 volte su 3
  Investimenti in comune
  Dadi non transitivi (intransitivi)
  Il prezzo di un libro
  La barca, l'uomo e il mattone
  Creare, modificare e restituire una funzione
  Input utente multi-linea
  Distanza dell'orizzonte
  Tic-Tac-Toe
  Labirinti (Maze)
  Progettare TinyURL
  Costante di Ramanujan
  Giustificazione del testo
  Data e tempo
  Algoritmo di Gale-Shapley
  Il problema dello zaino (Knapsack)
  Validazione UTF-8
  Sudoku mania
  Radici quadrate con il metodo di Newton
  Ippodromo
  Parser di espressioni infisse-prefisse-postfisse
  Derivate Simboliche
  Media geotmetica
  Verificare l'esistenza di un simbolo
  Primi troncati
  Contenimento del quadrato

NOTE LIBERE 4
=============
  Una relazione tra π ed e
  Ricerca del numero diverso
  Ricerca del numero singolo
  Punti in un semicerchio
  Coefficiente di Sorensen-Dice
  Parole di Lyndon
  Fattorizzazione di Lyndon
  Rimozione dei multipli
  Rock Paper Scissors
  TODO application
  Quine e Narciso
  Test di primalità
  Passeggiata casuale lungo una linea
  Serie di teste e croci (valore atteso)
  Ricerca con caratteri jolly (wildcard)
  Funzioni logiche booleane
  Tavole di verità
  Numeri Brasiliani
  Probabilità condizionata
  Teorema di Bayes 1
  Teorema di Bayes 2
  Probabilità bayesiane
  Dadi
  replace multiplo
  ASCII Mandelbrot
  Yahtzee
  Gioco del 15
  Numeri rari
  Patience Sort
  Lista degli indici di una lista
  Buche sulle strada
  Storia delle variabili
  Numeri di Chowla
  Secondi -> periodo
  Partizione di una lista in due parti con somme uguali
  Numeri di Zumkeller
  Numeri di Leonardo
  Frequenza caratteri
  Frequenza parole
  Magic 8-Ball
  I Ching
  Problema ABC
  Compressione/Decompressione intervallo di valori
  Plot di funzioni
  Spirale di Archimede
  Misure angolari
  Numero di settimane
  Il gioco del 21
  Fattoriale sinistro (Left factorial)
  Numeri primi lunghi
  Numeri Tau
  Sequenza Yellowstone
  Distanza di Jaro
  Pietre e gioielli (Stones and Jewels)
  Numeri super-d
  Algoritmo di Bresenham
  Associare gli elementi di una lista ogni k
  Somma delle potenze delle cifre
  Bruchi saltellanti
  Buste matrioska
  ASCII Julia
  Dado da 7 con dado da 5
  42 in newLISP e C
  Uguaglianza approssimata
  Primi sexy
  Tavola pitagorica
  Sottostringa più piccola che contiene tutti i caratteri di una stringa
  Algoritmo Floyd-Warshall
  Triangoli casuali
  Triangoli e bastoncini
  Generazione di una lista di numeri casuali che sommano a 1
  Numeri disarium
  Numeri promici
  Formula di Erone
  Tre funzioni per calcolare la potenza di un numero intero
  Numeri Armstrong (narcisistici)
  Evoluzione dell'algoritmo per la moltiplicazione di due numeri interi
  Indice di equilibrio
  Numero soluzioni equazione lineare a k variabili
  Internet-point

NOTE LIBERE 5
=============
  Spostamento di zeri
  Quadratura approssimata
  Introduzione alla programmazione dinamica
  Programmazione dinamica: il gioco delle pentole d'oro (pots of gold)
  Somma delle cifre in posizioni pari e dispari
  Ordinare una lista con un'altra lista
  Test di Lucas-Lehmer
  0,1,2 con 0,1
  Angolo delle lancette di un'orologio
  Data e ora
  Corda intorno alla Terra
  Eredità
  Sequenza di Farey
  Distanza di Chebyshev
  Anti-primi
  Numeri altamente abbondanti
  Creazione dinamica di variabili
  La funzione curry
  Algoritmo evolutivo
  Nome del programma
  loop e recur macro
  Breve introduzione ai grafi
  Lanciare N volte una moneta
  Problema dei fiammiferi di Banach con N scatole
  Conflitti read-write nelle transazioni di un database
  Unico elemento diverso in una lista
  1 o 2
  Generare tutte le coppie di elementi di una lista
  Numero di partite nel Tic-Tac-Toe
  Estrazione dati da file PDF
  Media continua
  Sequenza di Kolakoski
  Da stringa generica a stringa palindroma
  Frasi e semplici regole grammaticali
  commonLISP in newLISP
  Peso ideale e indice di massa corporea
  Sequenza di Golomb
  Acquistare e vendere azioni
  Numeri armonici
  Valore atteso e linearità dell'aspettativa
  Numero previsto di prove fino al successo
  Moltiplicazione ricorsiva
  Il gioco del Lotto
  Hash-map e contesti
  Numeri di Narayana
  Numeri di Motzkin
  Permutazioni, Disposizioni, Combinazioni
  Valore massimo di una lista ordinata
  Treni e binari
  Mastermind (by Norman)
  newLISP banner
  Puzzle di Gordon Lee
  Orologio ANSI
  Indici ordinali
  Generazione di password
  Verifica accessibilità siti web
  Miglior punto d'incontro
  Stringhe Unicode (UTF8) o ASCII
  Le funzioni "set-nth" e "nth-set" (deprecate)
  Somma di interi rappresentati come liste
  Equazione diofantea lineare
  Cache LRU
  Un bug della versione 10.7.5
  Algoritmo LZW (Lempel Ziv Welch)
  Moltiplicazione di due polinomi
  Addizione di due polinomi
  Sottrazione di due polinomi
  Dadi e somme
  Stringhe e dizionari (word break)
  Estrazione codice sorgente da eseguibile newLISP
  Algoritmo Boyer Moore (Voto di maggioranza - Majority element)
  Convertire 0 in N (+1 o *2)
  Funzione substring di Java
  Clojure-style Tail Recursion in newLISP
  Sviluppo di una funzione
  Closures (chiusure)
  Il concetto di base dei contesti in newLISP
  Numeri palindromi e numeri di Lychrel
  Numeri primi di Sophie Germain
  Il numero 666

NOTE LIBERE 6
=============
  Problema di Brocard
  Errore quadratico medio (Mean Square Error - MSE)
  Sequenze aliquot
  Assegnazione di valori tra liste
  Help macro
  Sequenza di Recaman
  Strutture dati autoreferenziali
  Calcoli nel tempo
  Text file utilities
  Code Obfuscation
  newLISP compiler?
  Frazioni egizie
  Formule polinomiali per numeri primi
  Nomi delle variabili/funzioni e velocità di esecuzione
  Radici primitive di un numero primo
  Salto della rana 1
  Salto della rana 2
  Numeri regolari (5-smooth)
  Conversione di una lista in un file .csv (excel)
  Selezione di elementi con indice pari o dispari
  Numero interno all'intervallo
  Love newLISP
  Creazione dinamica dei contesti
  Ricerca elementi dalla fine (stringhe o liste)
  eval, eval-string, read-expr
  newLISP from newLISP
  Valutazione di una funzione
  Metodi di Monte Carlo
  Metodi di Las Vegas
  Vincere 2 volte su 3...
  Ombrelli
  Duello continuo
  Cucciolata
  Cancellare/modificare gli elementi di una lista mentre la si attraversa
  Punto interno ad una sfera
  Correttori di bozze
  Probabilità: 1 su quanti?
  Sondaggi imbarazzanti
  Corte di giustizia
  Programs Launcher
  Duello tra idioti
  Formula di Bernoulli
  Palestre e autobus
  Somma di una serie di numeri: algoritmo di Kahan
  Numeri in base negativa
  Serie e somma armonica
  Raccolta di figurine
  Strano ma vero
  Passeggiata casuale (random-walk)
  Per gioco
  Scontro al bar
  La fallacia dello scommettitore
  La rovina del giocatore d'azzardo (Gambler's ruin)
  Roulette
  Separazione dei numeri uguali
  Spezzare un bastone
  Modello di Ehrenfest
  Media delle corrispondenze
  Media delle percentuali dei valori = Percentuale della media dei valori
  Quanti sono?
  Variabile random esponenziale
  Struttura dati: quack
  Elezioni
  Ricorsione e calcolo delle probabilità
  Match scacchistico
  Valore massimo e minimo con relativi indici
  Buon 2022
  Un bug della versione 10.7.6
  Rolling Hash
  Numero di espressioni valide con N parentesi
  Unione di liste/vettori ordinati
  Celsius <--> Fahrenheit
  Macro e variabili libere
  Creating statically scoped functions in newLISP
  Pavimenti e piastrelle
  Algoritmo minimax
  K punti più vicini all'origine
  Creazione di un accumulatore
  Numeri k-primi
  Chiave segreta

NOTE LIBERE 7
=============
  Hash-Map Quick Reference Guide
  Hash-Map General management functions
  KiloByte e KibiByte
  Blog di Cyril Zlobin
  Lambda the Ultimate
  Stati, Transizioni e catene di Markov
  Modifica di una lista con un pattern
  Fisher-Yates shuffle
  Una funzione trigonometrica interessante
  Modificare le liste di associazione
  Estrazione di elementi con probabilità predefinite
  Disporre i numeri di una lista nella forma: basso->alto->basso
  Poker d'Assi
  Sparse-matrix
  Perchè (-) × (-) = (+) ?
  Perchè newLISP indicizza da zero?
  Encode e decode URL
  Divisione di due polinomi
  Coda di priorità
  Triangoli eroniani
  Benchmark: passaggio per valore e passaggio per riferimento
  Sort topologico
  Creazione dinamica di variabili e funtori di default
  Formula shoelace
  Numeri casuali e intervalli
  Distribuzione casuale modificata
  Short-circuit evaluation
  Algoritmo di Bellman-Ford
  Fattoriale quasi esatto
  Algoritmo "Fast inverse square root" e 0x5f3759df
  Composizione multipla di funzioni
  Regressione lineare (Metodo dei minimi quadrati)
  Regressione polinomiale (Metodo dei minimi quadrati)
  Ordinamento naturale (Natural Sort)
  D. Backspace e AlphaCode
  isclose(x, y) di python 3
  Dimostrazione della soluzione dell'equazione quadratica
  La parola chiave "lambda"
  Addizioni e sottrazioni alternate
  Creazione di vettori/matrici (array) e liste con valori casuali
  Alcune funzioni sugli angoli
  Formattazione di numeri ordinali
  Programmazione Funzionale e Pensiero Funzionale
  Unione di liste di attributi (zip)
  net-eval e calcolo distribuito (distribute computing)
  Numeri di Lynch-Bell
  Algoritmo Lee - Ricerca del percorso in un labirinto
  Fredkin gate
  La funzione "amb"
  Numeri con somma uguale delle cifre con indice pari e dispari
  Velocità dei cicli in newLISP
  Quicksort iterativo
  Funzioni con stato
  Collisione dei contesti (context)
  Simulazione del lancio di dadi
  Creazione di immagini con ImageMagick
  Attrattore di Clifford
  Controllare se un numero è NaN (Not a Number)
  Interpolazione dei colori
  Distanza tra due colori
  Random-walk
  Script e argomenti della linea di comando
  Creazione di una serie di colori
  Traslazione e scalatura di punti
  SameGame - ChainShot
  Stooge Sort
  Slow Sort
  Bogo Sort
  CriptoAritmetica
  Centroide di un insieme di punti
  guiserver.lsp
  La funzione memcmp del C
  Algoritmi di string matching
  La funzione assert del C
  Rappresentazione dei grafi: Lista di Adiacenza <--> Matrice di Adiacenza
  Attraversamento di grafi - Algoritmo BFS (Breadth-First Search)
  Attraversamento di grafi - Algoritmo DFS (Depth-First Search)
  Passare una funzione con argomenti come parametro
  Funzioni nelle liste
  Limite di annidamento delle liste

NOTE LIBERE 8
=============
  Creazione di un contesto da una variabile
  Creazione di contesti con una funzione
  Mini-puzzle
  Minimo, massimo e indici
  Wordle
  Quadruple pitagoriche
  Formula di Haversine
  Formula di Lamberts
  Metodo di bisezione
  Metodo delle secanti
  Metodo di Newton
  Conversioni tra unità di misura
  La funzione append e append-nil
  Knapsack 0-1
  La funzione read-key
  Problema del cambio delle monete
  Interesse semplice e composto
  Massima sottostringa comune (longest common substring)
  Massima sottosequenza comune (longest common subsequence)
  Massima sottosequenza crescente (longest increasing subsequence)
  Numeri potenze di due
  Numeri di Proth
  Funzione sigmoid
  Algoritmo Round-Robin
  Lettura di righe o colonne di una matrice
  Modifica di righe o colonne di una matrice
  La funzione count (per stringhe e vettori)
  Onesti e Bugiardi
  I tre prigionieri
  Primi Home
  Numeri figurati poligonali
  (* x x) è più veloce di (pow x 2)
  Sequenza di Padovan
  Fattorione (numero di krishnamurthy)
  Numeri Star
  Numeri emirp
  Numeri con tutte le cifre uguali
  Numeri magici (magic number)
  Numeri polidivisibili
  Algoritmo jump search
  Numeri intoccabili (untouchable)
  Powerset di una lista
  Somme dei sottoinsiemi di una lista
  Somma dei sottoinsiemi (Subset Sum Problem)
  Numeri pratici
  Creare file di testo Windows e Unix
  Radicale di un numero
  Fattoriale e funzione Y
  La funzione explode
  Formula di Faulhaber
  Numeri piramidali quadrati
  Numeri potenti
  Combinazioni di punteggi per comporre un dato numero
  Pangram (pangramma)
  Problema K Centers
  Verificare se due segmenti/rette sono paralleli
  Verificare se due segmenti/rette sono ortogonali
  Quadrato, rettangolo, rombo o quadrilatero?
  Enigma machine
  Radice cubica
  Radice n-esima
  Analisi numerica e numeri in virgola mobile (floating point)
  Stabilità degli algoritmi di ordinamento
  Colorazione di un grafo (m Coloring Problem)
  Memoization
  Auto-replicazione di una lista
  La funzione sort
  Algoritmo K-Means
  Comportamento Lazy
  SBCL Mandelbrot
  La funzione constant
  La funzione global
  map e curry
  Trasformare la struttura di una lista
  Elementi duplicati/multipli di una lista
  Nome della funzione
  Complessità di una lista
  Eliminare sottoliste da una lista annidata
  Le funzioni set-ref e set-ref-all
  set-ref-all: differenze tra $0 e $it

NOTE LIBERE 9
=============
  La lunghezza di nil
  Vocali, consonanti e cifre in una stringa
  Pseudo-closures con gensym
  Passaggio di elementi di una lista come argomenti di funzione
  Differenza tra let e letex
  Ricorsione cond
  Come funziona (define (sum (x 0)) (inc 0 x)) ?
  Estrazione da una lista con un pattern
  Creazione di liste con struttura predefinita e valori casuali
  Assegnazione doppiamente quotata
  Esercizio
  Cicli senza cicli
  Ciclo Sattolo
  Lewis Carrol e le biglie
  Ricerca di elementi in una lista e in una hash-map
  Aerei della seconda guerra mondiale
  Il gioco del caos (the chaos game)
  Punto a distanza L e pendenza M da un altro punto
  Ricerca di una lista di elementi in una lista
  Classificazione dei triangoli
  Algoritmo CYK
  Coppie simmetriche
  Dirigenti e impiegati
  Terne con somma zero
  for-each di Scheme
  Delete symbol vs setting symbol to nil
  Similarità tra stringhe con il metodo dei trigrammi
  Crittografia one-time pad (OTP)
  Fern: il frattale di Barnsley
  Miller: gestione CSV,TSV,JSON
  La funzione labels del LISP
  A LISP programming exercise
  Formattazione di nil
  La funzione juxt di Clojure
  La funzione if-not
  Simulare un iteratore python
  Modifica/aggiornamento di una lista annidata
  Algoritmo del punteggio (Scoring algorithm)
  Alfabeto, cifre, caratteri
  Inverso modulare (modular inverse)
  La lista vuota () e la stringa vuota ""
  Multiple dispatch
  Palindromo più vicino
  Comparative macrology
  exit e reset negli script
  Tug of War
  Estrazione elementi da una lista
  Punti fissi di una lista
  Numero mancante in una progressione aritmetica
  List comprehensions
  map e funzioni con argomenti multipli
  Divisione incongrue
  Numeri causali e numero di eulero
  Funzioni come liste
  Numeri cistercensi
  La funzione match
  Analisi DNA
  Caratteri a matrice di punti
  Importazione di funzioni di libreria in linguaggio C
  Problema di McNuggets
  Frequenza delle parole di un testo
  Velocità di indicizzazione delle liste
  Comma quibbling
  Numeri di Rhonda
  args, $args e main-args, $main-args
  Unit testing
  Area di una circonferenza (montecarlo)
  Area di intersezione tra due circonferenze
  Gocce dal soffitto
  La saggezza della folla
  Zodiaco cinese
  Kilometri e miglia (terrestre, marine/nautiche)
  FOOP e self
  exec e redirezione di stdout e stderr
  Numeri magnanimi
  Aggiornamento dei valori dei simboli
  Numeri aritmetici
  Contesti come dizionari
  Interazione tra context, constant, e global
  Indice di Gini

NOTE LIBERE 10
==============
  Turochamp
  Riempimento di contenitori
  Chess puzzle 1
  Chess puzzle 2
  Quale gioco?
  Usare una funzione come macro
  Operazioni tra numeri stringa
  Confronto tra gli elementi di una lista
  Numeri colorati
  Numeri brillanti
  StrappaCamicia
  Circonferenza passante per tre punti
  Determinante di una matrice
  Multiple Value Bind macro
  100 prigionieri
  Morra Cinese
  Rubamazzo
  Numeri dei reparti
  Generatore circolare
  Numero di linea di uno script
  Interpolazione di una stringa
  Testing macro
  Trasformazione Box-Muller
  Cerchio minimo di inclusione (Minimum Enclosing Circle)
  Prodotto di Kronecker
  Numeri di Lha
  Settore circolare
  Corda del cerchio
  Esperimento dell'imbuto (Funnel Experiment)
  Fase della luna
  Varianza e deviazione standard, (N-1) oppure N?
  Jensen Device
  Il principio dei cassetti ("pigeonhole principle")
  Principio di inclusione-esclusione
  Fattoriale crescente e fattoriale decrescente
  Parentesi quadre
  cons e push
  newLISP "leggero"
  Hex dump
  Da quanto tempo newLISP è in esecuzione?
  ORO, passaggio per valore e passaggio per riferimento
  Segmenti sovrapposti
  Media di numeri "nascosti"
  Chiavi e lucchetti
  Golden ratio, SuperGolden ratio e Plastic number
  Costante di Feigenbaum
  Numeri estetici
  Colore dei cappelli
  push all'inizio o alla fine della lista?
  Funzione "itoa"
  Medie statistiche
  Numeri duffiniani (Duffinian)
  Numeri equidigitali
  Costante di Eulero-Mascheroni 0.5772156649...
  Stampare un testo molto lungo
  Flip matrix game
  Entropia di Shannon
  Triangolo di Floyd
  Problema algebrico
  Horizontal sundial
  FizzBuzz generico
  Numeri di Jacobsthal e Jacobsthal-Lucas
  La formica di Langton (Langton's ant)
  Il gioco di Penney
  Prezzi frazionati
  Tre cifre centrali
  Inversioni di frase
  map range - rescale
  I cinque numeri di Tukey (Tukey's fivenum)
  Modulino
  I limiti del ciclo for
  Topswops
  Musica maestro (beep)
  Numeri primi ultra-useful
  Lista dei file di una cartella
  Creazione di immagini in formato PPM
  Wave Sort
  1 o 2
  Little Endian e Big Endian
  Conversione Binario-Gray e Gray-Binario

NOTE LIBERE 11
==============
  Il problema della celebrità
  Turtle Graphics (by newbert)
  Dimensioni di un file JPG (by Cyril)
  Seven segments display
  Regular paperfolding sequence e dragon curve sequence
  Sequenza di Hofstadter-Conway $10000
  Sommatoria e produttoria di una funzione
  Teorema di Nicomachus (somma del k-esimo gruppo di numeri positivi dispari)
  Numeri Hoax
  Numero di cifre dei fattoriali (formula di Kamenetsky)
  Massimo sottoinsieme con MCD = 1
  Coppie di cubi
  MCD delle cifre di un numero
  La funzione DEFUN del Common LISP
  Spirale di Ulam
  Coefficiente di correlazione
  Numeri frugali
  Numeri Blum
  Firma dei primi (Prime signature)
  Numeri di Achille
  Numeri di Perrin
  a*x + b*y = n
  Sorry... i'm floating point
  Numeri sequenziali come stringa
  6174 - La costante di Kaprekar
  Minimo Comune Multiplo (MCM) - Least Common Multiple (LCM)
  Ruote dentate
  curry e hayashi
  Ricerca nelle liste di associazione
  Orientamento di tre punti
  Algoritmo della prossima permutazione lessicografica
  Formula per calcolare i numeri primi
  Creazione automatica di simboli/variabili
  Uso particolare degli operatori AND e OR (Short-circuit)
  Condividere un numero segreto (Shamir Secret Sharing)
  Inversione dei valori di un matrice binaria (0 -> 1), (1 -> 0)
  Logaritmi: ln, log2, log10, logN
  Dobble (Spot It) Game
  Conteggio di Morris
  Orientamento di un poligono
  Il problema della Bella Addormentata (Sleeping Beauty Problem)
  Per divertimento
  Posizione di scacchi casuale - random chess position
  Struttura dati generica
  Differenza simmetrica negli insiemi (set)
  Problema dei nomi degli Stati (State name puzzle)
  Consigli del Buddha
  Sequenza cifre-primi di Smarandache
  Ricerca del numero più vicino in una lista
  Numeri primi Pierpont
  Punti, linee, polilinee, poligoni
  Sequenza di Van Eck
  Addizione tra numeri interi (stringhe)
  Sottrazione tra numeri interi (stringhe)
  Numeri primi additivi
  Numeri primi-primi
  Distanza di un punto da un segmento
  Sostituire globalmente il testo in più file
  Copiare da "stdin" a "stdout"
  Eliminare/cambiare caratteri di una stringa (trim e replace)
  Problema delle Somme quadrate (Square-Sum problem)
  Brainfuck
  Problema del serbatoio
  Alcuni chiarimenti su newLISP
  La signora degusta il tè (Lady Tasting Tea)
  Partizioni di sequenze di interi
  Punteggi scacchistici
  Addizioni e sottrazioni esatte di numeri in virgola mobile
  Funzione slice di python
  Coefficienti multinomiali
  Sicurezza delle password
  Cattura di pagine web
  Generazione delle cartelle della tombola
  Prefix e Suffix Sum Array
  Minimize difference of Contiguous Sublist Sum
  Minimize difference of Sublist Sum
  Bambini e caramelle (Candy Lottery)
  DNS Query
  Libreria
  Probabilità della somma dei dadi in un intervallo

NOTE LIBERE 12
==============
  Sviluppo di programmi commerciali
  The Paradox of the Question
  Copia/Taglia e Incolla una stringa
  Massima Sequenza DNA
  Il gioco della tombola
  Modi per distribuire m oggetti tra n persone
  Problema di algebra elementare
  Minimo e massimo tra due frazioni
  Eventi singoli e ripetuti
  Somma delle coppie e ritorno
  Get data from a C structure
  Radice quadrata di numeri complessi
  Distributore d'acqua difettoso
  Dado con 100 facce
  La funzione bind
  Lattine ottimizzate
  Il gatto e il topo
  Palle da biliardo
  Espressioni condizionali in una lista
  Poligoni e formiche
  Cellulare e batterie
  Aree minime e massime
  Da 1 a 1 milione
  Il gioco della sequenza
  Problema delle 8 regine (8 queen)
  Dieta
  Lavorare insieme
  Musica casuale
  Sequenza strana
  Pierino e le mele
  Dado e numero ripetuto
  Dado truccato
  Lisp 1.5 Manual - John McCarthy
  Ciclo for con due indici
  Challenge: the seemingly simple 'my-or'
  Link simbolico di oggetti
  Il numero 0 è pari o dispari?
  Rapporto tra numeri casuali
  Definizione di funzioni all'interno di funzioni
  La funzione for-all
  La funzione random
  Freccette
  Lights Out Game
  Risiko!
  Open doors
  Divisibilità dei fattoriali
  Paradossi delle buste
  Parse numbers from a list of symbol
  Esempio di programmazione FOOP
  Peg solitaire
  Il gatto, la tartaruga e il tavolo
  Problema di Basilea
  Forum: In-place parameter substitution
  Forum: How to solve context collision
  Creazione di una REPL personalizzata
  Forum: closure?
  Forum: Why no closures?
  Spirale numerica
  read-line, current-line, read-char, current-char
  Poligoni su reticolo di punti (lattice)
  Problema con i Bit
  Bit string
  Sviluppi in serie di Taylor e Maclaurin
  Equazione di quarto grado
  Gestione stipendi (Salary Queries)
  Teorema di Wilson e numeri primi
  Patate disidratate
  Taxi verdi e blu
  Short classic puzzle
  Risultati delle votazioni
  Il paradosso di Simpson e la fallacia di Berkson
  Forum: The semantics of newLISP's if
  Forza 4 - Connect Four
  Moltiplicazione fra matrici e stress-test
  Estrazione di sotto-matrici
  Unione di sotto-matrici
  La leggenda della nascita degli scacchi
  Quante cifre ha x^y^z?
  La funzione unget del C
  Cartella corrente/lavoro - Current/Working directory

NOTE LIBERE 13
==============
  Moltiplicazione tra matrici - Algoritmo di Strassen
  Ricerca in una matrice di numeri uguali in sequenza
  Potere di acquisto
  Copertura di segmenti con punti
  Distanza approssimata tra due punti - Fast square root trick
  Errore quadratico medio (RMSE) e errore medio percentuale (MAPE)
  TimSort
  Counting Sort
  Caratteristiche dei principali algoritmi di ordinamento
  Il quadrato magico SATOR
  Alberi binari completi con vettori/liste
  Algoritmo Undo/Redo
  Multiple stack/queue
  FLAMES: il gioco delle relazioni
  Newton forward and backward interpolation
  Ragazzi e ragazze
  Divisione del premio
  Codice numerico univoco per stringhe (ASCII)
  Hotel e turisti
  Ordinare 0 e 1
  Salvare la definizione di un simbolo in una stringa
  Loop infinito
  Simulazione della funzione LOAD
  Unione veloce di stringhe
  The nice thing
  Pigeonhole Sort
  Bucket Sort
  Creazione automatica di contesti
  Forum: A quasiquote implementation in newLISP
  Raggruppare i valori di una lista associativa che hanno la stessa chiave
  Ramanujan e il taxi 1729
  Numero somma di due cubi
  Cubo perfetto
  Forum: Define-macro: new behind-the-curtains behavior
  Invarianti e barre di cioccolato
  Short Chess Game
  Quantili, quartili, percentili
  Box-plot e valori anomali (outlier)
  Selezionare colonne in una matrice (lista a due dimensioni)
  Forum: kazimir majorinc wrote
  Forum: fnparse to get all used functions
  LISP syntax and evaluation
  Gestione degli elementi (nome valore) in una lista
  Controllo parentesi nei file sorgenti
  Statistica: Skewness e Kurtosis
  Dadi e funzioni generatrici
  Forum: Tiny Lisp course - Lisp in 10 bullets
  Funzione "filter"
  Funzione "index"
  Formattazione di numeri interi e float (no "format")
  Pack Length Bytes
  Verificare la lunghezza di una lista
  Suddividere gli elementi di una lista (no "explode")
  Funzioni di autoincremento
  Undocumented "apply"
  La funzione "replace-assoc" (deprecata)
  Insertion Sort
  Rimuovere i commenti
  Rimuovere una sequenza di elementi uguali da una lista
  Verificare l'esistenza di un contesto
  Lutz Computer 2006
  Forum: Help with some basic object-oriented programming
  Forum: Formatting of println output
  Here document
  Numeri di Keith
  Numeri ondulati
  La funzione "replace"
  Translating S-expressions into XML
  Forum: On recursive procedures
  Sequenza di Sylvester
  Numeri di Cullen e di Woodall/Riedel
  Moltiplicazione, divisione, addizione e sottrazione di interi solo con "+"
  Modulo 10^9+7 (M = 1000000007)
  Primo elemento uguale tra due liste
  Ordinare parte di una lista
  Numero maggiore con le stesse cifre
  Numero minore con le stesse cifre
  x + y + z = x * y * x
  chatGPT e newLISP
  Forum: Context switch

NOTE LIBERE 14
==============
  Triangolo di Hosoya
  Divisione Modulare
  Potenza (esponenziazione) modulare
  Aspettativa matematica o valore atteso di una lista
  Script caricato dalla REPL o dal terminale?
  Captcha
  Somma della serie (n/1) + (n/2) + (n/3) + (n/4) + ... + (n/n)
  Palline e contenitori (Balls and Bins)
  Invertire le cifre di un numero
  Fattorioni e anti-fattorioni
  Stelle e barre (Stars and bars)
  La funzione "yield" di python
  Riflessione di un punto P lungo una linea AB
  Quale nazione?
  Reservoir Sampling
  Punti di intersezione tra due circonferenze
  Clessidra pattern
  Punti interi e circonferenze
  Problema del cerchio di Gauss
  Confronto tra numeri
  Storia di una intervista per programmatori (Programming interview)
  Trovare il perimetro
  Numeri speciali
  Numeri ciclope
  Somma di due quadrati consecutivi
  Somma di almeno due quadrati consecutivi
  Numeri somma di numeri consecutivi
  Best time to Buy and Sell Stock
  Analisi degli elementi di una lista/funzione
  Sequenza crc32
  Sort con memoria
  email address
  Warden and prisoners (Guardiani e prigionieri)
  Valori di default per i parametri di una funzione
  Da iterativo a funzionale
  La funzione "dup"
  Profiler casalingo
  La funzione "member"
  States & Provinces contiguity check
  Pensieri sparsi per imparare a programmare
  La tecnica di Feynman
  La matrice di Eisenhower
  Forum: Lispy regexes
  Restituire una stringa senza i doppi apici ""
  Allineamento di numeri floating point
  Crittografia MD5
  Funtori e dizionari
  Dividere una lista/stringa
  La funzione "expand"
  Aggiornamento dinamico dei simboli di una lista
  Some math functions
  Eliminazione sicura di un file
  Perfect Digital Invariant number (Numero invariante digitale perfetto)
  Floating-point tolerances revisited
  Five programming problems
  Numeri pandigitali quadrati
  Numeri pandigitali polidivisibili
  La funzione "sgn"
  Area di sovrapposizione di rettangoli
  Network programming and distributed scripting with newLISP
  Convertire una espressione in stringa
  Sequenze di interi con somma N
  Numero successivo con cifre distinte
  Differenza tra i caratteri "" e i caratteri {}
  Cryptography fun with newLISP
  sym e context
  Cifratura Atbash
  Cifrario quadrato di Polibio
  I dischi crittografici di Leon Battista Alberti
  Cifrario di Vernam e algoritmo One Time Pad (OTP)
  La tabula recta
  A trivial P2P file sharing
  Prodotto minimo e massimo con 9 cifre
  Somma di cubi di frazioni
  Coroutine
  Somma massima di elementi non contigui
  Somma delle cifre dei numeri da 1 a N
  Funzione di aiuto per il debug
  REPL e colori
  Conversione colori RGB <--> HEX

NOTE LIBERE 15
==============
  Potenze più vicine ad un numero
  Problemi di pesatura (con bilancia a due piatti)
  Problemi di pesatura (con bilancia a molla)
  Punto interno ad un triangolo
  Punto interno ad un rettangolo
  Ricerca in una lista di numeri adiacenti
  Super primi
  Candy crush
  Primi con cifre prime univoche
  Polinomi generatori di sequenze - Metodo delle differenze
  Prima e ultima cifra di un numero intero
  Numeri unprimeable
  Numeri Gilda
  Numeri upside-down
  Primi di Honaker
  Numeri plaindrome
  Coppie di primi Ormiston
  Numeri Rhonda
  Numeri Sastry
  Hamming weight
  Primo carattere meno frequente in una stringa
  Numeri nudi
  Numeri di Zuckerman
  Numeri di O'Halloran
  Coppie di Ruth-Aaron
  Stack con valori minimo e massimo
  Numeri di Leyland
  Numeri apocalittici
  Numeri fattoriali alternati
  Derivata aritmetica
  Numeri metadrome plaindrome, nialpdrome e katadrome
  Numeri zigodromi
  Numeri modesti
  Attraversamento di liste e stringhe (numeri palindromi)
  Tipi di numeri primoriali
  Quanti numeri primi ci sono?
  Somma degli inversi dei numeri primi
  Numeri k-iperperfetti
  

APPENDICI
=========
  The fifteen ideas characterizing LISP
  Lista delle funzioni newLISP
  Sul linguaggio newLISP - FAQ (Lutz Mueller)
  newLISP in 21 minuti (John W. Small)
  newLISP per programmatori (Dmitry Chernyak)
  notepad++ bundle
  Visual Studio Code e newLISP
  Debugger
  newLISPdoc - Il programma per la documentazione newLISP
  Compilare i sorgenti di newLISP
  Ricorsione e ottimizzazione della chiamata di coda (Tail Call Optimization)
  F-expression - FEXPR
  newLISP - Lisp per tutti (Krzysztof Kliś)
  Ricorsione avanzata in newLISP (Krzysztof Kliś)
  A Look at newLISP (Alexandru Lazar)
  Differenze tra newLISP, Scheme e Common LISP (Lutz Mueller)
  Chiusure, contesti e funzioni con stato (Lutz Mueller)
  Creazione di funzioni con ambito lessicale in newLISP (Lutz Mueller)
  "The Y of Why" in newLISP (Lutz Mueller)
  Valutazione delle espressioni, Indicizzazione Implicita, Contesti e Funtori di Default (Lutz Mueller)
  Gestione Automatica della Memoria in newLISP (Lutz Mueller)
  Benchmarking newLISP
  Frasi sulla Programmazione e sul Linguaggio Lisp
  Prefissi del Sistema Internazionale di unità di misura
  Alfabeto greco
  Codici nazionali (ISO 3166)
  Codici ASCII

BIBLIOGRAFIA/WEB
==================

YO LIBRARY
==========
"yo.zip" Libreria per matematica ricreativa e problem solving (231 funzioni)

DOCUMENTAZIONE EXTRA
====================
  A) Introduction to newLISP (by Cormullion)
  B) Code Patterns (by Lutz Mueller)
  C) The Little newLISPER
  D) Kazimir-Blog (by Kazimir Majorinc)

==========================================================================

LICENSE

MIT License

Copyright (c) 2019-2023 Massimo Corinaldesi aka cameyo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

==========================================================================
Klaatu barada nikto
==========================================================================

=============================================================================

