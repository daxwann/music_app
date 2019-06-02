class NotesController < ApplicationController
  before_action :require_login!

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id

    if @note.save
      redirect_to track_url(@note.track_id)
    else
      flash.now[:errors] = @note.errors.full_messages
      @track = Track.find_by(id: params[:note][:track_id])
      render 'tracks/show' 
    end
  end

  def destroy
    @note = Note.find_by(id: params[:id])
    if @note.user_id == current_user.id
      track_id = @note.track_id
      @note.destroy
      redirect_to track_url(track_id)
    else
      render plain: "Unauthorized user", status: 403
    end 
  end

  private

  def note_params
    params.require(:note).permit(:content, :track_id)
  end
end
