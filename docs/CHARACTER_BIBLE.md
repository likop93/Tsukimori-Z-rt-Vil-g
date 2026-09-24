# Tsukimori — Character Bible

**Verzió:** 1.0  
**Státusz:** aktív karakterkánon  
**Dátum:** 2026-09-24

## Használati szabály

Karaktermodell, portré, animáció, ruha, arckifejezés vagy jelenetrendezés előtt ezt a dokumentumot ellenőrizni kell.

A `LOCKED` karakterdöntést nem írhatja felül automatikusan generált asset, proxy, korábbi koncepció vagy más karakterhez tartozó vizuális jegy.

---

# Dr. Akira

## Identitás

- férfi főhős;
- városi terapeuta/doktor;
- kontrollált, megfigyelő személyiség;
- nem klasszikus fantasy-hős;
- Tsukimoriban Katsuro egykori házába/rendelőjébe érkezik;
- tisztánlátása vágyakat, félelmeket, hazugságokat, elfojtott önképet és természetfeletti nyomást érzékel;
- elemi motívuma: **szél**;
- későbbi kulcsmondat: **„Én vagyok a szél.”**
- későbbi cím: **„A Bukottak Királya.”**

## FINAL vizuális irány — LOCKED

LOCKED:
- **fekete haj**;
- Akira vizuális identitását nem szabad Lofttal összemosni;
- normál emberi, nyúlánk/karcsú-atletikus arány;
- sötét, elegáns, de praktikus megjelenés;
- nem chibi;
- nem fotórealista;
- Tsukimori anime-stilizált 3D art directionjéhez igazodik.

LOCKED megjelenés:
- kb. 180 cm;
- korai harmincas, felnőtt férfi arc;
- enyhén rendezetlen, nagyobb tincsekben olvasható fekete haj;
- intelligens, komoly, figyelő arc;
- karcsú-atletikus testalkat;
- sötét charcoal/fekete, modern, rétegzett városi felsőruházat;
- puhább belső réteg / kapucnis réteg megengedett és a jóváhagyott design része;
- sötét, karcsú nadrág és praktikus sötét cipő;
- visszafogott karóra;
- szemüveg opcionális variáns, vékony modern kerettel;
- hosszabb kabát későbbi alternatív outfit lehet, nem az elsődleges sziluett;
- a Black Fan motívum előrevetíthető, de ne legyen feltűnő cosplay-dísz.

A 3D gyártási specifikáció: `docs/AKIRA_PRODUCTION_SPEC.md`.

## Akira animációs nyelve — LOCKED

Alapelv:

> Minél furcsább dolog történik Akira körül, annál kevésbé reagál látványosan.

Jellemző:
- szem reagál először;
- fej utána;
- váll/test csak szükség esetén;
- kontrollált reakció;
- nincs nagy anime-hátrahőkölés;
- nyugodt járás;
- figyelő tekintet;
- finom súlyáthelyezés;
- kabát kézzel tervezett secondary motion + csak finom procedurális rásegítés.

FINAL locomotion:
- **in-place**;
- Godot CharacterBody3D mozgatja a karaktert;
- root motion csak külön cinematic kategóriában megengedett.

Első FINAL locomotion batch:
- `AKIRA_Idle_Base_01`
- `AKIRA_Walk_Loop`
- `AKIRA_WalkStart_L/R`
- `AKIRA_WalkStop_L/R`
- `AKIRA_Turn45_L/R`
- `AKIRA_Turn90_L/R`

Az első gyártási validáció csak Idle + Walk után folytatható a teljes csomagra.

---

# Miyako

## Identitás

- Katsuro özvegye;
- Akira fő érzelmi és romantikus ellenpontja;
- Katsuro egykori házához, rendelőjéhez és a régi rendszerhez kötődik;
- Akira és Miyako kapcsolata slow-burn, bizalomra épül;
- képes lehet átalakulások/korrupció semlegesítésére;
- kezdetben sötét hajú, elegáns, fekete gyászruhás megjelenés;
- később vizuálisan változhat, de ezt külön jóvá kell hagyni.

## FINAL vizuális irány — LOCKED

**Design A — Primary FINAL**
- kb. 165 cm;
- korai harmincas, felnőtt nő;
- karcsú, nőies, elegáns testalkat;
- hosszú, sötétbarna/feketébe hajló haj;
- részben feltűzött, rendezett hajforma;
- melankolikus, méltóságteljes, kontrollált arc;
- fekete/charcoal, rétegzett, gyászruhás alapoutfit;
- finom arany/bordó díszítés;
- hosszú, elegáns sziluett;
- sötét, praktikus-elegáns lábbeli.

