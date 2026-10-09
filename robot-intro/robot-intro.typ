#let ink = rgb("#212630")
#let accent = rgb("#3e63dd")
#let accent-scuro = rgb("#2c46b8")
#let tinta = rgb("#eef3fd")
#let ambra = rgb("#e9a13b")
#let ambra-scuro = rgb("#a86508")
#let ambra-tinta = rgb("#fdf3e2")
#let carta = rgb("#fffaf0")
#let codice-bg = rgb("#f4f5f7")
#let evidenziata = rgb("#e7eefb")
#let mono = "DejaVu Sans Mono"

#set document(title: "Dal robot al codice", author: "")
#set page(
  paper: "a4",
  margin: (top: 2.1cm, bottom: 2.4cm, x: 2.2cm),
  footer: context [
    #set text(size: 8.5pt, fill: luma(140))
    #stack(dir: ttb, spacing: 7pt,
      line(length: 100%, stroke: 0.5pt + luma(225)),
      align(center)[Dal robot al codice #h(10pt)·#h(10pt) #counter(page).display()],
    )
  ],
)
#set text(lang: "it", region: "IT", size: 11pt, fill: ink)
#set par(justify: true, leading: 0.65em)
#set heading(numbering: "1.1")
#set list(marker: (text(fill: accent)[•],), indent: 1em, spacing: 0.7em)
#set raw(tab-size: 2)

#show raw.where(block: true): it => block(width: 100%, fill: codice-bg, radius: 4pt, inset: (x: 10pt, y: 9pt), outset: (y: 3pt), stroke: none)[#it]
#show raw.where(block: false): it => box(fill: codice-bg, inset: (x: 3pt, y: 1pt), outset: (y: 2pt), radius: 3pt)[#it]

#show heading.where(level: 1): it => block(above: 1.6em, below: 1em, width: 100%)[
  #box(fill: accent, inset: (x: 7pt, y: 4pt), radius: 4pt, baseline: 32%)[
    #text(fill: white, weight: 800, size: 12pt)[#counter(heading).display()]
  ]
  #h(9pt)
  #text(size: 17pt, weight: 800, fill: ink)[#it.body]
  #v(-2pt)
  #line(length: 100%, stroke: 2.2pt + accent)
]

#show heading.where(level: 2): it => block(above: 1.4em, below: 0.75em)[
  #text(fill: accent, weight: 800, size: 12.5pt)[#counter(heading).display()]
  #h(7pt)
  #text(fill: ink, weight: 700, size: 12.5pt)[#it.body]
  #v(3pt)
  #line(length: 2.3em, stroke: 1.6pt + accent)
]

#show heading.where(level: 3): it => block(above: 1.1em, below: 0.5em)[
  #text(fill: accent-scuro, weight: 700, size: 11.5pt)[#it.body]
]

#let chip(txt) = box(fill: accent, inset: (x: 5pt, y: 2.5pt), outset: (y: 2pt), radius: 3pt)[
  #text(fill: white, size: 0.82em, font: (mono,), weight: 600)[#txt]
]

#let istruzione(firma, nome, testo) = block(
  width: 100%,
  fill: white,
  stroke: 0.7pt + luma(218),
  radius: 4pt,
  inset: 8pt,
  above: 7pt,
  below: 7pt,
)[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 7pt,
    align(center)[#chip(firma)],
    [
      #text(weight: 700, size: 0.95em, fill: ink)[#nome]
      \
      #text(size: 0.85em, fill: luma(105))[#testo]
    ],
  )
]

#let etichetta(txt) = text(size: 7.6pt, weight: 700, tracking: 0.14em, fill: luma(118))[#upper(txt)]

#let stella(pieno: true, dim: 0.78em, col: ambra) = {
  let r = dim / 2
  let pts = ()
  for i in range(10) {
    let a = 90deg - i * 36deg
    let rad = if calc.rem(i, 2) == 0 { r } else { r * 0.42 }
    pts.push((r + rad * calc.cos(a), r - rad * calc.sin(a)))
  }
  box(baseline: 40%)[
    #polygon(fill: if pieno { col } else { none }, stroke: 1pt + col, ..pts)
  ]
}

#let stelle(n) = box(baseline: 40%)[
  #for i in range(3) {
    if i > 0 { h(2.5pt) }
    stella(pieno: i < n)
  }
]

#let freccia(len: 1.1em, col: accent) = {
  let punta = ((0pt, 0pt), (0.32em, 0.16em), (0pt, 0.32em))
  box(width: len + 0.3em, height: 0.36em, inset: 0pt, baseline: 40%)[
    #place(dx: 0pt, dy: 0.17em, line(start: (0pt, 0pt), end: (len, 0pt), stroke: 1.3pt + col))
    #place(dx: len - 0.05em, dy: 0.02em, polygon(fill: col, ..punta))
  ]
}

#let robottino(col: accent) = box(width: 1.15em, height: 1.4em, inset: 0pt, baseline: 34%)[
  #place(dx: 0.5em, dy: 0em, circle(radius: 0.075em, fill: col))
  #place(dx: 0.575em, dy: 0.15em, line(start: (0em, 0em), end: (0em, 0.21em), stroke: 1pt + col))
  #place(dx: 0em, dy: 0.36em, box(width: 1.15em, height: 0.94em, inset: 0pt, stroke: 1.1pt + col, radius: 0.16em)[
    #place(dx: 0.255em, dy: 0.575em, circle(radius: 0.085em, fill: col))
    #place(dx: 0.725em, dy: 0.575em, circle(radius: 0.085em, fill: col))
    #place(dx: 0.42em, dy: 1.05em, line(start: (0em, 0em), end: (0.31em, 0em), stroke: 1pt + col))
  ])
]

#let vuota() = circle(radius: 0.07em, fill: luma(205))
#let oggetto() = circle(radius: 0.27em, fill: accent)
#let numero(n) = text(size: 0.82em, weight: 600, fill: ink)[#n]
#let puntini() = text(size: 0.85em, fill: luma(160))[…]

