# Akira + Miyako — Beauty Target Arrival Staging v1

**Jelenet:** Akira esti megérkezése Miyako házához  
**Státusz:** REVIEW TARGET / implementációs rendezési terv  
**Dátum:** 2026-09-24

## 0. Cél

Ez a jelenet a Tsukimori Visual Target v1 első **beauty target** jelenete.

Nem külön cutscene-film, hanem a bejárható Godot-játékmenetből természetesen kinövő, rövid rendezett találkozás.

Kulcsmondat:

> **Miyako: „Dr. Akira. Már vártam.”**

A jelenet feladata:
- megmutatni Akira és Miyako vizuális kontrasztját;
- először igazán „kész játék” érzetet adni;
- a hideg Tsukimori-éjszaka és a ház meleg belső fénye közötti kontrasztot használni;
- létrehozni az első valódi érzelmi feszültséget kettejük között;
- úgy megállítani a játékost, hogy az ne érezze hosszú, erőltetett cutscene-nek.

---

# 1. Kánon / asset szabály

Kötelező:
- Akira: `docs/AKIRA_PRODUCTION_SPEC.md`
- Miyako: `docs/MIYAKO_PRODUCTION_SPEC.md`
- Miyako ebben az első találkozásban **Design A — Primary FINAL** megjelenést használ.
- Design B ceremoniális outfitje itt **nem** használható alapként.
- A jelenlegi patak/híd/ház elrendezés marad.
- A jelenlegi encounter trigger és házpozíció marad, amennyiben F5-ben nem okoz kompozíciós hibát.

---

# 2. Térbeli staging

A jelenlegi blockout koordinátáihoz igazítva:

- közös ház: `Houses/MiyakoAkiraHome` — kb. `z = -122`
- Miyako találkozási pont: a ház előtti/kapu-közeli oldal
- Akira a híd felől érkezik a fő útvonalon
- a rendelőszárny a híd felőli oldalon marad
- a ház meleg bejárati fénye a vizuális fókusz
- a híd/falu hideg fényű tömege a háttérben olvasható marad

### Miyako helye

Miyako ne közvetlenül az út közepén álljon.

Cél:
- 0.8–1.2 m-rel a bejárat/küszöb elé vagy mellé;
- test 25–35°-ban az érkező út felé fordítva;
- ne teljesen Akira felé nézzen már a jelenet elején;
- a váll és csípő maradjon nyugodt;
- a meleg ajtófény egyik oldalról rajzolja az arcát.

### Akira megállási pontja

Akira automatikus lassítása a találkozáskor:
- trigger után kb. 1.8–2.3 m-re Miyakótól;
- ne álljon túl közel;
- ne legyenek azonnal romantikusan intim távolságban;
- az első jelenetben maradjon érezhető személyes tér.

---

# 3. Jelenet idővonala

Teljes célhossz: **7–10 másodperc**, az első mondat elolvasási idejét nem számolva.

## Beat 0 — Approach
**-2.0 → 0.0 sec**

Gameplay folytatódik.

Akira:
- normál Walk;
- a híd és az első túlparti ház után közelít;
- a kamera a meglévő `MiyakoCourt` beállítás felé oldódik;
- a játékos még irányít.

Környezet:
- eső/köd/wet stone aktív;
- távoli víz;
- szél;
- veranda-lámpa;
- nagyon finom szélcsengő.

Nincs zeneváltás azonnal.

## Beat 1 — Recognition
**0.0 → 1.2 sec**

A trigger aktiválódik.

1. Akira szeme Miyakóra vált.
2. kb. 80–120 ms múlva a feje követi.
3. még tesz egy rövid utolsó lépést.
4. Walk → WalkStop.
5. játékos input röviden blokkolódik.

Ez fontos Akira-character beat.

**Tilos:** hirtelen snap-turn vagy teljes testfordulat.

## Beat 2 — Miyako catches the eye
**1.2 → 2.6 sec**

Kamera:
- blend a `MiyakoFocus` rendezett kompozícióba;
- ne legyen túl közel;
- először Miyako sziluett + meleg ajtófény;
- Akira vállának/oldalának kis része maradhat foregroundban.

