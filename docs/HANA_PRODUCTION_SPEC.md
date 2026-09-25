# Hana — FINAL Character Production Spec v1

**Projekt:** Tsukimori — Zárt Világ  
**Karakter:** Hana  
**Státusz:** LOCKED PRIMARY / PRODUCTION SPEC  
**Dátum:** 2026-09-25

## 0. Authority

Kötelező együtt olvasni:
- `docs/CHARACTER_BIBLE.md`
- `docs/CREATIVE_BIBLE.md`
- `docs/DECISION_LOG.md`
- `docs/VISUAL_REFERENCE_INDEX.md`

Elsődleges képi referencia:
- ChatGPT Library: `/Tsukimori Visual References/characters/HANA_FINAL_CHARACTER_DESIGN_V1.png`

A képen lévő automatikusan generált feliratok, számok vagy szerepleírások nem történeti kánonok. A jóváhagyott vizuális tartalom az authority.

---

# 1. Karakter-vizuális mag

Hana a fő női szereplők között a **legmelegebb, legtestibb és legélettelibb vizuális jelenlét**.

Kulcsszavak:
- testiség;
- élet;
- hagyomány;
- termékenységi energia;
- melegség;
- közvetlenség;
- erő;
- nőies magabiztosság.

Nem Miyako elegáns gyászvonalát, nem Shion törékeny holdfényes jelenlétét és nem Renka petite energiáját ismétli.

Alapelv:
> Hana nem törékeny szépség. A jelenléte meleg, telt, földközeli és azonnal érezhető.

---

# 2. FINAL vizuális irány — LOCKED

## Arc
- felnőtt nő;
- meleg, nyitott, magabiztos tekintet;
- vörösesbarna szem;
- finom, gyakran félmosolyos mimika;
- ne legyen kislányos vagy idol-szerű;
- az arc legyen puhább, de karakteres.

## Bőr
- **meleg barna / tan bőrtónus — LOCKED karakterjegy**;
- világításban maradjon meleg tónusú;
- ne sodródjon porcelánfehér irányba a későbbi assetekben.

## Haj
- nagyon hosszú;
- sötétbarna / majdnem fekete;
- dús, erősen hullámos;
- nagy, olvasható hajtömeg;
- arany virágos hajdísz;
- finom arany függők / díszek megengedettek.

## Testalkat
- telt, erőteljesen nőies, buja sziluett;
- **nagyon telt mellkas / nagy keblek — LOCKED designjegy**;
- hangsúlyos csípő;
- erősebb, formás combok;
- puha, de nem gyenge testérzet;
- ne legyen karcsúra vagy törékenyre visszatervezve;
- a testarány stilizált anime, de felnőtt és anatómiailag koherens.

A karakter attraktivitását nem külön „fanservice rétegként” kell kezelni: a testalkat, ruha, testbeszéd és történeti szerep ugyanazon designrendszer részei.

---

# 3. Primary outfit — LOCKED

Színpaletta:
- fekete / nagyon sötét barna;
- mély bordó / vörös;
- arany;
- visszafogott virágmotívumok.

Forma:
- japán ihletésű, modernizált, rétegzett ruha;
- mély dekoltázs;
- felsőtestet és derekat hangsúlyozó szabás;
- széles, díszített öv/obi-jelleg;
- hosszabb, nyitott külső réteg;
- virágos textilminta;
- arany részletek;
- combnál kontrollált nyitás / magasabb szabás megengedett;
- elegáns, nőies lábbeli; magasított sarok/platform vizuálisan megengedett.

Kerülendő:
- generikus fantasy papnő;
- modern klubruha;
- túl sok arany/ékszer;
- cosplay-szerű ornamentika;
- olyan ruha, amely teljesen eltünteti Hana karakteres testalkatát.

---

# 4. Sziluett-azonosíthatóság

Hana már fekete sziluettből is felismerhető legyen:

- rendkívül hosszú, hullámos haj;
- telt mellkas;
- szélesebb, nőies csípő;
- hosszú, szétnyíló külső ruha;
- arany/virágos hajdísz;
- nyugodt, magabiztos tartás.

A fő női karakterek elkülönítése:
- Miyako = hosszú elegáns, kontrollált, gyász-sziluett;
- Shion = vékonyabb, törékeny, vízszerű;
- Renka = petite, alacsony, fiatalos felnőtt;
- Hana = **telt, meleg, földközeli, erős női sziluett**.

---

# 5. 2D / 2.5D production irány

A jelenlegi prototípus iránya miatt Hana elsődleges production célja 2D/2.5D kompatibilis.

## Sprite quality
- ne low-res retro pixel legyen;
- painterly/anime sprite;
- a FINAL képi referencia arcát és testarányát tartsa;
- játékbeli sprite és nagy dialógusportré ugyanazt a karaktert ábrázolja.

## Első szükséges sprite state-ek
- `HANA_Idle_Base`
- `HANA_Idle_Lean`
- `HANA_Walk`
- `HANA_Turn`
- `HANA_SoftSmile`
- `HANA_InviteGesture`
- `HANA_ArmsFolded`
- `HANA_Listen`