#let con-robot(n: none, scala: 1) = {
  if n == none {
    scale(scala * 100%)[#robottino()]
  } else {
    stack(dir: ttb, spacing: 1.2pt * scala, scale(scala * 100%)[#robottino()], text(size: 0.58em * scala, weight: 600, fill: ink)[#n])
  }
}

#let cella(cont, dim: 2.2em, tinta: none) = box(
  width: dim,
  height: dim,
  inset: 0pt,
  stroke: 0.9pt + luma(168),
  radius: 0.14em,
  fill: if tinta != none { tinta } else { white },
)[#align(center + horizon)[#cont]]

#let striscia(celle, indici: none, dim: 2.2em, gap: 0.16em, tinte: ()) = {
  let mappa = (:)
  for coppia in tinte {
    mappa.insert(str(coppia.at(0)), coppia.at(1))
  }
  let riga = ()
  for i in range(celle.len()) {
    let t = mappa.at(str(i), default: none)
    riga.push(cella(celle.at(i), dim: dim, tinta: t))
  }
  grid(
    columns: (dim,) * celle.len(),
    column-gutter: gap,
    row-gutter: 0.18em,
    align: center + horizon,
    ..riga,
    ..if indici != none { indici.map(i => text(size: 0.55em, fill: luma(120), weight: 500)[#i]) },
  )
}

#let griglia(righe, dim: 2.2em, gap: 0.16em) = grid(
  columns: (dim,) * righe.at(0).len(),
  column-gutter: gap,
  row-gutter: gap,
  align: center + horizon,
  ..righe.flatten().map(c => cella(c, dim: dim)),
)

#let slot-memoria(nome, valore) = box(width: 2.3em, inset: 4pt, stroke: 0.9pt + luma(170), radius: 3pt, fill: white)[
  #align(left)[#text(size: 0.55em, weight: 700, fill: accent)[#nome]]
  #align(center)[#text(size: 0.95em, weight: 600, fill: ink)[#valore]]
]

#let memoria(coppie) = grid(
  columns: (auto,) * coppie.len(),
  column-gutter: 0.3em,
  ..coppie.map(p => slot-memoria(p.at(0), p.at(1))),
)

#let scontrino(..righe) = block(
  width: 10em,
  fill: carta,
  inset: (x: 12pt, y: 10pt),
  radius: (top-left: 3pt, top-right: 3pt),
  stroke: (
    left: 0.8pt + luma(185),
    right: 0.8pt + luma(185),
    top: 0.8pt + luma(185),
    bottom: (paint: luma(185), thickness: 0.8pt, dash: "dashed"),
  ),
  above: 4pt,
)[
  #align(center)[#text(size: 7.5pt, weight: 700, tracking: 0.26em, fill: luma(115))[SCONTRINO]]
  #v(4pt)
  #line(length: 100%, stroke: 0.6pt + luma(192))
  #v(8pt)
  #set text(font: (mono,), size: 10.5pt)
  #stack(dir: ttb, spacing: 4pt, ..righe.map(r => align(center)[#r]))
  #v(8pt)
  #line(length: 100%, stroke: (paint: luma(192), thickness: 0.6pt, dash: "dashed"))
]

#let scenario(testo) = [
  #text(weight: 700, fill: luma(75))[Scenario.] #testo
]

#let obiettivo(testo) = block(
  width: 100%,
  fill: tinta,
  stroke: (left: 2.6pt + accent),
  radius: (top-right: 3pt, bottom-right: 3pt),
  inset: (x: 10pt, y: 7.5pt),
  above: 8pt,
  below: 8pt,
)[
  #text(fill: accent-scuro, weight: 700)[Obiettivo.] #text(fill: luma(120))[—] #testo
]

#let lato(tit, corpo, didascalia: none) = stack(dir: ttb, spacing: 3.5pt,
  etichetta(tit),
  corpo,
  ..if didascalia != none { (text(size: 0.74em, fill: luma(120), style: "italic")[#didascalia],) },
)

#let esempio(input: none, output: none, din: none, dout: none, impila: false) = block(
  width: 100%,
  fill: tinta,
  stroke: 0.6pt + luma(222),
  radius: 4pt,
  inset: 9pt,
  above: 8pt,
  below: 2pt,
)[
  #etichetta("Esempio")
  #v(5pt)
  #if impila [
    #stack(dir: ttb, spacing: 4pt,
      lato("Input", input, didascalia: din),
      align(center)[#rotate(90deg)[#freccia()]],
      lato("Output", output, didascalia: dout),
    )
  ] else [
    #grid(
      columns: (1fr, 1.8em, 1fr),
      align(left + horizon)[#lato("Input", input, didascalia: din)],
      align(center + horizon)[#freccia()],
      align(left + horizon)[#lato("Output", output, didascalia: dout)],
    )
  ]
]

#let problema(titolo, diff: 1, novita: none, corpo) = [
  #counter("problema").step()
  #context {
    let n = counter("problema").get().first()
    block(breakable: false, above: 1.5em, below: 1.2em, width: 100%)[
      #block(fill: accent, width: 100%, radius: (top-left: 5pt, top-right: 5pt), inset: (x: 11pt, y: 9pt), below: 0pt)[
        #grid(columns: (1fr, auto), column-gutter: 8pt,
          align(bottom)[#text(fill: white, size: 12.5pt, weight: 700)[Problema #n — #titolo]],
          align(bottom)[#box(fill: white, inset: (x: 7pt, y: 3pt), radius: 999pt)[#stelle(diff)]],
        )
      ]
      #block(width: 100%, radius: (bottom-left: 5pt, bottom-right: 5pt), stroke: (left: 0.8pt + luma(215), right: 0.8pt + luma(215), bottom: 0.8pt + luma(215)), inset: (x: 11pt, y: 10pt), above: 0pt)[
        #corpo
      ]
    ]
  }
]

#let esercizio(titolo, diff: 1, corpo, soluzione) = [
  #counter("esercizio").step()
  #context {
    let n = counter("esercizio").get().first()
    block(breakable: false, above: 1.5em, below: 1.2em, width: 100%)[
      #block(fill: accent, width: 100%, radius: (top-left: 5pt, top-right: 5pt), inset: (x: 11pt, y: 9pt), below: 0pt)[
        #grid(columns: (1fr, auto), column-gutter: 8pt,
          align(bottom)[#text(fill: white, size: 12.5pt, weight: 700)[Esercizio #n — #titolo]],
          align(bottom)[#box(fill: white, inset: (x: 7pt, y: 3pt), radius: 999pt)[#stelle(diff)]],
        )
      ]
      #block(width: 100%, radius: (bottom-left: 5pt, bottom-right: 5pt), stroke: (left: 0.8pt + luma(215), right: 0.8pt + luma(215), bottom: 0.8pt + luma(215)), inset: (x: 11pt, y: 10pt), above: 0pt)[
        #corpo
        #v(4pt)
        #block(width: 100%, fill: ambra-tinta, stroke: (left: 2.6pt + ambra), radius: (top-right: 3pt, bottom-right: 3pt), inset: (x: 10pt, y: 7pt))[
          #text(weight: 700, fill: ambra-scuro, size: 0.8em, tracking: 0.06em)[SOLUZIONE]
          #v(4pt)
          #soluzione
        ]
      ]
    ]
  }
]

#let toc-titolo(txt) = block(above: 1.6em, below: 1em, width: 100%)[
  #text(size: 17pt, weight: 800, fill: ink)[#txt]
  #v(-2pt)
  #line(length: 100%, stroke: 2.2pt + accent)
]

