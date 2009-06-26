Factory.sequence(:login) {|n| "foobar#{n}"}
Factory.sequence(:email) {|n| "user#{n}@example.com"}
Factory.define :user do |u|
  u.first_name 'Rajib'
  u.last_name 'Chowdhury'
  u.login { Factory.next(:login) }
  u.email { Factory.next(:email) }
  u.password pw = '0rbital'
  u.password_confirmation pw
end
