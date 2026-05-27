#!/bin/bash
# One-shot deploy: clear stale git lock, commit all changes, push to GitHub.
# Vercel (if connected to daisq24/sfes-lab) will auto-deploy on push.

set -u
cd "$(dirname "$0")" || exit 1

echo "==> Working dir: $(pwd)"
echo ""

# Clear stale lock from earlier interrupted git operation
if [ -f .git/index.lock ]; then
  echo "==> Removing stale .git/index.lock ..."
  rm -f .git/index.lock
fi

echo "==> git status (before) ..."
git status --short
echo ""

echo "==> git add -A ..."
git add -A
echo ""

echo "==> git commit ..."
git commit -m "feat(no.05): long-read five-question thought experiment

- merge Calvino × world-model + AI-geography + Loop-closes into one HTML
- 5 chapters titled with original prompts, bookmark-style insert layout
- frosted-glass background derived from 05-hero.png with brown→green color arc
- water-ripple overlay; warm sandstone master hero
- bilingual paragraphs throughout (zh + en)
- city atlas: 10 square tiles linked to source posters
- depersonalize coda passages; byline updated to Eva · 戴诗琪
- fix Tianjin typo in 01-空间的沉默语言"

echo ""
echo "==> git push origin main ..."
git push origin main 2>&1
push_status=$?
echo ""

if [ $push_status -eq 0 ]; then
  echo "✓ Push succeeded."
  echo ""
  echo "If daisq24/sfes-lab is connected to a Vercel project,"
  echo "the new deployment is now building. Check:"
  echo "  https://vercel.com/dashboard"
else
  echo "✗ Push failed (exit $push_status). See messages above."
  echo "Common causes: credential prompt, no internet, remote out of sync."
fi

echo ""
echo "── Done. Press any key to close this window ──"
read -n 1 -s