#show outline.entry.where(level: 1): it => context {
  let loc = it.element.location()
  let nums = counter(heading).at(loc)
  block(width: 100%, above: 0.45em, below: 0.2em)[
    #link(loc)[
      #text(weight: 800, fill: accent)[#numbering(it.element.numbering, ..nums)]
      #h(0.5em)
      #text(weight: 800, fill: ink)[#it.element.body]
      #h(0.4em)
      #box(width: 1fr, inset: (x: 0.35em), baseline: 0.3em)[#it.fill]
      #h(0.1em)
      #text(weight: 700, fill: accent)[#counter(page).at(loc).first()]
    ]
  ]
}

#show outline.entry.where(level: 2): it => context {
  let loc = it.element.location()
  let nums = counter(heading).at(loc)
  block(width: 100%, above: 0.1em, below: 0.1em)[
    #link(loc)[
      #h(1.4em)
      #text(fill: accent-scuro)[#numbering(it.element.numbering, ..nums)]
      #h(0.4em)
      #text(fill: luma(100))[#it.element.body]
      #h(0.4em)
      #box(width: 1fr, inset: (x: 0.35em), baseline: 0.3em)[#it.fill]
      #h(0.1em)
      #text(fill: luma(100))[#counter(page).at(loc).first()]
    ]
  ]
}

// ============================================================
//  COPERTINA
// ============================================================

#align(center)[
  #v(0.4cm)
  #scale(300%)[#robottino()]
  #v(0.5cm)
  #text(size: 27pt, weight: 800, fill: ink)[Dal robot al codice]
  #v(5pt)
  #text(size: 12pt, fill: luma(110), style: "italic")[Dalla logica del robot al computer e al primo programma in Python]
  #v(0.7cm)
  #striscia(
    (con-robot(n: 3), numero("7"), oggetto(), numero("−1"), puntini()),
    indici: ("0", "1", "2", "3", ""),
    dim: 2.4em,
  )
  #v(0.35cm)
  #for f in ("avanza()", "gira(destra)", "ripeti", "se", "leggi(x)", "if", "while", "print()") {
    chip(f)
    h(6pt)
  }
  #v(0.3cm)
  #text(size: 9.5pt, fill: luma(115))[
    #stelle(1) #h(2pt) facile #h(16pt) #stelle(2) #h(2pt) medio #h(16pt) #stelle(3) #h(2pt) difficile
  ]
]

#pagebreak()

#toc-titolo("Indice")

#outline(title: none, depth: 2)

// ============================================================
//  SEZIONE 1 — LE MOSSE DEL ROBOT
// ============================================================

#pagebreak()

= Le mosse del robot

Programmare è spiegare a qualcuno, passo per passo, come fare una cosa — senza lasciare niente al caso. Il nostro qualcuno è un piccolo robot: non pensa, ma esegue con precisione assoluta le istruzioni che gli diamo. In questa prima sezione impariamo tutto il suo vocabolario; lo metteremo poi alla prova con dieci problemi.

== Il mondo del robot

Il robot vive in una griglia di caselle e guarda sempre in una direzione: destra, sinistra, sopra o sotto. Le liste su cui viaggia possono essere così lunghe che nessuno sa dove finiscono. Ogni casella può essere di tre tipi:

- *Vuota* — ci si può camminare sopra senza che succeda niente.
- *Con un oggetto* — appena il robot entra nella casella, l'oggetto viene raccolto automaticamente.
- *Con un numero nascosto* — lo si può leggere con l'istruzione `leggi()`, che conosceremo tra poco.

#striscia(
  (con-robot(n: 3), vuota(), numero("7"), oggetto(), puntini()),
  indici: ("0", "1", "2", "3", ""),
)

#v(2pt)
#text(size: 0.8em, fill: luma(120), style: "italic")[Il robot è sulla casella 0, che nasconde il numero 3. La casella 2 nasconde un 7, la casella 3 contiene un oggetto, e la lista continua all'infinito.]

== Muoversi

Per muoversi il robot conosce solo due gesti. Tutto il resto — camminate, dietrofront, percorsi a zigzag — è una combinazione di questi.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 8pt,
  row-gutter: 8pt,
  istruzione("avanza()", "Avanza", "il robot si sposta di una casella nella direzione in cui sta guardando."),
  istruzione("gira(destra | sinistra)", "Gira", "il robot ruota su se stesso di 90°, in senso orario (destra) o antiorario (sinistra), senza cambiare casella."),
)

#text(size: 0.85em, fill: luma(120), style: "italic")[Per fare dietrofront lungo una striscia servono sempre due girate di fila: uno per guardare dalla parte opposta, l'altro per… no, davvero, ne bastano due.]

== Ricordare e comunicare

Nella pancia il robot porta una memoria fatta di caselle etichettate con le lettere dell'alfabeto. Per ora ne ha due: *a* e *b*. All'inizio ogni casella della memoria contiene 0.

#istruzione("leggi()", "Leggi", "restituisce il numero nascosto nella casella su cui si trova il robot in quel momento.")
#istruzione("leggi(x)", "Memorizza", "deposita nella casella x della memoria il numero della casella attuale. Attenzione: il numero che c'era prima è perso per sempre!")
#istruzione("scrivi(x)", "Comunica", "aggiunge in fondo allo scontrino il numero contenuto nella casella x della memoria. Lo scontrino è il modo che il robot ha di comunicare con noi.")

La memoria si può anche aggiornare con i calcoli: ogni istruzione deposita in una casella un valore calcolato con $+$, $−$, $×$ e $÷$ a partire dai valori attuali — e anche da `leggi()`, che porta il numero della casella su cui il robot si trova. Per esempio, partendo con *a* = 12 e *b* = 2:

#grid(
  columns: (auto, auto, auto),
  column-gutter: 14pt,
  memoria((("a", 12), ("b", 2))),
  align(center + horizon)[#chip("a = a / b")],
  memoria((("a", 6), ("b", 2))),
)

#v(3pt)
#text(size: 0.8em, fill: luma(120), style: "italic")[La memoria prima e dopo: *a* diventa 6, mentre *b* resta 2.]

== Decidere e ripetere

Finora il robot ha sempre eseguito tutto quello che gli scrivevamo, nell'ordine esatto. Con due nuove istruzioni impara a scegliere e a ripetere da solo. Le istruzioni «dentro» un *se* o un *ripeti* si scrivono rientrate di due spazi, come negli esempi qui sotto.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 8pt,
  row-gutter: 8pt,
  istruzione("se … altrimenti …", "Decidere", "esegue le istruzioni rientrate solo se la condizione è vera; con altrimenti, ne esegue altre quando è falsa. Le condizioni confrontano numeri con =, ≠, <, >, ≤ e ≥."),
  istruzione("ripeti: … stop", "Ripetere", "ripete per sempre le istruzioni rientrate. L'istruzione stop lo interrompe: il robot prosegue dalla prima istruzione che viene dopo il ripeti."),
)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 10pt,
  [
    ```typst
    se a < b:
      avanza()
    altrimenti:
      scrivi(b)
    ```
    #v(2pt)
    #text(size: 0.78em, fill: luma(120), style: "italic")[Se a è minore di b il robot avanza; altrimenti scrive il valore di b sullo scontrino.]
  ],
  [
    ```typst
    ripeti:
      avanza()
      se leggi() = 0:
        stop
    ```
    #v(2pt)
    #text(size: 0.78em, fill: luma(120), style: "italic")[Il robot avanza finché non trova uno 0: allora stop lo fa uscire dal ripeti.]
  ],
)

