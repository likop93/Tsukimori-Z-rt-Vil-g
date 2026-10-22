# TSUKIMORI — EGYSÉGES VIZUÁLIS ALAP V4
**Dátum:** 2026-10-20  
**Rendeltetés:** egyetlen, világos vizuális kiindulópont a GitHub/Work Godot implementációhoz; felesleges újratervezés megakadályozása.  
**Státusz:** eredeti karakterazonosság elfogadott, a közös végleges pixel-art render NEM készült el.

## Nyisd meg először
1. `03_EGYSÉGES_VIZUÁLIS_SZABVÁNY.md` — mit szabad és mit nem.
2. `preview_eredeti_par.html` — a két eredeti karakter **módosítás nélküli** képi összevetése ugyanazon képernyőn; bármely böngészőben nyitható.
3. `04_WORK_EGYETLEN_UTASITAS.md` — a Work által elvégzendő, rövid feladat.
4. `05_KÉPI_ELFOGADÁSI_TESZT.md` — objektív ellenőrzőlista.

## Van kész ábra, de nincs új arc
- `AKIRA_01_TULAJDONOSI_EGYALAKOS.png` — az általad jóváhagyott eredeti, szemüveg nélküli Akira, a játék egyalakos forrása.
- `AKIRA_02_TULAJDONOSI_KARAKTERLAP.png` — ugyanennek az Akirának többnézetű forrása; **a lapon lévő karakterbemutató szövegek nem új történeti kánonok**.
- `MIYAKO_01_TULAJDONOSI_EREDETI.jpeg` — az általad feltöltött, sötét ruhás eredeti Miyako.
- `MIYAKO_02_EREDETIBOL_KIVAGOTT_VN_REVIEW.png` — ugyanabból készült automatikus háttéreltávolítás. Nem új nő, de az alfa szélek még REVIEW.

**Minden eredeti karakterforrás változatlan bitekkel másolva.** A fájlok SHA-256 hash-e és képmérete külön manifestben ellenőrizhető.

## Nem tartalmazza
- nem tartalmaz új vagy kész, 100%-ban egységesített pixel-art karakterpárt;
- nem tartalmaz kész új Miyako-arckifejezéseket;
- nem tartalmaz kész 23 új filmes CG-t;
- nem nyúl a Godot-repóhoz és nem állítja, hogy bármelyik új fájl már be van építve.

## Miért kell így?
Eddig a karakteres CG-generálás gyakran szemüveges vagy öltönyös Akirát, illetve teljesen más Miyakót készített. A közvetlen felhasználói forrásokat rögzítjük, és nem készítünk helyettesítő arcot.

## Vizuális stílus
A GitHub `docs/PIXEL_ART_PRODUCTION_DIRECTION.md` LOCKED: **filmes, részletgazdag 2.5D pixel-art**, lehetséges első teszt 640×360 canvas. A feltöltött nagyfelbontású portrék **identitásreferenciák**; puszta átméretezés vagy pixel-szűrő nem jelent teljes, végleges stílusharmonizációt.
