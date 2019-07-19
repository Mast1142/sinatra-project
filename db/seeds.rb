User.create(
  username: "Sam",
  email: "sam@gmail.com",
  password: "password"
)

3.times do |index|
  Model.create(
    context: "#{index}",
    number: 123,
    user_id: 1
  )
end
