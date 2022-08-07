class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  #フォローする側のUserから見て、フォローされる側のUserを(中間テーブルを介して)集める。なので親はfollower_id(フォローする側)
  has_many :active_relationships, class_name: "Relationship",foreign_key: :follower_id,dependent: :destroy
  # 中間テーブルを介して「follower」モデルのUser(フォローされた側)を集めることを「followings」と定義
  has_many :followings, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship",foreign_key: :followed_id,dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  #二人のユーザーが複数のメッセージを送れるようにするために中間テーブルを作成
  has_many :messages, dependent: :destroy
  #相互のユーザーはroomsテーブルというチャットルームに属しているユーザーとroomは多対多
  has_many :entries, dependent: :destroy
  has_one_attached :profile_image

  validates :name,presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction,presence: false, length: { maximum: 50 }



def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
    profile_image.variant(resize_to_limit: [width, height]).processed
end

def followed_by?(user)
  passive_relationships.find_by(follower_id: user.id).present?
end

def self.look(search, word)
  if search == "perfect_match"
    @user = User.where("name LIKE?", "#{word}")
  elsif search == "forward_match"
    @user = User.where("name LIKE?", "#{word}%")
  elsif search == "backward_match"
    @user = User.where("name LIKE?", "%#{word}")
  elsif search == "partial_match"
    @user = User.where("name LIKE?", "%#{word}%")
  else
    @user = User.all
  end
end

end
