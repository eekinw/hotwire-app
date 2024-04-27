# == Schema Information
#
# Table name: rooms
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Room < ApplicationRecord
    validates :name, presence: true
    has_many :messages, dependent: :destroy
end