## Portré / expression minimum
- Neutral Warm
- Soft Smile
- Amused
- Serious
- Concerned
- Direct / Testing
- Tender
- Irritated

## Sprite integration
- meleg környezeti fényben különösen jól működjön;
- ne legyen élesebb vagy „másik festmény” érzetű, mint a környezet;
- ugyanaz a grading/logika érvényes rá, mint a Tsukimori 2.5D worldre;
- foreground takarásokat támogassa.

---

# 6. Mozgásnyelv — PRODUCTION LOCK

Hana mozgása legyen közvetlenebb és súlyosabb, mint Miyakóé vagy Shioné.

Alapelv:
> Hana nem siet el a saját jelenlétéből.

Jellemző:
- láthatóbb testsúlyváltás;
- stabilabb, földeltebb állás;
- kevés kapkodó mozdulat;
- nyugodt, magabiztos kézgesztusok;
- könnyebb fizikai közelség a beszélgetőpartnerhez;
- szemkontaktus természetes és közvetlen;
- mosoly és váll-/fejmozgás gyakran együtt dolgozik;
- kerülni kell a túlzó „jiggle” vagy komikus fanservice animációt.

A testalkatból adódó secondary motion finom és fizikai legyen, ne önálló látványeffekt.

---

# 7. Jelenetvilág / lighting

Hana vizuálisan különösen erős:
- meleg lámpafényben;
- belső fa terekben;
- esti teaház/fogadó jellegű helyszíneken;
- vörös/bordó textil és sötét fa mellett;
- intim, közelebbi párbeszédekben.

Kamera:
- ne fetisizáló „body pan” legyen;
- a testalkat a teljes kompozíció része;
- közeliben az arc és szemkontaktus maradjon fontos;
- teljes alaknál a haj + ruha + test sziluett együtt dolgozzon.

---

# 8. Anyag / textúra irány

2D/2.5D painterly cél:
- puha bőrárnyalás;
- meleg highlight;
- sötét, gazdag haj;
- bordó textilen festett virágminta;
- arany díszek visszafogott csillanása;
- ne legyen műanyag vagy túl glossy.

Ha később 3D asset készül:
- ugyanaz a vizuális logika;
- cel/PBR hibrid;
- ruhafizika és haj secondary motion kontrollált;
- mellkas/ruha deformációt külön quality review-val kell validálni;
- clipping és „gumibaba” deformáció nem elfogadható.

---

# 9. Karakterazonosság megőrzése

Nem engedélyezett:
- világos bőrre váltás;
- rövid vagy egyenes haj;
- arany hajdísz eltüntetése FINAL ok nélkül;
- mellkas/testalkat jelentős visszafogása;
- Miyako-féle gyászruhává egyszerűsítés;
- Shion-féle hideg lila/holdfényes paletta átvétele;
- generikus „anime sexy NPC” irány.

---

# 10. Production fájlstruktúra — javaslat

2D/2.5D:

`assets/characters/hana/final/hana_primary.png`  
`assets/characters/hana/final/hana_portraits.png`  
`assets/characters/hana/final/hana_sprite_sheet.png`  
`assets/characters/hana/final/hana_expressions/...`

Source:
`source/art/characters/hana/`

Későbbi 3D fallback/alternatív production esetén:
`assets/characters/hana/3d/`

A 2D és 3D változatok nem írhatják felül egymás vizuális canonját.

---

# 11. Validation checklist

## Visual
- [ ] tan/meleg bőrtónus stabil;
- [ ] vörösesbarna szem;
- [ ] nagyon hosszú, hullámos sötét haj;
- [ ] arany hajdísz;
- [ ] telt, karakteres testalkat;
- [ ] primary fekete–bordó–arany outfit;
- [ ] mély dekoltázs designhű;
- [ ] silhouette azonnal elkülönül Miyakótól/Shiontól/Renkától.

## 2D/2.5D
- [ ] sprite nem „rámatricázott”;
- [ ] environment gradinggel összhangban van;
- [ ] foreground occlusion működik;
- [ ] Idle nem statikus baba;
- [ ] Walk nem csúszik;
- [ ] portré és full-body ugyanannak a karakternek hat.

## Animation
- [ ] földelt testsúly;
- [ ] kontrollált secondary motion;
- [ ] nincs komikus túlzás;
- [ ] gesztusok közvetlenek és magabiztosak.

---

# 12. FINAL feltétel

Hana csak akkor production FINAL, ha:
1. hű a LOCKED visual referencehez;
2. a testalkat, haj, bőrtónus és outfit stabil;
3. 2D sprite + portré design consistency PASSED;
4. Idle + Walk + expression review PASSED;
5. Tsukimori scene integration PASSED;
6. tulajdonosi review elfogadta.

Addig:
**LOCKED DESIGN → PRODUCTION → REVIEW → FINAL ASSET**.
