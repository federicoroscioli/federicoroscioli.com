# Changelog — federicoroscioli.com (personal site)

All notable changes to the site are recorded here: the feature or bug, the exact
change, what was verified, and the downstream impact.

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
