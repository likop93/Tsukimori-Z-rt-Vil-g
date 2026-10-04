# Szoba és rendelő — VN-megjelenítés

2026-10-04. Tulajdonosi visszajelzés: az új hátterek jók VN-hez, de a mozgatható Akira aránya természetellenesen kicsi bennük. A tulajdonos engedélyezte az irányítás kivételét vagy más játszható tér készítését. A képeket megtartjuk és VN-háttérként használjuk.

Ez a változás felülírja a FIRST_NIGHT_IMPLEMENTATION_REVIEW.md és FIRST_DAY_IMPLEMENTATION_REVIEW.md korábbi, szobai/rendelői járásra és koordinátához kötött E-interakciókra vonatkozó leírását.

## Megjelenítés és kezelés

Akira szobájában nincs járó sprite vagy WASD-vezérlés. Az ablak, táska, fénykép, lefekvés és nappaliba visszalépés külön gombbal választható. Egér vagy fel/le és Enter kezeli őket. A fényképet kihagyó lefekvés továbbra is bemutatja a személyes nyomot.

A rendelőben ugyanez a kezelés indítja sorban az első/második konzultációt, a nap összegzését és az esti visszatérést. A reggeli és esti háttér előtt sem jelenik meg a kicsi járó Akira. Az esti visszatérés közvetlenül a Miyako VN-be vezet.

Az eredeti, korábban jóváhagyott Village Street/híd/ház és az első benti nappali-sáv játékosvezérelt marad. A szobai Vissza a nappaliba gomb ugyanebbe a meglévő sávba vezet; annak jobb szélén E visszavisz a VN-szobába. A szoba/rendelő képei nem új méretarányos pályák.

A menü szüneteltetése és a párbeszédek nyugtázása megmarad. A frissen megjelenő interakciós gombok csak az előző Enter/Space/E/kattintás elengedése után aktiválódnak; az utolsó mondat továbblépése nem választ ki véletlenül új műveletet.

## Történet és assetek

Szövegek, választáshatások, konzultáció-sorrend, clue-flag-ek és a Hana záróhang változatlanok. LOCKED karakterdizájnt nem módosítottunk. A képek REVIEW státuszban maradnak.

A két páciensportré, fénykép-CG és production hangok korábbi hiánya változatlan. Későbbi járható szoba/rendelő külön, az Akira sprite méretéhez és kamerájához tervezett háttérre/rétegekre szorul; a mostani képeket nem kell eldobni.

## Ellenőrzés

night_day_regression: teljes éjszaka–első nap két döntési ágon, valódi Enterrel választott interakciók, WASD nem mozgat rejtett Akirát a szobában, nincs járó sprite a rendelőben és esti VN-ben, nappali oda-vissza, egyszeri történeti hatások és külön lezárások.

interior_regression: meglévő házbelépés és mindkét választás, Miyako melletti átjárás, VN-szobába lépés, lefekvés és fényképes fallback. REVIEW képek: night_room_REVIEW.png, clinic_REVIEW.png, morning_REVIEW.png.