== I problemi

Dieci problemi, più o meno in ordine di difficoltà: le stelle in alto a destra indicano quanto. Ogni problema ha sempre la stessa forma: uno *scenario* che descrive il mondo, un *obiettivo* da raggiungere e un *esempio* di input e output. Tre convenzioni valgono per tutti: il robot parte sempre dalla prima casella; le posizioni si contano partendo da 0 (la casella di partenza è la posizione 0); le liste con i puntini continuano all'infinito. Tutte le istruzioni sono quelle imparate qui sopra — e se servirà una memoria più capace, verrà annunciato.

#problema("Raccogli gli oggetti", diff: 1)[
  #scenario[Il robot parte dalla casella 0 di una striscia di caselle, rivolto verso destra. Due oggetti lo aspettano: uno sulla casella −2 e uno sulla casella +2. Quando il robot entra in una casella con un oggetto, lo raccoglie automaticamente.]
  #obiettivo[Raccogli entrambi gli oggetti con una sola sequenza di istruzioni.]
  #esempio(
    input: striscia(
      (oggetto(), vuota(), con-robot(), vuota(), oggetto()),
      indici: ("−2", "−1", "0", "1", "2"),
    ),
    output: striscia(
      (vuota(), vuota(), con-robot(), vuota(), vuota()),
      indici: ("−2", "−1", "0", "1", "2"),
      tinte: ((2, evidenziata),),
    ),
    din: [il robot parte dalla casella 0, rivolto verso destra],
    dout: [una possibile conclusione: oggetti raccolti 2 su 2, e il robot è tornato alla partenza],
  )
]

#problema("La passeggiata", diff: 2)[
  #scenario[Il robot si trova nell'angolo in basso a sinistra di una griglia 4×3 (quattro colonne e tre righe), rivolto verso destra. Le caselle sono tutte vuote.]
  #obiettivo[Fai una passeggiata che attraversi tutte le caselle della griglia almeno una volta.]
  #esempio(
    input: griglia((
      (vuota(), vuota(), vuota(), vuota()),
      (vuota(), vuota(), vuota(), vuota()),
      (con-robot(), vuota(), vuota(), vuota()),
    )),
    output: griglia((
      (numero("9"), numero("10"), numero("11"), con-robot(n: "12")),
      (numero("8"), numero("7"), numero("6"), numero("5")),
      (numero("1"), numero("2"), numero("3"), numero("4")),
    )),
    din: [il robot parte dall'angolo in basso a sinistra, rivolto verso destra],
    dout: [una delle tante passeggiate possibili: 12 caselle su 12, nell'ordine indicato dai numeri],
  )
]

#problema("La somma della griglia", diff: 2)[
  #scenario[Come nella passeggiata, ma questa volta ogni casella della griglia nasconde un numero. Il robot parte dall'angolo in basso a sinistra.]
  #obiettivo[Trova la somma di tutti i numeri della griglia e falla comparire in fondo allo scontrino.]
  #esempio(
    input: griglia((
      (numero("2"), numero("7"), numero("1")),
      (numero("5"), numero("3"), numero("8")),
      (con-robot(n: "4"), numero("6"), numero("9")),
    )),
    output: scontrino("45"),
    din: [ogni casella nasconde un numero; il robot parte da quella con il 4],
    dout: [2 + 7 + 1 + 5 + 3 + 8 + 4 + 6 + 9 = 45],
  )
]

#problema("Fermati al −1", diff: 1)[
  #scenario[Il robot viaggia su una lista di caselle indefinitamente lunga: nessuno sa quante ce ne sono. Ogni casella nasconde un numero, e da qualche parte, prima o poi, c'è una casella che nasconde −1.]
  #obiettivo[Avanza fino alla prima casella con il numero −1 e fermati lì.]
  #esempio(
    input: striscia(
      (con-robot(n: "5"), numero("2"), numero("8"), numero("−1"), numero("7"), puntini()),
      indici: ("0", "1", "2", "3", "4", ""),
    ),
    output: striscia(
      (numero("5"), numero("2"), numero("8"), con-robot(n: "−1"), numero("7"), puntini()),
      indici: ("0", "1", "2", "3", "4", ""),
      tinte: ((3, evidenziata),),
    ),
    din: [la lista continua all'infinito: da qualche parte c'è un −1],
    dout: [il robot si ferma sulla casella con il −1 (posizione 3)],
  )
]

#problema("Conta i passi", diff: 2)[
  #scenario[Come nel problema precedente: lista infinita, numeri nascosti, e da qualche parte un −1.]
  #obiettivo[Fermati al −1 e scrivi sullo scontrino quanti passi hai fatto per arrivarci, cioè quante caselle lo separano dalla partenza.]
  #esempio(
    input: striscia(
      (con-robot(n: "4"), numero("7"), numero("2"), numero("9"), numero("−1"), puntini()),
      indici: ("0", "1", "2", "3", "4", ""),
    ),
    output: scontrino("4"),
    din: [quanto è lontano il −1?],
    dout: [il robot si ferma sul −1 e scrive: 4 passi dalla partenza],
  )
]

#problema("La somma del viaggio", diff: 2)[
  #scenario[Ancora la solita lista infinita di numeri, con un −1 a chiuderla.]
  #obiettivo[Avanza fino al −1 sommando man mano tutti i numeri incontrati lungo il viaggio (il −1 non si somma!). Poi scrivi la somma sullo scontrino.]
  #esempio(
    input: striscia(
      (con-robot(n: "3"), numero("1"), numero("4"), numero("−1"), puntini()),
      indici: ("0", "1", "2", "3", ""),
    ),
    output: scontrino("8"),
    din: [somma tutto quello che incontri lungo il cammino],
    dout: [3 + 1 + 4 = 8, poi il robot si ferma sul −1],
  )
]

#problema("La corsa crescente", diff: 2)[
  #scenario[Lista infinita di numeri, ma stavolta nessun −1: è il ritmo dei numeri a decidere quando fermarsi.]
  #obiettivo[Avanza finché ogni numero è più grande del precedente; fermati appena la crescita si interrompe, sull'ultimo numero crescente.]
  #esempio(
    input: striscia(
      (con-robot(n: "2"), numero("5"), numero("7"), numero("4"), numero("9"), puntini()),
      indici: ("0", "1", "2", "3", "4", ""),
    ),
    output: striscia(
      (numero("2"), numero("5"), con-robot(n: "7"), numero("4"), numero("9"), puntini()),
      indici: ("0", "1", "2", "3", "4", ""),
      tinte: ((2, evidenziata),),
    ),
    din: [i numeri crescono… finché crescono],
    dout: [il 4 è più piccolo del 7: il robot si ferma sul 7 (posizione 2)],
  )
]

