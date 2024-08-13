#!/usr/bin/python3
"""Recursively query Reddit API and
return a list containing the titles of all hot
articles for a given subreddit"""

import requests


def recurse(subreddit, hot_list=[]):
    """Function recursively query Reddit API and
    return a list containing the titles of all hot
    articles for a given subreddit"""

    url = f"https://www.reddit.com/r/{subreddit}/hot.json"

    # Set the parameters for the request
    params = {'limit': 100}

    # Set the headers to mimic a real browser request
    headers = {'User-Agent': 'Mozilla/5.0'}

    # Send a GET request to the Reddit API
    response = requests.get(url, headers=headers, params=params,
                            allow_redirects=False)

    # Check if the subreddit is invalid
    if response.status_code != 200:
        return None

    # Parse the JSON response
    data = response.json()

    # Check if the data contains the expected keys
    if 'data' not in data or 'children' not in data['data']:
        return None

    # Add titles from the current page to hot_list
    for post in data['data']['children']:
        hot_list.append(post['data']['title'])

    # Check for next page
    after = data['data'].get('after')

    # If no next page, return the accumulated hot_list
    if after is None:
        return hot_list

    # Define the next page URL and parameters
    next_url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    next_params = {'limit': 100, 'after': after}

    # Make a recursive call to handle the next page
    return recurse(subreddit, hot_list)
