class AlbumsController < ApplicationController
  def index
    @albums = Album.all
  end

  def show
    @album = Album.includes(:songs).find(params[:id])
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:success] = 'Album added!'
      redirect_to albums_path
    else
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      flash[:success] = 'Album updated!'
      redirect_to albums_path
    else
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    flash[:success] = 'Album removed!'
    redirect_to albums_path
  end

  private

  def album_params
    params.require(:album).permit(:title, :singer, :image, :remove_image, :retained_image)
  end
end