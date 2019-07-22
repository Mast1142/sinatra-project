User.destroy_all
Task.destroy_all

User.create(
  username: "Sam",
  email: "sam@gmail.com",
  password: "password"
)

3.times do |index|
  Task.create(
    content: "#{index}",
    user_id: 1
  )
end
