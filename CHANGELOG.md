# Changelog — federicoroscioli.com (personal site)

All notable changes to the site are recorded here: the feature or bug, the exact
change, what was verified, and the downstream impact.

## 2026-11-18

### CVs refreshed from the updated Overleaf sources
- **Request:** update the CVs on the website (the Overleaf sources were edited again on 2026-11-18).
- **Change:** `assets/docs/academic.pdf` (4 pages) and `assets/docs/business.pdf` (2 pages) replaced with PDFs
  recompiled from `cv_academic_en.tex` and `cv_business_en.tex` (`latexmk -pdf`, compiled under names without
  underscores). Previous PDFs archived in `old/2026-11-18_prima-di-aggiornare-cv/` (project root, outside this repo).
  `SITO.md` and the HTML are unchanged: the links already point to these two files.
- **Verified:** both compile with exit 0 and keep the same page count; word-level diff against the previous PDFs shows
  the new text (COIN Web App line, Python for Everybody course in the academic CV; Claude Code, certifications and
  COIN lines, reworded bullets in the business CV).
- **Impact:** after `aggiorna_sito.command` the Research page ("CV (PDF)", "Download my academic CV") and the menu
  "CV" link serve the new files. Browsers may cache the old PDFs for a short while.

## 2026-11-16

### CVs updated, Storytelling page removed, working-paper titles corrected
- **Request:** update the CVs on the site, remove the Storytelling page and its menu links, and fix the titles of the
  papers listed under "Work in Progress".
- **Change:**
  - `assets/docs/academic.pdf` and `business.pdf` replaced with PDFs compiled from the current Overleaf sources
    (`cv_academic_en.tex`, `cv_business_en.tex`; compiled locally with latexmk). The academic CV gains a "Reports and
    Technical Guidelines" section; the business CV has a rewritten profile and updated JRC entries. Previous versions
    archived in `Sito 2026/old/2026-11-16_prima-di-cv-e-storytelling/`.
  - Local clone synced to GitHub (it was 8 commits behind: the online upload of `academic.pdf`/`business.pdf`, link
    changes, removal of `ROF_cv.pdf`). `SITO.md` now carries those links (`cv:` and the Research sidebar/intro link),
    so the online-edit check is not triggered by them.
  - Storytelling removed: `storytelling.html` deleted (`git rm`), entry removed from the menu and the home link row
    (both come from `SITO.md → Navigation`), `## Storytelling` section removed from `SITO.md`; `02_genera_sito.py` no
    longer requires that section or the page (now three pages: home, research, photography); `aggiorna_sito.sh` no longer
    opens it. The address `/storytelling.html` will return 404.
  - "Work in Progress" titles taken from the latest drafts listed in the academic CV: *The Impact of Internal
    Colonisation on Land Condition in Uruguay*; *Greener on the Other Side: Environmental Policy Diffusion through U.S.
    Economic Regions*; *A Distributional Emissions Account for Italy: Carbon Footprints by Consumption, Income, and
    Wealth*. Replaces "Gendering the Land…" and "Emissions inequality: evidence from household survey data".
  - Generator markers re-inserted in the three pages after the sync (the earlier uncommitted conversion had been put
    aside with `git stash` to pull).
- **Verified:** on a scratch copy, regenerating the three pages from the new `SITO.md` differs from the current pages
  only by the intended changes (Storytelling links gone, new working-paper titles) plus the three known cosmetic
  differences (Research intro link style moved to CSS, Calais alt-text dash, one HTML comment); no mention of
  Storytelling left in the output, no broken local links. CV PDFs compile cleanly (academic 4 pages, business 2, same
  as the previous versions) and the text diff against the online PDFs shows the intended content updates.
- **Impact:** at the first run of `aggiorna_sito.command` these changes go live. That run has no stored "last
  generation" copy yet, so it will not check for online edits. Anyone with the old `/storytelling.html` link gets a 404.
  Local LaTeX may wrap lines slightly differently from Overleaf.

## 2026-10-20

### Single source `SITO.md` + one-click update command (same approach as MRSS)
- **Feature:** site text (menu, footer, email, CV paths, home bio, Research page,
  Photography projects, Storytelling) was copy-pasted across four HTML pages, so one
  change (e.g. the MRSS link fix) meant several edits and commits. Wanted a single
  markdown file feeding the site, plus a script/command that updates and publishes it,
  like the MRSS project.
