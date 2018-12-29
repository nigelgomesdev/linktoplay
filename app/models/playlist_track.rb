# frozen_string_literal: true

# == Schema Information
#
# Table name: playlist_tracks
#
#  id          :bigint(8)        not null, primary key
#  playlist_id :bigint(8)
#  track_id    :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# PlaylistTrack
class PlaylistTrack < ApplicationRecord
  include Scopable
  belongs_to :playlist, inverse_of: :playlist_tracks
  belongs_to :track, inverse_of: :playlist_tracks

  scope :title_ordered_by, ->(direction) { joins(:track).merge(Track.title_ordered_by(direction)) }
  scope :updated_at_ordered_by, ->(direction) { joins(:track).merge(Track.updated_at_ordered_by(direction)) }
  scope :views_ordered_by, ->(direction) { joins(:track).merge(Track.views_ordered_by(direction)) }
  scope :popularity, -> { views_ordered_by(:desc) }
  scope :title_like, ->(str) { joins(:track).merge(Track.title_like(str)) }
  scope :playlist_tracks_for_user, ->(user_id) { where(playlist_id: Playlist.playlists_for_user(user_id).try(:pluck, :id)) }
  scope :recent, -> { updated_at_ordered_by(:desc) }
  scope :within_playlist, ->(playlist_id) { joins(:playlist).merge(Playlist.where(id: playlist_id)) }
end
