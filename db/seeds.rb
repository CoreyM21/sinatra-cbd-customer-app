# here is where I will create some seed data to work with and test associations

# Create 2 users

corey = User.create(name: "Corey", email: "coreyjmartin2@gmail.com", password: "password") 
christina = User.create(name: "Christina", email: "christina@gmail.com", password: "password") 

# create some customer entries

CustomerEntry.create(content: "Corey Martin / 10 Hickory Street Central Islip NY 11722 / 631-258-2001 / called", user_id: corey.id)

#use active record to pre-associate data:

corey.customer_entries.create(content: "This is a test")

christina_entry = christina.customer_entries.build(content: "DO NOT CALL COREY")
christina_entry.save
