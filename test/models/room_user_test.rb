# == Schema Information
#
# Table name: room_users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_room_users_on_room_id  (room_id)
#  index_room_users_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (room_id => rooms.id)
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class RoomUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
