# Miyako első VN-jelenete — 2026-10-03 REVIEW

A ház előtti E-interakció 1.6 másodperces beállítás után VN-réteget nyit. A háttér a tényleges játszható házkülső, Miyako és Akira helyben marad. A beszélgetés alatt a mozgás zárolva van. Nincs automatikus eltűnés vagy előreléptetés.

E / Space / Enter / bal kattintás: először a teljes mondat kiírása, majd továbblépés. A záró oldal nyugtázása után egyszer áll be a met_miyako és miyako_first_dialogue_seen jelző, és visszatér az irányítás. A nyitó E nem lépteti át a köszöntést. Az intro-skip nem zárja le ezt a beszélgetést.

Szöveg: a helyben megtalált Tsukimori_RenPy_Prototype/game/Tsukimori/game/canonical_html_story.rpy canonical_html_chapter_1 külső találkozásából. A jóváhagyott „Dr. Akira. Már vártam.” után az eredeti narráció két oldalra bontva. Az adatok: data/opening/miyako_first_dialogue.json. Új kánon nem került be. A benti jelenet és választások nem kerültek előre a ház elé.

Portré: az assets/opening/reference/MIYAKO_FINAL_DESIGN_A_PRIMARY.png (792,8,275,371) runtime AtlasTexture-kivágása. REVIEW / PLACEHOLDER, nem végleges pixel-art portré. Hiányzik a külön gyártott, átlátszó hátterű Miyako Design A VN-portré és az arckifejezés-készlet. A névtábla és bordó keretes szövegdoboz a TSUKIMORI_PIXEL_DIALOGUE_UI_V1 vizuális irányát követő technikai UI. A teljes képes referencialap nem válik production atlasszá.

Teszt: tests/ui/vn_dialogue_regression.tscn valódi billentyűkkel ellenőrzi az indítást, kiírást, oldalváltást, a mozgás zárolását, a portré méretét, szövegelhelyezést és a végállapotot. tests/opening/regression.tscn a természetes nyitástól a találkozásig is ellenőrzi az új működést, beleértve az időkorlát nélküli olvasást. Mindkettő sikeres. Képek: review/vn_miyako_0.png–vn_miyako_2.png.

Következő lépés: házba lépés és a belső jelenet, majd a forrás szerinti első beszélgetés és döntés. Nincs új route-, inventory- vagy save/load-rendszer.
