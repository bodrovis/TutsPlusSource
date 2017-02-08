class Song < ApplicationRecord
  belongs_to :album

  dragonfly_accessor :track do
    after_assign do |a|
      song = FFMPEG::Movie.new(a.path)
      mm, ss = song.duration.divmod(60).map {|n| n.to_i.to_s.rjust(2, '0')}
      a.meta['duration'] = "#{mm}:#{ss}"
      a.meta['bitrate'] = song.bitrate ? song.bitrate / 1000 : 0
    end
  end
end
