from gmusicapi import Mobileclient
from getpass import getpass
import json

# fill this in
email = ''

api = Mobileclient()
logged_in = api.login(email, getpass())

if logged_in:
  for track in json.load(open('dump.json')):
    title = track['title']
    artist = track['artist']
    query = u"{title!s} - {artist!s}".format(**locals())
    results = api.search_all_access(query)['song_hits']

    if len(results) > 0:
      storeId = results[0]['track']['storeId']
      api.add_aa_track(storeId)
    else:
      print u"Google Music lacks: {query!s}".format(**locals())
else:
  print "failed to log in"
