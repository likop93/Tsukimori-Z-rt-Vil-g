# Miyako — FINAL Character Production Spec v1

**Projekt:** Tsukimori — Zárt Világ  
**Karakter:** Miyako  
**Státusz:** APPROVED DESIGN / PRODUCTION LOCK  
**Dátum:** 2026-09-24

## 0. Forrás és prioritás

Ez a dokumentum Miyako jóváhagyott vizuális irányának 3D gyártási specifikációja.

Kötelező együtt olvasni:
- `docs/CHARACTER_BIBLE.md`
- `docs/CREATIVE_BIBLE.md`
- `docs/DECISION_LOG.md`

Korábbi proxy, generált asset vagy régi karakterkoncepció nem írhatja felül ezt a specifikációt.

## 1. Két megtartott vizuális referencia

### Design A — Primary FINAL
Ez az elsődleges, alapjátékos Miyako.

Jellemzők:
- sötét, elegáns, gyászruhás megjelenés;
- hosszú, részben feltűzött sötét haj;
- karcsú, nőies, kontrollált sziluett;
- visszafogott fekete/charcoal textil;
- finom arany/bordó díszítés;
- melankolikus, méltóságteljes jelenlét.

**Ez határozza meg a FINAL alapmodellt.**

### Design B — Ceremonial / Detail Exploration
Ez is megtartott, hivatalos vizuális referencia, de **nem cseréli le Design A-t**.

Használható belőle:
- hajdísz;
- bordó–arany részletnyelv;
- textilminták;
- ceremoniális köntös/outfit variáns;
- bizonyos arckifejezések;
- díszesebb hajkezelés;
- szentélyi vagy különleges jelenetek hangulati inspirációja.

Nem használható belőle történeti kánonként:
- „házvezető” szerep;
- „szentélyi gondozó” szerep;
- bármely olyan szöveges karakterleírás, amely eltér a Story Canon / Character Bible tartalmától.

**Szabály:** Design B vizuális tartalék és alternatív kosztümforrás. A történeti identitást nem definiálja.

---

# 2. Vizuális cél

Miyako:
- felnőtt nő, kb. 32 éves;
- kb. 165 cm;
- karcsú, nőies, elegáns;
- sötét hajú;
- finom, kontrollált, visszafogott jelenlétű;
- özvegyi/gyászos tónusú, de nem kosztümös-gót;
- japán ihletésű, de nem teljes tradicionális kimonó az alap outfitben;
- anime-stilizált, érett és komoly;
- 3/4 kamerából azonnal felismerhető;
- narratív közeliben érzelmileg erős.

Kerülendő:
- idol-szerű megjelenés;
- fantasy papnő alapdesign;
- túl fiatalos arc;
- túl direkt szexualizálás;
- generikus anime-hercegnő hatás.

---

# 3. Haj

Primary:
- sötétbarna / feketébe hajló;
- hosszú;
- puha, rétegzett tincsek;
- részben feltűzött/rendezett;
- finom hajdísz megengedett.

Variáns:
- kiengedett haj érzelmi vagy otthoni jelenetekben;
- díszesebb Design B hajdísz ceremoniális helyzetekben.

Gyártás:
- mesh-alapú haj;
- nagy, olvasható formák;
- 4–6 secondary hair bone;
- finom, nem túlzó mozgás.

---

# 4. Arc

- finom, elegáns női arc;
- enyhén keskeny állvonal;
- intelligens, nyugodt tekintet;
- alapból visszafogott érzelem;
- melankólia + tartás egyszerre;
- nem hideg, inkább érzelmileg kontrollált.

Szem:
- alapból sötét, meleg barnás tónus;
- későbbi történeti változás külön állapot;
- hosszabb szemkontaktus, mint Akiránál.

---

# 5. Primary outfit

Alap:
- fekete / charcoal főruha;
- elegáns, rétegzett, hosszú sziluett;
- zártabb felsőrész;
- derékhangsúly / öv;
- hosszú alsó sziluett;
- finom textilminta;
- visszafogott arany/bordó részletek;
- elegáns, praktikus sötét lábbeli.

A ruha:
- gyász hangulatú;
- nőies;
- praktikus;
- nem teljes tradicionális kimonó;
- nem túl díszes.

Design B-ből származó ceremonial variant:
- erősebb bordó réteg;
- arany virágos vagy növényi motívum;
- díszesebb öv/hajdísz;
- különleges jelenetre használható;
- nem válik alap outfitté.

---

# 6. Testarány

- teljes magasság: 1.65 m;
- kb. 7–7.5 fej magas;
- karcsú, nőies;
- keskenyebb váll;
- finom derék;
- elegáns hosszanti vonalak;
- jól olvasható kéz;
- A-pose rest pose.

---

# 7. Mesh-felosztás

Ajánlott:
- Head / Body
- Eyes
- Teeth / mouth interior
- Hair_Main
- Hair_Secondary
- Hair_Ornament
- Main_Dress
- Inner_Layer
- Belt / Waist ornament
- Sleeve layers
- Shoes
- Ceremonial_Optional pieces

