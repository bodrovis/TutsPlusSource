class SongsController < ApplicationController
  def new
    @album = Album.find(params[:album_id])
    @song = @album.songs.build
  end

  def create
    @album = Album.find(params[:album_id])
    @song = @album.songs.build(song_params)
    if @song.save
      flash[:success] = "Song added!"
      redirect_to album_path(@album)
    else
      render :new
    end
  end

  private

  def song_params
    params.require(:song).permit(:title, :track)
  end
end