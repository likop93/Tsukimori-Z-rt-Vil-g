# Ren’Py → Godot: fő történeti út és következő jelenetek

Forrás: a `docs/RENPY_CANON.md` dokumentumban azonosított Ren’Py-projekt. A jelenettérkép a `label start` felől **normál játékban elérhető** útvonalat követi. A sorszámok a feltöltött `game/canonical_html_story.rpy` fájlra vonatkoznak; Kuroe és a második szabadidős szakasz külön fájlban vannak. A címkenevek és az állapotváltozások az átültetés ellenőrzési pontjai, nem a Godot-pálya automatikus átrendezésére szóló utasítások.

## Rögzített térbeli döntések

Shion háza a patak **falusi oldalán** van. Megmarad a patakhíd, Miyako és Akira **közös otthona a túlpart távolabbi házaként**, a házhoz tartozó **külön rendelőszárny**, valamint a jelenlegi falusi és erdei útstruktúra. A Ren’Py nem nevezi meg a hidat az első fejezetben; ez nem történeti ellentmondás. A Ren’Py „a falu egyik csendesebb részén” megfogalmazása összeegyeztethető a Godotban elfogadott csendes peremmel. A házakat és az utakat csak tényleges, jelenettel igazolható ellentmondás esetén, egyeztetés után mozgatjuk.

## Elérhető fő út

| Sorrend | Ren’Py-forrás | Kötelező történeti tartalom | Godot-helyszín és státusz |
|---|---|---|---|
| 0 | `reworked_story.rpy` `start` → `canonical_html_story.rpy` `canonical_html_prologue` | Akira elhagyja korábbi életét, Tsukimoriba tart. | Bejárható hegyi ösvény és falukapu megvan; a prológus szövege még nincs átültetve. |
| 1 | `canonical_html_chapter_1`, 94–173. sor | Falusi pillantások, Katsuro háza, Miyako első mondata, beszélgetés és első választás; utána az **első éjszaka** és a hallott férfihang. | Falun áthaladás és találkozás kész; a két eredeti jelenetképpel lejátszott első választás kész. Az első éjszaka hiányzik. |
| 2 | `canonical_html_chapter_2`, 174–496. sor | **Második reggel:** Miyako konyhai jelenete és érintésdöntés; Katsuro lezárt dolgozószobája, amelynek kulcsa Miyakónál van; a rendelő, a feljegyzés és Akira szakmai szabálya; **első rendelési nap reggele** és újabb döntés. | Ugyanabban a jóváhagyott közös házban; a rendelőszárny bejárható. A konyha, dolgozószoba és az összefüggő VN-jelenetek még készülnek. |
| 3 | `canonical_html_chapter_3`, 498–741. sor | Két, jelenleg **névtelen** páciens a rendelőben; Katsuro füzete és az esti beszélgetés; később visszatérő füzet. | A meglévő rendelőben, utána közös házban. A külön `tsukimori_patients_v2.rpy` Ken/Tomiko-jelenetei nem helyettesítik automatikusan a fő út két névtelen páciensét. |
| 4 | `canonical_html_chapter_4`, 743–1768. sor | Hana rendelői belépése és jelenetei, két döntés, Akira első különös érzékelése; később éjszakai látogató. | Meglévő rendelő és ház; Hana otthonának pontos helye még nincs kijelölve. |
| 5 | `canonical_html_chapter_5`, 1770–2520. sor | Shion jelenetei, dallam és kazetta körüli döntések, beleegyezés és Akira emlékei. | A rendelő, patakpart és a már kijelölt Shion-ház használható; a történet nem kívánja a ház áthelyezését. |
| 6 | `canonical_html_chapter_6`, 2522–3303. sor | Ház alatti hang, lépcső, hét pad, majd szentélyhez vezető út; három döntési pont. | A közös ház alatti titok vizuális jele már megvan. A belső és szentélyjeleneteket később kell felépíteni. |
| 7 | `canonical_html_chapter_7`, 3305–4045. sor | Szentély mélye, a hanggal folytatott választásos szembesítés, majd egy szabad nap a faluban. | Szentélyút a későbbi pályarészben; a szabadnap helyei a már létező utcához és mellékutakhoz csatlakozhatnak. |
| 8 | `canonical_interchapter_gate_1` → `canonical_html_hub` → `canonical_html_after_hub`, 4048–4436. sor | **Legfeljebb három** választható szabadidős alkalom Hanával, Shionnal, Ritsuval, Sorával; rendelés, kutatás vagy pihenés is választható; a továbbhaladás bármikor elérhető. | A meglévő falu és erdei utak maradnak; a többi főszereplő saját helyszíne később történeti alapon kap helyet. |
| 9 | `canonical_html_chapter_8` → `miyako_ix_v2.rpy` `canonical_kuroe_sequence` → `canonical_html_after_kuroe` | Új fogadalom, Kuroe és a második szívritmus, majd esti beszélgetés a konyhában. | Új helyszín csak a konkrét jelenetek igénye szerint; a közös ház és a már ismert falu megmarad. |
| 10 | `canonical_html_route_menu` → `romance_interchapter_v2.rpy` `canonical_interchapter_gate_2` / `canonical_interchapter_hub_2` → `canonical_html_after_interchapter_gate_2` | Újabb **legfeljebb három** este; külön kapcsolati mérföldkövek, azonnali kizárólagos route-zár nélkül; „Új korszak” után a mostani fő út véget ér. | További bejárható és VN-találkozók a már elfogadott pályán; későbbi otthonok csak akkor kapnak fix helyet, amikor a jelenetek indokolják. |

