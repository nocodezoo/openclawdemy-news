#!/bin/bash
# OpenClaw News Auto-Publisher - Creates versioned folders

SCRIPT_DIR="$HOME/.openclaw/workspace/openclaw-news"
OUTPUT_DIR="$HOME/Pictures/openclawdemy_site/news"
APACHE_DIR="/var/www/html/news"
GIT_DIR="$SCRIPT_DIR"

echo "🗞️ Generating OpenClaw News..."

# Generate new data
cd "$SCRIPT_DIR"
python3 tracker-v2.py

# Generate timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")
DATE_DIR=$(date +"%Y-%m-%d")

# Copy visual page and data to versioned folder
mkdir -p "$GIT_DIR/versions/$DATE_DIR"
cp "$SCRIPT_DIR/v2/index.html" "$GIT_DIR/versions/$DATE_DIR/index-$TIMESTAMP.html"
cp "$SCRIPT_DIR/v2/news_data.json" "$GIT_DIR/versions/$DATE_DIR/"

# Also copy to Apache (latest)
cp "$SCRIPT_DIR/v2/index.html" "$APACHE_DIR/latest.html"
cp "$SCRIPT_DIR/v2/index.html" "$APACHE_DIR/${TIMESTAMP}.html"
cp "$SCRIPT_DIR/v2/news_data.json" "$APACHE_DIR/news_data.json"

# Copy index/menu
cp "$SCRIPT_DIR/index.html" "$APACHE_DIR/index.html"

# Copy to output dir
cp "$SCRIPT_DIR/v2/index.html" "$OUTPUT_DIR/latest.html"
cp "$SCRIPT_DIR/v2/news_data.json" "$OUTPUT_DIR/"

# Git: Add new version folder and push
cd "$GIT_DIR"
git add "versions/$DATE_DIR/"
git commit -m "News update: $TIMESTAMP" 2>/dev/null || echo "No new changes to commit"
git push origin main --force 2>/dev/null || echo "Push skipped"

echo "✅ Published $TIMESTAMP in versions/$DATE_DIR/"
echo "📁 Versioned folder created and pushed to GitHub"
