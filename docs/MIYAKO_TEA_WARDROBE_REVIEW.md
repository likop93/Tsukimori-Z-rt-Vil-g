# Miyako esti tea — kapcsolat és ruhatár, REVIEW
2026-10-11. Tulajdonosi kérés: karakterenként eltérő személyes történet és a közeledéssel megjelenő merészebb ruhák. Első megvalósított jelenet: Miyako esti teázása a pecsét után.

## Jelenet és állapot
ÚJ, tulajdonosi kérésre írt kiegészítés; nem az eredeti Ren'Py/PDF szöveg átirata, nem új kreatív LOCK. A VI. fejezet eredeti folytatása még nincs átültetve.
A pecsét lezárókártyájáról folytatható; közvetlen teszt: Fejezetválasztás → V. Esti tea.
Miyako balra, Akira jobbra; Akira megváltozott jobb szeme megmarad. A közös szoba VN-only, játékosmozgás nélkül.
Három teljes ág: closer / slow / friends. A personal_choices.miyako_tea egyszer írható. Nem ad kanonikus affinitást, nem módosít horrorértéket. Az őszintén megbeszélt esti tempó nem új elutasítási trigger; az előző határhúzások hatása megmarad. Az előző figyelő/birtokló állapot a ruhán és egy rövid narrációs eltérésen is látszik.
Az esti átöltözés minden kölcsönösen elfogadott társasági ágon megtörténik; baráti közelség is lehet bizalom. Nem kizárólag romantikus jutalom. A ruházat nem helyettesíti a személyes beleegyezést.
miyako_evening_outfit_seen a válaszkor, miyako_tea_complete a lezáráskor áll be. A karakterlap a kimondott megállapodást mutatja; ruhaelőnézete nem ír állapotot. Új játék/fejezetválasztás törli a személyes döntést és az outfitfeloldást.
A belépési pont a korábbi eseményeket állítja be, de nem talál ki korábbi affinitást vagy horrorválasztást.

## Képek / produkciós korlát
Három új átlátszó alakos VN-kivágás, a korábbi fej–alsótest framinggel:
- miyako_evening_v1_REVIEW.png: normál barna haj/szem, meleg mosoly.
- miyako_evening_watchful_v1_REVIEW.png: figyelő állapot, visszafogott mosoly.
- miyako_evening_transformed_v1_REVIEW.png: ezüst haj, kék szem, meglévő teltebb sziluett és mániákus mosoly.
Mindhárom: sötét vállat szabadon hagyó kötött felső és hosszú szilvaszín szoknya. A ruha végig átlátszatlan. Alap kimonós design változatlan.
REVIEW: nem járó sprite-atlasz; azonos állópóz, nincs külön ülő/teázó kézanimáció vagy jelenet-CG. Akira az előző rendelői portrét használja az érkezési mondat alapján. Teljes lábfejig érő production lap és további arcreakciók későbbi assetek.

## Karakterenkénti további irány — MÉG NINCS IMPLEMENTÁLVA
- Hana: a jóváhagyott nőiesebb, karcsúbb hétköznapi V2 top/farmer ruha saját, rendelésen kívüli történeti jelenethez kapcsolható. Magabiztos alap és alárendelődő horrorág külön marad.
- Shion: saját bizalmi történet a közös emlék és a zene körül; személyes hétköznapi ruha későbbi vizuális review alapján.
- Kuroe: zenei környezetéhez és jóváhagyott sötét ruhatárához illő személyes jelenet; új outfit még nincs generálva.
Nem közös, automatikus „vetkőzési szint”: külön jelenetek, egyéni ízlés, külön személyes választások.

## Generálási provenance
Provider: beépített image_gen, transparent_background=true. Az eredeti generált fájlok megőrizve; másolatok assets/opening/vn_portraits alatt. Nincs utólagos képszerkesztés.

### Normál esti ruha
Edit reference: assets/opening/vn_portraits/miyako_cutout_v1_REVIEW.png.
Eredeti: C:/Users/likop/.codex/generated_images/01a0de06-53bf-7c60-8a17-b76aceffe7c1/exec-5301b67f-6490-4d5e-817a-9405b505936a.png.
Pontos prompt:
> Outfit and gentle expression edit of this adult Miyako VN portrait. Preserve exact mature face identity, brown eyes, dark brown long hair, gold ornaments, body proportions, hands and head-to-lower-body framing. She wears an elegant charcoal off-shoulder long-sleeved knit top, showing shoulders and collarbones, opaque fabric and a modest neckline, with a flowing dark plum long skirt. A tasteful comfortable evening outfit at home. Softer small warm smile, relaxed shoulders. Same detailed illustration style and natural standing pose. Transparent alpha background. No frame, no text.

### Átalakult esti ruha
Edit target: normál esti generált kép. Supporting reference: miyako_transformed_manic_v1_REVIEW.png.
Eredeti: C:/Users/likop/.codex/generated_images/01a0de06-53bf-7c60-8a17-b76aceffe7c1/exec-54f263f4-726e-433f-a05a-aaaffdbc06d1.png.
Pontos prompt:
> Edit the first reference portrait: keep the exact charcoal off-shoulder opaque long-sleeved knit top, plum long skirt, folded hands, framing and elegant mature adult Miyako identity. The second reference is her established supernatural alternate appearance: transfer its silver hair, ice blue eyes, unsettling wide smile and established fuller silhouette to the first reference, with fully opaque clothing. Preserve the gold ornaments, detailed illustration style and head-to-lower-body framing. A standing visual novel cutout, transparent alpha background, no halo or painted backdrop, no frame, no text. This is the same evening outfit in her existing horror state, not a new character design.

### Figyelő esti ruha
Edit target: normál esti generált kép. Supporting reference: miyako_possessive_v1_REVIEW.png.
Eredeti: C:/Users/likop/.codex/generated_images/01a0de06-53bf-7c60-8a17-b76aceffe7c1/exec-5a153f44-49ee-4c7c-bb15-f2e702888071.png.
Pontos prompt:
> Edit target first reference: preserve exactly her charcoal off-shoulder opaque knit top, plum long skirt, folded hands, mature adult Miyako identity, body silhouette, gold ornaments and full head-to-lower-body framing. Supporting expression reference second image: match its subtly watchful direct gaze, slightly narrowed brown eyes and restrained lingering smile. Keep long dark brown hair and brown eyes. Same detailed illustration and pose. Transparent alpha background with no halo or painted scenery, no text or frame. This is a subtle wary expression variation of the same standing VN evening portrait.

## Ellenőrzés
Godot 4.7.2: import/parse, tea_regression (3 választás × 3 horrorállapot), seal_regression (valódi Shion–pecsét–tea átmenet), chapter_select_regression (9 belépési pont, billentyűzet, visszalépés, reset).
Képi ellenőrzés: review/tea_choices_REVIEW.png, tea_stage0/1/2_REVIEW.png, tea_journal_REVIEW.png.

A kilenc kombinációs teszt egyik ismétlése a kilépéskor 4 ObjectDB példányra figyelmeztetett; a futás és minden ellenőrzés sikeres, parse/runtime script error nélkül. Ez a projekt korábbi tesztjeiben is előforduló lezárási figyelmeztetés, nem megoldottként jelentett hiba.

