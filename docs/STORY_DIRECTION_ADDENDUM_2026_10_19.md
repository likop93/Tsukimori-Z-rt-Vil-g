# Tulajdonosi történeti kiegészítés — 2026-10-19

**Státusz:** az alábbi történeti irányok tulajdonosi döntések. Ez a dokumentum nem állít Godot-implementációt.
**Forrás:** a jelen fejlesztési chatben átadott „TSUKIMORI — Work fejlesztési átadás” és a Mashiro-kivételre adott pontosító válasz.
**Elsőbbség:** az explicit új tulajdonosi döntés az adott pontban felülírhatja a régebbi irányt; minden más LOCKED döntés megmarad.

## Katsuro és a falu titka
Kezdetben a misztikus hangulat dominál. A karakterek pszichológiai problémái nem kapnak rögtön kész magyarázatot vagy diagnóziscímkét.
Katsuro külön, személyes dolgozószobájában később előkerülnek a falusiakról készült feljegyzései. Miyako tud róluk és tudatosan rejtegeti őket. Ez nem a rendelőszárny.
A pszichológiai nyomozati ágon feltárulhat Katsuro megölése egy korábbi Hetedik Éjszakán. Közvetlen elkövető, tanú és elhallgató külön szerep; személyek még nincsenek kijelölve.
A misztikus út és a világ végső természete nyitott marad. A nyomozati ág állítása nem lesz automatikusan minden út objektív világmagyarázata.

## Hetedik Éjszaka
Visszatérő kulcsnapok: 7., 14., 21., 28., majd a további hetek.
A Kollektíva fenyegetése erősödik. A szokatlan társas viselkedés, felnőtt meztelenség vagy közterületi intimitás a torzulás lehetséges eleme; konkrét jelenetek és képi megoldások nincsenek ezzel automatikusan elkészítve vagy jóváhagyva.
A tulajdonosi történeti döntés szerint a Kollektíva az adott éjszakai szexuális együttlétet ismeri el védő eseményként; korábbi kapcsolat és bizalom nem elég. Ez a fenyegető közösség torz szabálya, nem szabad beleegyezés vagy romantikus jutalom.
Kötelező nem szexuális túlélési, menekülési vagy ellenállási lehetőség is. Egy fenyegetés alatti történés nem válhat automatikusan szeretői kapcsolattá.
A 28. napi „Katsuro sorsa” lehetséges rossz befejezés; nincs engedély automatikus halálra vagy önkényes feltételküszöbre.

## Ayame
28 éves felnőtt nő, alkalmanként Aoi boltjában dolgozik gyógynövényekkel és teákkal. Külön személyiség és kapcsolati útvonal.
- 3. nap: hétköznapi első találkozás.
- 5. nap: személyesebb beszélgetés.
- 7. nap: első éjszakai látogatás Akiránál.
- 14. nap: második Hetedik Éjszaka.
- 15. nap: kölcsönös, józan döntéssel feloldható szeretői kapcsolat; nem automatikus jutalom a korábbi éjszakákért.
Eleinte az éjszakára hivatkoznak, nem vallják be érzelmeiket. Később valódi szerelem is kialakulhat.
A jóváhagyott elsőtalálkozás- és Hetedik Éjszaka-kép referencia; a bináris fájlok importja külön igazolandó.
Ayame konkrét tulajdonosi kivétel a régebbi karakterbővítési stop alól, nem általános felhatalmazás további szereplők kitalálására.

## Pszichológiai karakterépítés
Minden fontos szereplő súlyos, saját előzményekkel és hétköznapi megnyilvánulásokkal kidolgozott problémát kapjon. A konkrét diagnózisok írói javaslatok, nem véglegesített tények.
A tünetek, a trauma, a szereplő döntése és a horrorreakció külön kezelendő. Mentális betegségből nem következik automatikusan erőszak vagy gyilkosság.

## Mashiro: True Love és A Hold Két Arca
Mashiro kizárólagos True Love útvonala teljes értékűen, változatlan fő romantikus befejezésként megmarad. Menedéke őszinte, de nem garantáltan biztonságos.
Külön jóváhagyott titkos kivétel: **A Hold Két Arca**, Akira, Mashiro és Sayuri számára.
Ez nem általános háremengedély, és más többpartneres kombinációt nem nyit meg Mashiróval.

Kötelező történeti követelmények:
1. Mashiro és Sayuri személyes történetének mély megismerése.
2. Őszinteség mindhárom fél között.
3. Mashiro és Sayuri egymással kialakított, Akirától függetlenül is létező bizalma és érzelmi kapcsolata.
4. Mindhárom fél szabad, tudatos és folyamatos beleegyezése.
5. Pozitív, karakterhű személyes történetszálak.
6. A külön titkos eseménylánc sikeres teljesítése.
7. Végjátékbeli közös döntés, amely egyik résztvevőt sem áldozza fel a másik kettőért.

Technikai irány: kizárólag egy dedikált **moon_two_faces** útvonal kaphat külön kivételkezelést. A jelenlegi általános Mashiro-exkluzivitási szabályt nem szabad globálisan kikapcsolni.
A pontos affinitási küszöbök, eseményazonosítók és napok **REVIEW / még nyitottak**. A titkos út nem implementált, Sayuri személyiségét, életkorát, megjelenését és önálló történetét ez a kiegészítés nem találja ki.

## Változatlan keret
120 történeti nap, lehetséges időugrások és route-függő romantikus utazások. Első időjárási rendellenesség legkorábban a 30. napon.
640×360 alapfelbontás, cinematic 2.5D pixel-art, meglévő jóváhagyott vizuális identitások és jelenetek megőrzése.
Nincs második GameState vagy dialógusrendszer, és nincs a külön átadott Miyako-folyosófeladat megismétlése.

## Implementációs státusz
Ayame, a Hetedik Éjszaka rendszere, a nyomozati bizonyítéklánc és moon_two_faces jelenleg MISSING a vizsgált ccf6fbc main alkalmazáskódjában.
A pontos audit, ütemterv, assetjegyzék és teszteredmények: [WORK_HANDOFF_AUDIT_2026_10_19.md](WORK_HANDOFF_AUDIT_2026_10_19.md).
