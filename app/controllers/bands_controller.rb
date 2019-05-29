class BandsController < ApplicationController
  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      redirect_to band_url(@band)
    else
      render :new
    end
  end

  def edit
    @band = Band.find_by(id: params[:id])

    if @band
      render :edit
    else
      redirect_to bands_url
    end
  end

  def update
    @band = Band.find_by(id: params[:id])

    if @band.update_attribute!(band_params)
      redirect_to band_url(@band)
    else
      render :edit
    end
  end

  def destroy
    @band = Band.find_by(id: params[:id])
    @band.destroy!
    redirect_to bands_url
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
