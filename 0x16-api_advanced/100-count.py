#!/usr/bin/python3
"""Script that queries the Reddit API and returns the count of words in
    word_list in the titles of all the hot posts
    of the subreddit"""
import requests


def count_words(subreddit, word_list, word_count={}, after=None):
    """Queries the Reddit API and returns the count of words in
    word_list in the titles of all the hot posts
    of the subreddit"""

    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    headers = requests.utils.default_headers()
    headers['User-Agent'] = 'My User Agent 0.0.1'

    res = requests.get(url, params={"after": after}, headers=headers,
                       allow_redirects=False)
    if res.status_code != 200:
        return None

    resp = res.json()

    hot_list = [child.get("data").get("title") for child in (resp.get("data")
                                                             .get("children"))]
    if not hot_list:
        return None

    word_list = list(dict.fromkeys(word_list))

    if word_count == {}:
        word_count = {word: 0 for word in word_list}

    for title in hot_list:
        split_words = title.split(' ')
        for word in word_list:
            for s_word in split_words:
                if s_word.lower() == word.lower():
                    word_count[word] += 1

    if not resp.get("data").get("after"):
        sorted_counts = sorted(word_count.items(), key=lambda kv: kv[0])
        sorted_counts = sorted(word_count.items(),
                               key=lambda kv: kv[1], reverse=True)
        [print('{}: {}'.format(k, v)) for k, v in sorted_counts if v != 0]
    else:
        return count_words(subreddit, word_list, word_count,
                           resp.get("data").get("after"))
