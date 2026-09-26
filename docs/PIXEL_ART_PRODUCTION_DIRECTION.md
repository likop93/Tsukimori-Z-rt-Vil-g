# Tsukimori — Pixel Art Production Direction v1

**Dátum:** 2026-09-26  
**Státusz:** **LOCKED — FINAL PRODUCTION VISUAL DIRECTION**

## 0. Tulajdonosi döntés

A Tsukimori teljes játékának végleges vizuális prezentációja **2D/2.5D cinematic pixel-art narrative adventure**.

A korábbi teljes 3D irány **nem production target többé**. A meglévő 3D munka:
- nem törlendő;
- térbeli / blocking / layout referenciaként megtartható;
- nem írhatja felül a pixel-art production irányt.

A vizuális inspiráció egyik referenciája az **A Space for the Unbound** részletgazdag, filmes pixel-art narratív prezentációja, de Tsukimori **nem másolat**: saját karakterdesignnal, sötétebb hegyi-falusi dark-fantasy hangulattal, saját UI-val, saját kameranyelvvel és saját természetfeletti vizuális rendszerrel készül.

---

# 1. Fő vizuális cél

A cél: **high-detail cinematic pixel art**, nem retro-nosztalgia önmagáért.

Kötelező:
- kézzel komponáltnak ható pixelnyelv;
- kontrollált pixelélek és klaszterek;
- tudatos, korlátozottabb helyi paletták;
- részletgazdag, de jól olvasható karakterek;
- filmes világítás;
- 2.5D parallax;
- foreground / midground / background rétegek;
- köd, eső, víz, fények és növényzet külön animálható rétegei;
- karakter- és környezetgrafika ugyanahhoz a vizuális világhoz tartozzon.

Kerülendő:
- sima anime illusztráció egyszerű pixel-filterrel;
- AI-render lebutítása / downscale-je mint végleges asset;
- fotórealisztikus vagy „élőszereplős” hatás;
- generikus pixel-asset csomag érzet;
- túlzott 8/16-bites karikatúra;
- chibi arány;
- inkonzisztens pixelméret;
- subpixel-szerű, elmosott mozgás.

---

# 2. Karakterek

A már jóváhagyott FINAL karakterreferenciák **identitás-authorityként változatlanul érvényesek**.

Pixel-art átültetéskor meg kell tartani:
- arcazonosság;
- hajforma és hajszín;
- testarány és sziluett;
- outfit;
- karakterre jellemző szín- és detail language;
- mozgásnyelv;
- testtartás és gesztuskarakter.

A pixel-art adaptáció **nem redesign**.

Kötelező karakterforrások:
- docs/VISUAL_REFERENCE_INDEX.md
- docs/CHARACTER_BIBLE.md

Ha az új pixel sprite nem felismerhető azonnal a FINAL referenciából, az asset review FAILED.

---

# 3. Környezet

Tsukimori pixel-art környezete:
- tradicionális / vidéki japán hegyi építészet;
- sötét fa;
- shoji;
- cseréptető;
- nedves út és kő;
- cédruserdő;
- moha;
- köd;
- patak / fekete víz;
- hideg kék-zöld éjszaka;
- meleg borostyán lámpafény.

A környezet ne statikus festmény legyen.

Kötelező mélységi rendszer:
1. távoli ég / hegy;
2. távoli falu;
3. háttérépületek;
4. midground;
5. járható sík;
6. foreground takarások;
7. időjárás / VFX rétegek.

---

# 4. 2.5D és parallax

A világ oldalirányú / rendezett filmes felfedezést használ.

Alapelv:
> **a karakter a jelenetben él, nem egy háttérkép előtt sétál.**

Kötelező:
- kamera és parallax együtt mozogjon;
- karakter baseline stabil;
- karakter és környezet pixelmérete egyezzen;
- kontaktárnyék;
- foreground occlusion;
- környezeti fény / tint;
- eső, köd, fény és víz reagáljon a kompozícióra.

A korábbi javasolt relatív depth értékek továbbra is használhatók kiindulópontként:
- sky/moon: 0.02–0.05
- mountains: 0.08–0.12
- far village: 0.15–0.22
- background buildings: 0.28–0.35
- midground: 0.45–0.60
- walkable plane: 1.0
- foreground: 1.15–1.35

---

# 5. Animáció

A cél nem maximális frameszám, hanem **karakteres, kézzel kontrollált motion**.

Preferált:
- kevés, erős frame;
- jól olvasható kulcspózok;
- finom breathing / haj / ruha motion;
- szem- és fejmozgások;
- környezeti loopok;
- karakter-specifikus idle.

Kerülendő:
- túl sima interpolált AI-mozgás;
- „puppet” érzet;
- frame-to-frame design drift;
- lebegés;
- foot sliding.

---

# 6. CG / narratív jelenetek

A fontos CG-k és route-jelenetek **ugyanebben a pixel-art vizuális nyelvben** készüljenek.

Nem elfogadható:
- exploration pixel art + külön sima anime-render CG világ;
- fotórealisztikus közjáték;
- karakterarc drift.

A CG lehet részletesebb, de ugyanazt a pixelrácsot, palettalogikát és karakterazonosságot használja.

---

# 7. UI

A UI lehet modernebb és elegánsabb, nem kell retro konzolosnak lennie.

Kötelező:
- pixel-art világgal harmonizáló tipográfia / frame;
- jó olvashatóság;
- visszafogott animáció;
- sötét, elegáns Tsukimori hangulat;
- dialógus / choice prezentáció továbbra is karakteres.

A régi UI referencia kompozíciós és funkcionális irányként használható, de a végleges rendernyelvet pixel-artra kell fordítani.

---

# 8. Render / technikai irány

Kiinduló technikai teszt:
- alacsonyabb belső render canvas;
- nearest-neighbor skálázás;
- integer scaling, ahol lehetséges;
- exact pixel alignment;
- pixel snapping;
- texture filtering OFF a pixel asseteken.

**Javasolt első teszt:** 640×360 belső canvas → 1920×1080 3× integer upscale.

Ez **WORKING TECH TARGET**, nem külön tulajdonosi LOCK; a végleges belső felbontás review alapján módosítható.

---

# 9. Production pipeline

Javasolt pipeline:

**approved character/environment reference → pixel concept / palette pass → sprite/background pixel production → animation frames → Godot import nearest-neighbor → parallax / lighting / VFX integration → in-game review → polish**

AI használható:
- ötleteléshez;
- kompozíciós explorációhoz;
- reference generationhöz;

de **FINAL assetként nem kerülhet be automatikusan egy nyers generált kép**.

A végleges assetnek kézzel kontrollált pixel-art consistency review-n kell átmennie.

---

# 10. Primary visual target

Hivatalos pixel-art vizuális target:

/Tsukimori Visual References/visual_target/TSUKIMORI_PIXEL_ART_VISUAL_TARGET_V1.png

Státusz: **LOCKED PRIMARY PRODUCTION VISUAL TARGET**

A kép vizuális nyelve irányadó:
- pixel density;
- meleg/hideg fénykontraszt;
- klinika/belső tér részletesség;
- karakter és környezet egysége;
- filmes panel-kompozíció;
- narratív pixel-art prezentáció.

A képen lévő konkrét automatikus szövegek és jelenettartalom önmagukban nem kánonok; a vizuális stílus az authority.

---

# 11. Végső szabály

Minden új vizuális assetnél a kérdés:

> **„Ez ugyanabból a high-detail pixel-art Tsukimoriból jött?”**

Ha nem, az asset nem FINAL.
