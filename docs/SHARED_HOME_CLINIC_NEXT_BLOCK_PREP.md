# Tsukimori — Shared Home + Clinic Next Block Preparation

**Dátum:** 2026-10-04  
**Státusz:** IMPLEMENTATION PREP / REVIEW PLAN  
**Tulajdonosi döntés:** a jelenlegi házbelépési rész kész alap. **Nem kell újratervezni vagy újraimplementálni.**

## 0. Authority és jelenlegi állapot

Kötelező források:
- `docs/DECISION_LOG.md`
- `docs/STORY_CANON.md`
- `docs/CREATIVE_BIBLE.md`
- `docs/CHARACTER_BIBLE.md`
- `docs/PIXEL_ART_PRODUCTION_DIRECTION.md`
- `docs/MIYAKO_INTERIOR_REVIEW.md`
- `docs/INTERIOR_PASSAGE_AND_CONTINUATION_REVIEW.md`

Meglévő, megtartandó működés:
- külső Miyako VN;
- explicit E-belépés;
- rövid fade;
- `SHARED_HOME_CLINIC_INTERIOR_PIXEL_V1` jelenlegi REVIEW háttér;
- első benti Miyako-beszélgetés;
- két meglévő választás és a hozzájuk tartozó egyszeri állapotmódosítás;
- `entered_shared_home` és `miyako_interior_dialogue_seen` jelzők;
- Miyako melletti átjárás;
- meglévő első járósáv;
- jelenlegi fejezet-folytatási pont.

A belépési részt **nem szabad felülírni csak azért, hogy az új floorplan kényelmesebb legyen**. Az új területek ehhez csatlakozzanak.

---

# 1. Következő blokk célja

A jelenlegi egyetlen járható nappali-sávból fokozatosan valódi, történetileg olvasható közös ház + rendelő helyszín legyen.

A következő játszható lánc:

**meglévő belépés → nappali / konyha-étkező → Akira szobája → folyosó / privát szárny → Katsuro dolgozószobája → rendelő előtere / rendelőszárny → első éjszaka → első konkrét Katsuro-nyom → chapter hook**

A blokk célja nem a teljes épület végleges elkészítése, hanem egy kb. **10–15 perces, koherens második játékegység** a már működő érkezés után.

---

# 2. Térbeli lockok

Megőrzendő:

- a ház Katsuro egykori háza;
- Akira és Miyako közös lakóhelye;
- a rendelőszárny ugyanazon ingatlan része;
- a rendelőnek külön, híd felőli külső bejárata van;
- a lakótér és rendelő között van belső kapcsolat;
- Katsuro dolgozószobája személyes / mystery-room funkciójú tér;
- a rendelő és Katsuro dolgozószobája **nem olvasztható össze**.

Javasolt topológia, nem méretarányos blueprint:

```
[Külső főbejárat]
       |
[MEGLÉVŐ BELÉPÉS / GENKAN]
       |
[NAPPALI] ---- [KONYHA / ÉTKEZŐ]
   |
[FOLYOSÓ]
   |--------- [AKIRA SZOBA]
   |--------- [MIYAKO SZOBA] (kezdetben korlátozott)
   |--------- [KATSURO DOLGOZÓ] (mystery gate)
   |
[BELSŐ KAPCSOLAT]
   |
[RENDELŐ VÁRÓ] -- [VIZSGÁLÓ / KONZULTÁCIÓ]
       |---------- [ADMIN / IRATTÁR]
       |---------- [GYÓGYSZER / UTILITY]
       |
[KÜLÖN KÜLSŐ RENDELŐBEJÁRAT]
```

A konkrét ajtópozíciók és kamera-kompozíciók REVIEW során finomíthatók, de a funkcionális kapcsolat maradjon.

---

# 3. Task A — Nappali + konyha / étkező

## Funkció
A játékos első benyomása a ház hétköznapi oldaláról.

## Vizuális cél
- meleg fa;
- törtfehér shoji;
- puha lámpafény;
- kinti hideg eső csak ablakon / hangon keresztül;
- otthonos, de kissé túl rendezett;
- Miyako jelenléte érezhető;
- Katsuro hiánya is érezhető.

## Minimum interakciók
2–3 rövid observe pont:
1. étkezőasztal / két emberre terített vagy félbehagyott rend;
2. régi családi vagy házhoz kötődő tárgy;
3. rendelő felé mutató praktikus elem / ajtó / tábla.

Ne legyen exposition dump. Egy observe pont maximum 1–3 rövid mondat.

