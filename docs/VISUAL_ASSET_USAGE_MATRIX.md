# Tsukimori — Visual Asset Usage Matrix

**Dátum:** 2026-09-30  
**Státusz:** APPROVED ORGANIZATION / USAGE GUIDE

## Cél

Ez a dokumentum megmondja, hogy a meglévő Tsukimori képek milyen szerepben használhatók.

Alapszabály:

> Egy kép lehet kiváló marketing/key art vagy hangulati referencia anélkül, hogy gameplay- vagy karakter-authority lenne.

A karakter- és vizuális kánon elsődleges authorityja továbbra is:
- `docs/DECISION_LOG.md`
- `docs/VISUAL_REFERENCE_INDEX.md`
- `docs/CHARACTER_BIBLE.md`
- a LOCKED FINAL karakterreferenciák
- `docs/PIXEL_ART_PRODUCTION_DIRECTION.md`

---

# 1. PRODUCTION AUTHORITY / GAMEPLAY IDENTITY

Ezek határozzák meg, hogyan kell kinéznie a játék végleges pixel-art világának vagy a fő karaktereknek.

| Asset | Használat | Státusz |
|---|---|---|
| `characters/AKIRA_FINAL_CHARACTER_DESIGN_V1.png` | Akira identitás, arc, haj, outfit, sziluett | LOCKED PRIMARY |
| `characters/MIYAKO_FINAL_DESIGN_A_PRIMARY.png` | Miyako alapidentitás, first encounter | LOCKED PRIMARY |
| `characters/SHION_FINAL_CHARACTER_DESIGN_V1.png` | Shion identitás | LOCKED PRIMARY |
| `characters/HANA_FINAL_CHARACTER_DESIGN_V1.png` | Hana identitás | LOCKED PRIMARY |
| `characters/HIMIKO_FINAL_CHARACTER_DESIGN_V1.png` | Himiko identitás | LOCKED PRIMARY |
| `visual_target/TSUKIMORI_PIXEL_ART_VISUAL_TARGET_V1.png` | teljes játék pixel-art quality/style target | LOCKED PRIMARY |
| `ui/TSUKIMORI_PIXEL_DIALOGUE_UI_V1.png` | fontos dialógusok hibrid UI-ja | LOCKED PRIMARY |

**Szabály:** ezekből készülhet pixel-art adaptáció, de redesign nem.

---

# 2. PLAYABLE BASE / SCENE REFERENCE

Ezek használhatók közvetlenül prototípushoz és scene staginghez, de FINAL előtt production pass kell.

| Asset | Használat | Státusz |
|---|---|---|
| `backgrounds/VILLAGE_STREET_PIXEL_V1.png` | Village Street playable base | APPROVED PLAYABLE BASE |
| `backgrounds/BRIDGE_PIXEL_V1.png` | híd playable base | APPROVED PLAYABLE BASE |
| `backgrounds/MIYAKO_HOUSE_EXTERIOR_PIXEL_V1.png` | Miyako/Akira ház külső | APPROVED PLAYABLE BASE |
| `backgrounds/SHARED_HOME_CLINIC_INTERIOR_PIXEL_V1.png` | közös ház/rendelő belső hero slice | APPROVED PLAYABLE BASE |
| `visual_target/OPENING_SEQUENCE_STORYBOARD_V1.png` | opening staging, shot rhythm, composition | LOCKED STAGING REFERENCE |

**Nem FINAL közvetlenül:** layer separation, parallax, tiszta occlusion, pixel-density pass, animation/VFX szükséges.

---

# 3. NPC SOURCE / POPULATION REFERENCE

Ezekből lehet production sprite-atlaszokat készíteni, de maguk a boardok nem runtime-ready atlaszok.

| Asset | Használat | Státusz |
|---|---|---|
| `npc/VILLAGE_NPC_PACK_V1_WOMEN_ONLY.png` | női falusi lakosság alapirány | LOCKED POPULATION DIRECTION |
| `npc/VILLAGE_NPC_ATTRACTIVE_VARIANTS_V2.png` | vonzóbb/elegánsabb falusi variációk | APPROVED VARIATION |
| `npc/INN_COURTESAN_NPC_PACK_V1.png` | fogadó felnőtt courtesan/sex-worker vizuális irány | APPROVED INN REFERENCE |

