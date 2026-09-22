# Akira Proxy v0.2

Az Akira proxy továbbra is BLOCKOUT, de már kifejezetten mozgás- és kamera-reviewra készült.

## Újdonságok v0.2

- részletesebb humanoid walk cycle;
- súlyáthelyezés és medencefordulás;
- váll/mellkas ellenmozgás;
- fejstabilizálás;
- lábfej/boka fázisok;
- külön kabátcsontok és másodlagos mozgás;
- WalkStart és WalkStop;
- GateReact és Lookout reakciók;
- Godot oldali lágy animation blending;
- mozgási sebességhez igazított walk playback;
- enyhe procedurális testdőlés.

## Újragenerálás Blenderben

1. Frissítsd a projektet a legújabb GitHub verzióra.
2. Blenderben menj a **Scripting** munkaterületre.
3. Nyisd meg: `tools/blender/create_akira_proxy.py`
4. Nyomd meg a **Run Script** gombot.

A script újragenerálja:

- `assets/characters/akira/proxy/akira_proxy.blend`
- `assets/characters/akira/proxy/akira_proxy.glb`

Ezután várd meg Godotban az új GLB importját, majd F5.

## Review

Most már ne csak azt nézd, hogy "mozog-e". Figyeld:

- van-e súlya a járásnak;
- természetes-e az indulás és a megállás;
- csúszik-e a láb;
- túl merev-e a törzs;
- forduláskor együtt él-e a test a mozgással;
- a kabát mozgása segít-e a sziluetten;
- a kamera mellett emberinek hat-e Akira mérete és tempója.

A proxy nem FINAL Akira. A cél most az, hogy a hegyi út teljes mozgásérzete értékelhető legyen emberi karakterrel.