## Acceptance
- Akira szabadon végigsétál;
- sem bútor, sem Miyako nem blokkolja indokolatlanul;
- camera/pixel density egységes;
- világosan olvasható, merre van a privát és a rendelő irány;
- nincs véletlenül „hotel lobby” vagy generikus japán ház érzés.

---

# 4. Task B — Akira szobája

## Funkció
Akira első saját, biztonságosnak tűnő tere.

## Kötelező elemek
- fekhely;
- hely a csomagjának;
- orvosi táska / szakmai tárgy;
- egy személyes felület: asztal / polc / ablak;
- később használható anchor alváshoz / egyszerű mentéshez, de **save rendszer most még nem része ennek a tasknak**.

## Első látogatás
Nem kell hosszú jelenet.
Elég:
- rövid körbenézés;
- 2 observe pont;
- egy később visszahívható személyes tárgy.

## Acceptance
A szoba Akiráé legyen, ne Katsuro szobájának újrafestése.

---

# 5. Task C — Miyako szobája

## Első implementáció
**Korlátozott hozzáférés.**

Lehet:
- csukott ajtó;
- E → rövid observe;
- későbbi flaggel nyitható.

Nem kell még teljes interior scene.

## Cél
Miyako privát tere létezzen a világban, de az első este ne sérüljön a karakter határainak érzete.

## Kerülendő
- indokolatlan betörés;
- automatikus „loot” jelleg;
- korai intim tárgyak vizsgálata.

---

# 6. Task D — Katsuro dolgozószobája

## Funkció
Az első valódi mystery-room.

Ez legyen a következő blokk legerősebb helyszíne.

## Első hozzáférés
Két jó review-opció:

### A — részben nyitott
A játékos bejuthat, de:
- 1–2 fiók / szekrény zárva;
- bizonyos tartalom nem érhető el.

### B — kezdetben zárt
A játékos csak:
- ajtót;
- névtáblát / jellegzetes tárgyat;
- kulcslyukat / fényt / hangot
érzékel.

**A/B közül egyik sem válik automatikusan LOCKED kánonná tulajdonosi jóváhagyás nélkül.**

## Első konkrét Katsuro-nyom — PROPOSED OPTIONS

Egyetlen első nyom elég. Lehetséges:
- kézzel írt, Akirához köthető rövid jegyzet;
- régi fénykép;
- kazetta / hangfelvétel hordozója, amely még nem feltétlenül játszható le;
- orvosi / kutatási dokumentum, amely túl személyes vagy túl régi ahhoz, hogy hétköznapi legyen;
- lezárt fiók, rajta Akira számára felismerhető jel.

A nyom feladata:
**válaszoljon egy kis kérdésre, és nyisson két újat.**

Ne leplezze le Katsuro teljes igazságát.

---

# 7. Task E — Rendelőszárny

## Minimum bejárható egységek

### 1. Váró
- 3–5 ülőhely;
- kabát / esernyő pont;
- helyi tájékoztató / tábla;
- külön külső ajtó vizuálisan olvasható.

### 2. Vizsgáló / konzultáció
- valódi orvosi funkció;
- vizsgálóágy / szék;
- íróasztal;
- alapműszerek;
- ne fantasy labor legyen.

### 3. Admin / irattár
- dossziék;
- Katsuro-rendszer nyoma;
- későbbi történeti dokumentumok helye.

### 4. Gyógyszer / utility
- tárolás;
- alapellátási eszközök;
- praktikus háttérfunkció.

## Cél
A játékos értse:
> ez nem díszlet-rendelő, itt valóban lehetett és lehet orvosi munka.

A „miért ilyen jól felszerelt?” kérdés finoman felmerülhet, de nem kell most megválaszolni.

---

# 8. Task F — Első éjszaka

A jelenlegi szöveges chapter-transition maradhat fallbackként, de a következő production cél egy játszható / rendezett éjszakai mini-szakasz.

## Ritmus
1. Miyako visszavonul / elköszön;
2. a ház elcsendesedik;
3. Akira kap rövid szabad mozgást;
4. a kinti eső halkabb;
5. fa / csövek / szél / távoli víz;
6. egy apró, hétköznapinak is magyarázható furcsaság;
7. Katsuro első nyoma;
8. chapter hook.

## Hangulati szabály
Nem jumpscare.
Nem teljes természetfeletti reveal.

A cél:
> **„Ebben a házban valami nincs rendben.”**

## Lehetséges mikrofurcsaságok — PROPOSED
- egy ajtó, amelyről Akira biztos volt, hogy csukva volt;
- nagyon halk hang a rendelő felől;
- egy fény rövid felvillanása;
- nedves lábnyom / vízcsepp, amelynek nincs egyértelmű forrása;
- Katsuro tárgyának váratlan jelenléte.