#problema("Dove si ferma la corsa", diff: 2)[
  #scenario[Come la corsa crescente, ma con una richiesta in più.]
  #obiettivo[Fermati quando i numeri smettono di crescere e scrivi sullo scontrino la posizione raggiunta. Ricorda: la casella di partenza è la posizione 0.]
  #esempio(
    input: striscia(
      (con-robot(n: "2"), numero("5"), numero("7"), numero("4"), numero("9"), puntini()),
      indici: ("0", "1", "2", "3", "4", ""),
    ),
    output: scontrino("2"),
    din: [come prima, ma ora ci vuole anche la posizione],
    dout: [il robot si ferma sul 7, che si trova sulla casella 2],
  )
]

#problema("Serie su serie", diff: 3, novita: [Novità: memoria espansa! Da qui in avanti il robot ha tre caselle di memoria: a, b e c.])[
  #scenario[Questa volta la lista è organizzata in serie: prima una serie di numeri positivi, poi un −1 che la chiude, poi la serie successiva… e quando tutte le serie sono finite, un −2 a salutare.]
  #striscia(
    (numero("4"), numero("1"), numero("7"), numero("2"), numero("−1"), numero("4"), numero("5"), numero("−1"), numero("5"), numero("7"), numero("5"), numero("7"), numero("3"), numero("−2")),
    dim: 1.6em,
    gap: 0.12em,
    tinte: ((4, ambra-tinta), (7, ambra-tinta), (13, ambra-tinta)),
  )
  #v(2pt)
  #text(size: 0.8em, fill: luma(120), style: "italic")[Tre serie: (4, 1, 7, 2), (4, 5) e (5, 7, 5, 7, 3).]
  #obiettivo[Calcola la somma di ciascuna serie e scrivi sullo scontrino la media delle somme.]
  #esempio(
    input: striscia(
      (con-robot(n: "2", scala: 0.68), numero("4"), numero("−1"), numero("4"), numero("5"), numero("−1"), numero("3"), numero("4"), numero("5"), numero("−1"), numero("−2"), puntini()),
      dim: 1.6em,
      gap: 0.12em,
      tinte: ((2, ambra-tinta), (5, ambra-tinta), (9, ambra-tinta), (10, ambra-tinta)),
    ),
    output: scontrino("9"),
    din: [tre serie: (2, 4), (4, 5) e (3, 4, 5)],
    dout: [somme 6, 9 e 12: la media è (6 + 9 + 12) ÷ 3 = 9],
    impila: true,
  )
]

#problema("La media fra i −1", diff: 3)[
  #scenario[L'ultima lista è quasi tutta di numeri positivi: solo il primo e l'ultimo numero sono −1.]
  #obiettivo[Scrivi sullo scontrino la media aritmetica di tutti i numeri che si trovano fra i due −1.]
  #esempio(
    input: striscia(
      (con-robot(n: "−1"), numero("2"), numero("6"), numero("4"), numero("8"), numero("−1"), puntini()),
      indici: ("0", "1", "2", "3", "4", "5", ""),
    ),
    output: scontrino("5"),
    din: [il primo e l'ultimo numero sono −1],
    dout: [2 + 6 + 4 + 8 = 20, e 20 ÷ 4 = 5],
  )
]

#block(breakable: false, width: 100%, above: 1.4em)[
  #align(center)[
    #scale(170%)[#robottino()]
    #v(0.2cm)
    #text(size: 13pt, weight: 700, fill: ink)[Complimenti!]
    #v(3pt)
    #text(size: 11pt, fill: luma(110))[Se sei arrivato fin qui, hai già la testa da programmatore.]
  ]
]

// ============================================================
//  SEZIONE 2 — COME FUNZIONA UN COMPUTER
// ============================================================

#pagebreak()

= Come funziona un computer

Il robot della prima sezione esegue un vocabolario piccolissimo di istruzioni: avanza, gira, leggi, scrivi, se, ripeti, stop. Un computer fa esattamente la stessa cosa, solo che il suo vocabolario è un po' più ricco e lui esegue miliardi di istruzioni al secondo. In questa sezione apriamo la scatola e scopriamo come è fatto dentro e come riesce a rappresentare *qualsiasi* cosa — numeri, lettere, immagini — usando soltanto due simboli.

== Dentro la scatola

Un computer è un insieme di pezzi che collaborano. I più importanti sono cinque.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 8pt,
  row-gutter: 8pt,
  istruzione("CPU", "Il processore", "è il «cervello»: esegue le istruzioni una dopo l'altra, fa i calcoli e decide cosa fare in base ai confronti. È il nostro robot, ma fatto di silicio."),
  istruzione("RAM", "La memoria di lavoro", "è la memoria veloce e temporanea: contiene i dati e i programmi mentre il computer li sta usando. Quando spegni il computer, la RAM si svuota."),
  istruzione("DISCO", "Il disco rigido", "è la memoria lenta e permanente: conserva file, programmi e foto anche quando il computer è spento. Prima di usarli, vengono copiati nella RAM."),
  istruzione("GPU", "La scheda video", "è un processore specializzato nei calcoli grafici, cioè nel disegnare immagini e animazioni. La usano anche i videogiochi e l'intelligenza artificiale."),
  istruzione("MB", "La scheda madre", "è la piastra che collega tutto: processore, RAM, disco, scheda video e periferiche comunicano tra loro attraverso i suoi circuiti."),
)

#v(4pt)

*Altre componenti, un po' meno protagoniste:*

- *Alimentatore* — trasforma la corrente di casa nella corrente giusta per i componenti.
- *Ventole e dissipatori* — raffreddano processore e scheda video, che scaldano molto.
- *Porte e connettori* — USB, HDMI, prese audio: il punto di contatto con il mondo esterno.
- *Scheda di rete* — collega il computer a Internet e agli altri computer.
- *Periferiche* — tastiera, mouse, monitor, stampante: servono a dare comandi e a vedere i risultati.

Il flusso è sempre lo stesso: le periferiche mandano dati al processore, che li elabora usando la RAM come appoggio, li conserva sul disco e rimanda i risultati fuori. È lo stesso schema del robot: `leggi()` per ricevere, la memoria per lavorare, `scrivi()` per comunicare.

== Il bit: l'alfabeto del computer

=== Acceso o spento

Dentro un computer non c'è spazio per sfumature: ogni minuscolo interruttore è o *acceso* o *spento*, cioè vale *1* oppure *0*. Questa unità minima di informazione si chiama *bit*.

