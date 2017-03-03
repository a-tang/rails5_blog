class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  validates(:title, {presence: true, uniqueness: {message: "must be unique!"}})
  validates :body, presence: true
  def self.search(search)
    where("body ILIKE :search", search: "%#{search}%")
  end

  def user_full_name
    user ? user.full_name : ""
  end

  def like_for(user)
    likes.find_by_user_id user if user
  end

end
