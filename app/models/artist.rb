# frozen_string_literal: true

# == Schema Information
#
# Table name: artists
#
#  id         :bigint(8)        not null, primary key
#  fullname   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Artist
class Artist < ApplicationRecord
  include Scopable
  validates :fullname, presence: true
  scope :fullname_like, ->(str) { where('lower(fullname) like ?', "%#{str.downcase}%") }
end