Un bit da solo può dire solo due cose, quindi non basta. Mettendo insieme *otto* bit otteniamo un *byte*: con otto caselle da 0/1 possiamo scrivere $2^8 = 256$ combinazioni diverse. Ecco perché il byte è l'unità di misura più usata per la memoria: un byte per un carattere, milioni di byte (megabyte, gigabyte) per una foto o un film.

#striscia(
  ("0", "1", "0", "0", "0", "0", "0", "1"),
  indici: ("128", "64", "32", "16", "8", "4", "2", "1"),
  dim: 1.5em,
  gap: 0.12em,
)

#v(3pt)
#text(size: 0.8em, fill: luma(120), style: "italic")[Un byte: ogni casella vale un bit, e sotto c'è il «peso» della sua posizione. Questa sequenza vale 64 + 1 = 65.]

=== Mettersi d'accordo

La sequenza `01000001` è soltanto una fila di otto bit: di per sé non significa niente. Se decidiamo che è un *numero*, vale 65; se decidiamo che è una *lettera*, è la lettera `A`. Il computer non lo sa: siamo noi a stabilire come leggere quei bit.

Per questo esistono le *convenzioni condivise*, cioè formati e protocolli: regole scritte una volta e rispettate da tutti.

- Per i caratteri: *ASCII*, *Unicode*, *UTF-8*.
- Per le immagini: *PNG*, *JPEG*, *GIF*, *SVG*.
- Per i suoni: *MP3*, *WAV*.
- Per i documenti: *PDF*, *DOCX*.
- Per far parlare i computer tra loro: *TCP/IP*, *HTTP*, *Wi-Fi*.

Senza un accordo, gli stessi bit sarebbero incomprensibili. È come lo scontrino del robot: `45` significa «somma», ma solo perché noi e il robot avevamo concordato di leggere lì i numeri.

=== Come si scrivono i numeri

Per contare usiamo dieci cifre, da 0 a 9, e il valore di una cifra dipende dalla sua posizione: nel numero 237, il 2 vale 200, il 3 vale 30 e il 7 vale 7. Il computer fa lo stesso, ma con *due* cifre: si chiama sistema *binario*.

Ogni posizione vale una potenza di 2: la più a destra 1, poi 2, 4, 8, 16, 32 e così via. Dunque `1011` non è «milleundici»: è

$ 1 × 8 + 0 × 4 + 1 × 2 + 1 × 1 = 11. $

#striscia(
  ("1", "0", "1", "1"),
  indici: ("8", "4", "2", "1"),
  dim: 1.7em,
  gap: 0.14em,
)

#v(3pt)
#text(size: 0.8em, fill: luma(120), style: "italic")[Il numero binario 1011 letto con i suoi pesi: equivale a 11.]

Anche qui servono standard condivisi: gli *interi* si codificano in complemento a due (un trucco per rappresentare i numeri negativi usando il primo bit come segno), mentre i numeri con la virgola seguono lo standard *IEEE 754*, che li scompone in segno, esponente e mantissa. Proprio per come è fatto questo standard, nei programmi capita che `0.1 + 0.2` non faccia esattamente `0.3`: è una conseguenza del modo in cui i numeri vengono memorizzati, non un errore.

=== Come si scrivono i caratteri

Le lettere sono numeri, come tutto il resto. La *tabella ASCII* è la convenzione più famosa: assegna un numero da 0 a 127 a lettere, cifre, segni di punteggiatura e comandi. Ecco qualche esempio.

#table(
  columns: (1fr, 1.4fr, 1fr),
  inset: (x: 8pt, y: 5pt),
  align: (center, center, center),
  stroke: 0.5pt + luma(215),
  table.header([*Decimale*], [*Binario*], [*Carattere*]),
  [32], [`00100000`], [spazio],
  [48], [`00110000`], [`0`],
  [57], [`00111001`], [`9`],
  [65], [`01000001`], [`A`],
  [90], [`01011010`], [`Z`],
  [97], [`01100001`], [`a`],
  [122], [`01111010`], [`z`],
)

#v(4pt)

Due curiosità utili: la `A` vale 65 e la `a` vale 97, cioè differiscono di 32 — esattamente il peso di un singolo bit. Maiuscole e minuscole sono parenti strettissime. E le cifre `0`…`9` non valgono 0…9: la cifra `0` vale 48, così si distingue dal numero 0. Quando nel robot leggevamo un numero e non una lettera, era perché noi avevamo deciso di interpretare quei bit come numeri.

L'ASCII copre solo 128 simboli e non basta per accenti, lettere greche o emoji. Per questo è nato *Unicode*: una tabella enorme che assegna un numero a ogni carattere di ogni lingua. UTF-8 è il formato che trasforma questi numeri in byte. Per esempio `è` è il numero 232, e in UTF-8 occupa due byte; una faccina come `😀` ne occupa quattro.

=== Come si parla al processore

Rimane la domanda più importante: come faccio a dire al processore di eseguire l'azione x?

Il processore possiede un *instruction set* (insieme di istruzioni): un vocabolario ristretto di operazioni come *carica*, *somma*, *confronta*, *salta*. È esattamente il vocabolario del robot, un po' più ampio. Ogni istruzione è a sua volta un numero, con una parte che dice *cosa fare* e parti che dicono *su quali dati*.

Scrivere quei numeri a mano si chiama *codice macchina*. Per non impazzire, si usano nomi leggibili — `MOV`, `ADD`, `JMP` — che corrispondono uno a uno alle istruzioni: è il linguaggio *assembly*. Un programma chiamato *assembler* traduce i nomi in numeri. I linguaggi ad alto livello come *Python* sono ancora più comodi: li scriviamo in italiano/inglese, e un *interprete* o un *compilatore* li traduce, passo dopo passo, nelle istruzioni del processore.

Storicamente, prima delle tastiere, i programmi si preparavano su *schede perforate*: cartoncini con dei fori. Foro = 1, niente foro = 0. Le schede venivano lette da una macchina e diventavano istruzioni. Anche lì, tutto era ridotto a due soli simboli.

=== La memoria come una griglia

Immagina la memoria come una lunghissima striscia di caselle, identica a quella del robot. Ogni casella contiene un byte e ha un *indirizzo*: la prima è la 0, poi la 1, la 2, e così via.

#striscia(
  (numero("5"), numero("0"), numero("7"), numero("1"), numero("9"), puntini()),
  indici: ("0", "1", "2", "3", "4", ""),
)

#v(3pt)

C'è però una differenza importante rispetto al robot: il robot può solo fare un passo alla volta, mentre il processore può chiedere *direttamente* il contenuto di un indirizzo qualsiasi. Per questo si dice *accesso casuale* (random access): la memoria risponde subito, non importa se la casella è la 3 o la 30 000.

Qui nasce il concetto di *variabile*: invece di ricordarci l'indirizzo 1 048 576, diamo a quella casella un nome, per esempio `x`, e ci scriviamo dentro un valore.

#memoria((("x", 5), ("y", 7), ("z", 9)))

