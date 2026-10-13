# Mashiro — LOCKED character bible (2026-10-13)

**Állapot:** jóváhagyott karakter- és produkciós specifikáció. **Felülírás:** kizárólag kifejezett tulajdonosi jóváhagyással.

> Elsődleges történeti forrás: [MASHIRO_MAIN_ROMANCE_CANON.md](MASHIRO_MAIN_ROMANCE_CANON.md). Ez a dokumentum azt kiegészíti, nem írja felül.

## 1. Alapazonosság

- Mashiro (真白), 25 éves felnőtt nő, 165 cm magas.
- Nappal félénk, kedves, szemérmes virágkertész, a **Holdvirág Üvegház** gondozója; a közelben kis házban él.
- Éjjel a **Fehér Rókaisten emberi alakú inkarnációja**. Tudatossága folytonos; emlékszik az éjszaka történtekre, ami nappal zavarba is hozhatja.
- Akira **kiemelt, kanonikus true-love romantikus útja**, de a kapcsolat kölcsönös, szabad döntés, kiérdemelendő és **elbukható**. Más női route-ok nem törlődnek.

## 2. LOCKED látvány — bármely jelenetben

- Felnőtt, finom, karakteresen nőies arc; világos porcelánbőr.
- Hosszú, hófehér haj; kertészkedéskor jellemzően felkötve.
- Vékony, **ezüstkeretes szemüveg**, állandó karakterazonosító.
- Nappal világos szürkés/kékes szemek; éjjel arany, rókaszerű pupillájú szemek.
- **Szándékosan túlzó homokóra-alkat:** rendkívül telt mellek (a fejmérettel összemérhető hangsúly), feltűnően keskeny derék és csípőalap, telt/vastag combok, kerek és telt fenék. **Ezek a karakteres arányok nem módosíthatók** a póz, kamera vagy nappal/éjjel váltása miatt.
- Éjjel: fehér rókafülek, egy különösen dús, nagy fehér rókafarok, aranyszemek; **ugyanaz az emberi arc és test**, nem antropomorf állat.
- Nappali modern öltözet: világos kötött felső/top, puha világos színek, könnyű szoknya vagy kertészkedéshez rövidnadrág. Az első nappali üvegházi látogatásnál **felkötött fehér haj, világos top és rövidnadrág**.
- Ne kerüljön automatikusan minden jelenetbe kimono, yukata vagy miko ruha. A referencián szereplő öltözet a jelenetekhez igazítható, a test- és arcidentitás nem.
- Hangulat: romantikus dark fantasy, melegség és misztikum, nem explicit képi jelenetekkel.

## 3. Jóváhagyott vizuális referencia és alkalmazás

**Elsődleges vizuális forrás:** a tulajdonos által a 2026-10-13-i beszélgetésben jóváhagyott **Mashiro nappali/éjjeli többpaneles karakterlap**. Ezen látható a nappali teljes alak, az éjjeli rókaalak, oldalsó / háromnegyedes nézetek, arckifejezések, szemüveg, haj, fülek, farok, ruharészletek és a Holdvirág Üvegház.

Az asszisztens által korábban készített egyszerű pásztázó GIF **nem jóváhagyott animációs karakterlap**, és nem használható Godot-produkciós referenciaként. Az itt jóváhagyott **többpaneles irányadó karakterlap** produkciós referencia, **nem kész animáció vagy spritesheet**.

Kötelező vizuális ellenőrzés minden új munkánál:
1. ugyanaz a felnőtt arc, porcelánbőr, haj, szemüveg;
2. azonos karakteres testarányok minden nézetben;
3. nappal / éjjel azonos emberi identitás;
4. éjjel konzisztens fülek, farok, aranyszemek;
5. Akira/Miyako megjelenése illeszkedjen a saját kánonjukhoz;
6. új kameraállás nem egyenlő új karakterdizájnnal.

## 4. Romantikus fő route

- **Első találkozás:** nap 5–10, alapjavaslat nap 7: Mashiro fehér virágokat hoz Miyakónak, és Miyako házában találkozik Akirával. Félénken meghívja a Holdvirág Üvegházba. Miyako megjegyzi, hogy Mashiro ritkán hív idegeneket.
- **Látogatás:** a következő nap rendelés után választható. Másnap ideális; két nap után bizonytalanabb; 3–4 nap után nehezebb; 5+ napnál a route lezárulhat.
- Komoly romantikus elköteleződés egy másik szereplő mellett lezárhatja Mashiro útját. Barátság és alkalmi flört önmagában nem.
- **Kimenetek:** True Love / teljes emberi és természetfeletti gyógyulás, Lost Destiny, Other Romance.
- Tervezett állapotkulcsok: `mashiro_met`, `mashiro_invited`, `mashiro_invitation_day`, `mashiro_first_visit`, `mashiro_trust`, `mashiro_affection`, `mashiro_route_locked`, `mashiro_route_active`.
- A fenti kulcsok **tervezettek**, nem állítás egy futó Godot-implementáció létezéséről.

## 5. Godot / Work referenciacsomag

**Cél:** azonos karakterből épített 2.5D cinematic VN-portrék, többpaneles karakterreferenciák, későbbi réteges animációs export és esemény-CG-k.

| Panel | Tartalom | Kötelező konzisztencia |
|---|---|---|
| A | Nappali teljes alak, elöl | Referenciaarc, szemüveg, haj, testarány |
| B | Nappali oldalnézet + 3/4 hátulnézet | Térbeli arányok, haj, öltözet |
| C | Éjszakai teljes alak | Ugyanaz a karakter, fülek, farok, aranyszem |
| D | Kifejezések | Félénk mosoly, zavar, gyengéd tekintet, meglepetés, titokzatos éjszakai tekintet |
| E | Részletek | Szemüveg, hajkötés, fülek, farok, kezek, ruházat |
| F | Akira–Mashiro pillanatok | Első találkozás Miyakónál, nappali üvegházi közelség |

**Javasolt Godot-szerkezet (nem implementált):** `CharacterBody/Portrait`, `Eyes/Blink`, `Hair_Front`, `Hair_Back`, `Fox_Ears`, `Fox_Tail`, `Glasses`, `Outfit`, `FX`. A tényleges frame-eket és anchor/pivot adatokat csak a végleges szeparált export után szabad rögzíteni; a nagy karakterlapot nem szabad egy kész spritesheetnek nevezni.

## 6. Jóváhagyott jelenetképek és következő képek

A beszélgetésben elkészült és jóváhagyott vizuális irányok:
- `CG_MASHIRO_FIRST_MEETING_01` — virágátadás Miyako otthonában, Akira jelenlétében.
- `CG_MASHIRO_GREENHOUSE_VISIT_01` — első látogatás a Holdvirág Üvegházban.
- `CG_MASHIRO_NIGHT_FOX_01` — holdfényes rókaalak.
- **Két további Akira–Mashiro közös pillanat** és egy **bővített, többpaneles, jóváhagyott karakterlap** a beszélgetésben.

További tervezett képek: `CG_MASHIRO_CLOSE_APPROACH_01`, `CG_MASHIRO_HEALING_01`, `CG_MASHIRO_FOX_HEALING_01`, `CG_MASHIRO_CONFESSION_01`, `CG_MASHIRO_TRUE_ROUTE_01`.

> **Fájlintegritási megjegyzés:** a beszélgetésben generált képek itt még nem kerültek feltöltésre a GitHub-repó bináris assetjeiként. A lenti asset-manifeszt a nyilvántartásukat és a következő importot szolgálja. Nem szabad őket azonosítani a már elkészült, importálható Godot-assetekkel.
