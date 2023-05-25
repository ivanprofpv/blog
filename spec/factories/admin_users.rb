FactoryBot.define do
  factory :admin_user do
    email { "admin@blog.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
