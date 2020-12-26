User.create!(name:  "管理者",
             email: "admin@example.com",
             password:  "qqqqqq",
             password_confirmation: "qqqqqq",
             admin: true)
%W[仕事 趣味 家事].each { |a| Label.create(name: a) }
