# Akira — FINAL Character Production Spec v1

**Projekt:** Tsukimori — Zárt Világ  
**Karakter:** Dr. Akira  
**Státusz:** APPROVED DESIGN / PRODUCTION LOCK  
**Dátum:** 2026-09-24

## 0. Forrás és prioritás

Ez a dokumentum a jóváhagyott **Akira FINAL Character Design v1** 3D gyártási specifikációja.

Kötelező együtt olvasni:
- `docs/CHARACTER_BIBLE.md`
- `docs/CREATIVE_BIBLE.md`
- `docs/DECISION_LOG.md`

Ha egy korábbi proxy, generált GLB vagy régi koncepció eltér ettől, **ez a specifikáció az irányadó**.

---

# 1. Vizuális cél

Akira legyen:
- felnőtt, korai harmincas férfi;
- kb. **180 cm** magas;
- karcsú-atletikus, nem testépítő;
- fekete hajú;
- intelligens, nyugodt, figyelő arcú;
- modern, városi, sötét tónusú;
- anime-stilizált, de normál emberi arányú;
- jól olvasható 3/4 kamerából;
- közeliben is elég részletes narratív jelenetekhez.

Nem lehet:
- szőke;
- Loft-szerű;
- chibi;
- túl bishounen;
- fotórealista;
- fantasy-páncélos;
- túl dekorált.

---

# 2. Jóváhagyott elsődleges megjelenés

## Haj
- fekete;
- rövid/közepesen rövid;
- enyhén rendezetlen;
- nagy, jól olvasható tincscsoportokra bontva;
- homlokra részben ráeső frufru;
- oldalt és hátul rendezettebb tömeg;
- ne legyen túl tüskés vagy shounen-hős jellegű.

## Arc
- keskenyebb, felnőtt férfi arc;
- finom, de határozott állkapocs;
- komoly, kontrollált alaptekintet;
- nem agresszív;
- enyhén fáradt / megfigyelő karakter megengedett;
- anime-szemarány, de visszafogott méret.

## Szem
- alapállapotban sötét, barnás-szürkés tónus;
- természetfeletti fejlődéshez külön eye-material/variant előkészíthető;
- a zöldülés történeti állapot legyen, ne alapdesign.

## Szemüveg
- **opcionális variáns**;
- vékony, modern, sötét keret;
- nem lehet Loft vizuális ismertetőjegyének másolata;
- külön meshként kapcsolható.

---

# 3. Ruházat

## Primary outfit

A jóváhagyott karakterlap alapján:
- sötét charcoal / fekete külső réteg;
- modern, rétegzett városi felső;
- kapucnis vagy puhább belső réteg;
- egyszerű világosabb szürke alsó felső;
- sötét, karcsú szabású nadrág;
- praktikus fekete/szürke cipő;
- visszafogott karóra;
- opcionális kis táska / vállpánt csak jelenetfüggően.

A ruházat célja:
**„városi doktor, aki nem kalandornak öltözött, mégis képes végigjárni Tsukimori hegyi környezetét.”**

## Alternatív variánsok későbbre
- hosszabb sötét kabát;
- hidegebb időjárási réteg;
- rendelői, kevésbé utcai megjelenés.

Ezek nem írhatják felül az elsődleges sziluettet.

---

# 4. Testarány és modellezési arányok

Cél:
- teljes magasság: **1.80 m Godot scale-ben**;
- kb. 7–7.5 fej magas;
- váll: közepes, nem széles;
- mellkas: természetes;
- derék: karcsú;
- láb: enyhén hosszított anime-stilizáció megengedett;
- kéz: enyhén nagyobb olvashatóságért, de nem stilizált túlzás;
- fej: kissé nagyobb, mint fotórealista modellen, hogy 3/4 kamerából olvasható maradjon.

T-pose/A-pose:
- gyártási alap: **A-pose**;
- váll kb. 35–45°-ban leengedve;
- tenyér enyhén előre/befelé természetes rigeléshez.

---

# 5. Mesh-felosztás

