"""Read canonical text without executing the source."""
import json, re, sys
from pathlib import Path
root = Path(__file__).resolve().parents[1]
source = Path(sys.argv[1]).read_text(encoding='utf-8-sig')
block = source.split('# --- Az éjszakai látogató ---', 1)[1].split('jump canonical_html_chapter_5', 1)[0]
pattern = re.compile(r'\s*(?:(akira|miyako)\s+)?("(?:[^"\\]|\\.)*")\s*$')
lines = []
cg = 'res://assets/home_day1/akira_room_REVIEW.png'
for row in block.splitlines():
    if 'scene canonical_bg_akiradreampool' in row: cg = 'res://assets/home_day2/night_dream_pool_REVIEW.png'
    elif 'scene canonical_bg_night' in row: cg = 'res://assets/home_day1/akira_room_REVIEW.png'
    elif 'scene canonical_bg_office' in row: cg = 'res://assets/home_day1/clinic_REVIEW.png'
    elif 'scene canonical_bg_shionpondnight' in row: cg = 'res://assets/home_day2/shion_pond_night_REVIEW.png'
    match = pattern.fullmatch(row)
    if not match: continue
    text = json.loads(match[2])
    if match[1] == 'miyako': cg = ''
    event = ''
    if text.startswith('A víz közepén'): event = 'dream_pool'
    elif text.startswith('A rendelő ajtaja'): event = 'wet_notebook'
    elif text.startswith('Akira széthúzta'): event = 'visitor_seen'
    elif text == 'Shion.': event = 'visitor_named'
    elif text.startswith('Katsuróé volt.'): event = 'appointment'
    parts = []
    for word in text.split():
        if not parts or len(parts[-1])+len(word)+1 > 150: parts.append(word)
        else: parts[-1] += ' '+word
    for i, part in enumerate(parts):
        line = dict(speaker={'akira':'Akira','miyako':'Miyako'}.get(match[1],''),text=part,cg=cg,expression='worried')
        if cg in ['res://assets/home_day1/akira_room_REVIEW.png','res://assets/home_day1/clinic_REVIEW.png']:
            line['cg_tint'] = '#6b7aa3'
        if event and i == 0: line['event'] = event
        lines.append(line)
base = 'res://assets/opening/vn_portraits/'
data = dict(id='night_visitor',source='canonical_html_story.rpy / chapter IV / Az éjszakai látogató; original text, wrapped only',portrait=True,portrait_speaker='Miyako',portrait_side='left',portrait_facing='left',portrait_path=base+'miyako_worried_v1_REVIEW.png',akira_portrait_path=base+'akira_neutral_v1_REVIEW.png',lines=lines)
(root/'data/home_day2/night_visitor.json').write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(len(lines),'night visitor pages')
