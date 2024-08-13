#!/usr/bin/python3

import requests

def number_of_subscribers(subreddit):
    """ This function queries the Reddit API for the subscriber count of a subreddit. """

    url = "https://www.reddit.com/r/{}/about.json".format(subreddit)
    headers = { "User-Agent": "My Reddit Script v1.0 by @joehsn" }  # Set custom User-Agent

    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code == 404:
        return 0
    results = response.json().get("data")
    return results.get("subscribers")