A `canonical_html_legacy_route_menu` hosszabb Hana/Shion/Miyako szövege, a külön `miyako_ix_v2` folytatás és a Hana tűzoroszlán-demó **nincs automatikusan a fenti fő útba kötve**. A `reworked_story.rpy` I–VI. fejezete szintén nem a `start` utáni út, noha a fájl a projektben megmaradt.

## Állapotok, amelyeket a Godotnak ugyanígy kell kezelnie

| Ren’Py-állapot | Kezdet / szabály | Godot-megfeleltetés |
|---|---|---|
| `aff_miyako`, `aff_hana`, `aff_shion`, később `aff_sora`, `aff_ritsu`, `aff_kuroe` | Kezdetben 0; döntésenként nőnek. | `GameState.aff_miyako` és az első döntés már megvan. A többit a kapcsolódó jelenettel együtt vezetjük be. |
| `akira_gyogyulas`, `akira_elmerules` | Külön tengelyek, kezdetben 0. | Gyógyulás első értéke már átkerült; az Elmerülést az első Ren’Py-eseménynél kell bevezetni. |
| `flag_*`, `story_flags`, `patient_seen`, `codex_unlocked` | Egyszeri döntések, jelenetek, páciens- és karakterfelfedezések. | Stabil kulcsnevek és egyszeri alkalmazás; jelenleg csak az első Miyako-döntés és a Godot-belépési jelzők vannak meg. |
| `attraction`, `intimacy`, `potential`, `romance_state`, `neglect`, `attention_hunger` | Több külön érték; az affinitás **nem** jelenti automatikusan a románcot. A románc `none → attraction → romance → committed` mérföldkövekkel halad. | A későbbi jelenetekhez külön típusok és küszöbök; ne vonjuk össze a Godotban egyetlen „route pont” változóvá. |
| `confrontation_resolve` | 50-ről indul; a VII. fejezetben a válaszok módosítják. Az eredményküszöbök `>=70`, `>=40`, különben az alacsony ág. | Későbbi szentélyszakasz; a választási és eredménylogikát át kell venni, a harcrendszerrel nem szabad összekeverni. |
| `canonical_hub_visits_left`, `canonical_gate2_visits_left` | A két szabadidős szakasz külön-külön 3 alkalommal indul; a fő történet előbb is folytatható. | Későbbi hubokban külön számláló és külön végállapot. |

Különösen a második szabadidős szakaszban egy látogatás **nem** zárhatja le automatikusan az összes többi kapcsolatot. Hana hegyi forrása feltételekhez kötött; például `aff_hana >= 4`, `potential["hana"] >= 2`, `akira_women_safety >= 2`, `akira_life_joy >= 1` és sértetlen határjelző szükséges. Shion patakparti mérföldköve külön feltételekkel nyílik: `aff_shion >= 4`, `intimacy["shion"] >= 2`, `attraction["shion"] >= 2`, `akira_women_safety >= 2`, sértetlen határjelző. A teljes feltétel az eredeti `tsukimori_systems_v2.rpy` függvényeiben van; a Godot-átültetésnél ezeket egyenként kell ellenőrizni.

## Következő Godot-jelenetek: átültetési jegyzék

| Következő rész | Pontos forrás és döntés | Indítás / zárás a meglévő pályán | Elfogadási feltétel |
|---|---|---|---|
| Első éjszaka | `canonical_html_chapter_1`, a Miyako-választás után: Akira nem alszik, hajnal előtt idegen férfihangot hall. Nincs új döntés. | A közös házban az első beszélgetés folytatása. A mostani próba a döntés után visszaadja az irányítást; a történeti továbblépés majd külön jelenetből indulhat ugyanitt. | Mindkét első választás azonos éjszakai jelenetbe fut; a korábbi pontváltozások megmaradnak. |
| Második reggel, konyha | `canonical_html_chapter_2`, 174. sortól: Miyako, tea, Katsuro múltja, kézérintés. **Marad:** `aff_miyako +1`, `akira_gyogyulas +1`. **Távolság:** `flag_miyako_tavolsag = True`, pontnövekedés nélkül. | Ugyanazon közös ház konyhai VN-képe / későbbi bejárható belső tere; nem új lakóépület. | A két ágon pontos Ren’Py-szöveg és állapot, majd közös visszatérés a dolgozószoba beszélgetéséhez. |
| Katsuro szobája → rendelő | Ugyanitt: Miyako szerint a **személyes, lezárt dolgozószoba nem a rendelő**; a kulcs nála van. A rendelő jegyzete és Akira szabálya: a páciensekkel a rendelőn kívül nem találkozik. | A dolgozószobát a közös házon belül kell később kialakítani; a már elkészült külön rendelőszárny a rendelő marad. | A két tér sosem olvad össze; a zárt szoba nem hozzáférhető a kulcsos történeti pont előtt. |
| Első rendelési nap reggele | `canonical_html_chapter_2` vége: **Empátia:** `aff_hana +1`, `aff_shion +1`, `akira_gyogyulas +1`. **Klinikai távolság:** `flag_klinikai_tavolsag = True`, pontnövekedés nélkül. | Közös ház konyhája → rendelőszárny meglévő oldalsó bejárata. | A döntés egyszer történik, utána a III. fejezet első két névtelen páciense fogadható. |

A már működő rendelőszárny jelenleg szabadon bejárható bemutató. Ez **nem** jelenti azt, hogy a későbbi páciensek történeti jelenete a II. fejezet vagy az első döntés előtt megtörtént volna. A bejárás megmarad; a történeti események külön jelző alapján indulnak.

Akira FINAL karaktermodellje és FINAL animációi külön kreatív specifikációra várnak; ezen a történeti megfeleltetésen belül nem változnak.
