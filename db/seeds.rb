# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
ProductCategory.destroy_all
OrderItem.destroy_all
Order.destroy_all
Customer.destroy_all
Product.destroy_all
Category.destroy_all
Province.destroy_all
Page.destroy_all

provinces = [
  ["Manitoba", 0.05, 0.07, 0.00],
  ["Ontario", 0.00, 0.00, 0.13],
  ["Alberta", 0.05, 0.00, 0.00],
  ["British Columbia", 0.05, 0.07, 0.00],
  ["Quebec", 0.05, 0.09975, 0.00]
]

provinces.each do |name, gst, pst, hst|
  Province.create!(
    name: name,
    gst_rate: gst,
    pst_rate: pst,
    hst_rate: hst
  )
end

coffee = Category.create!(
  name: "Coffee",
  description: "Locally roasted coffee products from Winnipeg and Manitoba suppliers."
)

tea = Category.create!(
  name: "Tea",
  description: "Loose leaf and packaged tea products for everyday use and gifts."
)

honey_jam = Category.create!(
  name: "Honey and Jam",
  description: "Local honey, jam, preserves, and sweet pantry products."
)

gift_boxes = Category.create!(
  name: "Gift Boxes",
  description: "Prepared pantry gift boxes for families, offices, and special occasions."
)

products = [
  ["Prairie Morning Coffee", "Medium roast coffee with smooth chocolate notes.", 1499, 30, coffee, true, true],
  ["Winnipeg Dark Roast", "Bold dark roast coffee for strong coffee lovers.", 1599, 25, coffee, false, true],
  ["Maple Breakfast Coffee", "Light roast coffee with a mild maple aroma.", 1399, 20, coffee, false, false],
  ["Manitoba Breakfast Tea", "Classic black tea blend for daily use.", 899, 40, tea, true, false],
  ["Wild Berry Herbal Tea", "Caffeine-free herbal tea with berry flavour.", 999, 35, tea, false, true],
  ["Mint Prairie Tea", "Refreshing mint tea for evenings and digestion.", 849, 28, tea, false, false],
  ["Clover Honey Jar", "Pure local clover honey from Manitoba farms.", 1299, 32, honey_jam, false, true],
  ["Blueberry Jam", "Small-batch blueberry jam made with real fruit.", 799, 24, honey_jam, true, false],
  ["Strawberry Rhubarb Jam", "Sweet and tart jam for toast and desserts.", 849, 22, honey_jam, false, false],
  ["Prairie Snack Box", "Gift box with local snacks and sweets.", 2999, 15, gift_boxes, true, true],
  ["Coffee Lover Gift Box", "Gift box with two coffees and local chocolate.", 3999, 12, gift_boxes, false, true],
  ["Tea and Honey Gift Set", "Tea collection with a local honey jar.", 3499, 18, gift_boxes, false, false]
]

products.each do |name, description, price_cents, stock_quantity, category, on_sale, new_arrival|
  product = Product.create!(
    name: name,
    description: description,
    price_cents: price_cents,
    stock_quantity: stock_quantity,
    active: true,
    on_sale: on_sale,
    new_arrival: new_arrival
  )

  ProductCategory.create!(
    product: product,
    category: category
  )
end

Page.create!(
  title: "About Prairie Pantry Market",
  slug: "about",
  content: "Prairie Pantry Market is a fictional Winnipeg business that sells local pantry products, including coffee, tea, honey, jam, snacks, and gift boxes."
)

Page.create!(
  title: "Contact Prairie Pantry Market",
  slug: "contact",
  content: "Customers can contact Prairie Pantry Market for product questions, gift box requests, and local order support."
)

puts "Seed complete."
puts "#{Province.count} provinces created."
puts "#{Category.count} categories created."
puts "#{Product.count} products created."
puts "#{Page.count} pages created."