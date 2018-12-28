# == Schema Information
#
# Table name: sources
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  status     :string           default("active")
#  domain     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Source < ApplicationRecord
enum status: { 
    active: "active",
    blocked: "blocked"
  }
end
