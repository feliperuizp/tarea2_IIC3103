class Comment < ApplicationRecord
    belongs_to :article

    validates :author, presence: true
    validates :cbody, presence: true
end
