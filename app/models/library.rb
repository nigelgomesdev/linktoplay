# == Schema Information
#
# Table name: libraries
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Library < ApplicationRecord
  belongs_to :user
  has_many :playlists
  has_many :tracks
end
