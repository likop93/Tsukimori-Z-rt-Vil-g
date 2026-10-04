"""Apply REVIEW expression cues without altering dialogue or choices."""
import json
from pathlib import Path

BASE = "res://assets/opening/vn_portraits/"

def all_lines(data):
    yield from data.get("lines", [])
    for choice in data.get("choices", []):
        yield from all_lines(choice)

def configure_hana(data):
    data["portrait_side"] = "left"
    data["portrait_variants"] = {
        "smile": BASE + "hana_neutral_v1_REVIEW.png",
        "neutral": BASE + "hana_guarded_v1_REVIEW.png",
        "sad": BASE + "hana_sad_v1_REVIEW.png",
        "surprised": BASE + "hana_surprised_v1_REVIEW.png",
        "warm": BASE + "hana_warm_v1_REVIEW.png",
    }
    # Source expressions remain the baseline. Additional visual cues are REVIEW.
    for line in all_lines(data):
        text = line["text"]
        if "Hana tekintete először vált bizonytalanná" in text or "Hana szeme egy pillanatra megremegett" in text or "egy név rajzolódott ki" in text:
            line["expression"] = "surprised"
        elif "Legközelebb is jöhetek?" in text or "Megvárta, amíg a nő légzése megnyugszik" in text:
            line["expression"] = "warm"
    return data

def apply(root):
    for path in (root / "data").glob("**/*.json"):
        data = json.loads(path.read_text(encoding="utf-8-sig"))
        if not isinstance(data, dict) or "lines" not in data:
            continue
        changed = False
        if data.get("portrait_speaker") == "Hana":
            configure_hana(data)
            changed = True
        elif path.stem in ("patient_1", "patient_2"):
            n = path.stem[-1]
            data.pop("portrait_square", None)
            data.update(portrait=True, portrait_speaker="Páciens", portrait_trim=True,
                        portrait_side="left", portrait_path=BASE + f"patient_{n}_neutral_v1_REVIEW.png")
            data["portrait_variants"] = {m: BASE + f"patient_{n}_{m}_v1_REVIEW.png" for m in ("neutral", "sad", "surprised", "warm_smile", "thoughtful", "smile")}
            for line in all_lines(data):
                if line["speaker"] == "Páciens":
                    line["expression"] = "sad"
                    if "köszönöm" in line["text"].lower():
                        line["expression"] = "warm_smile"
                    elif "Nem tudom" in line["text"] or "Néha" == line["text"].strip("."):
                        line["expression"] = "thoughtful"
                    elif "Ez nem önzőség?" in line["text"] or "Nem akar marasztalni?" in line["text"]:
                        line["expression"] = "surprised"
            changed = True
        elif data.get("portrait", True) and any(line["speaker"] == "Miyako" for line in all_lines(data)):
            data["portrait_side"] = "left"
            data["portrait_variants"] = {"neutral": BASE + "miyako_cutout_v1_REVIEW.png", **{m: BASE + f"miyako_{m}_v1_REVIEW.png" for m in ("warm", "worried", "surprised")}}
            for line in all_lines(data):
                if line["speaker"] != "Miyako":
                    if "nem leszel egyedül" in line["text"].lower() or line["text"] == "Csak ketten?" or "Milyen nyelven beszéltek" in line["text"]:
                        line["expression"] = "surprised"
                    continue
                text = line["text"].lower()
                line["expression"] = "neutral"
                if any(word in text for word in ("fél", "hallgattak", "nem láttam", "másnak szólt")):
                    line["expression"] = "worried"
                elif any(word in text for word in ("fáradt", "vártam", "jó reggelt", "örülök", "köszönöm")):
                    line["expression"] = "warm"
                elif "ezért" in text or "nem kell" in text:
                    line["expression"] = "surprised"
                cues = {
                    "most még ne": "worried", "ideges vagy": "worried",
                    "nem is annak szántam": "warm", "mindkettőnek": "warm",
                    "csak ketten": "surprised", "első napra elég": "warm",
                    "hajnalig ült": "worried", "ezt már nem mondta": "worried",
                    "talán azt várta": "worried", "én ebben nőttem": "worried",
                    "nem lesz": "warm", "ez az, amitől": "worried",
                }
                for cue, mood in cues.items():
                    if cue in text:
                        line["expression"] = mood
            if path.stem == "morning":
                data["lines"][-1]["expression"] = "warm"
                for choice in data.get("choices", []):
                    choice["lines"][0]["expression"] = "warm" if choice["id"] == "stay" else "worried"
            changed = True
        if changed:
            path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

if __name__ == "__main__":
    apply(Path(__file__).resolve().parents[1])
