class Room < ApplicationRecord
  has_many :mesages, dependent: :destroy
  has_many :entries, dependent: :destroy
end
