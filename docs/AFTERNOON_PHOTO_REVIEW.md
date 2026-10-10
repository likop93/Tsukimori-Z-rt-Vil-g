# Late afternoon and missing photograph — 2026-10-10 REVIEW

Hana's ending card now offers an explicit continuation into the existing chapter IV
late-afternoon Miyako scene. Input must be released before the button is enabled.
34 pages preserve the original narration/dialogue, ending before The Night Visitor.
Extractor: `tools/build_afternoon_review.py`; source is the owner's local
`canonical_html_story.rpy`. No source code is executed and no source file edited.

Miyako stays left, medical-outfit Akira right, facing inward. Notebook event uses
a clean CG with closed windows; portraits return for the wrist event. Mark and
notebook flags appear at their lines; completion only at the end. No invented
choices, relationship points or automatic Shion jump.

First-night photo placeholder replaced with an actual Akira–Katsuro paper print.
Katsuro lacks an approved facial reference in the inspected repository, so his
depiction is explicitly provisional REVIEW, not a character design lock.

Assets:
- `assets/home_day1/akira_katsuro_photo_v1_REVIEW.png`
- `assets/home_day2/notebook_awakening_v1_REVIEW.png`

Remaining: approved Katsuro design, dedicated wrist-mark/hand-contact CG and
recorded whisper/laughter, then the original Night Visitor scene. Existing subtle
wood sound is used for the floor knock; no fabricated voice recording.

## Generation

Provider: built-in ImageGen. Originals retained in Codex generated_images.
Photo reference: `assets/opening/reference/AKIRA_FINAL_CHARACTER_DESIGN_V1.png`.
Exact photo prompt:

Create a single landscape 16:9 illustration of an old personal photograph showing two adult Japanese male doctors, Akira and Katsuro, standing side by side in an unidentifiable softly blurred neutral setting. Akira on the left MUST preserve the approved reference's exact black tousled hair, face and adult proportions, wearing his simple dark jacket and gray shirt. Katsuro on the right is a provisional REVIEW depiction, slightly older-looking adult colleague in a plain dark blazer and light shirt, dark short hair, his face partly shaded by gentle photographic fading rather than a dramatic mystery mask. Friendly restrained expressions, natural shoulders, chest-up framing with hands entirely outside the photograph. No invented date, place, written caption, badges or supernatural clues. Render a tangible lightly faded paper print with narrow worn cream margins, softly warm sepia colors while retaining Akira's identity, in finely detailed cinematic pixel-art illustration compatible with Tsukimori VN. The photograph fills the frame. Exactly two men. No UI, no text, no surrounding desk, no elaborate photo frame. This is a review memory image, not a definitive Katsuro character sheet.

Notebook references: local Ren'Py `images/imported/rework/katsuro_notebook_awakening_reworked.png`
and `assets/home_day1/clinic_REVIEW.png`. Initial exact prompt:

Create a REVIEW story insert for Tsukimori using image 1 as notebook-event composition reference and image 2 as approved clinic architecture and cinematic pixel-art style reference. A close view of Katsuro's plain open notebook on the clinic wooden desk, pages lifting by themselves, a dark wet spreading stain and a fine crack across one page. There is NO legible name, no readable text, no face or character. ALL windows and exterior doors seen in the background must be fully CLOSED, cool late afternoon light through closed panes, warm amber desk lamp, bookshelf and medical charts consistent with image 2. Fine crisp pixel clusters like image 2, not photorealistic. Keep book and wet cracked page in the middle upper two thirds of the landscape 16:9 composition; lower quarter reserved for dialogue overlay. Restrained uncanny atmosphere, no explosive flying detached sheets. Do not copy image 1's open window or realistic rendering.

The initial result incorrectly included a UI panel. Exact corrective prompt:

Edit ONLY the bottom quarter of this image: remove the entire decorative dialogue box, its frame, floral decorations and dark rectangle. Replace it with the uninterrupted wooden desk surface continuing naturally from above. This must be a clean full-bleed background CG with NO UI, NO borders, NO panels, NO text overlays. Keep notebook, stain, closed windows and clinic exactly as they are.
