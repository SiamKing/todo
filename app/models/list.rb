class List < ApplicationRecord
    belongs_to :user
    has_many :items
    validates :name, presence: true
    validates :name, uniqueness: { scope: :user }
end