Ajánlott külön mesh részek:
- Body / Head
- Eyes
- Teeth / Mouth interior
- Hair_Main
- Hair_Secondary
- Brows / lashes, ha külön geometria
- Outer_Jacket
- Inner_Hoodie / Shirt
- Pants
- Shoes
- Glasses_Optional
- Watch
- Optional bag / strap

A mesh-felosztás szolgálja:
- ruhaanimációt;
- material swapet;
- szemüveg ki/be kapcsolását;
- későbbi outfit variánsokat.

---

# 6. Geometriai quality bar

A cél nem modern AAA fotórealizmus, hanem stabil stilizált főszereplő.

Ajánlott teljes karakter:
- **45k–70k triangle** LOD0, tartozékokkal együtt;
- fej + haj kapjon elsőbbséget;
- kéz és arc ne legyen túl agresszíven optimalizálva.

LOD:
- **LOD0:** 45k–70k tris — dialógus / közeli / normál játék
- **LOD1:** 25k–40k tris — általános exploration
- **LOD2:** 12k–20k tris — távoli szereplés

Ha a teljesítmény nem indokolja, LOD0/LOD1 közötti automatikus váltás csak később kerüljön be.

---

# 7. Topológiai prioritások

Különösen tiszta edge flow kell:
- szemhéj;
- száj;
- nasolabial/arc deformáció;
- állkapocs;
- váll;
- hónalj;
- könyök;
- csukló;
- kézujjak;
- csípő;
- térd;
- boka.

Kerülendő:
- vállnál becsípődő jacket;
- könyöknél összeomló sleeve;
- combnál egymásba vágó nadrág;
- nyak és kapucni penetráció.

---

# 8. Hajgyártás

A haj **mesh alapú**, nem strand hair.

Felépítés:
1. nagy hajtömeg;
2. első/frufru tincscsoportok;
3. oldalsó tincsek;
4. tarkó/hátsó tömeg;
5. 3–5 animálható secondary lock.

A haj:
- ne legyen túl sok apró lapból;
- silhouette-first;
- 3/4 nézetből tisztán olvasható;
- enyhe anisotropic/specular hatás megengedett, de ne legyen műanyag.

---

# 9. Anyagok és textúrák

Stílus:
- finom cel/PBR hibrid;
- visszafogott specular;
- kézzel kontrollált roughness;
- minimális mikrozaj;
- a formát a világítás és festett tónus együtt adja.

Ajánlott textúraméretek:
- Face/Head: 2K
- Hair: 2K
- Outfit atlas: 2K
- Shoes/accessories: 1K–2K
- Eyes: 1K elegendő

Material group:
- Skin
- Eyes
- Hair
- Cloth_Dark
- Cloth_Light
- Leather/Rubber
- Metal_Accent
- Glasses

Kerülendő:
- túl erős normal map;
- fotótextúrás bőr;
- túl nedves/plasztik skin;
- fényes fekete ruha.

---

# 10. Arc és blendshape-ek

A mimika legyen **visszafogottabb**, mint tipikus anime játékban.

Minimum blendshape készlet:
- Blink_L
- Blink_R
- Eye_Wide_L
- Eye_Wide_R
- Eye_Squint_L
- Eye_Squint_R
- Brow_Up_L
- Brow_Up_R
- Brow_Down_L
- Brow_Down_R
- Brow_InnerUp
- Mouth_Smile_L
- Mouth_Smile_R
- Mouth_Frown_L
- Mouth_Frown_R
- Mouth_Press
- Mouth_Open
- Jaw_Open
- Lip_UpperUp
- Lip_LowerDown

Később:
- viseme készlet dialógushoz.

## Arc quality bar

Alaparc:
- nyugodt;
- figyelő;
- enyhén zárt.

Első fontos expression presetek:
- Neutral
- Slight Smile
- Serious
- Concerned
- Surprised — visszafogott
- Tired
- Side Glance / Observe

---

# 11. Rig

## Exportált deform csontok

Törzs:
- root
- pelvis
- spine_01
- spine_02
- spine_03
- neck
- head

Kar oldalanként:
- clavicle
- upperarm
- upperarm_twist
- forearm
- forearm_twist
- hand

