# Tsukimori — Visual Reference Index

**Dátum:** 2026-09-24  
**Státusz:** aktív vizuális authority index

## Cél

Ez a dokumentum a ChatGPT-ben jóváhagyott konkrét képi referenciákat köti össze a projekt kreatív governance rendszerével.

A képek hivatalos másolatai a ChatGPT Library-ben találhatók:

`/Tsukimori Visual References/`

Almappák:
- `characters/`
- `ui/`
- `visual_target/`

Egyben letölthető/csatolható csomag:
- `/Tsukimori Visual References/TSUKIMORI_VISUAL_REFERENCE_PACKET_V1.zip`

## Kötelező értelmezési szabály

A képeken automatikusan generált szöveg, életkor, foglalkozás, szerepleírás, idézet vagy más felirat **nem válik automatikusan kánonná**.

Authority sorrend:
1. tulajdonosi explicit döntés;
2. `docs/DECISION_LOG.md`;
3. `docs/STORY_CANON.md`, `docs/CHARACTER_BIBLE.md`, `docs/CREATIVE_BIBLE.md`;
4. az itt felsorolt jóváhagyott képi referencia vizuális tartalma;
5. implementációs/proxy asset.

Ha egy képen lévő szöveg ütközik a dokumentált kánonnal, a dokumentált kánon az irányadó.

---

## Karakter referenciák

| Fájl | Státusz | Használat | SHA-256 |
|---|---|---|---|
| `characters/AKIRA_FINAL_CHARACTER_DESIGN_V1.png` | **LOCKED PRIMARY** | Akira arc, haj, testarány, primary outfit, sziluett | `20b842f6fd63816361b6f747ebb4cc232f5801ff1e70a97e16e27ec912661acd` |
| `characters/AKIRA_ANIMATION_SHOWCASE_V1.png` | **LOCKED MOTION REFERENCE** | Akira Idle/Walk/Run/interakciós mozgásérzet; nem írja felül a production specet | `256d8d8c5da7cf8a4836f4a04753c849e440cb8e0d39c88b1b1dc1fad4391fec` |
| `characters/MIYAKO_FINAL_DESIGN_A_PRIMARY.png` | **LOCKED PRIMARY** | Miyako alapjátékos megjelenés; first encounterhez ez az authority | `18e84a9b2896e97772be590b231e0b27e6b960ace53f95d55329cbaa5e8f03c2` |
| `characters/MIYAKO_DESIGN_B_CEREMONIAL_VARIANT.png` | **LOCKED VARIANT** | hajdísz, bordó–arany detail language, ceremoniális outfit | `e31d4add5c8187838b510a220447e4896f48ea33a28ae051c65af0dedae821de` |
| `characters/SHION_FINAL_CHARACTER_DESIGN_V1.png` | **LOCKED PRIMARY** | Shion arc, zöld szem, fekete/ibolyás haj, primary outfit, holdfény/víz vizuális nyelv | `e65d15d6192e78c795a5083b1e695106a309161c188a41453b779d5ec9560653` |
| `characters/RENKA_CHARACTER_DESIGN_V1_REFERENCE.png` | **APPROVED REFERENCE** | Renka jelenlegi vizuális irány; még nem production lock | `25ea70919fe0719bb901d12faa6c3af08d6ac594d2d7fdae2c556c399c003de1` |
| `characters/HANA_FINAL_CHARACTER_DESIGN_V1.png` | **LOCKED PRIMARY** | Hana arc, tan bőr, nagyon hosszú hullámos haj, arany hajdísz, telt/buja testalkat, fekete–bordó–arany primary outfit | `c63ac780162addddf4e9cfef470038483f200f8b3ba88ac62de18e1a16d3ff9c` |
| `characters/HIMIKO_FINAL_CHARACTER_DESIGN_V1.png` | **LOCKED PRIMARY** | Himiko Empress-design: vörös haj, heterokrómia, kb. 200 cm-es karakterérzet, monumentális sziluett, extrém nagy mellkas, fehér–fekete városi/orvosi primary outfit | `e95bfb8bd81e0846bf2e037ec814bd89ef716285f250d0c1ede97cce7779d293` |

### Himiko megjegyzés

A Himiko-kép **LOCKED PRIMARY** vizuális referencia. Az automatikusan generált feliratok és idézetek nem történeti kánonok. A Character Bible és a `docs/HIMIKO_PRODUCTION_SPEC.md` határozza meg a használható részleteket.

### Hana megjegyzés

A Hana-kép **LOCKED PRIMARY** vizuális referencia. A képen lévő automatikusan generált feliratok nem történeti kánonok. A bőrtónusnál a Character Bible szerinti meleg tan/barna irány az authority, még akkor is, ha egy render fényben világosabbnak látszik.

### Renka megjegyzés

A Renka-kép jelenleg **APPROVED REFERENCE**, nem teljes FINAL production lock. A történeti/életkori kánont külön dokumentum határozza meg; a képi lap szövege önmagában nem authority.

---

## UI referencia

| Fájl | Státusz | Használat | SHA-256 |
|---|---|---|---|
| `ui/TSUKIMORI_DIALOGUE_UI_V1.png` | **APPROVED / VISUAL AUTHORITY** | dialógusbox, névtábla, választási highlight, narration/thought variáns, általános prezentáció | `333ff49088052e14ad1f3374754101fb9b19a3498e071cc47b609e2e54894862` |

---

## Visual target referenciák

| Fájl | Státusz | Használat | SHA-256 |
|---|---|---|---|
| `visual_target/AKIRA_MIYAKO_BEAUTY_TARGET_SCENE.png` | **LOCKED BEAUTY REFERENCE** | warm/cool lighting, Miyako doorway staging, Akira foreground, rainy village mood | `1f0eda84565ef5442a9b054942d6a841bacc857d7bca99a5f083822a85dec1fd` |
| `visual_target/AKIRA_MIYAKO_BEAUTY_TARGET_STORYBOARD.png` | **APPROVED STAGING REFERENCE** | first encounter shot language és ritmus | `d63b9351dd39cc5985ceed8e153359e7c7e93cf032125a14d8137094a8ca0c45` |
| `visual_target/TSUKIMORI_2_5D_VISUAL_TARGET_V1.png` | **APPROVED VISUAL TARGET — PROTOTYPE** | az Until Then által inspirált, de saját Tsukimori 2D/2.5D cinematic narrative adventure irány első hivatalos képi célreferenciája | `fcab458a7ba4280d47f3b48ffc5086d2aa1c8475b3293a953a7cefdec9310243` |

### 2.5D státusz

A `TSUKIMORI_2_5D_VISUAL_TARGET_V1.png` **nem FINAL production lock**.

Először a Miyako first-encounter 2.5D prototípusban kell validálni. Addig:
- a jelenlegi 3D verziót nem szabad törölni;
- a 3D world layout kánon megmarad térbeli referenciának;
- a 2.5D prototípus külön implementációs réteg;
- teljes production migration csak újabb tulajdonosi döntéssel történhet.

---

## Work / Codex használati szabály

Ha a Work/Codex környezet közvetlenül hozzáfér a ChatGPT Library-hez, a fenti fájlneveket és mappát kell használni.

Ha a képek nem érhetők el közvetlenül:
1. **ne generáljon helyettük új vizuális authorityt**;
2. ne módosítsa a karakterdesignt saját értelmezés alapján;
3. a dokumentált production specet használja fallbackként;
4. jelezze, hogy a konkrét képi referencia szinkronizálása szükséges.

A képi referencia hiánya nem jogosít fel LOCKED design újratervezésére.
