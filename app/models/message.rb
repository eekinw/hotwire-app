# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_id    :bigint           not null
#
# Indexes
#
#  index_messages_on_room_id  (room_id)
#
# Foreign Keys
#
#  fk_rails_...  (room_id => rooms.id)
#
class Message < ApplicationRecord
    belongs_to :room
    validates :content, presence: true

    # after create, update, destroy, broadcast changes to the room model

    # after_create_commit -> { broadcast_prepend_later_to :room }
    # after_update_commit -> { broadcast_replace_later_to :room }
    # after_destroy_commit -> { broadcast_remove_to :room }
    broadcasts_to :room, inserts_by: :append

end
