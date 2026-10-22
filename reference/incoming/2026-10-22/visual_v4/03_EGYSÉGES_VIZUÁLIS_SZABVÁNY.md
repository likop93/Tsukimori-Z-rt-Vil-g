# EGYSÉGES VIZUÁLIS SZABVÁNY — TSUKIMORI V4

## 1. Authority / prioritás
1. A felhasználó jelenleg jóváhagyott, ténylegesen csatolt képei és újabb kifejezett döntései.
2. A Godot `docs/DECISION_LOG.md` továbbra is érvényes LOCKED tartalma, kivéve amit egy későbbi kifejezett tulajdonosi döntés felülírt.
3. `docs/PIXEL_ART_PRODUCTION_DIRECTION.md` — LOCKED gyártási render, konzisztens pixel-art nyelv.
4. GitHub `docs/AKIRA_PRODUCTION_SPEC.md` / `docs/MIYAKO_PRODUCTION_SPEC.md` — karaktertulajdonságok és mozgásnyelv, de a régi 3D / WASD technikai részek nem élveznek elsőbbséget az új navigációs döntéssel szemben.
5. Régi REVIEW és egyéb generált képek csak háttér-/hangulat-referenciák, nem személyazonosság-források.

## 2. Arcazonosság — ABSZOLÚT SZABÁLY
### AKIRA / A0
- Referencia: `AKIRA_01_TULAJDONOSI_EGYALAKOS.png` (+ többnézetű `AKIRA_02_TULAJDONOSI_KARAKTERLAP.png`).
- **SEMMILYEN SZEMÜVEG**; fekete, rétegzett, kissé rendezetlen haj; a feltöltött arc, szem, hajkontúr és fiatal felnőtt arányok.
- **Korai utcai/intro outfit**: sötét modern kabát, szürke kapucnis réteg, világos póló, sötét nadrág, cipő, karóra. Az előző elegáns fekete **öltönyös generált arc és ruhakészlet elvetett**.
- **Orvosi köpeny csak valódi rendelési / gyógyítási jelenetben**; személyazonosság változatlan.
- Szigorúan nincs újraértelmezett „szemüveg nélküli öltönyös orvos” az elfogadott forrás helyett.

### MIYAKO / M0
- Referencia: `MIYAKO_01_TULAJDONOSI_EREDETI.jpeg`; használható alfa-kezdemény `MIYAKO_02_EREDETIBOL_KIVAGOTT_VN_REVIEW.png`.
- Ugyanaz a hosszú, részben feltűzött sötétbarna haj, barna szem, arany hajdíszek/függők, finom komoly arcvonások.
- Alapruha: magas nyakú, sötét charcoal-fekete, arany textilmintás, hosszú elegáns viselet. Nem fehér-bordó vagy virágos kimono, nem mélyen dekoltált új karakter.
- A játék elején sem ezüst haj, sem kék szem, sem végleges testtorzulás. Ezek későbbi, történetileg kiváltott és maradandó folyamatok.
- Nincs kötelezően komor mimika: az arc azonos marad, *csak* szemöldök, szemhéj, száj és tekintet változhat.
- A már létező külön esti outfit csak az adott jelenetben; nem ad jogot más női arc vagy más sziluett létrehozására.

## 3. Azonos képi gyártási pipeline — három réteg, ne keverd össze
**I. Identity / hi-res forrás:** a fenti tulajdonosi képek, archiválva, soha felül nem írva. Ezek méretarány- és arcreferenciák, nem automatikusan játék-FINAL.

**II. VN reaction szett:** azonos fejpozíció, szemmagasság, testarány, ruhakivágás, megvilágítás és alfa-sziluett, egyetlen alaprétegből. Ne rajzold újra az egész embert egy mosoly miatt. Minden módosítást az A0/M0 forrásra lehessen visszavezetni. Egységes portrékeret és renderstílus; **a két mostani alfa-portré azonos pixelméretű, de ettől még nem azonos végleges stílusú**.

