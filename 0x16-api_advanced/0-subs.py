#!/usr/bin/python3
"""Script that queries the Reddit API and returns the number of subscribers of
a given subreddit"""
import requests


def number_of_subscribers(subreddit):
    """
        return number of subscribers for a given subreddit
        return 0 if invalid subreddit given
    """
    url = f"https://www.reddit.com/r/{subreddit}/about.json"

    headers = requests.utils.default_headers()
    headers['User-Agent'] = 'My User Agent 0.0.1'

    res = requests.get(url, headers=headers).json()
    subscribers = res.get('data', {}).get('subscribers')
    if not subscribers:
        return 0
    return subscribers
