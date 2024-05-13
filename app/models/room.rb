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

    scope :ordered, -> { order(created_at: :desc) }

    # broadcasting

    # after_create_commit -> { broadcast_prepend_later_to "rooms" }
    # after_update_commit -> { broadcast_replace_later_to "rooms" }
    # after_destroy_commit -> { broadcast_remove_to "rooms" }
    # The above 3 callbacks are equivalent to the following single line
    broadcasts_to -> (room) { "rooms" }, inserts_by: :prepend
end
