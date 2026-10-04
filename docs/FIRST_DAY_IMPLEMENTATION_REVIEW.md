# Első rendelési nap — összefüggő REVIEW

2026-10-04. Tulajdonosi kérés: az első éjszaka után az első nap, egyben átnézhető csomagban. A bevezető, karakterdizájnok és LOCKED térbeli döntések megmaradnak.

## Végigjátszható lánc

Első éjszaka lezárása → explicit reggeli folytatás → Miyako közelség-választás → reggeli felkészülés és Katsuro külön dolgozószobájáról szóló párbeszéd → rendelési attitűd-választás → két konzultáció → Katsuro rendelői füzete → esti beszélgetés Miyakóval → második éjszakai „Hana” záróhang → az első nap vége.

A rendelőben az asztalhoz sétálva E indítja a soron következő konzultációt. A fejléc jelzi a lezárt konzultációk számát. Két konzultáció után ugyanitt E indítja a nap összegzését és a füzet megfigyelését. Ezek után a bal szélen E visszavisz a nappaliba; Miyakóhoz sétálva E indítja az esti beszélgetést. A záróképernyőről a Főmenü gombbal lehet kilépni.

Minden dialógus nyugtázásra lép. A járható padlósávok megmaradnak; VN alatt a mozgás zárolva. Az esti asztali beszélgetés és az éjszakai kép alatt nincs a háttérben álló Akira sprite. Miyako meglévő, keret nélküli portréját használjuk.

A közös VN-panel 18 pixellel feljebb kezdődik, így a háromsoros szöveg külön helyet kap a Tovább gomb és a billentyűjelzés fölött. A teszt a tényleges szövegterület alsó szélét is összeveti a gomb helyével; a Label automatikus méretnövekedése nem rejtheti el az átfedést.

## Forrás és adaptáció

Alap: canonical_html_story.rpy, III. fejezet, az első két konzultációtól a „Hana” hangig. Megfelelő PDF: Tsukimori_teljes_megirt_tortenet_2026-10-04.pdf, 8–15. oldal. A reggeli és a két konzultáció további párbeszédei a PDF-ből kerültek be. A páciensdialógusok bővített szemelvények, nem a PDF teljes, szó szerinti prózaátirata.

Nem írtunk új klinikai esetet. A két páciens névtelen marad; nem váltak automatikusan Hanává vagy új karakterdizájnná. Az eddigi technikai reggeli idővonalat megtartjuk: a II–III. fejezet kiválasztott reggeli mondatai az első Godot rendelési nap felkészülésében szerepelnek. Ez REVIEW ritmusadaptáció, nem új kreatív lock.

A Katsuro-füzet és az esti beszélgetés az eredeti III. fejezetben szerepel. A füzet a rendelői könyvespolchoz tartozik; nem jelent belépést Katsuro külön, személyes dolgozószobájába. A homályos férfihang nem azonosítja a beszélőt, nem nyitja meg a Mélységet és nem leplezi le Katsuro teljes státuszát.

Hana külön megírt galactorrhoea-klinikai jelenete nem került kitalált pótlással a napba. A IV. fejezet eredeti terápiás szövege rendelkezésre áll; annak és a külön klinikai kiegészítésnek a következő napi összekapcsolása későbbi feladat.

## Állapot és karaktermenü

A meglévő egyszeri reggeli/rendelési választáshatások változatlanok. first_clinic_day_seen a két nyugtázott konzultációt jelöli; nem a teljes nap végét.

Új, nyugtázott állapotok:
- katsuro_clinic_notebook_seen — a rendelői füzet megfigyelése befejeződött;
- miyako_first_day_evening_seen — az esti beszélgetés befejeződött;
- hana_name_heard — a záróhang szövegét elolvastuk;
- first_day_complete — az egész nap záróképernyője elérhető.

A Hana név hallása nem állít met_hana flaget és nem leplezi le a névtelen cameo személyazonosságát a karaktermenüben. Akira lapján megjelennek az átélt események; Miyako lapján az esti beszélgetés. A menü továbbra is csak olvassa az állapotot. Új játék törli az új flag-eket is.

## Vizuális és production korlátok

A meglévő REVIEW reggeli, rendelő, közös otthon és Akira-alvási képekből építkezünk. Az alkonyt a rendelő visszafogott fényváltozata jelzi. Nincs új karakter- vagy helyszínredesign.

Hiányzó production assetek: a két névtelen páciens jóváhagyott külön sprite-ja/portréja; Katsuro füzetének képi közelije; végleges nappali/klinikai rétegek és animációk; végleges hangfelvétel. A páciensek egyelőre szöveges VN-ként jelennek meg; a Hana szó csak szövegben érthető, alatta technikai mormolás hallható. A fénykép korábbi helyőrző státusza változatlan.

Ez a csomag az első nap történeti jelenetláncát lezárja. A teljes szabad falusi napi ciklus, váró/folyosó bővítése és a következő nap még nincs megvalósítva. Inventory, combat, új route-rendszer és komplex mentés nincs.

## Ellenőrzés

Godot 4.7.2, night_day_regression: mindkét reggeli/rendelési ág, a két konzultáció egymás utáni nyugtázása, szövegek illeszkedése, füzet külön flagje, rendelő–nappali navigáció, esti VN, sprite eltüntetése a záróképben, Hana megismerésének kizárása, új játék törlése. A korábbi éjszakai szüneteltetés/tartott input tesztje is benne maradt.

REVIEW képek: review/first_day_evening_REVIEW.png és review/first_day_complete_REVIEW.png. Az éjszakai források és imagegen napló: FIRST_NIGHT_IMPLEMENTATION_REVIEW.md.
