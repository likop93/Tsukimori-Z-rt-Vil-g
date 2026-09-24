# Shion — FINAL Character Production Spec v1

**Projekt:** Tsukimori — Zárt Világ  
**Karakter:** Shion  
**Státusz:** APPROVED DESIGN / PRODUCTION LOCK  
**Dátum:** 2026-09-24

## 0. Forrás és prioritás

Ez a dokumentum a jóváhagyott **Shion FINAL Character Design v1** vizuális irányának 3D gyártási specifikációja.

Kötelező együtt olvasni:
- `docs/CHARACTER_BIBLE.md`
- `docs/CREATIVE_BIBLE.md`
- `docs/DECISION_LOG.md`

A jóváhagyott képi referencia vizuális elemei az irányadók. A referencia-lapon automatikusan generált életrajzi számok vagy szöveges szerepleírások **nem válnak automatikusan történeti kánonná**.

---

# 1. Vizuális cél

Shion legyen:
- karcsú, finom, törékeny hatású nő;
- hosszú, fekete / nagyon sötét ibolyás hajjal;
- karakteres **zöld szemmel**;
- csendes, visszafogott, enyhén természetellenes jelenléttel;
- vízhez, holdfényhez és emlékezethez vizuálisan kötődő;
- anime-stilizált, érett karakter;
- Miyakótól és Kuroétól azonnal elkülöníthető;
- 3/4 kamerából is olvasható sziluettel;
- közeliben finom, érzelmileg ambivalens arccal.

Kerülendő:
- Miyako másolása;
- túl harsány goth megjelenés;
- túl világos, „tündér” fantasy;
- idol-szerű cukiság;
- túl nagy anime-reakciók;
- fotórealista bőr/haj.

---

# 2. Primary visual

## Haj
- fekete, finom ibolyás/lilás árnyalattal a fényben;
- hosszú, váll alá / derékig nyúló;
- puha, kissé nedves érzetű tincscsoportok;
- arcot keretező hosszabb tincsek;
- finom virágos hajdísz megengedett és a jóváhagyott design része;
- holdfényben ezüstös/lilás edge-light működjön.

## Szem
- **zöld — LOCKED karakterjegy**;
- a zöld legyen tisztán olvasható, de ne neon;
- közeliben enyhe mélység / víztükör-jelleg megengedett;
- tekintete gyakran hosszabb ideig mozdulatlan, majd hirtelen aprót vált.

## Arc
- keskenyebb, finom arc;
- visszafogott alapmimika;
- enyhe törékenység és távolságtartás;
- ne legyen állandóan szomorú;
- veszélyesebb vagy provokatív pillanatnál is a kontroll maradjon fontosabb, mint a nagy grimace.

---

# 3. Primary outfit

Jóváhagyott irány:
- sötét fekete / mély ibolya alap;
- japán ihletésű, rétegzett ruha;
- finom virágminták;
- aszimmetrikus, hosszú, könnyű külső réteg;
- visszafogott öv / megkötés;
- elegáns, nőies, de nem Miyako gyászruhája;
- bőr- és textilfelület között finom kontraszt.

A Primary outfit érzete:
**víz + holdfény + csend + törékenység**.

Alternatív variánsok későbbre:
- hétköznapi könnyebb ruha;
- onsen/fürdőruha jelenet;
- hálóruha;
- ceremoniális/szentélyi outfit.

Ezek külön variant assetek; nem írják felül a Primary modellt.

---

# 4. Testarány

A történeti pontos magasság nincs külön LOCKED számként rögzítve.

Gyártási cél:
- karcsú, hosszanti, törékeny sziluett;
- kb. 7–7.5 fej magas anime-stilizált emberi arány;
- keskenyebb váll;
- finomabb karok és kezek;
- hosszú haj és ruha adja a sziluett jelentős részét.

Ha később pontos magasságot LOCKOLUNK, a Godot scale-t ahhoz kell igazítani.

Rest pose:
- A-pose;
- leengedett váll;
- természetesen nyitott kéz;
- neutrális, nem pózoló alapállás.

---

# 5. Mesh-felosztás

Ajánlott:
- Head / Body
- Eyes
- Teeth / Mouth interior
- Hair_Main
- Hair_Front
- Hair_Secondary
- Hair_Ornament
- Primary_Outfit
- Outer_Flowing_Layer
- Belt / Waist detail
- Shoes
- Optional outfit variants

Cél:
- hosszú haj secondary motion;
- külső ruha külön deformáció;
- variant outfit;
- stabil materialkezelés.

---

# 6. Geometriai quality bar

Ajánlott:
- LOD0: 50k–75k tris
- LOD1: 28k–45k tris
- LOD2: 14k–22k tris

Prioritás:
- arc;
- szem;
- haj sziluett;
- kéz;
- ruhaszegély és virágdísz.

---

# 7. Topológia

Kiemelten tiszta:
- szemhéj;
- szemkörnyék;
- száj;
- állkapocs;
- váll;
- könyök;
- csukló;
- kézujjak;
- csípő;
- térd.

Hosszú haj és ruha:
- kerüljük a testbe penetráló tincseket;
- ne essen össze vállfordulásnál;
- ülő/lehajló póznál legyen külön teszt.

---