Kéz:
- 3 csont × 5 ujj × 2 oldal

Láb oldalanként:
- thigh
- thigh_twist
- shin
- foot
- toe

Arc:
- eye_L
- eye_R
- jaw

Secondary:
- hair 3–5 csont;
- ruha/jacket 6–8 secondary csont, ha szükséges.

Cél:
- kb. **70–75 deform bone**;
- Blender control/IK csontok exportból kizárva;
- animáció export előtt bake.

---

# 12. Animációs gyártási szabály

LOCKED:
- FINAL locomotion **in-place**;
- mozgást Godot CharacterBody3D végzi;
- root motion csak cinematic clipnél.

Akira mozgási alapelve:
> Minél furcsább a helyzet, annál kontrolláltabb az első reakció.

Szem → fej → váll/test.

Kötelező első review:
1. `AKIRA_Idle_Base_01`
2. `AKIRA_Walk_Loop`

Csak ezek jóváhagyása után:
- WalkStart L/R
- WalkStop L/R
- Turn45 L/R
- Turn90 L/R

---

# 13. Ruha és secondary motion

Nem full cloth simulation.

Elsődleges megoldás:
- baked secondary motion fontos animációkban;
- nagyon enyhe Godot procedurális wind layer;
- kapucni / jacket hem csak finoman reagáljon.

Cél:
- ne lobogjon videojátékosan;
- Akira kontrollált személyiségéhez illeszkedjen.

---

# 14. Godot import

Ajánlott fájlszerkezet:

`assets/characters/akira/final/akira_character.glb`  
`assets/characters/akira/final/akira_locomotion.glb`  
`assets/characters/akira/final/akira_interaction.glb`  
`assets/characters/akira/final/akira_cinematic_01.glb`

Forrás:
`source/blender/characters/akira/akira_final_v1.blend`

Ha a source könyvtár szerkezete később más lesz, a Godot runtime assetút maradjon stabil.

---

# 15. Godot shader / lookdev

Karaktervilágítás:
- arc olvashatósága fontosabb, mint fizikailag tökéletes fény;
- finom rim/fill megengedett;
- erős toon-outline nem kell;
- sötét ruha ne olvadjon fekete masszává;
- esti jelenetben Akira arcán mindig maradjon kontrollált meleg/hideg formafény.

Beauty target:
**Akira esti megérkezése Miyako házához.**

A karakter FINAL lookdev csak akkor tekinthető sikeresnek, ha ebben a jelenetben:
- arc olvasható;
- fekete haj különválik a háttértől;
- sötét ruha rétegei megmaradnak;
- sziluett felismerhető;
- nem tűnik asset-store modellnek.

---

# 16. VALIDATION CHECKLIST

## Blender
- [ ] 1.80 m karakter scale
- [ ] clean transforms
- [ ] A-pose rest pose
- [ ] nincs non-manifold kritikus hiba
- [ ] normálok helyesek
- [ ] face deformation működik
- [ ] váll/könyök/térd nem omlik össze
- [ ] haj és ruha nem penetrál alapmozgásban
- [ ] export control bones nélkül

## Godot
- [ ] glTF import hibamentes
- [ ] skeleton mapping stabil
- [ ] materialok helyesek
- [ ] 3/4 kamerában sziluett olvasható
- [ ] Idle loop nem ugrik
- [ ] Walk foot lock stabil
- [ ] nincs foot sliding
- [ ] sötét esti fényben arc olvasható
- [ ] opcionális szemüveg kapcsolható
- [ ] beauty target jelenetben review-zva

---

# 17. FINAL státusz feltétele

Akira karakterasset csak akkor lehet **FINAL**, ha:
1. a jóváhagyott designhoz vizuálisan hű;
2. Idle + Walk review PASSED;
3. Godotban a beauty target jelenetben jól olvasható;
4. arc/haj/ruha deformáció hibamentes;
5. a tulajdonos vizuálisan jóváhagyta.

Addig a státusz:
**APPROVED DESIGN → PRODUCTION → REVIEW → FINAL**.
