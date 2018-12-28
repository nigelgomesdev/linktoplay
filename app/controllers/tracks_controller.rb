class TracksController < ApplicationController
  before_action :set_track, only: [:show, :edit, :update, :destroy,
    :play_previous, :play_next]
  before_action :set_library, :set_playlist
  load_and_authorize_resource
    
  # GET /tracks
  # GET /tracks.json
  def index
    @tracks = Track.accessible_by(current_ability).scoped(search_params).page(params[:page])
  end

  # GET /tracks/1
  # GET /tracks/1.json
  def show
    @track.increment!(:views)
  end

  # GET /tracks/new
  def new
    @track = Track.new
  end

  # GET /tracks/1/edit
  def edit
  end

  # POST /tracks
  # POST /tracks.json
  def create
    @track = Track.new(track_params)

    respond_to do |format|
      if @track.save
        format.html { redirect_to @track, notice: 'Track was successfully created.' }
        format.json { render :show, status: :created, location: @track }
      else
        format.html { render :new }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tracks/1
  # PATCH/PUT /tracks/1.json
  #TODO: N+1 issue: https://github.com/flyerhzm/bullet/issues/147
  def update
    respond_to do |format|
      if @track.update(track_params)
        format.html { redirect_to @track, notice: 'Track was successfully updated.' }
        format.json { render :show, status: :ok, location: @track }
      else
        format.html { render :edit }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tracks/1
  # DELETE /tracks/1.json
  def destroy
    @track.destroy
    respond_to do |format|
      format.html { redirect_to tracks_url, notice: 'Track was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def play_previous
    previous_track = Track.accessible_by(current_ability)
      .previous_tracks(@track.created_at)
      .first
    if previous_track.present?
      redirect_to track_path(previous_track)
    else from playlist
      flash[:notice] = 'No previous track found'
      render :show 
    end
  end

  def play_next
    next_track = Track.accessible_by(current_ability)
      .next_tracks(@track.created_at)
      .first
    if next_track.present?
      redirect_to track_path(next_track)
    else
      flash[:notice] = 'No next track found'
      render :show 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track
      @track = Track.find(params[:id])
    end

    def set_library
      @library = current_user.try(:library)
    end

    def set_playlist
      params[:playlist_id].present? && @playlist = Playlist.find(params[:playlist_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def track_params
      params.require(:track).permit(:title, :status, :genre, :artist_id, :source_id,
        :source_link, :views, :library_id, playlist_ids: [])
    end

    def search_params
      params[:q] || {}
    end
end
