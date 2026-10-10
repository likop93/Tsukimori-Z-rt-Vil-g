"""Extract the existing late-afternoon scene as text, never execute source code."""
import argparse
import json
import re
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument('source', type=Path)
args = parser.parse_args()
source = args.source.read_text(encoding='utf-8-sig')
block = source.split('label canonical_html_chapter_4:', 1)[1].split('# --- Késő délután ---', 1)[1].split('# --- Az éjszakai látogató ---', 1)[0]
lines = []
pattern = re.compile(r'\s*(?:(akira|miyako)\s+)?("(?:[^"\\]|\\.)*")\s*$')
for row in block.splitlines():
    match = pattern.fullmatch(row)
    if not match:
        continue
    text = json.loads(match[2])
    parts = []
    for word in text.split():
        if not parts or len(parts[-1]) + len(word) + 1 > 150:
            parts.append(word)
        else:
            parts[-1] += ' ' + word
    for i, part in enumerate(parts):
        line = dict(speaker={'akira':'Akira','miyako':'Miyako'}.get(match[1],''), text=part, expression='worried')
        if i == 0:
            if text.startswith('A szoba ismét lehűlt'):
                line['cg'] = 'res://assets/home_day2/notebook_awakening_v1_REVIEW.png'
                line['event'] = 'notebook_awakening'
            elif text.startswith('Akira csuklója égetni'):
                line.update(cg='', event='wrist_mark')
            elif text.startswith('Miyako mozdulata megállt') or text.startswith('Miyako arca elsápadt'):
                line['expression'] = 'surprised'
            elif text.startswith('A ház alatt halk koppanás'):
                line['event'] = 'knock'
            elif text.startswith('Odakint elállt az eső'):
                line['event'] = 'window_whisper'
        lines.append(line)
base = 'res://assets/opening/vn_portraits/'
data = dict(id='miyako_afternoon', source='canonical_html_story.rpy / chapter IV / Késő délután; text unchanged, wrapped only', portrait=True, portrait_speaker='Miyako', portrait_side='left', portrait_facing='left', portrait_path=base+'miyako_worried_v1_REVIEW.png', akira_portrait_path=base+'akira_doctor_v1_REVIEW.png', portrait_variants={m:base+'miyako_'+m+'_v1_REVIEW.png' for m in ['worried','surprised','warm']}, lines=lines)
(Path(__file__).resolve().parents[1]/'data/home_day2/miyako_afternoon.json').write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(len(lines), 'afternoon pages')