**III. Cinematic CG:** új, egyetlen 16:9 jelenetkép; ugyanazon A0/M0 identitások, azonos helyszín-topológia, fény/paletta/pixelrács, a szöveg számára szabad alsó sáv, ráégetett felirat és UI nélkül. A karakterek fizikailag hiteles pozícióban ülnek, állnak vagy cselekszenek. Képi forrás nem lehet karakterlap-kollázs.

## 4. Játékon belüli egységesség (LOCKED stílus)
- High-detail cinematic **2.5D pixel-art**, nem külön smooth-anime CG világegyetem.
- Következetes pixelcsoportok és élek, kézzel kontrollált részletek, nem automatikus pixel-filter.
- Meleg borostyán belső/lámpafény és hideg kék-zöld esti külső, közös tónusgörbével; a sötét haj és ruha részletei maradjanak olvashatók.
- Rétegek: háttér + cselekvés + előtér (parallax opcionális), nem statikus portrékat állító dioráma.
- Első technikai teszt 640×360 natív canvas → 3× integer upscale; 16:9 CG lehet nagyobb munkaméretű, de a final pixelrács egységes.
- Kattintható falu-/helyszíntérkép és filmes események; WASD, járóanimáció és nem jóváhagyott NPC elhelyezés nincs szükségeltetve.

## 5. Egyértelmű reakció-mátrix
Közös arc- és beállítás-rendszer. Új arckifejezés késznek csak tényleges, karakterazonos képfájl esetén jelölhető.

| Állapot | Akira (A0) | Miyako (M0) | Első használat | Státusz |
| --- | --- | --- | --- | --- |
| 00 alap | kontrollált, figyelő | finoman komoly, nyugodt | érkezés, bevezetés | ALAPKÉP RENDELKEZÉSRE ÁLL |
| 01 finom mosoly | ritka, enyhe | lágy ajaksarok | fogadás | TERV |
| 02 meleg | visszafogott | szem és váll lazul | közös étkezés, tea | TERV |
| 03 játékos | enyhe reakció | finom aszimmetrikus mosoly | humor | TERV |
| 04 érdeklődő | figyelő | enyhe szemöldök- és fejmozgás | közös beszélgetés | TERV |
| 05 aggódó | visszafogott aggodalom | szűkülő szemöldök | trauma utóhatása | TERV |
| 06 figyelő/nyugtalanító | felismerési bizonytalanság | rövid gyanakvó pillantás | Katsuro nyomai | TERV |
| 07 sebezhető | fáradt, feszült | fájdalmas, visszafojtott | későbbi vallomások | TERV |

**Stop-szabály:** ha egy módosítás miatt az arc, ruha vagy haj eltér a referenciától, az adott kép FAIL, nem kerül Work/Godot FINAL helyre. Inkább a meglévő neutral képet használjuk.

## 6. Történeti folytonosság és helyszínek
- Nyitás: Akira saját autóval érkezik, a falu szélén parkol; gyalogosan halad tovább, először falu, aztán patakhíd, majd Miyako/Katsuro háza.
- Miyako háza nem ryokan/fogadó; a túlparti közös házhoz klinikai szárny tartozik. Shion háza a falusi oldalon van.
- A faluban csak a jelenet idején ténylegesen jelen lévő, történetileg jogosult nők kerülhetnek konkrétan a CG-be. Egyetlen jelenet ne gyűjtse össze az összes későbbi főszereplőt.
- Az első napok nem leplezhetik le biztosan a kollektív pszichológiai magyarázatot, Katsuro halálának okát vagy Miyako későbbi formáját.
- Az első időjárási rendellenesség: 30. nap. Előtte a hagyományos eső/köd nem természetfeletti meteorológiai anomália.

## 7. Tiltólista — a korábbi loopot ne ismételd
- új Akira-arc; szemüveg; elegáns öltöny a jóváhagyott utcai ruha helyett; fehér orvosi köpeny az autóban, faluban vagy teázáskor;
- új arcú, vörös-fehér kimonós vagy túlzottan szexualizált „másik Miyako”;
- generic anime csapatkép, önkényes női főszereplő-sereg;
- felirat/keret/kollázs közvetlen CG-nek;
- hiányzó 23 CG *késznek* bejelentése;
- nyers AI-anime PNG „FINAL pixel-art” címen.
