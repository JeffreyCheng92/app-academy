# == Schema Information
#
# Table name: albums
#
#  asin        :string       not null, primary key
#  title       :string
#  artist      :string
#  price       :float
#  rdate       :date
#  label       :string
#  rank        :integer
#
# Table name: styles
#
# album        :string       not null
# style        :string       not null
#
# Table name: tracks
# album        :string       not null
# disk         :integer      not null
# posn         :integer      not null
# song         :string

require_relative './sqlzoo.rb'

def alison_artist
  # Select the name of the artist who recorded the song 'Alison'.
  execute(<<-SQL)
    SELECT
      a.artist
    FROM
      albums a
    JOIN
      tracks t
    ON
      t.album = a.asin
    WHERE
      t.song = 'Alison'
  SQL
end

def exodus_artist
  # Select the name of the artist who recorded the song 'Exodus'.
  execute(<<-SQL)
    SELECT
      a.artist
    FROM
      albums a
    JOIN
      tracks t
    ON
      a.asin = t.album
    WHERE
      t.song = 'Exodus'
  SQL
end

def blur_songs
  # Select the `song` for each `track` on the album `Blur`.
  execute(<<-SQL)
    SELECT
      t.song
    FROM
      tracks t
    JOIN
      albums a
    ON
      a.asin = t.album
    WHERE
      a.title = 'Blur'

  SQL
end

def heart_tracks
  # For each album show the title and the total number of tracks containing
  # the word 'Heart' (albums with no such tracks need not be shown). Order first by
  # the number of such tracks, then by album title.
  execute(<<-SQL)
    SELECT
      a.title, COUNT(t.song)
    FROM
      albums a
    JOIN
      tracks t
    ON
      a.asin = t.album
    WHERE
      t.song LIKE '%Heart%'
    GROUP BY
      a.title
    ORDER BY
      COUNT(t.song) DESC, a.title
  SQL
end

def title_tracks
  # A 'title track' has a `song` that is the same as its album's `title`. Select
  # the names of all the title tracks.
  execute(<<-SQL)
    SELECT
      t.song
    FROM
      tracks t
    JOIN
      albums a
    ON
      a.asin = t.album
    WHERE
      t.song = a.title
  SQL
end

def eponymous_albums
  # An 'eponymous album' has a `title` that is the same as its recording
  # artist's name. Select the titles of all the eponymous albums.
  execute(<<-SQL)
    SELECT
      title
    FROM
      albums
    WHERE
      title = artist
  SQL
end

def song_title_counts
  # Select the song names that appear on more than two albums. Also select the
  # COUNT of times they show up.
  execute(<<-SQL)
    SELECT
      t.song, COUNT(t.song)
    FROM
      tracks t
    GROUP BY
      t.song
    HAVING
      COUNT(t.song) > 2
  SQL
end

def best_value
  # A "good value" album is one where the price per track is less than 50
  # pence. Find the good value albums - show the title, the price and the number
  # of tracks.
  execute(<<-SQL)
    SELECT
      a.title, a.price, new.jj
    FROM
      albums a
    JOIN (
        SELECT
          t.album, COUNT(t.song) jj
        FROM
          tracks t
        GROUP BY
          t.album
        ) new
    ON
      a.asin = new.album
    WHERE
      a.price / new.jj < 0.5


  SQL
end

def top_track_counts
  # Wagner's Ring cycle has an imposing 173 tracks, Bing Crosby clocks up 101
  # tracks. List the top 10 albums in order of track count. Select both the
  # album title and the track count.
  execute(<<-SQL)
    SELECT
      a.title, new.num_trax
    FROM
      albums a
    JOIN (
      SELECT
        t.album poop, COUNT(t.song) num_trax
      FROM
        tracks t
      GROUP BY
        t.album
      ) new
    ON
      a.asin = new.poop
    ORDER BY
      new.num_trax DESC, a.title DESC
    LIMIT
      10

  SQL
end

def rock_superstars
  # Select the artist who has recorded the most rock albums, as well as the
  # number of albums. HINT: use LIKE '%Rock%' in your query.
  execute(<<-SQL)

    SELECT
      a.artist, COUNT(DISTINCT a.title)
    FROM
      albums a
    JOIN
      styles s
    ON
      a.asin = s.album
    WHERE
      s.style LIKE '%Rock%'
    GROUP BY
      a.artist
    ORDER BY
      COUNT(a.title) DESC
    LIMIT
      1

  SQL
end

def expensive_tastes
  # Select the five styles of music with the highest average price per track,
  # along with the price per track. One or more of each aggregate functions,
  # subqueries, and joins will be required.
  #
  # HINT: Start by getting the number of tracks per album. You can do this in a
  # subquery. Next, JOIN the styles table to this result and use aggregates to
  # determine the average price per track.

  execute(<<-SQL)
    SELECT
      s.style, (SUM(albums1.price) / SUM(albums1.s_count))
    FROM
      styles s
    JOIN
      (
        SELECT
          albums.*, COUNT(tracks.song) AS s_count
        FROM
          albums
        JOIN
          tracks ON albums.asin = tracks.album
        WHERE
          albums.price IS NOT NULL
        GROUP BY
          albums.asin
        ) AS albums1
      ON albums1.asin = s.album
    GROUP BY
      s.style
    ORDER BY
      (SUM(albums1.price) / SUM(albums1.s_count)) DESC
    LIMIT
      5

  SQL
end
