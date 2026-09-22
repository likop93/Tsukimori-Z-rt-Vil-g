# Akira Proxy v0.1

Ez a lépés azért került a Mountain Path Blockout 2.0 elé, mert a kamera és a mozgás érzetét egy kapszula/tojás alapján nem érdemes véglegesíteni.

## Cél

Az Akira proxy **nem végleges karaktermodell**. Emberarányos greybox, amelyen már megítélhető:

- a karakter képernyőn elfoglalt mérete;
- a kamera magassága és távolsága;
- a járási sebesség;
- a test fordulása;
- a láb- és karmozgás olvashatósága;
- a jelenlegi fix világirányú WASD játékérzete;
- az ösvény és a kamera kompozíciója.

A proxy kb. 1,82 m magas, felnőtt férfi arányú, karcsú-atletikus sziluettel. Egyszerű hosszú kabáttömeget, fekete hajtömeget és visszafogott sötét/smaragd színjeleket használ.

## Elkészítés Blenderben

1. Frissítsd a projektet a legújabb GitHub verzióra.
2. Indítsd el a Blendert.
3. Menj a **Scripting** munkaterületre.
4. Nyisd meg: `tools/blender/create_akira_proxy.py`
5. Nyomd meg a **Run Script** gombot.

A script a `project.godot` alapján automatikusan megkeresi a Tsukimori projekt gyökerét, és létrehozza:

- `assets/characters/akira/proxy/akira_proxy.blend`
- `assets/characters/akira/proxy/akira_proxy.glb`

A Blender-fájlban három alap animáció készül: **Idle, Walk, Run**.

## Godot

A Player scene most már tartalmaz egy proxy-loadert. Ha az `akira_proxy.glb` még nincs jelen, a régi kapszula látszik és a projekt továbbra is működik.

Amint a GLB létrejön a fenti helyen, Godot import után automatikusan:

- elrejti a kapszulát;
- betölti az Akira proxyt;
- álló helyzetben Idle animációt használ;
- mozgás közben Walk animációt használ.

A Run animáció egyelőre csak elő van készítve; futásrendszert most nem vezetünk be.

## Review

F5 után először **nem a modell szépségét** értékeljük. A kérdések:

- jó-e Akira mérete a képen;
- túl gyorsnak vagy lassúnak érződik-e a 4.2 m/s;
- természetes-e a kamera követési távolsága;
- működik-e a jelenlegi világirányú WASD emberi járással is;
- a kameraváltások alatt olvasható marad-e a test;
- kell-e közelebb vagy távolabb vinni a kamerát.

Csak ezután folytatjuk a Mountain Path Blockout 2.0 kompozícióját.

**Státusz: BLOCKOUT / REVIEW. A proxy semmilyen eleme nem válik automatikusan FINAL assetté.**
