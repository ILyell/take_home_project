This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
r = Random.new
teas = []
1000.times do
    tea = { 
        title: Faker::Tea.variety,
        description: Faker::Tea.type,
        temperature: Faker::Number.decimal(l_digits: 2, r_digits: 1),
        brew_time: Faker::Number.decimal(l_digits: 1, r_digits: 2).to_s
    }
    
    teas << tea
end
Tea.insert_all(teas)
puts "Teas Created!"

customers = []
2000.times do
    customer = { first_name: Faker::Name.first_name,
                last_name: Faker::Name.last_name,
                email: Faker::Internet.email,
                address: Faker::Address.full_address
    }
    customers << customer
end

Customer.create(customers)
puts "Customers Created!"

customers = Customer.all

status = ["pending","active","inactive"]
frequency = ["Monthly", "Bi-Annually", "Annually"]

customers[1..500].each do |customer|
    subscriptions = []
    5.times do
        subscription = {
            tea_id: r.rand(1..1000),
            customer_id: customer.id,
            title: Faker::Tea.variety,
            price:  Faker::Number.decimal(l_digits: 2, r_digits: 2),
            status: status[r.rand(1..3)],
            frequency:  frequency[r.rand(1..3)]
        }
        subscriptions << subscription
    end
    Subscription.insert_all(subscriptions)  
end
puts "Subscriptions Created!"

customers[501..1000].each do |customer|
    subscriptions = []
    15.times do
        subscription = {
            tea_id: r.rand(1..1000),
            customer_id: customer.id,
            title: Faker::Tea.variety,
            price:  Faker::Number.decimal(l_digits: 2, r_digits: 2),
            status: status[r.rand(1..3)],
            frequency:  frequency[r.rand(1..3)]
        }
        subscriptions << subscription
    end
    Subscription.insert_all(subscriptions)  
end
puts "Subscriptions Created!"

customers[1001..1500].each do |customer|
    subscriptions = []
    50.times do
        subscription = {
        tea_id: r.rand(1..1000),
        customer_id: customer.id,
        title: Faker::Tea.variety,
        price:  Faker::Number.decimal(l_digits: 2, r_digits: 2),
        status: status[r.rand(1..3)],
        frequency:  frequency[r.rand(1..3)]
        }
        subscriptions << subscription
    end
    Subscription.insert_all(subscriptions)  
end
puts "Subscriptions Created!"

customers[1501..1700].each do |customer|
    subscriptions = []
    100.times do
        subscription = {
        tea_id: r.rand(1..1000),
        customer_id: customer.id,
        title: Faker::Tea.variety,
        price:  Faker::Number.decimal(l_digits: 2, r_digits: 2),
        status: status[r.rand(1..3)],
        frequency:  frequency[r.rand(1..3)]
        }
        subscriptions << subscription
    end
    Subscription.insert_all(subscriptions)
end
puts "Subscriptions Created!"

customers[1701..1900].each do |customer|
    subscriptions = []
    500.times do
        subscription = {
        tea_id: r.rand(1..1000),
        customer_id: r.rand(1701..1900),
        title: Faker::Tea.variety,
        price:  Faker::Number.decimal(l_digits: 2, r_digits: 2),
        status: status[r.rand(1..3)],
        frequency:  frequency[r.rand(1..3)]
        }
        subscriptions << subscription
    end
    Subscription.insert_all(subscriptions)  
end
puts "Subscriptions Created!"

customers[1901..1999].each do |customer|
    subscriptions = []
    1000.times do
        subscription = {
        tea_id: r.rand(1..1000),
        customer_id: customer.id,
        title: Faker::Tea.variety,
        price:  Faker::Number.decimal(l_digits: 2, r_digits: 2),
        status: status[r.rand(1..3)],
        frequency:  frequency[r.rand(1..3)]
        }
        subscriptions << subscription
    end
    Subscription.insert_all(subscriptions)  
end
puts "Subscriptions Created!"