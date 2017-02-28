class Category < ApplicationRecord
  validates(:name, {presence: true, uniqueness: {message: "must be unique!"}})
end
