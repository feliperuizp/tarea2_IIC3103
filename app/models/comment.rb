class Comment < ApplicationRecord
    belongs_to :article, optional: true

    validates :author, presence: true
    validates :comment, presence: true

end
