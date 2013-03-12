
task :runDailyEmail  => [:environment] do
  birthday_users = User.birthday_2_weeks_from_today
  
  birthday_users.each do |u|
    u.sendEmails
  end
  
end
