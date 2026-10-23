# Tsukimori — 120 napos történeti irány és Work fejlesztési handoff

> **2026-10-21 tulajdonosi pontosítás:** [CANON_SYNC_2026_10_21.md](CANON_SYNC_2026_10_21.md). A lent említett „szabadon bejárható” világ és „minden NPC találkozása” **nem WASD-vezérelt szabad mozgást** jelent. A játék kattintásos térképpel, filmes jelenetváltásokkal és VN-nel működik. A korábbi buszos intró SUPERSEDED: Akira autóval érkezik, a falu szélén parkol és filmes gyalogos beállításokon jut el Miyakóhoz. Az elfogadott 120 napos történet változatlan; az itt leírt 1–10. napos fejlesztési cél nem elkészült tíz nap.

**Rögzítve:** 2026-10-14  
**Státusz:** tulajdonos által elfogadott új kreatív irányok + világosan megjelölt, MÉG NEM LOCKED javaslatok.  
**Első technikai cél:** az 1–10. nap végigjátszható, összefüggő Godot-változata.

> A jelenlegi `docs/STORY_CANON.md`, `docs/CREATIVE_BIBLE.md`, `docs/DECISION_LOG.md`, `docs/CHARACTER_BIBLE.md`, az egyes produkciós spec-ek és a `docs/MASHIRO_LOCKED_BIBLE.md` továbbra is irányadók. Ez **kiegészítő** handoff; ellentmondás esetén ne írj felül kánont automatikusan, hanem jelezd az ütközést.

## A. Elfogadott kreatív döntések (LOCKED direction)

1. **Karakterbővítési stop az első szakaszban.** A meglévő jóváhagyott szereplők játékbeli integrációja fontosabb új karakterek tervezésénél.
2. **Minden fontos karakter külön, saját helyszínt kap.** A 1. nap **délutánján** Akira bejárja Tsukimorit, és itt ismer meg sok, már rendelkezésre álló szereplőt. A falu szabadon bejárható és a találkozások természetesek, nem automatikus szerelmi elköteleződések.
3. **Első mérföldkő: játszható 10. nap.** Készüljenek tartós nap-/napszak-, esemény- és kapcsolati rendszerek; folyamatos történet és ellenőrizhető játékállapot. A jelenlegi REVIEW falubejárást fejlesszük tovább, ne cseréljük le nulláról. Lásd `docs/VILLAGE_HUB_REVIEW.md`.
4. **Hosszú távú keret: 120 játékbeli nap, négy évszak** (30 nap/évszak; 1–30 tavasz, 31–60 nyár, 61–90 ősz, 91–120 tél). A 120 nap tartalmazhat fókuszált történeti napokat és játékosvezérelt mindennapokat; nem kell 120 külön hosszú lineáris fejezet.
5. **Időjárási/évszaktorzulás csak a 30. naptól kezdődik.** Az **1–29. nap időjárása és évszakrendje természetes**; a pszichológiai/szupernaturális horror korábban is jelen lehet, de NINCS időjárási anomália. A 30. napon először finom, megmagyarázhatatlan meteorológiai anomália; ez később erősödik, a távoli évszakok egybefolyhatnak. Az ok **nincs eldöntve**. A 30. napon belül kezdődik az első eltérés, ezért a 30. nap nem hibátlan, természetes tavaszi nap.
6. **Minden felnőtt női romantikus út eltérő pszichológiai horror- és érzelmi történetet ad**, eltérő titkokkal és befejezésekkel. A teljes igazság nem szükséges minden út befejezéséhez. Route-ok: Miyako, Shion, Kuroe, Hana, **Himiko (Hana nővére)**, Reina, **Renka**, Mashiro; továbbá háremút és nem-romantikus/sötét/ébredési lezárások lehetősége.
7. **Mashiro true route-ja kivételes, kizárólagos út.** Ő Akira lehetséges tiszta újrakezdése és teljes gyógyulása. Akira **nem szükségszerűen ismeri fel eredeti identitását**, nem kell minden szilánkot összegyűjtenie, és Loft/A Szervezet teljes múltja akár fel sem tárulhat ezen az úton. A horror és a torzulások jelen vannak, de Mashiro ága tisztább érzelmi tónusú. A világ/metafizika akár a bűnök eltörlésének vagy az identitás újrakezdésének lehetőségét is megengedheti; ennek pontos mechanizmusa **nyitott**. **Mashiro nem szerepel a háremútban**; komoly hárem-elköteleződés és Mashiro True Ending kizárják egymást.
8. **Háremút két eltérő erkölcsi állapottal lehetséges:** kölcsönös, tájékozott, önkéntes, visszavonható kapcsolatokból épülő jó szándékú változat; illetve sötét, manipulatív változat, ahol Akira kontrollja megsemmisíti mások autonómiáját. Nem szükséges minden szereplő részvétele. Nem a partnerek száma jelenti a morális különbséget, hanem az őszinteség és a szabad döntés. Ez felnőtt történet, a kizsákmányolás horror és erkölcsi romlás, nem romantikus jutalom.
9. **Fekete legyező szilánkjai Akira szétszakadt tudatához/emlékeihez kapcsolódnak.** Akira korábban A Szervezet része volt, és nőket manipulált, kihasznált, szexuálisan kizsákmányolt. A sötét út e magatartás visszatérése lehet. A legyező közös széttörése **már létező történet, Loft és A Szervezet kapcsolódásával**: ne találjunk ki alternatív széttörés-eredetet, mielőtt a korábbi forrásokat ellenőriztük.
10. **Tsukimori ontológiai természete NYITOTT:** tényleges természetfeletti falu, látomás, kómában átélt világ, élet-halál közötti határ vagy ezek összetettebb viszonya. A `Silent Hill`-szerű bizonytalanság, pszichológiai horror és világreakció **hangulati/történetvezetési inspiráció**, nem másolandó lore vagy jelenet.
11. **Ébredés/kóma lehetőség**, amelyben Akira megváltozott fizikai állapotban térhet vissza, **nem eldöntött végleges igazság**. Az esetleges sérülés vagy fogyatékosság ne legyen automatikusan erkölcsi büntetésként kezelve.
12. **Himiko** külön, Hana nővéreként fontos út; korábban kb. **3–4. napi érkezése volt tervezve**. **Mashiro bemutatkozása** továbbra is **5–10. nap**, alapjavaslat 7. nap, Miyako házánál virágcsokorral; üvegházi meghívása időérzékeny. Ne legyen jelen az 1. napi kötelező bemutatkozásoknál.

