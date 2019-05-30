class AlbumsController < ApplicationController
  def show
    @album = Album.find_by(id: params[:id])
    
    if @album
      render :show
    else
      redirect_to bands_url
    end
  end

  def new
    @bands = Band.all
    @album = Album.new(band_id: params[:band_id])

    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      render :new
    end
  end

  def edit
    @album = Album.find_by(id: params[:id])
    @bands = Band.all

    if @album
      render :edit
    else
      redirect_to bands_url
    end
  end

  def update
    @album = Album.find_by(id: params[:id])

    unless @album
      redirect_to bands_url
    end

    if @album.update_attributes(band_params)
      redirect_to album_url(@album)
    else
      render :edit
    end
  end

  def destroy
    @album = Album.includes(:band).find_by(id: params[:id])
    band = @album.band

    @album.destroy
    redirect_to band_url(band)
  end

  private

  def album_params
    params.require(:album).permit(:title, :band_id, :year, :live)
  end
end