- **Change:**
  - New, outside this repo (in `Sito 2026/`, so they are not published):
    `SITO.md` (the only file to edit; format rules in its header),
    `codice/02_genera_sito.py` (rewrites the generated parts of the pages),
    `codice/01_ottimizza_foto.sh` (resizes new/changed originals from `foto/` into
    `assets/photos-web/`, only if newer than the existing copy),
    `aggiorna_sito.sh` (pull -> photos -> generate -> show changes -> commit/push),
    `aggiorna_sito.command` (double-click wrapper around the `.sh`).
  - The four pages now carry `<!-- BEGIN:name --> ... <!-- END:name -->` markers around
    the generated parts (meta, nav, footer, home hero, Research header/keywords/work in
    progress/publications/experience/teaching/sidebar, Photography header/project
    menu/projects, Storytelling placeholder). Only comment lines were added; CSS, the
    slideshow/lightbox script and the profile photo stay hand-written.
  - `research.html`: added `.hero p a { ... }` to the CSS (same rule `index.html` has),
    so the intro link no longer needs an inline `style=`.
  - Photo count per project is read from the files in `assets/photos-web/`
    (`prefixNNN.jpg`, must be consecutive); video poster is `assets/video-thumbs/ID.jpg`.
  - Online-edit protection: the generator keeps a copy of the last `SITO.md` it used
    (`codice/ultima_generazione/`), recomputes the old output from it, and stops (exit 3,
    shows the differing lines) if a generated part was edited outside `SITO.md`;
    `--forza` / typing "sovrascrivi" overrides. No alarm if the edit was already copied
    into `SITO.md`, and the photo count is ignored in the comparison (it comes from disk).
  - Originals archived before the change: `Sito 2026/old/2026-10-20_html-prima-di-SITO-md/`.
  - Local clone fast-forwarded to `55fb870` first (it was 10 commits behind the online
    edits: new bio, gmail address, MRSS link, `CV_ROF.pdf` / `CV_academia.pdf`); `SITO.md`
    was seeded from that live content, so none of those online edits are lost.
- **Verified:** on scratch copies only (nothing real was regenerated or published):
  round trip (markers in the live pages, regenerate from `SITO.md`, diff) reproduces the
  live content apart from three cosmetic differences listed below; md edits reach exactly
  the right lines/pages; renaming a menu item updates all four pages (nav + home row);
  adding a photo and adding a project work; error messages for missing field, wrong field
  count, missing section/part, missing/non-consecutive photos, unknown marker; full
  `aggiorna_sito.sh` runs against a local bare repo (no change, decline to publish then
  publish, online edit outside and inside generated parts, stop persisting across runs,
  "sovrascrivi" path). Bug found and fixed during testing: adding a photo triggered a
  false "edited online" alarm (photo count comes from disk, not from `SITO.md`).
- **Impact:** the first run of `aggiorna_sito.command` will show these changes in the
  pages (rendering is identical): (1) Research intro link: inline `style=` replaced by the
  CSS rule; (2) Calais slideshow `data-label` (alt text) uses an en dash like the title;
  (3) HTML comment `<!-- 2. SE TI MUOVI -->` becomes `<!-- 2. PARKINSON -->`; plus trailing
  whitespace removed. That first run has no "last generation" copy yet, so it does not
  check for online edits; later runs do. `SITO.md` lives outside the repo (not on GitHub).
  The old `optimize-photos.sh` in this repo is superseded by `codice/01_ottimizza_foto.sh`
  and left untouched.

## 2026-08-18

### Added PRSS and Storytelling links + new Storytelling placeholder page
- **Feature:** wanted a link to the PRSS website, consistent with the existing
  Research/Photography links, in both the top nav and the homepage link row.
  Also wanted a Storytelling link/page as a work-in-progress placeholder.
