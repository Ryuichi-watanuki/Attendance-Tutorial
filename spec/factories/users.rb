# 一般利用者
FactoryBot.define do
  
  factory :admin, class: User do
    name { "システム管理者" }
    email { "admin@email.com" }
    department { "管理者" }
    basic_time { Time.current.change(hour: 8, min: 0, sec: 0) }
    work_time { Time.current.change(hour: 7, min: 30, sec: 0) }
    admin { true }
    password { "password" }
    password_confirmation { "password" }
  end
  
  factory :user, class: User do
    name { "User1" }
    sequence(:email) { |n| "user#{n}@email.com" }
    basic_time { Time.current.change(hour: 8, min: 0, sec: 0) }
    work_time { Time.current.change(hour: 7, min: 30, sec: 0) }
    password { "password" }
    password_confirmation { "password" }
  end
end
