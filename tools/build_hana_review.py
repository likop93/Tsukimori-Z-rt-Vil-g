"""Extract chapter IV's first Hana appointment without executing Ren'Py code."""
import argparse
import json
import re
from dialogue_portrait_staging import configure_hana
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument("source", type=Path)
args = parser.parse_args()
root = Path(__file__).resolve().parents[1] / "data/home_day2"
root.mkdir(exist_ok=True)
source = args.source.read_text(encoding="utf-8-sig")
chapter = source.split("label canonical_html_chapter_4:",1)[1].split("# --- Késő délután ---",1)[0]
rows = chapter.splitlines()
pattern = re.compile(r'\s*(?:(akira|hana|miyako)\s+)?("(?:[^"\\]|\\.)*")\s*$')
def extract(rows):
    result=[]
    mood="smile"
    for row in rows:
        expression=re.search(r"show hana (smile|neutral|sad)",row)
        if expression:
            mood=expression[1]
        match = pattern.fullmatch(row)
        if not match:
            continue
        speaker={"akira":"Akira","hana":"Hana","miyako":"Miyako"}.get(match[1],"")
        text=json.loads(match[2])
        # Split at sentence boundaries and then words, retaining all source text.
        parts=re.split(r"(?<=[.!?])\s+(?=[A-ZÁÉÍÓÖŐÚÜŰ„])",text)
        part=""
        for sentence in parts:
            for word in sentence.split():
                if len(part)+len(word)+1 > 165:
                    result.append(dict(speaker=speaker,text=part,expression=mood))
                    part=""
                part=(part+" "+word).strip()
        if part:
            result.append(dict(speaker=speaker,text=part,expression=mood))
    return result
menus=[i for i,row in enumerate(rows) if row.strip()=="menu:"]
groups=[]
cursor=0
for number,start in enumerate(menus):
    stop=start+1
    while stop<len(rows) and (not rows[stop].strip() or len(rows[stop])-len(rows[stop].lstrip())>4):
        stop+=1
    choices=[]
    labels=[i for i in range(start+1,stop) if re.fullmatch(r'        ".*":',rows[i])]
    ids=["ask_body","let_lead"] if number==0 else ["recall","wait"]
    for n,i in enumerate(labels):
        end=labels[n+1] if n+1<len(labels) else stop
        effects=[row.strip() for row in rows[i+1:end] if row.strip().startswith("$") and not row.strip().startswith("$renpy.notify")]
        original_label=json.loads(rows[i].strip()[:-1])
        labels_ui=["Rákérdezek, mit akar a saját testétől.","Figyelem, merre vezeti a beszélgetést."] if number==0 else ["Egy konkrét emlékről kérdezem.","Nem sürgetem, hagyom dönteni."]
        choices.append(dict(id=ids[n],label=labels_ui[n],source_label=original_label,lines=extract(rows[i+1:end]),source_effects=effects))
    groups.append((extract(rows[cursor:start]),choices))
    cursor=stop
groups.append((extract(rows[cursor:]),[]))
for name,(lines,choices) in zip(["hana_arrival","hana_memory","hana_close"],groups):
    data=dict(id=name,source="canonical_html_story.rpy / chapter IV first appointment; PDF pages 16–26",portrait=True,portrait_speaker="Hana",portrait_path="res://assets/opening/vn_portraits/hana_neutral_v1_REVIEW.png",lines=lines,choices=choices)
    data["portrait_variants"]={"smile":data["portrait_path"],"neutral":"res://assets/opening/vn_portraits/hana_guarded_v1_REVIEW.png","sad":"res://assets/opening/vn_portraits/hana_guarded_v1_REVIEW.png"}
    if name=="hana_arrival":
        data["met_at_line"]=next(i for i,line in enumerate(lines) if line["speaker"]=="Hana")
    configure_hana(data)
    (root/(name+".json")).write_text(json.dumps(data,ensure_ascii=False,indent=2)+"\n",encoding="utf-8")
    print(name,len(lines),"choices",len(choices))
tail=source.split("# --- A visszatért füzet ---",1)[1].split("label canonical_html_chapter_4:",1)[0]
split=tail.index("# --- Néhány nappal később ---")
for name,part in [("night_notebook",tail[:split]),("morning_hana",tail[split:])]:
    data=dict(id=name,portrait=False,source="canonical_html_story.rpy / chapter III ending; PDF before chapter IV",lines=extract(part.splitlines()))
    (root/(name+".json")).write_text(json.dumps(data,ensure_ascii=False,indent=2)+"\n",encoding="utf-8")
    print(name,len(data["lines"]))