Miyako:
- álló Idle;
- hosszú szemkontaktus;
- alig észrevehető belégzés;
- egyik kéz nyugodtan a ruha/öv közelében;
- nincs nagy meghajlás.

Fény:
- meleg key a házból;
- hideg kék fill a falu felől;
- finom haj-rim.

## Beat 3 — First gesture
**2.6 → 3.6 sec**

Miyako:
- nagyon kicsi, kb. 8–12°-os fejbiccentés/meghajlás;
- szemkontaktust nem szakítja meg azonnal;
- egyik kéz enyhén megmozdul, majd megáll;
- a ruha 2–3 frame késéssel követ.

Ez nem ceremoniális meghajlás.

## Beat 4 — The line
**3.6 sec → player advance**

Kamera:
- nyugodt two-shot / over-Akira-shoulder;
- Miyako arca teljesen olvasható;
- Akira részben foreground;
- háttérben a meleg belső tér és oldalt hideg Tsukimori.

Miyako:

> **„Dr. Akira. Már vártam.”**

Hang:
- közvetlen, halk;
- nincs melodramatikus zenei sting;
- a környezeti hang halkulhat kb. 10–15%-kal a mondat alatt.

## Beat 5 — Akira response hold
**a sor után kb. 0.8–1.2 sec**

Akira:
- nem válaszol testtel nagyot;
- szemkontaktus;
- minimális állkapocs / légzés;
- súlypont nagyon kicsit középre áll.

Ez az első alkalom, amikor a játékos megérzi:
**Akira figyel, nem performál.**

## Beat 6 — Transition inward
A jelenet ezután:
- vagy Ren'Py-ből átültetett házbelső párbeszédre vált;
- vagy rövid kontrollált átmenettel belépnek a házba.

A beauty target szempontjából a küszöb-jelenet itt lezárul.

---

# 4. Kamera staging

## Shot A — Approach composition

Forrás:
- meglévő `MiyakoCourt`

Cél:
- Akira teljes alak / 3/4;
- ház előtte jobbra;
- Miyako már korán látható legyen;
- híd/falu részben maradjon a képben;
- ne takarja Miyakót tetőoszlop vagy növény.

## Shot B — Miyako reveal

Forrás:
- meglévő `MiyakoFocus` továbbfinomítva.

Javaslat:
- kamera kb. 35–50 mm ekvivalens érzet;
- enyhén Akira válla mögül;
- Miyako a kép jobb harmadában;
- meleg ajtófény mögötte;
- bal oldali háttér: hideg falu / köd.

## Shot C — First-line two-shot

Új narratív kamera vagy ideiglenes override ajánlott.

Kompozíció:
- Akira bal foreground;
- Miyako jobb/midground;
- szemvonal közel egy magasságban;
- enyhe magasságkülönbség természetesen megmarad (180 vs 165 cm);
- ne legyen romantikus close-up még.

## Shot D — optional micro close-up

Csak későbbi polish passban.

A mondat után 0.5–0.7 sec Miyako-szem/arc közeli használható, de **nem kötelező**.
A jelenet P4G-szintű lehet nélküle is.

---

# 5. Fényterv

## Hideg világ

Moon/sky:
- kékesszürke;
- alacsony kontraszt;
- ködön szétszórva.

## Ház / veranda

`WarmEntryLight`:
- melegebb és irányítottabb;
- Miyako arcának kb. 55–65%-át olvashatóan megfogja;
- nem égeti ki a bőrt;
- a ruha fekete részletei megmaradnak.

## Akira

Akira a hideg és meleg fény határán álljon:
- ház felőli oldal enyhén meleg;
- falu felőli oldal hideg;
- fekete hajhoz finom rim;
- arca ne legyen túl világos.

## Vizualitási szabály

**A két karakter arca mindig olvasható.**
A „sötét játék” nem jelent fekete arcokat.

---

# 6. Környezeti mozgás

