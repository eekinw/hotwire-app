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
  has_many :room_users
  has_many :users, through: :room_users

  scope :ordered, -> { order(created_at: :desc) }

  # thee are 3 Active Record Callbacks that are used to broadcast changes to the room model
  # the 'later' suffix denotes async processing using ActiveJob, which is the recommended way to broadcast changes
  # 'later' denotes async processing using ActiveJob
  after_create_commit -> { broadcast_prepend_later_to "rooms" }
  after_update_commit -> { broadcast_replace_later_to "rooms" }
  after_destroy_commit -> { broadcast_remove_to "rooms" }
   # Those three callbacks are equivalent to the following single line
  # broadcasts_to ->(_room) { 'rooms' }, inserts_by: :prepend
  # there are 4 types of inserts_by options we can choose when broadcasting: :prepend, :append, :before, :after
end

# more examples:

# 基本（同期処理）
# @cat.broadcast_prepend_to "cats"

# ActiveJobを利用した非同期処理
# @cat.broadcast_prepend_later_to "cats"

# broadcast_prepend_toの引数がself版（ストリームがselfに設定される）
# @cat.broadcast_prepend

# ActiveJobを利用した非同期処理 + broadcast_prepend_toの引数がself版（ストリームがselfに設定される）
# @cat.broadcast_prepend_later
