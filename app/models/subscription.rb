class Subscription < ApplicationRecord
  belongs_to :tea
  belongs_to :customer
  enum status: [:pending, :active, :inactive]

  validates :status, presence: true
  validates :price, presence: true
  validates :title, presence: true
  validates :frequency, presence: true
end