Kicsi amplitúdó:
- eső;
- talajköd;
- cédrusok;
- veranda-szélcsengő;
- Miyako hajának néhány tincse;
- ruha alja;
- Akira hoodie/jacket széle.

A jelenetben semmi ne mozogjon gyorsabban, mint ami a figyelmet Miyakóról elvinné.

---

# 7. Audio staging

Háttér:
- víz;
- eső;
- távoli szél;
- fa finom recsegése;
- nagyon halk falu.

Trigger pillanat:
- nincs „whoosh”.
- nincs UI ding.
- nincs horror sting.

Miyako mondatánál:
- ambience duck: -10–15%;
- a szélcsengő lehet egyetlen nagyon finom, természetes hang közvetlenül előtte vagy utána.

Zene:
- opcionális;
- ha belép, csak nagyon halvány, 1–2 hangos motívummal;
- a csend elsőbbséget élvez.

---

# 8. Animációk

## Akira
Szükséges:
- `AKIRA_Walk_Loop`
- `AKIRA_WalkStop_R/L`
- `AKIRA_Idle_Base_01`
- eye-look target
- head follow
- subtle body settle

## Miyako
Szükséges:
- `MIYAKO_Idle_Base_01`
- `MIYAKO_SoftBow_01` vagy a `SoftGesture` specializált változata
- `MIYAKO_FoldHands` opcionálisan a mondat után
- eye contact target
- subtle hair/cloth secondary

**Nem kell** teljes cinematic mocap-szerű animáció ehhez a jelenethez.

---

# 9. Input és gameplay

Triggerkor:
- movement input lock;
- kamera input lock, ha van;
- player velocity finoman nullára csillapodik;
- nem teleportáljuk Akirát látványosan.

Jelenet után:
- ha házbelső VN/jelenet indul, kontroll átadódik annak;
- ha exploration folytatódik, input lágyan visszatér;
- `met_miyako` csak a jelenet megfelelő pontján álljon be, ne a trigger első frame-jében.

---

# 10. Technical implementation suggestion

Ajánlott új réteg:
`MiyakoFirstEncounterDirector`

Feladata:
- trigger fogadása;
- input lock/unlock;
- WalkStop kiválasztása;
- eye/head look target;
- kamera blend;
- Miyako gesture;
- dialogue start;
- GameState flag;
- transition back/inside.

Ne kerüljön minden logika közvetlenül a `first_street.gd` fájlba.

Javasolt scene/node:
`scenes/narrative/miyako_first_encounter.tscn`

Javasolt script:
`scripts/narrative/miyako_first_encounter.gd`

---

# 11. Review checklist

## Kompozíció
- [ ] Miyako már approach közben észrevehető
- [ ] ház meleg fénye tisztán vezeti a szemet
- [ ] híd/falu hideg háttere érződik
- [ ] nincs vizuális takarás
- [ ] 180/165 cm magasságkülönbség természetes

## Akira
- [ ] szem reagál először
- [ ] fej késik
- [ ] WalkStop nem csúszik
- [ ] nincs snap rotation
- [ ] reakció kontrollált

## Miyako
- [ ] Primary Design A outfit
- [ ] arc olvasható
- [ ] gesztus kicsi
- [ ] szemkontaktus hosszabb
- [ ] ruha/haj finoman követ

## Fény
- [ ] fekete ruha nem massza
- [ ] fekete haj nem olvad háttérbe
- [ ] arcok olvashatók
- [ ] warm/cool kontraszt erős, de nem túlszaturált

## Ritmus
- [ ] 7–10 sec alatt felépül
- [ ] nincs felesleges animáció
- [ ] első mondatnak van tér
- [ ] csend működik

---

# 12. Beauty target PASS feltétel

A jelenet akkor PASSED, ha egy F5 bejárásból készült állókép vagy rövid capture már önmagában azt az érzést adja:

> **„Ez nem blockout. Ez Tsukimori.”**

A beauty target PASSED státusz nem jelenti automatikusan, hogy a ház, Akira vagy Miyako assetje FINAL; csak azt, hogy a jelenet vizuális és rendezési nyelve elérte a projekt quality barját.
