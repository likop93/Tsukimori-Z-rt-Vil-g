"""Extract chapter V through Shion's farewell, without running Ren'Py."""
import json, re, sys
from pathlib import Path
root = Path(__file__).resolve().parents[1]
source = Path(sys.argv[1]).read_text(encoding='utf-8-sig')
block = source.split('label canonical_html_chapter_5:',1)[1].split('    "Miyako akkor érkezett vissza',1)[0]
pattern = re.compile(r'\s*(?:(akira|shion)\s+)?("(?:[^"\\]|\\.)*")\s*$')
base = 'res://assets/opening/vn_portraits/'
scenes = {'canonical_bg_office':'','canonical_bg_shionsurprise':'res://assets/home_day2/shion_recognition_REVIEW.png','canonical_bg_childhoodvision':'res://assets/home_day2/shion_childhood_REVIEW.png','generated_cg_shion_farewell':'res://assets/home_day2/shion_farewell_REVIEW.png'}
ids = ['shion_arrival','shion_memory','shion_close']
choice_ids = [['join_melody','wait_melody'],['play_tape','ask_consent']]
segments = [dict(lines=[],choices=[]) for _ in ids]
segment = 0
in_menu = False
branch = None
expression = 'neutral'
cg = ''
for row in block.splitlines():
    if row.strip() == 'menu:':
        in_menu = True
        branch = None
        continue
    if in_menu and row.strip() and len(row)-len(row.lstrip()) == 4:
        segment += 1
        in_menu = False
        branch = None
    if in_menu and row.startswith('        "') and row.rstrip().endswith(':'):
        label = json.loads(row.strip()[:-1])
        branch = dict(id=choice_ids[segment][len(segments[segment]['choices'])],label=label,lines=[])
        segments[segment]['choices'].append(branch)
        continue
    if row.strip().startswith('scene '): cg = scenes.get(row.strip().split()[1],cg)
    if row.strip().startswith('show shion '): expression = row.strip().split()[2]
    match = pattern.fullmatch(row)
    if not match: continue
    text = json.loads(match[2])
    event = ''
    if text == 'Dr. Akira?': event = 'met_shion'
    elif text.startswith('Akira tudta, mire gondol.'): event = 'shion_eye_recognition_seen'
    elif text.startswith('A címkéjén két név'): event = 'shion_tape_found'
    elif text.startswith('A gyermek Akira sírt.'): event = 'shion_shared_memory_seen'
    if text.startswith('Shion felsikoltott.') or text.startswith('Shion arca megváltozott.'): expression = 'surprised'
    parts = []
    for word in text.split():
        if not parts or len(parts[-1])+len(word)+1 > 150: parts.append(word)
        else: parts[-1] += ' '+word
    target = branch['lines'] if in_menu else segments[segment]['lines']
    for i, part in enumerate(parts):
        line = dict(speaker={'akira':'Akira','shion':'Shion'}.get(match[1],''),text=part,expression=expression,cg=cg)
        if event and i == 0: line['event'] = event
        target.append(line)
for id, data in zip(ids,segments):
    data.update(id=id,source='canonical_html_story.rpy / chapter V through Shion farewell; original text wrapped only',portrait=True,portrait_speaker='Shion',portrait_side='left',portrait_facing='left',portrait_path=base+'shion_neutral_v1_REVIEW.png',akira_portrait_path=base+'akira_doctor_v1_REVIEW.png',portrait_variants={m:base+'shion_'+m+'_v1_REVIEW.png' for m in ['neutral','sad','surprised']})
    (root/'data/home_day2'/f'{id}.json').write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(id,len(data['lines']),'pages',len(data['choices']),'choices')
