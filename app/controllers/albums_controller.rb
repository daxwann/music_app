class AlbumsController < ApplicationController
  before_action :require_login!

  def show
    @album = Album.find_by(id: params[:id])
    
    if @album
      render :show
    else
      flash.now[:errors] = ["Album does not exist"]
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
    @bands = Band.all

    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find_by(id: params[:id])
    @bands = Band.all

    if @album
      render :edit
    else
      flash.now[:errors] = ["Album does not exist"]
      redirect_to bands_url
    end
  end

  def update
    @album = Album.find_by(id: params[:id])

    unless @album
      flash.now[:errors] = ["Album does not exist"]
      redirect_to bands_url
    end

    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = Album.includes(:band).find_by(id: params[:id])
    band_id = @album.band_id

    @album.destroy
    redirect_to band_url(band_id)
  end

  private

  def album_params
    params.require(:album).permit(:title, :band_id, :year, :live)
  end
end