**Design B — Ceremonial / Detail Exploration**
- szintén megtartott hivatalos vizuális referencia;
- nem cseréli le Design A-t;
- használható belőle: hajdísz, bordó–arany részletnyelv, textilminták, díszesebb ceremoniális outfit, bizonyos arckifejezések;
- különleges/szentélyi/ceremoniális jelenetekhez használható;
- a lapon szereplő téves szerepleírások — „házvezető”, „szentélyi gondozó” — **nem kánonok**.

A 3D gyártási specifikáció: `docs/MIYAKO_PRODUCTION_SPEC.md`.

## Mozgásnyelv — PRODUCTION LOCK

- kontrollált;
- kevés felesleges testsúlyváltás;
- lassabb, tudatos kézmozdulatok;
- hosszabb szemkontaktus;
- érzelmi kibillenést apró gesztus árul el;
- félbehagyott mozdulat, elfordított tekintet, megálló kéz fontosabb, mint nagy reakció.

Alapelv:
> Miyako érzelmeit gyakran egy félbehagyott mozdulat árulja el.

Első animációs batch:
- `MIYAKO_Idle_Base_01`
- `MIYAKO_Walk_Loop`
- `MIYAKO_Turn_Soft_L/R`
- `MIYAKO_FoldHands`
- `MIYAKO_Wait`
- `MIYAKO_LookAway`
- `MIYAKO_SoftGesture`

Első találkozási kánon:
**„Dr. Akira. Már vártam.”**

---

# Shion

## Identitás

- fekete haj;
- **zöld szem — LOCKED karakterjegy**;
- karcsú, visszafogott;
- vízhez, emlékezethez és szentélyhez kötődik;
- Oto vitte le gyerekként a mélybe;
- Kuroe korábbi barátnője;
- háza a patak falusi oldalán van.

## FINAL vizuális irány — LOCKED

- hosszú fekete / nagyon sötét ibolyás haj;
- hideg holdfényben ezüstös-lilás edge-light;
- finom virágos hajdísz;
- sötét fekete / mély ibolya, japán ihletésű rétegzett Primary outfit;
- finom virágminták;
- törékeny, hosszanti, csendes sziluett;
- a vizuális motívum: **víz + holdfény + emlékezet + csend**;
- nem Miyako 2.0 és nem harsány goth;
- a jóváhagyott referencia-lap képi elemei az irányadók; a rajta automatikusan generált életrajzi számok/szövegek nem válnak automatikusan történeti kánonná.

A 3D gyártási specifikáció: `docs/SHION_PRODUCTION_SPEC.md`.

## Mozgásnyelv — PRODUCTION LOCK

Alapelv:
> Shion akkor a legnyugtalanítóbb, amikor túl kevéssé mozog.

- nagyon kis testsúlyváltás;
- hosszabb statikus pózok;
- szem gyakran előbb vált, mint a fej;
- lassú, csekély fejfordítás;
- néha szinte természetellenesen mozdulatlan;
- a haj és ruha finom, puha secondary motiont kap.

Első animációs batch:
- `SHION_Idle_Base_01`
- `SHION_Walk_Loop`
- `SHION_Turn_Slow_L/R`
- `SHION_LookAside`
- `SHION_StillHold`
- `SHION_SmallSmile`
- `SHION_WaterObserve`

---

# Kuroe

- fiatal goth művész;
- Shion exbarátnője;
- hegedű/zongora/zene motívum;
- Akira jövőbeli mahagóni gitárjának ötlete tőle ered;
- a hangszer külső motívumai közül Miyako motívumai dominálnak.

---

# Hana

- barna/tan bőr;
- nagyon hosszú, sötét, hullámos haj;
- arany hajdísz;
- vörösesbarna szem;
- erős, közvetlen, testi/fertilitási energia.

Mozgásérzet:
- közvetlenebb;
- teltebb, erősebb jelenlét;
- több testsúly és határozottabb gesztus, mint Miyakónál vagy Shionnál.

---

# Oto

- idős ritualista nő;
- régi rend / living seals;
- Shion gyerekkori szentélytörténetéhez kötődik.

---

# Katsuro

- Akira elődje;
- Miyako férje;
- nyilvánosan halottnak hitt;
- történeti lehetőség szerint fekete vízben fogva lehet;
- ház, dolgozószoba, láda, kazetta és Black Fan rejtélyének központja.

---

# Karakterasset szabály

PLACEHOLDER vagy PROXY nem válhat FINAL karakterkánonná.

FINAL karakterhez kell:
- jóváhagyott front/side/back;
- arcirány;
- színpaletta;
- ruha;
- sziluett;
- rig-kompatibilitás;
- animációs language review.
