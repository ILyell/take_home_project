require 'rails_helper'

RSpec.describe Subscription, type: :model do

  describe 'initialize' do
    it 'stores status as an enum' do
      create(:customer)
      test_customer = Customer.first
      create(:tea)
      test_tea = Tea.first
      subscription = {
          "customer_id": test_customer.id,
          "tea_id": test_tea.id,
          "title": test_tea.title, 
          "price": Faker::Number.decimal(l_digits: 2, r_digits: 2),
          "status":  "active",
          "frequency": "Often" 
      }
      
      Subscription.create(subscription)
      subscription = Subscription.last
      expect(subscription.status).to eq("active")
      expect(subscription.pending?).to eq(false)
      expect(subscription.active?).to eq(true)
    end
  end
  describe 'relations' do
    it { should belong_to(:customer) }
    it { should belong_to(:tea) }
  end

  describe 'validations' do
    it 'validates' do
      validate_presence_of :status
      validate_presence_of :price
      validate_presence_of :title
      validate_presence_of :frequency
    end
  end
end
