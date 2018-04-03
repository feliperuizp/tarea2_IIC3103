class Article < ApplicationRecord
	has_many :comments, :dependent => :delete_all
	validates :title, presence: true
	validates :subtitle, presence: false
	validates :body, presence: true
end