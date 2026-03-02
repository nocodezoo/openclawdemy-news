#!/bin/bash
# OpenClaw News Auto-Publisher - Visual Version

SCRIPT_DIR="$HOME/.openclaw/workspace/openclaw-news"
OUTPUT_DIR="$HOME/Pictures/openclawdemy_site/news"
APACHE_DIR="/var/www/html/news"

echo "🗞️ Generating OpenClaw News..."

# Generate new data
cd "$SCRIPT_DIR"
python3 tracker-v2.py

# Generate timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")

# Copy news data
cp "$SCRIPT_DIR/v2/news_data.json" "$OUTPUT_DIR/news_data.json"
cp "$SCRIPT_DIR/v2/news_data.json" "$APACHE_DIR/news_data.json"

# Copy VISUAL news page (v2/index.html has all images, ticker) as timestamped
cp "$SCRIPT_DIR/v2/index.html" "$OUTPUT_DIR/${TIMESTAMP}.html"
cp "$SCRIPT_DIR/v2/index.html" "$APACHE_DIR/${TIMESTAMP}.html"

# Also as latest
cp "$SCRIPT_DIR/v2/index.html" "$OUTPUT_DIR/latest.html"
cp "$SCRIPT_DIR/v2/index.html" "$APACHE_DIR/latest.html"

# Copy index/menu
cp "$SCRIPT_DIR/index.html" "$OUTPUT_DIR/index.html"
cp "$SCRIPT_DIR/index.html" "$APACHE_DIR/index.html"

# Update mainviewnews
cd "$APACHE_DIR"
FILES=$(ls -t *.html 2>/dev/null | grep -E "^2026" | head -20)

cat > "$APACHE_DIR/mainviewnews.html" << HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OpenClaw News | All Versions</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { background: #0a0a0a; color: white; font-family: sans-serif; }
        .card { transition: all 0.3s; }
        .card:hover { transform: scale(1.05); box-shadow: 0 0 40px rgba(249, 115, 22, 0.4); border-color: #f97316; }
    </style>
</head>
<body class="min-h-screen">
    <header class="py-8 border-b border-zinc-800 text-center">
        <h1 class="text-4xl font-black mb-2">🦞 OpenClaw <span class="text-orange-500">News</span> - All Versions</h1>
        <p class="text-zinc-400">Click any version to view the full news</p>
    </header>
    <main class="max-w-7xl mx-auto px-4 py-12">
        <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-4">
HTML

for file in $FILES; do
    date_part=$(echo "$file" | sed 's/.html//')
    echo "<a href=\"$file\" class=\"card block bg-zinc-900 border border-zinc-800 rounded-xl p-6 text-center\">
        <div class=\"text-3xl mb-3\">📰</div>
        <h3 class=\"font-bold text-orange-400\">$date_part</h3>
    </a>" >> "$APACHE_DIR/mainviewnews.html"
done

cat >> "$APACHE_DIR/mainviewnews.html" << HTML
        </div>
    </main>
</body>
</html>
HTML

cp "$APACHE_DIR/mainviewnews.html" "$OUTPUT_DIR/"

echo "✅ Published ${TIMESTAMP}.html (VISUAL with images)"
echo "📋 Main viewer updated"
