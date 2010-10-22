Factory.define :user do |f|
  f.email { Factory.next(:email) }
end
