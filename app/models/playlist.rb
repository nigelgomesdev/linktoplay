# frozen_string_literal: true

# == Schema Information
#
# Table name: playlists
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  status     :string           default("active")
#  views      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  library_id :bigint(8)
#
# Playlist
class Playlist < ApplicationRecord
  include Scopable

  belongs_to :library
  has_many :playlist_tracks, dependent: :destroy
  has_many :tracks, through: :playlist_tracks

  accepts_nested_attributes_for :tracks, reject_if: :all_blank

  enum status: {
    active: 'active',
    blocked: 'blocked'
  }

  validates :title, presence: true

  scope :title_ordered_by, ->(direction) { order(title: direction) }
  scope :updated_at_ordered_by, ->(direction) { order(updated_at: direction) }
  scope :title_like, ->(str) { where('lower(title) like ?', "%#{str.downcase}%") }
  scope :recent, -> { updated_at_ordered_by(:desc) }
  scope :playlists_for_user, ->(user_id) { where(library_id: Library.where(user_id: user_id).try(:pluck, :id)) }

  delegate :user, to: :library
end
