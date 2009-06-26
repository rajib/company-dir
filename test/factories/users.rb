Factory.define :user do |u|
  u.login 'foobar'
  u.password pw = 'foo123!@#'
  u.password_confirmation pw
end
