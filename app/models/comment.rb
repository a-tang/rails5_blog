class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :body, presence: true

  def user_full_name
    user ? user.full_name : ""
  end

end
