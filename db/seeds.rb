User.create!(name:  "管理者",
             email: "admin@example.com",
             password:  "qqqqqq",
             password_confirmation: "qqqqqq",
             admin: true)
%W[仕事 趣味 家事].each { |a| Label.create(name: a) }
10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(
               id: n+2,
               name: name,
               email: email,
               password: password,
               password_confirmation: password,
               )
end
10.times do |n|
  name = Faker::Games::Pokemon.name
  content = Faker::Games::Pokemon.name
  user = User.find(n+2)
  Task.create!(name: name,
               content: content,
               user: user
               )
end
Task.all.ids.sort.each do |task_id|
  Label.all.ids.sort.each do |label_id|
    Labelling.create(task_id: task_id, label_id: label_id)
  end
end
