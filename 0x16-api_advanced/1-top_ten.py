#!/usr/bin/python3
"""reddit api query for title of first 100 hot posts"""

import requests


def top_ten(subreddit):
    """function queries the Reddit API and
    prints the title of top 10 hot posts
    for a given subreddit"""

    url = f"https://www.reddit.com/r/{subreddit}/hot.json?limit=10"
    headers = {"User-Agent": "subreddit-top-ten/0.1"}

    try:
        response = requests.get(url, headers=headers, allow_redirects=False)
        if response.status_code == 200:
            data = response.json()
            posts = data.get("data", {}).get("children", [])
            for post in posts:
                print(post["data"]["title"])
        else:
            print(None)
    except requests.RequestException:
        print(None)
