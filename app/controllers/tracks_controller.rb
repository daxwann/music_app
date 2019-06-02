class TracksController < ApplicationController
  before_action :require_login!

  def new
    @track = Track.new(album_id: params[:album_id])
    @albums = Album.all

    render :new
  end

  def create
    @track = Track.new(track_params)
    @albums = Album.all

    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def show
    @track = Track.find_by(id: params[:id])
    @note = Note.new

    if @track
      render :show
    else
      flash.now[:errors] = ["Track does not exist"]
      redirect_to bands_url
    end
  end

  def edit
    @track = Track.find_by(id: params[:id])
    @albums = Album.all

    if @track
      render :edit
    else
      flash.now[:errors] = ["Track does not exist"]
      redirect_to bands_url
    end
  end

  def update
    @track = Track.find_by(id: params[:id])
    @albums = Album.all

    if @track.update_attributes(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find_by(id: params[:id])
    
    album_id = @track.album_id
    @track.destroy
    redirect_to album_url(album_id) 
  end

  private

  def track_params
    params.require(:track).permit(:title, :ord, :album_id, :bonus, :lyrics)
  end
end