## B. Route-ok: jóváhagyott tematikus irányok (nem kész küldetés- vagy dialógusvázlat)

| Út | A horror/kapcsolat elsődleges témája |
|---|---|
| Miyako | Birtoklás, függőség, megszállottság |
| Shion | Emlékezet, múlt, identitás |
| Kuroe | Szabadság, vágy, kontroll kérdése; Shionhoz fűződő múlt |
| Hana | Bizalom, kiszolgáltatottság, önrendelkezés |
| Himiko | Tudati kontroll, pszichiátriai/pszichológiai hatalom, Hana családi konfliktusa |
| Reina | Erkölcs, testi autonómia, felelősség |
| Renka | Korrupció, fekete víz, Akira múltjának visszatérése |
| Mashiro | Kizárólagos szerelem, gyógyulás, tiszta újrakezdés |
| Hárem — jó szándékú | Nyílt, szabadon vállalt többszereplős kapcsolat, valós konfliktusokkal |
| Hárem — sötét | Manipuláció, személyiség és beleegyezés elvesztése |
| Akira sötét útja | A korábbi elkövetői identitás visszatérése |
| Kóma/ébredés | A valóság és az identitás kérdése, NYITOTT ending lehetőség |

## C. A horror dramaturgiai munkahipotézise (nem új kánon)

- **Nap 1–10:** megismerkedés, falu élete és finom pszichológiai anomáliák; **nincs időjárási/évszaktorzulás**.
- **Nap 11–29:** memória- és észlelési horror fokozódhat; még mindig természetes időjárás.
- **Nap 30:** első szokatlan időjárási esemény.
- **Nap 31–60:** időszakos, lokalizált évszak- és időjárási eltérések.
- **Nap 61–90:** egyes körzetekben párhuzamos évszakélmény.
- **Nap 91–120:** az évszakok és a tér-idő rendje akár erősen összekeveredhet, route-függően.
- A fokozás és a konkrét jelenetek csak **javasolt dramaturgiai irány**, külön jóváhagyást igényelnek.

## D. Közvetlen Work/Godot teendők

1. **Először auditáld** a jelenlegi `project.godot`, `scripts/game_state.gd`, főjelenetek, a `docs/VILLAGE_HUB_REVIEW.md` és az eredeti Ren'Py történeti források állapotát. Ne állíts késznek csupán dokumentált funkciót; Godot-teszttel ellenőrizd.
2. Tartsd meg a meglévő 1. napi délutáni, összefüggő bejárható falu működését. **Minden karakter saját helyszíne** felé fejleszd tovább; ne cseréld le az elfogadott vizuális identitásokat generikus NPC-kkel.
3. Vezess be egységes **day + time-of-day + visit/discovery + route-state** modellt. A már létező flag-ek migrációja/kompatibilitása elsődleges; fejezetválasztó tesztbelépés ne adjon meg nem érdemelt pontokat.
4. Építs működő **1–10. napos** fő flow-t, ahol az 1. nap délutánja a falubejárás; Himiko és Mashiro megjelenése az időzítési kánont követi.
5. Az 1–29. napokra **weather_anomaly = false** legyen invariáns; a 30. naptól indulhat a rendszer. Ha nincs még teljes időjárásrendszer, először tervezett adatmodell és teszt, nem dekoratív, véletlen időjárási glitch.
6. Legyen tesztelve: normál új játék, első rendelési nap → falubejárás → esti folytatás, helyszínátjárók, karakterismereti flag-ek, kapcsolati döntések, 10. nap elérése, Mashiro meghívás időzítése, időjárási anomália korlátja.
7. Minden átadásban külön: **implemented / review / placeholder / planned**, hiányzó assetek és teszteredmények.
8. A tulajdonos által jóváhagyott karakter- és CG-referenciákat használd; ha nincs képfájl a repóban, **ne állítsd integráltnak**.

## E. Nyitva maradó, nem önkényesen eldöntendő kérdések

- Tsukimori végső természetének magyarázata.
- A szilánkok teljes metafizikai működése és minden egyes emlék tartalma.
- Loft és A Szervezet korábbi, pontos cselekményének forrásellenőrzése; a széttörés történetét nem írjuk újra.
- Mashiro „bűnök eltörlése” mechanizmusának ontológiai/erkölcsi jelentése.
- A 120 nap részletes napi forgatókönyve és a route-lock pontos naptári határai (kivéve korábban elfogadott Mashiro-meghívás).
- Az ébredés/kóma ending valódi volta és esetleges fizikai következményei.

**Work handoff szabály:** A fentiekből első körben a játszható **1–10. napot** készítsd el; hosszú távú 120 napos adat-/narratív kompatibilitással. Az elfogadott kreatív döntésekhez ne nyúlj, a nyitott rejtélyeket pedig ne oldd meg önállóan.
