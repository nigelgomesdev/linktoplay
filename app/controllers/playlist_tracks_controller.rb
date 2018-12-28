class PlaylistTracksController < ApplicationController
  before_action :set_playlist_track, only: [:show, :edit, :update, :destroy]
  before_action :set_playlist
  load_and_authorize_resource

  # GET /playlist_tracks
  # GET /playlist_tracks.json
  def index
    @playlist_tracks = PlaylistTrack.accessible_by(current_ability).scoped(search_params)
    if params[:playlist_id].present?
      @playlist_tracks = @playlist_tracks.within_playlist(params[:playlist_id])
    end
    @playlist_tracks = @playlist_tracks.page(params[:page])
  end

  # GET /playlist_tracks/1
  # GET /playlist_tracks/1.json
  def show
  end

  # GET /playlist_tracks/new
  def new
    @playlist_track = PlaylistTrack.new
  end

  # GET /playlist_tracks/1/edit
  def edit
  end

  # POST /playlist_tracks
  # POST /playlist_tracks.json
  def create
    @playlist_track = PlaylistTrack.new(playlist_track_params)
    respond_to do |format|
      if @playlist_track.save
        format.html { redirect_to @playlist_track, notice: 'Playlist track was successfully created.' }
        format.json { render :show, status: :created, location: @playlist_track }
      else
        format.html { render :new }
        format.json { render json: @playlist_track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /playlist_tracks/1
  # PATCH/PUT /playlist_tracks/1.json
  def update
    respond_to do |format|
      if @playlist_track.update(playlist_track_params)
        format.html { redirect_to @playlist_track, notice: 'Playlist track was successfully updated.' }
        format.json { render :show, status: :ok, location: @playlist_track }
      else
        format.html { render :edit }
        format.json { render json: @playlist_track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playlist_tracks/1
  # DELETE /playlist_tracks/1.json
  def destroy
    @playlist_track.destroy
    # respond_to do |format|
    #   format.html { redirect_to playlist_tracks_url, notice: 'Playlist track was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist_track
      @playlist_track = PlaylistTrack.find(params[:id])
    end

    def set_playlist
      @playlist = Playlist.find(params[:playlist_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def playlist_track_params
      params.require(:playlist_track).permit(:playlist_id, :track_id)
    end

    def search_params
      params[:q] || {}
    end
end
