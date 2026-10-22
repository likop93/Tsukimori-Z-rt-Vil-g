# WORK — EGYETLEN VIZUÁLIS FELADAT, NINCS ÚJRATERVEZÉS

A mellékelt `TSUKIMORI_EGYSEGES_VIZUALIS_ALAP_V4.zip` a legutóbb tulajdonos által jóváhagyott **Akira/Miyako** arcokat rögzíti. A két különálló PNG és a Miyako JPEG eredeti, nem generálj új karaktert.

**Első prioritás: karakterazonosság védelme, nem új CG-k készítése.**

1. Nyisd meg a `03_EGYSÉGES_VIZUÁLIS_SZABVÁNY.md` fájlt és a `preview_eredeti_par.html` összehasonlítást.
2. A jelenlegi Godot-projektben azonosítsd az aktív Akira/Miyako VN és CG assetútvonalait. Csinálj rövid assettérképet: meglévő/elfogadott, meglévő/eltérő, hiányzó. Ne nevezd újra vagy töröld tömegesen a fájlokat.
3. **Az Akira alap VN-portréhoz a csomag Akira egyalakos forrását**, Miyakóhoz a csomag eredeti fehér háttérmentes REVIEW kivágatát vedd vizuális kontrollnak. Ellenőrizd az alfa-élhibákat, túlméretezést és hogy azonos a szövegdoboz fölötti beállítás. Eredetit archiválj, a helyes forrás megléte nem jelenti automatikusan a jelenlegi integráció felülírását.
4. A korábbi téves, szemüveges/öltönyös Akira és új kinézetű Miyako CG-ket jelöld **REJECTED_FOR_CHARACTER_IDENTITY**, a munkafolyamatból zárd ki; a kódban csak akkor válts le képet, ha bizonyítottan eltérő és van helyette használható elfogadott asset.
5. A Godot LOCKED 2.5D cinematic pixel-art irányának megfelelően ne használj nyers anime PNG-t végleges játék-CG-ként: a karakterazonosság fix, a renderadaptáció külön feladat. Nincs kapkodó új imagegen-loop és nincs automatikus filteres „pixel-art véglegesítés”.
6. **Egyetlen ellenőrizhető próba:** az első Miyako-beszélgetés VN-beállítása, két eredeti karakterazonos portréval, 640×360 beállításban. Készíts előtte–utána screenshotot; az új jelenetszöveget, flageket, tartalmi unlockokat most ne módosítsd.
7. Egyelőre ne kezdj új narratív napokat, hosszas átfogó auditot vagy teljes grafikai remake-et. A képhibát javítsd célzottan, futtasd az érintett VN regressziós tesztet, és küldj konkrét eredményt.

**Kritikus:** a régi buszos/WASD-es leírások a később jóváhagyott autós+térképes döntéssel ütköznek, ezeket *csak az érintett irányítási/nyitási részben* kezeld felülírtnak. A falu LOCKED földrajza maradjon.

**Késznek jelenthető:** referenciák rögzítése, aktív assettérkép, egy kontrollált VN képi helyesbítés, érintett teszt, két screenshot. **Nem késznek jelenthető:** összes Miyako mimika, 23 CG, általános pixel-art renderkonverzió.
