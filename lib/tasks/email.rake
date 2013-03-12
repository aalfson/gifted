
task :runDailyEmail  => [:environment] do
  puts "Sending email for birthdays 2 weeks from today....."

  birthday_users = User.birthday_2_weeks_from_today
  
  birthday_users.each do |u|
    u.sendEmails
  end

  puts "runDailyEmail completed."
end
