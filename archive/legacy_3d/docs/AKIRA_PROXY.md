# Akira Proxy v0.2

Az Akira proxy továbbra is BLOCKOUT, de már kifejezetten mozgás- és kamera-reviewra készült.

## Két működési mód

### 1. Blender GLB — elsődleges
Ha jelen van:

`assets/characters/akira/proxy/akira_proxy.glb`

akkor a játék ezt tölti be, a teljes v0.2 animációs csomaggal.

### 2. Procedurális Godot fallback — hordozható
Ha egy friss GitHub ZIP-ben nincs benne a helyben generált GLB, a játék **nem tér vissza kapszulára**.

A Godot automatikusan felépít egy emberarányos Akira fallbacket:
- fej / haj;
- törzs;
- külön karok és lábak;
- térdhajlítás;
- hosszabb kabátsziluett;
- járási ciklus;
- kar-láb ellenmozgás;
- törzsfordulás;
- kabát-utómozgás;
- enyhe idle légzés;
- kapu- és kilátóponti fejreakció.

Így a projekt bármelyik gépen használható marad Blender futtatása nélkül is.

## Blender v0.2

A részletesebb proxy továbbra is újragenerálható:

1. Blender → **Scripting**
2. nyisd meg: `tools/blender/create_akira_proxy.py`
3. **Run Script**

A script létrehozza/frissíti:

- `assets/characters/akira/proxy/akira_proxy.blend`
- `assets/characters/akira/proxy/akira_proxy.glb`

Godot import után automatikusan a GLB veszi át a procedurális fallback helyét.

## Fontos

A procedurális fallback nem FINAL Akira és nem váltja ki a későbbi végleges karaktermodellt. Az a feladata, hogy friss GitHub ZIP-en, új számítógépen és CI/regression tesztben se jelenjen meg újra a régi „nudli” kapszula.