Cél:
- outfit variánsok;
- hajvariánsok;
- secondary motion;
- material swap;
- egyszerű Godot kapcsolhatóság.

---

# 8. Geometriai quality bar

Ajánlott:
- LOD0: 50k–75k tris
- LOD1: 28k–45k tris
- LOD2: 15k–22k tris

Prioritás:
- arc;
- haj;
- kéz;
- ruha rétegek;
- sziluett.

---

# 9. Topológia

Tiszta edge flow:
- szemhéj;
- száj;
- arc;
- állkapocs;
- nyak;
- váll;
- könyök;
- csukló;
- kézujjak;
- csípő;
- térd.

Ruha:
- ujjvégek;
- övrész;
- ruha alsó széle;
- hátsó rétegek;
- ülés/fordulás közbeni deformáció.

---

# 10. Anyagok

Stílus:
- finom cel/PBR hibrid;
- matt, elegáns textilek;
- minimális arany/bordó fény;
- nem fényes fekete;
- nem latex;
- nem olcsó selyemhatás.

Ajánlott textúrák:
- Head: 2K
- Hair: 2K
- Outfit: 2K
- Accessories: 1K–2K

Material group:
- Skin
- Eyes
- Hair
- Cloth_Black_Main
- Cloth_Secondary
- Accent_Burgundy
- Ornament_Gold
- Shoes

---

# 11. Arc / blendshape-ek

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
- Faint Smile
- Serious
- Concerned
- Protective / Jealous
- Tired / Melancholic
- Quiet Vulnerability
- Look Away

Miyako mimikája:
- kis amplitúdójú;
- finom;
- kontrollált;
- lassabb, mint Akiráé.

---

# 12. Rig

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
- teljes ujjrig

Láb:
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
- hair 4–6 bone
- ruha 6–10 secondary bone

Control/IK csontok exportból kizárva; animáció bake export előtt.

---

# 13. Animációs nyelv — PRODUCTION LOCK

Miyako:
- kontrollált;
- lassabb;
- tudatos;
- kevés testsúlyváltás;
- hosszabb póztartás;
- kézmozdulatok érzelmi jelentőségűek;
- kibillenésnél inkább megáll, mint kitör.

Alapelv:
> Miyako érzelmeit gyakran egy félbehagyott mozdulat árulja el.

Első batch:
- `MIYAKO_Idle_Base_01`
- `MIYAKO_Walk_Loop`
- `MIYAKO_Turn_Soft_L/R`
- `MIYAKO_FoldHands`
- `MIYAKO_Wait`
- `MIYAKO_LookAway`
- `MIYAKO_SoftGesture`

Első gyártási review csak:
1. Idle
2. Walk

---

# 14. Ruha secondary motion

Nem full cloth simulation.

Használat:
- kézzel animált secondary motion;
- finom procedural wind csak rásegítésként;
- ruha alja, ujjak, öv kis késéssel követi a testet;
- súlyos, elegáns, nem túl lobogó mozgás.

---

# 15. Godot assetstruktúra

Ajánlott:

`assets/characters/miyako/final/miyako_character.glb`  
`assets/characters/miyako/final/miyako_locomotion.glb`  
`assets/characters/miyako/final/miyako_interaction.glb`  
`assets/characters/miyako/final/miyako_ceremonial.glb`

Forrás:
`source/blender/characters/miyako/miyako_final_v1.blend`

---

# 16. Lookdev

Kötelező:
- arc meleg fényben jól olvasható;
- fekete ruha ne legyen fekete massza;
- haj váljon el a háttértől;
- arany/bordó részletek csak finoman villanjanak;
- ködös esti jelenetben is felismerhető sziluett.

Beauty target:
**Akira esti megérkezése Miyako házához.**

---

# 17. Validation

Blender:
- [ ] 1.65 m scale
- [ ] A-pose
- [ ] clean transforms
- [ ] face deformation stabil
- [ ] ruha nem penetrál
- [ ] haj secondary motion stabil
- [ ] ceremonial variant külön kapcsolható
- [ ] control bones exportból kizárva

Godot:
- [ ] glTF import stabil
- [ ] materialok helyesek
- [ ] 3/4 kamera olvasható
- [ ] fekete ruha részletei megmaradnak
- [ ] Idle loop stabil
- [ ] Walk nem csúszik
- [ ] arc esti fényben jól olvasható
- [ ] Akira mellett erős, eltérő vizuális energia
- [ ] Design B elemei nem írják felül Design A alapmodelljét

---

# 18. FINAL státusz

Miyako csak akkor FINAL, ha:
1. Primary Design A-hoz hű;
2. Design B csak jóváhagyott variánsként van kezelve;
3. Idle + Walk review PASSED;
4. Godot beauty targetben jól működik;
5. ruha/haj deformáció stabil;
6. tulajdonosi vizuális jóváhagyást kap.

Addig:
**APPROVED DESIGN → PRODUCTION → REVIEW → FINAL**.
