#!/usr/bin/env python3
"""Generate sample news data for testing."""

import json
from datetime import datetime

sample_data = {
    "timestamp": datetime.now().isoformat(),
    "overall": {
        "score": 72.5,
        "label": "Faith",
        "color": "green",
        "sources_covering": 12,
        "total_mentions": 47
    },
    "sources": [
        {"source": "Reddit r/LocalLLaMA", "type": "reddit", "items_found": 8, "credibility": {"faith": 75, "mistrust": 10, "score": 78}},
        {"source": "Hacker News", "type": "api", "items_found": 5, "credibility": {"faith": 80, "mistrust": 5, "score": 85}},
        {"source": "GitHub Trending", "type": "github", "items_found": 3, "credibility": {"faith": 90, "mistrust": 0, "score": 95}},
        {"source": "Product Hunt", "type": "search", "items_found": 4, "credibility": {"faith": 65, "mistrust": 15, "score": 68}},
        {"source": "TechCrunch", "type": "search", "items_found": 2, "credibility": {"faith": 60, "mistrust": 20, "score": 62}},
        {"source": "Discord OpenClaw", "type": "social", "items_found": 12, "credibility": {"faith": 85, "mistrust": 5, "score": 88}},
        {"source": "The Verge", "type": "search", "items_found": 1, "credibility": {"faith": 50, "mistrust": 25, "score": 55}},
        {"source": "Wired", "type": "search", "items_found": 1, "credibility": {"faith": 45, "mistrust": 30, "score": 48}},
    ],
    "summary": "OpenClaw is gaining traction with 47 mentions across 12 sources. Most coverage from technical communities (Reddit, GitHub, Discord) shows strong faith. Mainstream tech news has limited coverage but is generally positive."
}

with open('/home/openryanclaw/.openclaw/workspace/openclaw-news/news_data.json', 'w') as f:
    json.dump(sample_data, f, indent=2)

print("Sample data generated!")
