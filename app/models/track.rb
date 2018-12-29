# frozen_string_literal: true

# == Schema Information
#
# Table name: tracks
#
#  id          :bigint(8)        not null, primary key
#  title       :string
#  status      :string           default("active")
#  genre       :string
#  artist_id   :bigint(8)
#  source_id   :bigint(8)
#  source_link :string
#  views       :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  library_id  :bigint(8)
#
# Track
class Track < ApplicationRecord
  include Scopable

  belongs_to :library
  belongs_to :artist
  belongs_to :source, optional: true
  has_many :playlist_tracks, dependent: :destroy
  has_many :playlists, through: :playlist_tracks

  enum status: {
    active: 'active',
    blocked: 'blocked'
  }
  enum genre: {
    pop: 'pop',
    rock: 'rock',
    jazz: 'jazz',
    country: 'country'
  }

  validates :title, presence: true
  validates :artist, presence: true
  validates :source_link, presence: true

  before_validation :set_source

  scope :title_ordered_by, ->(direction) { order(title: direction) }
  scope :updated_at_ordered_by, ->(direction) { order(updated_at: direction) }
  scope :views_ordered_by, ->(direction) { order(views: direction) }
  scope :popularity, -> { views_ordered_by(:desc) }
  scope :title_like, ->(str) { where('lower(title) like ?', "%#{str.downcase}%") }
  scope :recent, -> { updated_at_ordered_by(:desc) }
  scope :previous_tracks, ->(date) { where('created_at > ?', date).order(created_at: :desc) }
  scope :next_tracks, ->(date) { where('created_at < ?', date).order(:created_at) }
  scope :tracks_for_user, ->(user_id) { where(library_id: Library.where(user_id: user_id).try(:pluck, :id)) }

  delegate :user, to: :library

  private

  def set_source
    uri = URI.parse(source_link)
    self.source = Source.where(domain: uri.host).first
  end
end