**Production előtt:** transparent atlasz, fix frame size, bottom-center pivot, egységes pixel density, valódi idle/walk/look frame-ek.

---

# 4. KEY ART / MARKETING / ROUTE PROMO

Ezek nem írják felül a karakterdesignt és nem közvetlen gameplay assetek. Erős illusztratív anyagként használhatók.

Library:
`/Tsukimori Visual References/marketing_key_art/`

| Asset | Ajánlott felhasználás | Authority |
|---|---|---|
| `MIYAKO_MOONLIT_VERANDA_KEY_ART_V1.png` | Miyako route promo, chapter splash, loading art, social/Steam marketing | KEY ART ONLY |
| `MIYAKO_TSUKIMORI_PROMO_KEY_ART_V1.png` | Tsukimori + Miyako promo, store/banner concept, route reveal | KEY ART ONLY |
| `visual_target/AKIRA_MIYAKO_BEAUTY_TARGET_SCENE.png` | beauty-target, promo-kompozíció inspiráció | BEAUTY / STAGING REFERENCE |
| `visual_target/AKIRA_MIYAKO_BEAUTY_TARGET_STORYBOARD.png` | cinematic first-encounter staging | STAGING REFERENCE |

**Fontos:** ha a key art arca, teste, outfite vagy környezete eltér a LOCKED karakter-/világ-authoritytól, a LOCKED forrás nyer. A key art hangulatot és marketingprezentációt szolgál.

---

# 5. CG / STORY EVENT REFERENCE

A nagy történeti pillanatok részletesebb pixel-CG vagy promo illusztrációjához használhatók inspirációként.

Ajánlott:
- Miyako holdfényes/verandás key art
- Akira–Miyako beauty target
- opening storyboard
- későbbi trauma/memory key visualok

A végleges játékbeli CG-k azonban:
- ugyanabban a high-detail pixel-art nyelvben készüljenek;
- kövessék a FINAL karakterreferenciát;
- ne váltsanak át másik vizuális univerzumba.

---

# 6. SUPPORTING / LEGACY REFERENCE

Használhatók ötletelésre és funkcionális referenciára, de nem production authorityk.

| Asset | Használat | Státusz |
|---|---|---|
| `visual_target/TSUKIMORI_2_5D_VISUAL_TARGET_V1.png` | korábbi 2.5D prototípus/hangulat | SUPPORTING / SUPERSEDED |
| `ui/TSUKIMORI_DIALOGUE_UI_V1.png` | UI funkció/kompozíció | LEGACY SUPPORTING |
| `characters/MIYAKO_DESIGN_B_CEREMONIAL_VARIANT.png` | ceremonial/detail variation | LOCKED VARIANT, nem primary |
| `characters/RENKA_CHARACTER_DESIGN_V1_REFERENCE.png` | Renka jelenlegi iránya | APPROVED REFERENCE |
| `characters/AKIRA_ANIMATION_SHOWCASE_V1.png` | Akira motion idea | MOTION REFERENCE |

---

# 7. NOT DIRECTLY USABLE AS RUNTIME ASSET

Ezeket nem szabad változtatás nélkül runtime FINAL assetként használni:

- storyboard boardok;
- NPC showcase boardok;
- character design sheetek;
- marketing/key art képek;
- nyers AI-generált képek;
- olyan képek, amelyekben szöveg, prezentációs layout vagy nem kánonikus designrészlet van.

Ezekből production asset készülhet, de csak külön review után.

---

# 8. Gyors döntési szabály

Ha új kép készül, először kapjon egyet ezek közül:

1. **PRODUCTION AUTHORITY**
2. **PLAYABLE BASE / REVIEW**
3. **NPC SOURCE / REFERENCE**
4. **KEY ART / MARKETING**
5. **CG / STORY EVENT REFERENCE**
6. **SUPPORTING / LEGACY**
7. **DISCARD / NOT USED**

A kategória nem egyenlő a minőséggel. Egy marketing key art lehet gyönyörű és végleges marketinganyag, miközben gameplayhez továbbra sem authority.

