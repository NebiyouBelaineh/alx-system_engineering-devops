#!/usr/bin/python3
"""Script that queries the Reddit API recursively and returns a list
containing the titles of all hot articles for a given subreddit. If no
results are found for the given subreddit, the function should return None."""
import requests


def recurse(subreddit, hot_list=[], after='after'):
    """Prints the titles of the first 10 hot posts listed for a given
    subreddit."""

    url = f"https://www.reddit.com/r/{subreddit}/hot.json"

    if after != 'after':
        url = url + f'?after={after}'

    headers = requests.utils.default_headers()
    headers['User-Agent'] = 'My User Agent 0.0.1'

    res = requests.get(url, headers=headers, allow_redirects=False).json()
    resp = res.get('data', {}).get('children', None)

    if not resp:
        return None

    for r in resp:
        hot_list.append(r.get('data').get('title'))
    after = res.get('data').get('after')

    if not after:
        return hot_list
    return (recurse(subreddit, hot_list, after))
