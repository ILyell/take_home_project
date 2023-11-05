class Customer < ApplicationRecord
    has_many :subscriptions
    has_many :teas, through: :subscriptions
    validates :email, uniqueness: true
end
