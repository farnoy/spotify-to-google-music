#!/usr/bin/env ruby

require 'rspotify'
require 'json'

# fill those in
client_id = ''
secret_id = ''
user_name = ''
playlist_name = ''

RSpotify.authenticate(client_id, secret_id)
user = RSpotify::User.find(username)

playlist = user.playlists.find { |p| p.name == playlist_name }

tracks = Array.new

offset = 0
loop do
  t = playlist.tracks(limit: 100, offset: offset)
  tracks.concat(t)

  if t.count < 100
    break
  end
  offset = offset + 100
end

tracks.map! { |track|
  { title: track.name, artist: track.artists.first.name }
}

JSON.dump(tracks, File.open('dump.json', 'w'))
