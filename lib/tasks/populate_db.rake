namespace :populate_db do
  desc "Populate the database with fake data"
  task populate: :environment do
    require "faker"

    1.times do
      User.create(email: 'jorginhoffc@hotmail.com', password: "123456")
      User.create(email: 'jorgecoutinho2013@outlook.com', password: "123456")
    end

    5.times do
      Tag.create(name: Faker::Book.genre)
    end

    10.times do
      post = Post.new(title: Faker::Book.title, user_id: [1,2].sample, tag_ids: [1, 2, 3, 4, 5].sample(2))
      post.body = Faker::Lorem.paragraphs(number: 15).join("\n\n")
      post.save
    end

    10.times do
      # anonymous comments
      c = Comment.new(post_id: Post.all.sample.id)
      c.body = Faker::Lorem.paragraphs(number: 1).join("\n\n")
      c.save
    end

    20.times do
      # authenticated comments
      c = Comment.new(post_id: Post.all.sample.id, user_id: [1,2].sample)
      c.body = Faker::Lorem.paragraphs(number: 1).join("\n\n")
      c.save
    end
    puts "Banco de dados populado com sucesso!"
  end
end