#v(5pt)
#text(size: 0.85em, fill: luma(120), style: "italic")[Tre variabili: tre nomi che puntano a tre caselle della memoria. Da qui in avanti useremo proprio questa idea per capire le variabili di Python.]

// ============================================================
//  SEZIONE 3 — INTRODUZIONE A PYTHON
// ============================================================

#pagebreak()

= Introduzione a Python

Abbiamo visto che un computer esegue istruzioni e conserva dati in caselle di memoria con un indirizzo. Python è il linguaggio con cui gli scriveremo queste istruzioni: molto più leggibile del codice macchina, ma comunque rigoroso. Prima di iniziare, quattro regole di base — ovvie per chi programma, fondamentali per chi comincia.

#obiettivo[
  Il computer esegue *esattamente* quello che è scritto, non quello che intendevi. Python non perdona le distrazioni: sii preciso.
]

- *I caratteri contano uno a uno.* Maiuscole e minuscole sono diverse: `print` e `Print` sono due cose distinte, e `x` non è `X`. Una lettera sbagliata e il programma si ferma.
- *Gli spazi a inizio riga contano.* Il rientro (indentazione) dice a Python quali istruzioni appartengono a un blocco. Tutte le righe dello stesso blocco devono avere lo *stesso* rientro; usa sempre lo stesso numero di spazi (la convenzione è 4). Se sbagli, Python dà errore.
- *I simboli vanno chiusi e abbinati.* Ogni parentesi aperta va chiusa: `(` con `)`, `[` con `]`, `"` con `"`. Le righe `if`, `else` e `while` finiscono con i due punti `:`, che introducono il blocco rientrato.
- *Una istruzione per riga.* Python legge una riga alla volta; per scrivere una nota che il computer deve ignorare si usa `#`.

#v(2pt)

Un programma si scrive in un file (per esempio `main.py`) e si esegue dall'alto verso il basso, una riga dopo l'altra, proprio come le istruzioni del robot.

== Variabili

Una *variabile* è un nome attaccato a una casella della memoria. È la stessa idea di `a`, `b` e `c` nella pancia del robot, con due novità: possiamo scegliere il nome che vogliamo e ogni casella contiene un valore che possiamo leggere e cambiare.

Per scrivere un valore dentro una variabile si usa il segno `=`, che si legge «diventa» e *non* è l'uguale della matematica:

```python
x = 5
```

#v(2pt)
#text(size: 0.8em, fill: luma(120), style: "italic")[Da leggere: «nella casella x metti il valore 5».]

#memoria((("x", 5),))

#v(6pt)

Poi possiamo usare quel nome per rileggere il valore e per calcolare:

```python
x = 5
y = 3
z = x + y
print(z)
```

#v(2pt)
#text(size: 0.8em, fill: luma(120), style: "italic")[`z` diventa 8. Il valore di destra viene calcolato e poi riposto nella casella di sinistra.]

Le operazioni disponibili sono le solite: `+` (somma), `-` (sottrazione), `*` (moltiplicazione), `/` (divisione) e `%` (resto della divisione, per esempio `7 % 2` fa `1`).

I nomi delle variabili seguono poche regole: possono contenere lettere, cifre e il trattino basso `_`, non possono iniziare con una cifra e non possono contenere spazi. Quindi `numero` e `numero_1` vanno bene, `1numero` no. Ricorda: `nome` e `Nome` sono due variabili diverse.

== Liste

Spesso non basta una casella sola: serve una *sequenza* di valori. In Python si chiama *lista* e si scrive tra parentesi quadre. I valori stanno in caselle *contigue*, una attaccata all'altra, numerate a partire da *0* — proprio come le caselle del robot.

```python
v = [10, 20, 30]
```

#striscia((numero("10"), numero("20"), numero("30")), indici: ("0", "1", "2"))

#v(6pt)

Per leggere un elemento si scrive il nome della lista e, tra parentesi quadre, la sua *posizione* (indice):

```python
print(v[0])
print(v[2])
```

#v(2pt)
#text(size: 0.8em, fill: luma(120), style: "italic")[Stampa 10 e poi 30. Il primo elemento è `v[0]`, non `v[1]`!]

Python sa contare anche da destra: `v[-1]` è l'ultimo elemento, `v[-2]` il penultimo. E `len(v)` restituisce quanti elementi contiene la lista (`3`, in questo caso). Per aggiungere e togliere elementi si usano due metodi:

```python
v.append(40)
v.remove(20)
```

#v(2pt)
#text(size: 0.8em, fill: luma(120), style: "italic")[`append(40)` aggiunge 40 in fondo; `remove(20)` elimina la prima casella che contiene 20. La lista diventa `[10, 30, 40]`.]

== Decidere: if ed else

Come il robot con *se* e *altrimenti*, Python prende decisioni con `if` e `else`. La differenza è che la condizione va scritta con `==` per chiedere «sono uguali?», mentre `=` resta l'assegnazione.

```python
x = 7
if x > 5:
    print("x è grande")
else:
    print("x è piccolo")
```

Il blocco dentro `if` e quello dentro `else` sono rientrati: è il rientro a dire dove comincia e dove finisce ciascun blocco. La riga dell'`if` e quella dell'`else` terminano con `:`. I confronti disponibili sono:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 12pt,
  [
    - `==` uguale a
    - `!=` diverso da
    - `<` minore di
    - `>` maggiore di
  ],
  [
    - `<=` minore o uguale
    - `>=` maggiore o uguale
    - `and` e `or` per unire più condizioni
    - `not` per negare una condizione
  ],
)

== Ripetere: while e break

Il robot aveva `ripeti:` per ripetere all'infinito e `stop` per fermarsi. In Python c'è `while`, che ripete *finché* una condizione è vera, e `break` per uscire dal ciclo.

```python
i = 0
while i < 3:
    print(i)
    i = i + 1
```

#v(2pt)
#text(size: 0.8em, fill: luma(120), style: "italic")[Stampa 0, 1, 2 e poi si ferma: quando `i` diventa 3 la condizione è falsa.]

La grande differenza rispetto al robot è che `while` vuole una condizione sulla riga. Se la condizione non diventa mai falsa, il ciclo non finisce più: per questo dentro il ciclo bisogna *cambiare* qualcosa (nel nostro esempio, `i` cresce). Quando serve uscire prima, si usa `break`:

```python
i = 0
while True:
    if i == 5:
        break
    i = i + 1
```

#v(2pt)
#text(size: 0.8em, fill: luma(120), style: "italic")[`while True` ripete per sempre, esattamente come `ripeti:`; `break` è lo `stop` del robot.]

== Parlare con l'utente: print

Il robot comunicava scrivendo sullo scontrino con `scrivi(x)`. In Python lo scontrino è lo schermo e l'istruzione si chiama `print`:

```python
print("Ciao!")
print(3 + 4)
x = 10
print(x)
```

