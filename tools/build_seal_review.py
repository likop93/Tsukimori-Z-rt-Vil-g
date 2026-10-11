"""Extract the end of chapter V without executing source code."""
import json, re, sys
from pathlib import Path
root=Path(__file__).resolve().parents[1]
source=Path(sys.argv[1]).read_text(encoding='utf-8-sig')
block='    "Miyako akkor érkezett vissza'+source.split('    "Miyako akkor érkezett vissza',1)[1].split('    jump canonical_html_chapter_6',1)[0]
pattern=re.compile(r'\s*(?:(akira|miyako|a_melybol_szolo_hang)\s+)?("(?:[^"\\]|\\.)*")\s*$')
lines=[]
cg=''
for row in block.splitlines():
    match=pattern.fullmatch(row)
    if not match: continue
    text=json.loads(match[2])
    event=''
    if text.startswith('Miyako a kazettához lépett'): cg='res://assets/home_day2/seal_cassette_REVIEW.png'
    elif text.startswith('Ezt kereste.'): cg=''
    elif text == 'A tiédet.': event='akira_seal_revealed'
    elif text.startswith('Oto nem tud írni.'): event='invitation_authorship_questioned'
    elif text == 'Én.': event='katsuro_voice_shared'
    elif text.startswith('A rendelő ajtaja magától'): cg='res://assets/home_day2/seal_cassette_REVIEW.png'; event='tape_awakened'
    elif text == 'Ne hallgasd.': cg=''
    elif text.startswith('De már késő volt.'): cg='res://assets/home_day2/seal_fan_vision_REVIEW.png'; event='seal_fan_vision_seen'
    elif text.startswith('A látomás megszűnt.'): cg=''
    elif text.startswith('Miyako tekintetében'): event='akira_right_eye_green'
    elif text.startswith('Az asztalon fekvő fekete kő pedig'): event='seal_stone_split'
    parts=[]
    for word in text.split():
        if not parts or len(parts[-1])+len(word)+1>150: parts.append(word)
        else: parts[-1]+=' '+word
    for i,part in enumerate(parts):
        line=dict(speaker={'akira':'Akira','miyako':'Miyako','a_melybol_szolo_hang':'Hang a mélyből'}.get(match[1],''),text=part,cg=cg,expression='worried')
        if i==0 and event: line['event']=event
        lines.append(line)
base='res://assets/opening/vn_portraits/'
data=dict(id='miyako_seal',source='canonical_html_story.rpy / end of chapter V; unchanged text, wrapped only',portrait=True,portrait_speaker='Miyako',portrait_side='left',portrait_facing='left',portrait_path=base+'miyako_worried_v1_REVIEW.png',akira_portrait_path=base+'akira_doctor_v1_REVIEW.png',lines=lines)
(root/'data/home_day2/miyako_seal.json').write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(len(lines),'seal pages')
