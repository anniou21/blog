# db/seeds.rb
require "faker"

puts "🧹 Nettoyage des tables..."
Comment.delete_all
Category.delete_all
Post.delete_all
Blog.delete_all
User.delete_all

Faker::UniqueGenerator.clear

puts "👤 Création des users (Devise)..."
users = []

10.times do
  password = Faker::Internet.password(min_length: 10)
  users << User.create!(
    email: Faker::Internet.unique.email,
    password: password,
    password_confirmation: password
  )
end

puts "🗂 Création des blogs (liés aux users)..."
blogs = []

users.each do |user|
  rand(1..3).times do
    blogs << Blog.create!(
      user_id: user.id,
      name: Faker::Company.catch_phrase
    )
  end
end

puts "📝 Création des posts (liés aux blogs)..."
posts = []

blogs.each do |blog|
  rand(5..12).times do
    posts << Post.create!(
      blog_id: blog.id,
      title: Faker::Lorem.sentence(word_count: 6),
      body: Faker::Lorem.paragraphs(number: 6).join("\n\n")
    )
  end
end

puts "💬 Création des comments (liés aux posts)..."
posts.each do |post|
  rand(2..8).times do
    Comment.create!(
      post_id: post.id,
      description: Faker::Lorem.sentences(number: 2).join(" ")
    )
  end
end

puts "🏷 Création des categories (liées aux posts)..."
category_pool = [
  "Tech", "Business", "Marketing", "Productivité", "Design",
  "Dev Web", "Freelance", "Startup", "SEO", "WordPress", "Framer"
]

posts.each do |post|
  rand(1..3).times do
    Category.create!(
      post_id: post.id,
      name: category_pool.sample,
      description: Faker::Lorem.sentence
    )
  end
end

puts "✅ Seed terminé !"
puts "Users: #{User.count} | Blogs: #{Blog.count} | Posts: #{Post.count} | Comments: #{Comment.count} | Categories: #{Category.count}"