Ezek közül csak tulajdonosi jóváhagyással válasszon Work konkrét kánont.

---

# 9. Task G — Chapter hook

A blokk végén ne egyszerű „első nap vége” felirat legyen.

Minimum:
- egy új konkrét kérdés;
- egy személyes Akira–Katsuro kapcsolat;
- egy visszatérő vizuális vagy hangmotívum.

A chapter hook nem fedheti fel:
- Katsuro teljes státuszát;
- a Mélység teljes természetét;
- Loft teljes szerepét;
- Shion teljes múltját.

---

# 10. Implementációs sorrend

## Batch 1 — Spatial shell
- nappali/konyha;
- folyosó;
- Akira-szoba ajtó / szoba;
- Miyako-ajó korlátozott hozzáféréssel;
- Katsuro-dolgozó ajtó / shell;
- rendelő belső kapcsolat + váró.

**Review:** navigáció, pixel density, ajtók, camera, grounding.

## Batch 2 — Clinic function
- vizsgáló;
- admin/irattár;
- gyógyszer/utility;
- külön külső rendelőbejárat.

**Review:** valódi orvosi olvashatóság, ház/rendelő kapcsolat.

## Batch 3 — Interaction pass
- observe pontok;
- minimális flag-ek;
- locked-door feedback;
- Katsuro első clue placeholder slot.

**Review:** pacing, nincs túlmagyarázás.

## Batch 4 — First night
- fény/hang váltás;
- éjszakai szabad mozgás;
- mikrofurcsaság;
- Katsuro clue;
- chapter hook.

**Review:** 10–15 perces blokk teljes ritmusa.

---

# 11. Minimális GameState javaslat

Csak egyszerű story flag-ek, nem teljes save rendszer:

- `entered_shared_home` — már létezik;
- `miyako_interior_dialogue_seen` — már létezik;
- `visited_akira_room`;
- `noticed_miyako_room`;
- `noticed_katsuro_study`;
- `entered_clinic_waiting`;
- `first_night_started`;
- `katsuro_first_clue_seen`;
- `first_night_seen` — meglévő flaget lehet megtartani a végpontként.

Ne vezessünk be route-rendszert ebben a batchben.

---

# 12. Technikai szabályok

- 640×360 belső target megtartása;
- nearest filtering;
- consistent pixel density;
- bottom-center actor grounding;
- occlusion mask ahol bútor / fal előtérbe kerül;
- nincs subpixel sprite smear;
- szobánként rendezett kamera;
- scene transition csak ott, ahol kompozíciósan indokolt;
- a ház ne váljon „egymás mellé rakott háttérképek” sorává: legyen világos térbeli kapcsolat;
- a meglévő belépési scene és dialogue működés regresszióját minden batch után ellenőrizni kell.

---

# 13. Nem része ennek a blokknak

- teljes inventory;
- combat;
- teljes route-rendszer;
- komplex save/load;
- teljes klinikai beteg-rendszer;
- Himiko korai fizikai megjelenése;
- Mélység megnyitása;
- Katsuro teljes truth reveal;
- Miyako szobájának teljes route-intim tartalma;
- FINAL voice acting.

---

# 14. Acceptance criteria a teljes blokkhoz

A blokk review-ready, ha:

1. a meglévő házbelépés változatlanul működik;
2. legalább nappali/konyha, Akira szoba, folyosó, rendelő váró és egy klinikai szoba bejárható;
3. Miyako szobája létezik, de korai hozzáférése kontrollált;
4. Katsuro dolgozószobája külön mystery térként olvasható;
5. a rendelőnek felismerhető külön külső bejárata és belső kapcsolata van;
6. a játékos kap legalább 4–6 rövid observe pontot;
7. az első éjszaka nem csak fekete képernyős szöveg;
8. van egy első Katsuro-clue;
9. a végén van chapter hook;
10. a teljes új szakasz nem töri el a külső Miyako VN-t, a benti első választást vagy a játékosirányítást.

---

# 15. Owner review checkpoints

Tulajdonosi review szükséges ezek előtt:

1. Katsuro első clue konkrét tartalma;
2. Katsuro dolgozószoba első hozzáférési módja (részben nyitott vs zárt);
3. első éjszakai mikrofurcsaság konkrét típusa;
4. chapter hook konkrét képe / mondata;
5. bármilyen új karakter fizikai megjelenése.

A Work ezekhez készíthet 2–3 rövid opciót, de ne LOCKOLJA saját döntésből.
