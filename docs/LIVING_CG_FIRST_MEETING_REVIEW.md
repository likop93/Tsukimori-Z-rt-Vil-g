# Akira–Miyako Living CG — működő REVIEW próba

2026-10-29. Kiindulás: GitHub main `97f70f8`. **Az eredeti, tulajdonos által kiválasztott CG beépítve és bekapcsolva; Godotban lefuttatva.** Ez az első találkozás helyi filmes próbája, nem globális látványváltás és nem FINAL grafikai jóváhagyás.

## Forrás és ellenőrzés

A tulajdonos átadta a `TSUKIMORI_LIVING_CG_AKIRA_MIYAKO_REVIEW_WORK_V1 (2).zip` csomagot. Az `AKIRA_MIYAKO_LIVING_CG_01_USER_PREFERRED_REVIEW.png` képet használtuk, nem a második alternatívát. Az eredeti 1672×941 PNG változatlan másolat; SHA-256: `39017fd4e6e53b3c19e6d966be094e23f499d0c11ac97dd96c269ba197b75c0e`. A csomag README-jében megadott hash egyezik. [Provenance](../assets/opening/living_cg/PROVENANCE.json), [eredeti csomagleírás](../assets/opening/living_cg/SOURCE_README.md).

Képi ellenőrzés: Akira szemüveg nélkül balra, Miyako hosszú sötét hajjal, arany hajdísszel és fekete hétköznapi ruhában jobbra. Ráégetett szöveg/UI nincs. Nem történt generálás, átfestés, kivágás vagy karakter-redesign.

## IMPLEMENTED / TESTED

- A meglévő `scripts/opening/living_cg.gd` kilencmásodperces vezérlője az eredeti CG-t jeleníti meg. Legfeljebb 2,5% lassú kameraközelítés, külön mozgó szirmok, négy, a képen ellenőrzött lámpapozíció finom fényváltozása.
- Lineáris szűrés és ablakfelbontású `canvas_items` render a CG alatt; a tesztképek 1920×1080-asak. Nincs automatikus pixelesítés. A VN indulásakor és megszakításkor visszaáll az eredeti viewport mód.
- 0,8 másodperces áttűnés a meglévő VN-rendszerre. Az első mondat csak a vezérlés átadása után kezd kiíródni. A szöveg, választások, flagek és kapcsolatértékek változatlanok.
- Skip gomb és billentyűs kihagyás; szünet/feloldás; mozgástiltás; az ismételt kihagyás nem indít második párbeszédet. A kihagyás önmagában nem állítja be a találkozás befejezési flagjeit.
- A fejezetválasztó **I. Miyako · első találkozás** pontja és a rendes falu → híd → ház útvonal egyaránt elindítja az átvezetést.
- A 2026.10.22-i kompakt VN-doboz, portréméret és Akira-bal/Miyako-jobb elrendezés megmarad. A többi jelenet stílusa változatlan.

## REVIEW / MISSING

A sima anime CG után a meglévő pixel-háttérre és 640×360-as VN-renderre térünk vissza. A ruhák és a képernyőoldalak összhangban vannak, de a háttér, a nézőpont, a napszak fénye és a részletesség eltér. A CG utcai/ház előtti hangulata nem bizonyítja, hogy ugyanazt a konkrét házhomlokzatot látjuk. Ez a jelenet vizuális folytonossági REVIEW-pontja; a ház jelenetét nem terveztük újra.

Csak lapos PNG érkezett. Nincs külön háttér-, szem- vagy hajréteg, ezért nincs háttér-parallax, pislogás vagy hajanimáció. A szirmok eltérő sebessége nem háttér-parallax. Új hanganyag, autós nyitány, horrorbevillanás és új történeti nap nem része ennek a változtatásnak.

## Tényleges ellenőrzés és előnézet

Godot 4.7.2 stable, Compatibility/OpenGL, RTX 4070 SUPER. A main alapú külön ellenőrző példányban az érintett fájlokkal, grafikus futásban. [Teljes eredmények és naplók](living_cg_review_2026_10_29/results.json). [Képkockasorozat](living_cg_review_2026_10_29/FRAMES.md).

| Futás | Eredmény |
|---|---|
| `tests/ui/living_cg_regression.tscn -- --approved-cg` | PASS: valódi forrás, természetes lejátszás, képkockák, Pause, Skip, VN-végigléptetés, state |
| `tests/ui/living_cg_regression.tscn` | PASS: technikai fixture, hiányzó forrás, megszakítás utáni renderhelyreállítás |
| `tests/ui/vn_dialogue_regression.tscn` | PASS: eredeti első mondat, kompakt elrendezés, nincs szövegvágás, billentyűkezelés |
| `tests/ui/current_entry_audit.tscn` | PASS: valódi bejárás, új CG, találkozás, házba belépés és mindkét meglévő válasz |
| `tests/ui/chapter_select_regression.tscn` | PASS: fejezetindítás, CG kihagyása, első mondat nem vész el |
| `tests/opening/regression.tscn` (`gate_flow_regression.gd`) | PASS: teljes nyitány, bejárás, találkozás, állapotbiztos intro-Skip |
| `tests/opening/cinematic_input_regression.tscn` | Assertions PASS; a korábban is dokumentált 4 ObjectDB instance kilépési figyelmeztetés megmaradt |

A végső hét futásban nincs parse/runtime ERROR. A nyitány-input teszt nem figyelmeztetésmentes. A képrögzítés első próbája idő előtt megszakadt. A külső billentyűbevitel kizárására az érintett automatizált UI-tesztek ablakai most nem kérnek fókuszt; a megismételt futás sikeres volt. A régi, azonnali VN-t feltételező tesztek korlátos várakozással követik a tényleges átvezetést; a korábbi történeti ellenőrzések megmaradtak.

## Ebben az egységben változott fájlok

- `assets/opening/living_cg/`: eredeti 01 PNG, Godot importbeállítás, csomagleírás és forrásnyilvántartás.
- `data/opening/miyako_living_cg_REVIEW.json`: konkrét textúra, hash, lámpahorgonyok, `enabled: true`.
- `tests/ui/living_cg_regression.gd`: valódi forrásos mód és képkockarögzítés; a szintetikus mechanikateszt megmaradt.
- `tests/ui/vn_dialogue_regression.gd`, `tests/ui/current_entry_audit.gd`, `tests/ui/chapter_select_regression.gd`, `tests/opening/gate_flow_regression.gd`: az új átvezetés kivárása/kipróbálása.
- `docs/DECISION_LOG.md`, ez a jelentés és `docs/living_cg_review_2026_10_29/`: tényleges állapot, bizonyítékok.

A korábbi mechanikai előkészítés történeti bizonyítékai a `docs/living_cg_mechanics_2026_10_29/` mappában megmaradtak. Az ottani `art_validated: false` az akkori, kép nélküli futásra vonatkozik.
