# macOS tesztcsomag — 2026-10-12

Forrás: a jóváhagyott `f233c78` karaktergaléria-verzió tiszta ZIP-je.
Kimenet: `Tsukimori-macOS-Character-Gallery-2026-10-12.zip`.

Kicsomagolás után a `Tsukimori.app` áthúzható az Alkalmazások mappába.
Nem kell hozzá Godot. A ZIP mellékelt `OLVASS_EL_MAC.txt` fájlja tartalmazza
a telepítést és a korlátokat.

Godot 4.7.2, Universal2 (Intel x86_64 és Apple Silicon arm64), ad-hoc aláírás.
Apple-notarizáció nincs; a macOS kérhet alkalmazásonkénti megnyitási engedélyt.
Útmutató: https://docs.godotengine.org/en/4.7/tutorials/export/running_on_macos.html

Ellenőrzés: sértetlen ZIP; `Tsukimori.app` és plist; két Mach-O architektúra;
végrehajtható fájlmód; aláírásfájl jelenléte; a csomagolt játékadatok Godot
indulása Windows alatt. Natív Macen nem történt futtatás vagy aláírásellenőrzés.

Az export tiszta staging másolatban történt. A helyi, korábban módosított
`export_presets.cfg` megmaradt. A futáskor használt `assets/opening/reference/`
képeket bele kell foglalni az exportba; a repo exportmintája ennek megfelelően javítva.

A csomag a kért jóváhagyott állapotot rögzíti. Az ezt követően készült
sétálható falubejárás külön Godot-projekt REVIEW csomagban található.
