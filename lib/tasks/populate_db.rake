namespace :populate_db do
  desc "Populate the database with fake data"
  task populate: :environment do
    require "faker"

    1.times do
      User.create(email: 'example@com', password: "123456")
      User.create(email: 'jorgecoutinho2013@outlook.com', password: "123456")
    end

    5.times do
      Tag.create(name: Faker::Book.genre)
    end

    5.times do
      post = Post.new(title: Faker::Book.title, user_id: [1,2].sample, tag_ids: [1, 2, 3, 4, 5].sample(2))
      post.body = Faker::Lorem.paragraphs(number: 7).join("\n\n")
      post.save
    end
    puts "Banco de dados populado com sucesso!"
  end
end
