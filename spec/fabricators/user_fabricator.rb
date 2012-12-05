Fabricator :user do
  email { sequence(:email) { |i| "user#{i}@example.com" } }
  password "password"
  password_confirmation { |u| u.password }
  time_zone "Eastern Time (US & Canada)"
end
