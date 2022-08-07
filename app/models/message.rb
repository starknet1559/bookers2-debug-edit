class Message < ApplicationRecord
  validates :content, presence: true
  #メッセージが空白の場合、保存されないようにする
  belongs_to :user
  belongs_to :room
end
