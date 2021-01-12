# here is where I will create some seed data to work with and test associations

# Create 2 users

corey = User.create(name: "Corey", email: "coreyjmartin2@gmail.com", password: "password") 
christina = User.create(name: "Christina", email: "christina@gmail.com", password: "password") 

# create some customer entries

CustomerEntry.create(title: "Corey Martin", content: "10 Hickory Street Central Islip NY 11722", phone: "6312582001", user_id: corey.id)

#use active record to pre-associate data:

corey.customer_entries.create(title: "Test", content: "This is a test", phone: "123")

christina_entry = christina.customer_entries.build(title: "Don't Call", content: "DO NOT CALL COREY", phone: "0")
christina_entry.save
