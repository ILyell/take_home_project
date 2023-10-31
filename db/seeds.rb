

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
teas = []
100.times do
    tea = { title: Faker::Tea.variety,
            description: Faker::Tea.type,
            temperature: Faker::Number.decimal(l_digits: 2, r_digits: 1),
            brew_time: Faker::Number.decimal(l_digits: 1, r_digits: 2).to_s
    }
    teas << tea
end
Tea.insert_all(teas)

customers = []
10.times do
    customer = { first_name: Faker::Name.first_name,
                last_name: Faker::Name.last_name,
                email: Faker::Internet.email,
                address: Faker::Address.full_address
    }
    customers << customer
end
Customer.insert_all(customers)