# 8. Haj production

Mesh alapú.

Struktúra:
1. Hair_Main tömeg
2. arcot keretező tincsek
3. két oldalsó hosszú blokk
4. hátsó hosszú tömeg
5. 4–7 secondary lock
6. opcionális virágdísz külön mesh

Mozgás:
- lassú;
- enyhén késleltetett;
- vízszerűen puha;
- nem lobogó.

---

# 9. Anyagok / shader

Stílus:
- finom cel/PBR hibrid;
- hajon enyhe ibolya/ezüst perem;
- matt, puha textil;
- kontrollált roughness;
- minimális mikrozaj.

Ajánlott:
- Head 2K
- Hair 2K
- Outfit 2K
- Accessories 1K–2K
- Eyes 1K

Material group:
- Skin
- Eyes_Green
- Hair_BlackViolet
- Cloth_Black
- Cloth_DeepViolet
- Floral_Accent
- Ornament
- Shoes

---

# 10. Arc / blendshape-ek

Minimum:
- Blink_L/R
- Eye_Wide_L/R
- Eye_Squint_L/R
- Brow_Up_L/R
- Brow_Down_L/R
- Brow_InnerUp
- Mouth_Smile_L/R
- Mouth_Frown_L/R
- Mouth_Press
- Mouth_Open
- Jaw_Open
- Lip_UpperUp
- Lip_LowerDown

Expression presetek:
- Neutral
- Small Smile
- Sad / Distant
- Controlled Anger
- Confused
- Provocative / Testing
- Soft Blink
- Cold / Withdrawn

Mimika:
- kis amplitúdó;
- szemdomináns;
- hosszabb csendek;
- érzelem gyakran késve jelenik meg az arcon.

---

# 11. Rig

Humanoid base Akira/Miyako kompatibilis névlogikával.

Törzs:
- root
- pelvis
- spine_01
- spine_02
- spine_03
- neck
- head

Kar/láb:
- twist bones
- teljes ujjrig
- toe bones

Arc:
- eye_L
- eye_R
- jaw

Secondary:
- hair 5–8 deform bone;
- outfit 5–8 deform bone.

Blender control/IK bone exportból kizárva; bake export előtt.

---

# 12. Animációs nyelv — PRODUCTION LOCK

Alapelv:
> Shion akkor a legnyugtalanítóbb, amikor túl kevéssé mozog.

Jellemző:
- nagyon kis testsúlyváltás;
- hosszabb statikus pózok;
- szem gyakran előbb vált, mint a fej;
- fejfordítás lassú és csekély;
- időnként szinte „megáll”;
- kéz finoman követi a ruhát/hajat;
- természetes emberi mozgás, de minimálisan késleltetett timinggal.

Első batch:
- `SHION_Idle_Base_01`
- `SHION_Walk_Loop`
- `SHION_Turn_Slow_L/R`
- `SHION_LookAside`
- `SHION_StillHold`
- `SHION_SmallSmile`
- `SHION_WaterObserve`

Első review:
1. Idle
2. Walk

---

# 13. Secondary motion

Nem full cloth/hair sim.

Baked:
- hosszú haj fő clipjeiben;
- külső ruharétegben.

Godot procedural:
- csak finom szél;
- víz/szentély környezetben enyhe környezeti rásegítés.

---

# 14. Godot assetstruktúra

Ajánlott:

`assets/characters/shion/final/shion_character.glb`  
`assets/characters/shion/final/shion_locomotion.glb`  
`assets/characters/shion/final/shion_interaction.glb`  
`assets/characters/shion/final/shion_variants.glb`

Forrás:
`source/blender/characters/shion/shion_final_v1.blend`

---

# 15. Lookdev

Shion vizuális kulcsa:
- hideg holdfény;
- zöld szem;
- sötét ibolya/fekete haj;
- finom virágdísz;
- vízreflexió.

Kötelező:
- haj ne olvadjon a háttérbe;
- zöld szem 3/4 közeli kamerában olvasható;
- ruha ne legyen fekete massza;
- ezüstös rim finom maradjon.

---

# 16. Validation

Blender:
- [ ] A-pose
- [ ] clean transforms
- [ ] arc deformáció stabil
- [ ] hosszú haj nem penetrál vállon
- [ ] ruha deformáció stabil
- [ ] secondary csontok kontrolláltak
- [ ] control bone-ok nem exportálódnak

Godot:
- [ ] import stabil
- [ ] zöld szem olvasható
- [ ] 3/4 sziluett különbözik Miyakótól
- [ ] Idle szándékosan csendes, nem „halott”
- [ ] Walk stabil, nincs foot slide
- [ ] holdfényes lookdev működik
- [ ] víz/szentély környezetben jól olvasható

---

# 17. FINAL feltétel

Shion csak akkor FINAL, ha:
1. hű a jóváhagyott vizuális designhoz;
2. zöld szem és hajsziluett stabil;
3. Idle + Walk review PASSED;
4. Godotban holdfényes/water lookdev review PASSED;
5. vizuálisan egyértelműen elkülönül Miyakótól és Kuroétól;
6. tulajdonosi jóváhagyást kap.

Addig:
**APPROVED DESIGN → PRODUCTION → REVIEW → FINAL**.