`print` accetta più valori separati da virgola e li stampa uno dopo l'altro:

```python
x = 3
y = 5
print("La somma è", x + y)
```

#v(2pt)
#text(size: 0.8em, fill: luma(120), style: "italic")[Stampa: `La somma è 8`.]

Il testo tra virgolette si chiama *stringa* e va sempre racchiuso tra `"` oppure `'`. I numeri, al contrario, si scrivono senza virgolette: `print(5)` stampa il numero, `print("5")` stampa il testo.

== Dal robot a Python: cosa cambia

La logica è la stessa; cambia il modo di scriverla. Questa tabella riassume le differenze principali.

#table(
  columns: (1fr, 1fr, 1.7fr),
  inset: (x: 8pt, y: 6pt),
  align: (left, left, left),
  stroke: 0.5pt + luma(215),
  table.header([*Robot*], [*Python*], [*Attenzione*]),
  [`a = a / b`], [`a = a / b`], [Qui `=` assegna: la casella a sinistra riceve il valore di destra.],
  [`se a = b:`], [`if a == b:`], [Nel robot `=` confronta; in Python confronta `==`, mentre `=` assegna.],
  [`altrimenti:`], [`else:`], [Le parole chiave cambiano, l'idea no.],
  [`ripeti:`], [`while True:`], [Il ciclo infinito del robot diventa un while sempre vero.],
  [`stop`], [`break`], [Esce dal ciclo più vicino.],
  [`scrivi(x)`], [`print(x)`], [Lo scontrino del robot diventa lo schermo.],
  [`leggi(x)`], [`x`], [Nel robot si copia dalla casella; in Python si legge direttamente il nome.],
  [memoria a, b, c], [qualsiasi nome], [I nomi li scegliamo noi, non più solo lettere singole.],
  [rientro di 2 spazi], [rientro (di solito 4)], [In Python il rientro è obbligatorio e fa parte della sintassi.],
)

// ------------------------------------------------------------
//  ESERCIZI
// ------------------------------------------------------------

== Esercizi introduttivi

Piccoli esercizi per prendere confidenza con la sintassi. Scrivi il codice in un file, eseguilo e confronta il risultato con la soluzione.

#esercizio("Il primo saluto", diff: 1)[
  Scrivi un programma che stampi sullo schermo la scritta `Ciao, mondo!`.
][
  ```python
  print("Ciao, mondo!")
  ```
]

#esercizio("Una variabile e la sua stampa", diff: 1)[
  Crea una variabile `x` con dentro il numero `7`, poi stampala.
][
  ```python
  x = 7
  print(x)
  ```
]

#esercizio("La somma", diff: 1)[
  Crea due variabili `a` e `b` con due numeri a piacere e stampa la loro somma.
][
  ```python
  a = 3
  b = 5
  print(a + b)
  ```
]

#esercizio("Primo e ultimo", diff: 1)[
  Crea la lista `v = [10, 20, 30]` e stampa il primo e l'ultimo elemento, usando le parentesi quadre.
][
  ```python
  v = [10, 20, 30]
  print(v[0])
  print(v[2])
  ```
]

#esercizio("Scambio di valori", diff: 2)[
  Le variabili `a` e `b` contengono due numeri. Scambia tra loro i valori e stampali alla fine. (Suggerimento: serve una terza variabile di appoggio.)
][
  ```python
  a = 1
  b = 2
  c = a
  a = b
  b = c
  print(a)
  print(b)
  ```
]

#esercizio("Trova l'errore", diff: 2)[
  Questo programma non funziona. Trova l'errore e correggilo.

  ```python
  x = 5
  if x = 5:
      print("uguale")
  ```
][
  Nella condizione dell'`if` serve il confronto `==`, non l'assegnazione `=`:

  ```python
  x = 5
  if x == 5:
      print("uguale")
  ```
]

== Esercizi più avanzati

Ora che la sintassi è chiara, ragioniamo con cicli e liste — gli stessi problemi che risolvevi con il robot, ma scritti in Python.

#esercizio("Conta da a a b", diff: 2)[
  Leggi due numeri nelle variabili `a` e `b` e stampa tutti i numeri interi da `a` a `b`, estremi inclusi.
][
  ```python
  a = 3
  b = 8
  i = a
  while i <= b:
      print(i)
      i = i + 1
  ```
]

#esercizio("Il massimo", diff: 2)[
  Data una lista di numeri, trova il valore più grande e stampalo.
][
  ```python
  v = [4, 9, 1, 7]
  massimo = v[0]
  i = 1
  while i < len(v):
      if v[i] > massimo:
          massimo = v[i]
      i = i + 1
  print(massimo)
  ```
]

#esercizio("È crescente?", diff: 2)[
  Stabilisci se una lista di numeri è crescente (ogni elemento è maggiore o uguale al precedente) e stampa `True` oppure `False`.
][
  ```python
  v = [1, 3, 3, 8]
  crescente = True
  i = 1
  while i < len(v):
      if v[i] < v[i - 1]:
          crescente = False
      i = i + 1
  print(crescente)
  ```
]

#esercizio("Al contrario", diff: 2)[
  Data una lista, costruisci una nuova lista con gli stessi elementi in ordine inverso, poi stampala.
][
  ```python
  v = [1, 2, 3, 4]
  inv = []
  i = len(v) - 1
  while i >= 0:
      inv.append(v[i])
      i = i - 1
  print(inv)
  ```
]

#esercizio("Somma e media", diff: 2)[
  Data una lista di numeri, calcola e stampa la loro somma e la loro media.
][
  ```python
  v = [2, 4, 6]
  somma = 0
  i = 0
  while i < len(v):
      somma = somma + v[i]
      i = i + 1
  print(somma)
  print(somma / len(v))
  ```
]

#esercizio("Quanti pari", diff: 3)[
  Conta quanti numeri pari ci sono in una lista e stampa il risultato. Usa l'operatore `%`.
][
  ```python
  v = [1, 2, 3, 4, 5, 6]
  pari = 0
  i = 0
  while i < len(v):
      if v[i] % 2 == 0:
          pari = pari + 1
      i = i + 1
  print(pari)
  ```
]

#esercizio("Il primo negativo", diff: 3)[
  Scorri una lista finché non trovi il primo numero negativo, poi stampalo. Usa `break` per uscire dal ciclo.
][
  ```python
  v = [5, 3, -2, 8]
  i = 0
  while i < len(v):
      if v[i] < 0:
          break
      i = i + 1
  print(v[i])
  ```
]

#block(breakable: false, width: 100%, above: 1.4em)[
  #align(center)[
    #scale(140%)[#robottino()]
    #v(0.2cm)
    #text(size: 13pt, weight: 700, fill: ink)[Fine del percorso]
    #v(3pt)
    #text(size: 11pt, fill: luma(110))[Dal vocabolario del robot alle prime righe di Python: la strada è aperta.]
  ]
]
