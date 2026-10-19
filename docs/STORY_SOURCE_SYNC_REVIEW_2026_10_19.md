# Történeti forrásellenőrzés és másik chat — 2026-10-19
Státusz: REVIEW összevetés. Nem új LOCKED bible, nem implementált történeti jelenet.

## Ellenőrzött források
- GitHub main: TSUKIMORI_120_DAY_STORY_AND_WORK_HANDOFF.md, MASHIRO_LOCKED_BIBLE.md, MASHIRO_MAIN_ROMANCE_CANON.md, CHARACTER_BIBLE.md, STORY_CANON.md és Ren'Py megfeleltetési dokumentumok.
- Tulajdonosi pontosítás: a folytatás szövege az alaptörténetben keresendő.
- Helyi, változatlan forrás: Downloads/Tsukimori_teljes_megirt_tortenet_2026-10-04.pdf, 61 oldal. Szövegkinyerés; a következő VI. fejezet 43. oldala vizuálisan is ellenőrizve.
- Helyi, változatlan Ren'Py: Downloads/Tsukimori_RenPy_Prototype/game/Tsukimori/game/canonical_html_story.rpy. A főút címkéi és a következő fejezetek ellenőrizve. A himiko_content.rpy saját megjegyzése szerint karakter-előkészítés, külön Himiko-fejezet nélkül.
- Másik chat: „Folytatás írása”, 6acd09cd-9068-83eb-b5e1-9ab140be7541. Az olvasó eszköz öt legutóbbi felhasználói üzenetet adott vissza, régebbi lapozási kurzor nélkül. Az asszisztensválaszok tényleges szövege helyett tartalomhivatkozások érkeztek; azokat nem tekintjük elolvasott specifikációnak.

## Alaptörténet és naptár
Az első tíz FEJEZET nem azonos az első tíz NAPPAL.
A PDF 2. oldalának szerkesztői megjegyzése külön jelzi: I–VI részletesebb próza; VII–X korábbi, tömörebb változat. Kuroe belépője és Shion éjszakai jelenete külön egység, végleges fejezetszám nélkül.

A már implementált Hana/Shion/pecsét/tea folytatása nem hiányzó alaptörténet miatt állt meg: a következő anyag létezik, de a későbbi 120 napos iránnyal egyeztetett napi elhelyezés még nincs teljesen átültetve.

| Anyag | Ellenőrzött forrás | Átültetési korlát |
|---|---|---|
| A ház alatti hang | PDF 43. oldal; Ren'Py canonical_html_chapter_6, 2522. sortól | A pecsét közvetlen folytatása; a már hozzáírt esti tea időrendjével össze kell kötni. Akira észlelése nem új, objektív világmagyarázat. |
| A szentély mélye | PDF 44. oldal; canonical_html_chapter_7 | Korai végső leleplezésként nem importálható automatikusan a 120 napos, bizonytalan ontológiájú történetbe. |
| Katsuro szobája | PDF 46. oldal | Régi sorrendben a szentély után; a másik chat most a fokozatos nyomozás fontos forrásává teszi. A rendelő nem ez a szoba. |
| Miyako testi átalakulása | PDF 46. oldal régebbi változata | Nem írja felül a tulajdonos későbbi, lassú folyamatot kérő döntését. A jelenlegi korai transformation flag hamis marad. |
| Himiko | himiko_content.rpy; karakterbible és 120 napos handoff | A helyi fájl csak definiálja a karaktert, nincs benne kész belépődialógus. 3–4. nap korábbi terv, nem kész Godot-jelenet. |
| Mashiro | MASHIRO_MAIN_ROMANCE_CANON.md | 5–10. napi bemutatkozás, javasolt 7.; meghívási határidő implementálva, portrék/CG-k hiányoznak, jelenet még nincs. |

A korábbi Hana-heverőszöveg nem térhet vissza a tulajdonos által kért, Akirához közeli szék helyett. A helyi forrásolvasás nem ad felhatalmazást már javított jelenetek visszaállítására.

## A másik chatben ténylegesen olvasható új tulajdonosi irányok
1. Eleinte a hely miszticizmusa domináljon; a szereplők problémái ne legyenek rögtön nyilvánvalóak.
2. Katsuro elrejtett jegyzeteit később a személyes szobájában találja meg Akira; Miyako rejtegeti őket.
3. A nem misztikus értelmezési ágon Katsurót a nők ölhettek meg az egyik hetedik éjszakán. Ez az ág megfogalmazása, nem minden út kötelező végső igazsága.
4. A hetedik éjszakák visszatérő, erősödő veszélyt hordoznak. A negyedik alkalom halálos kimenetele a felhasználói mondatban lehetőségként szerepel; nincs végleges küszöbként implementálva.
5. Szereplőnként eltérő pszichológiai működés szükséges; kész diagnózislista, küszöbök és napi eseménysor nem érkezett az olvasható üzenetekben.

A partner jelenlétéhez kötött közösségi védelem és a szexet túlélési feltétellé tevő felvetés is szerepelt az üzenetekben. Nem készült belőlük játékszabály. Megvalósítási alternatíva REVIEW-ra: önként vállalt társas jelenlét vagy segítség mint védelem, szexuális aktus kikényszerítése nélkül. Ez nem jóváhagyott kánonmódosítás.

## Megmaradó határok
- A 30. nap előtti időjárási anomáliatilalom változatlan.
- Mashiro kizárólagossága nem oldódik fel; a hetedik éjszaka nem jelent automatikus elköteleződést.
- A folyosói Miyako-feladat nincs duplikálva.
- A mentális probléma önmagában nem automatikus agresszió-/gyilkosságflag. Konkrét karakteresemény és választás kell.
- A jegyzetek és szereplői állítások nyomok, nem önállóan eldöntött végső metafizika.
- Nincs most új hetedikéjszaka-végrehajtó, automatikus halál, kényszerített szexmechanika vagy új ending.

## Következő átültetési egység
A VI. fejezet és a Katsuro-jegyzetek előkészítésének pontos összeillesztése a meglévő pecsét/tea után, a szentélyi teljes igazság korai közlése nélkül. Ezzel együtt későbbi napokra visszanyitható falu, majd Himiko/Mashiro külön jelenetei és a 10. napig tartó folyamat. A kész naptár és a most tesztelt saját helyszínek ennek alapjai; a teljes tíz nap továbbra sincs késznek minősítve.