- **Change:**
  - Added a **PRSS** link (https://federicoroscioli.github.io/prss/, opens in a
    new tab since it's a separate site) and a **Storytelling** link
    (`storytelling.html`) to the top nav on all three pages (`index.html`,
    `research.html`, `photography.html`) and to the homepage link row below the
    bio, in the same `.btn-ghost` / nav-link style as Research and Photography.
  - New `storytelling.html`: a minimal placeholder page reusing the site's nav,
    palette, and footer, with an eyebrow reading "Work in Progress" and a link
    back to the homepage. No content yet — to be built out later.
  - Local working copy: the `sito` folder had gone missing from Dropbox between
    sessions (not deleted by this session) while the live site kept working
    fine — Federico had been editing small things directly on GitHub in the
    meantime (e.g. the "Update research section with new titles and authors"
    commit). Re-cloned the repo from GitHub back into Dropbox to resume local,
    multi-file editing; nothing was lost since GitHub was always the source of
    truth.
- **Verified:** served locally and confirmed in-browser that the homepage nav
  and link row both show Research/Photography/PRSS/Storytelling/CV(or Contact)
  in order, the PRSS link's href is the external URL, and the Storytelling page
  renders with the site's standard nav/footer.
- **Impact:** site now has four top-level destinations plus an external PRSS
  link; Storytelling is live as a placeholder ready for real content later.

## 2026-07-03

### Added the R textbook + interactive exercises to the Research sidebar
- **Feature:** two teaching resources mentioned on the old Google Sites page
  were missing from the new site's Links sidebar.
- **Change (`research.html`):** added "R Programming Textbook" linking to
  https://federicoroscioli.github.io/book/ and "Interactive Exercises" linking
  to https://federicoroscioli.shinyapps.io/exercises/, placed after the slide
  decks and before Download CV.
- **Verified:** served locally and confirmed both links render with the correct
  hrefs in the sidebar.
- **Impact:** Research page now links out to both external teaching resources.

### Simplified homepage link row + trimmed a duplicate sidebar link
- **Feature:** requested changes now that the site is live.
- **Change:**
  - `index.html`: the "freelance photojournalist" mention in the bio is now
    plain text (no longer links to Photography, since Photography is already in
    both the top nav and the row below the bio). The link row below the bio
    paragraph was replaced with exactly three links — **Research, Photography,
    Contact** — replacing the previous set (Download CV, Photography, Google
    Scholar, Email). CV and the top-nav links are unaffected.
  - `research.html`: removed "Photography Portfolio" from the sidebar Links
    block — Photography is already reachable from the top nav on every page, so
    the sidebar no longer repeats it.
- **Verified:** served locally, confirmed in-browser that the bio text is
  unlinked, the new three-link row renders as Research/Photography/Contact, and
  the research sidebar now lists Google Scholar, three teaching-slide PDFs, and
  Download CV (no Photography entry).
- **Impact:** homepage and research page have one less redundant link each.

### YouTube videos confirmed working on the live site
- **Bug (resolved without a code change):** videos still failed once hosted,
  even though the earlier `file://`-origin fix (click-to-play facade,
  `youtube-nocookie.com`) was in place. Likely cause: YouTube's per-video
  "allowed domains" embedding restriction not yet covering the new hosting
  domain. Federico checked/adjusted the video's embedding settings in YouTube
  Studio; playback now works on the live GitHub Pages site.
- **Impact:** no site-code change was needed; noting this here in case the
  domain changes again (e.g. once `www.federicoroscioli.com` goes live) and the
  same symptom reappears — check the YouTube Studio embedding allow-list first.

## 2026-07-02

### Added a Research page + reworked the slideshows
- **Feature:** (1) wanted the full research content that used to be on the
  homepage back as its own page. (2) Wanted the slideshows to autoplay, be
  smaller, show position dots, and enlarge into a *still-a-slideshow* view on
  click (not a single photo).
- **Change:**
  - New `research.html`, built from the archived homepage
    (`old/2026-07-02_index.html`): keeps Work in Progress, all 7 peer-reviewed
    publications, 8 experiences, 7 teaching entries, and the Links/Contact
    sidebar. The duplicate name+bio+photo hero was replaced with a compact
    "Research & CV" page header; the Google Scholar link uses the real ID.
  - Unified the nav across all pages to **Research · Photography · CV** (logo →
    home). Added Research to the homepage and photography navs; removed the dead
    `index.html#research` style anchors.
  - `photography.html` slideshows: now **autoplay** every 4.5s; **max-width
    440px** (roughly half the previous size); **dots** under each stage (one per
    photo, active dot highlighted, click a dot to jump); clicking the photo adds
    an `.enlarged` class that fixes the *same* slideshow over a dark full-screen
    backdrop — arrows, dots and autoplay keep working, so it stays a slideshow.
    Close via the × button, backdrop click, or Escape. Manual moves restart the
    autoplay timer so it doesn't jump immediately. Removed the old single-photo
    lightbox (element, CSS, and handlers).
- **Verified:** served locally and checked in-browser — Research page shows the
  right title/nav/sections (7 pubs, 8 experience, 7 teaching, real Scholar link,
  no duplicate portrait); all 5 slideshows initialise with dots, autoplay
  advances the photo, clicking a photo enlarges the widget to a fixed full-screen
  overlay (position:fixed, 92vw × 78vh stage, z-index 1000) that remains a
  working slideshow, and the old `#lightbox` is gone.
- **Impact:** site is now four pages — minimal home, Research (full CV detail),
  Photography (compact autoplaying slideshows), and the CV PDF.

### Homepage rewritten as a minimal single-screen landing
- **Feature:** the homepage was a long scroll (7 publications + 8 experiences +
  7 teaching entries + sidebar). Wanted something compact, in the style of
  rdriver.owlstown.net.
- **Change:** archived the old homepage to `old/2026-07-02_index.html`, then
  rewrote `index.html` as a lean single-screen: dark nav (Photography · CV),
  a hero that fills the viewport (eyebrow, name, one bio paragraph that weaves in
  the key facts and links "freelance photojournalist" to the Photography page),
  four links (Download CV, Photography, Google Scholar, Email), the portrait, and
  a slim footer. No publication/experience/teaching lists or sidebar — that
  detail now lives in the CV PDF. The heavy stylesheet from the old homepage was
  dropped in favour of a much smaller one.
- **Verified:** served locally and confirmed in-browser that the page renders as
  one screen with the portrait, bio, and all four links working.
- **Impact:** homepage is now a compact profile card. Full CV detail is one click
  away via the Download CV button. Google Scholar link still has a `YOUR_ID`
  placeholder that needs the real profile ID.

### Photography: per-project slideshows + fixed the video embeds
- **Feature/bug:** (1) galleries showed every photo at once; wanted a slideshow
  per project. (2) The YouTube embeds threw "Error 153 — Video player
  configuration error" when the page was opened locally (`file://`), because a
  YouTube iframe can't verify the page origin without an HTTP referer.
- **Change (`photography.html`):**
  - Replaced each project's photo grid with a **slideshow**: one photo on a 3:2
    stage, prev/next arrows and a counter (e.g. "1 / 22") overlaid. Only the
    current image loads (plus a 1-image preload), so a 38-photo project is as
    light as a single photo. Clicking the photo still opens the fullscreen
    lightbox. Navigation wraps at both ends; Taranto's two series
    (taranto1 + taranto2) run as one 1–38 sequence.
  - Replaced both YouTube iframes with a **click-to-play facade**: a poster
    (real YouTube thumbnail, saved to `assets/video-thumbs/`) with a play button.
    The player iframe (youtube-nocookie, autoplay) is only injected on click, so
    the page never loads an embed it can't configure — this removes Error 153.
    Each caption also carries a "Watch on YouTube ↗" fallback link.
  - Downloaded posters: `XxFfL4yEDJ0.jpg` (1280×720) and `qacEFu8gcMY.jpg`
    (480×360, the best YouTube keeps for that 2013 upload; cropped to 16:9).
- **Verified:** served locally over http and checked in-browser — all 5
  slideshows initialise with the correct first photo and counter, prev/next wrap
  around and cross the Taranto series boundary (photo 19 → taranto1019,
  photo 20 → taranto2001), the video posters load, and clicking a poster swaps in
  the `youtube-nocookie` player. Note: inline video playback needs http(s)
  (localhost or the hosted site); on a `file://` copy use the "Watch on YouTube"
  link.
- **Impact:** photography section is now a compact slideshow per project instead
  of long grids, and the videos work once served over http (they will on GitHub
  Pages). The `.photo-grid`/`.photo-slot`/lazy-grid code was removed.

### Wired up photography galleries, favicon, and hero portrait
- **Feature:** the site had placeholder tiles for photos and no branding assets.
- **Change:**
  - Added `optimize-photos.sh` — reads the original ~2000px JPGs from
    `assets/photos/` and writes 1600px / quality-80 web copies to
    `assets/photos-web/`. Originals are never modified; rerun the script after
    adding photos.
  - `photography.html`: replaced the placeholder grids with a small data-driven
    script that builds the image tiles for each project from a `galleries`
    config (prefix + count). Photos use `loading="lazy"`. The lightbox now opens
    via one delegated click handler per grid. Taranto combines two shooting
    series (`taranto1` + `taranto2` = 38 photos) into one gallery. "Se ti muovi
    non ci pensi" is video-only (no stills were provided), so its grid was
    removed and only the YouTube embed remains.
  - Added the favicon (`assets/logos/fav_icon.jpg`) to `index.html` and
    `photography.html`.
  - `index.html`: placed the personal portrait (`assets/08.jpg`) in the hero and
    changed the hero-photo frame from 200×240 to 200×200 (square) so the 200×200
    portrait fits crisp, with no upscaling or face-cropping.
- **Verified:** ran `optimize-photos.sh` → 127 web photos, 283 MB → 60 MB. Served
  the site locally (python http.server) and confirmed via the browser that all
  127 gallery images render across the 5 grids with zero broken images, the
  lightbox is wired, and the hero portrait + favicon load. Screenshots taken of
  the photography galleries and the homepage hero.
- **Impact:** photography section is now live with real images at web-optimized
  weight; site total well under GitHub Pages' 1 GB cap. Paper/publication visuals
  are still an open design question (deferred).

### Earlier the same session (pre-changelog)
- Built the site from the Google Sites content in the warm "editorial" style:
  `index.html` (hero, work-in-progress, publications, experience, teaching,
  sidebar) and `photography.html` (6 documentary projects + 2 YouTube embeds).
- Populated real CV data from the Overleaf `cv.tex`.
- Copied teaching/CV PDFs into `assets/docs/`.
- Moved Work in Progress above Peer-reviewed Publications on the homepage.
- Removed the Journal Referee, Skills, and Languages sidebar blocks.
