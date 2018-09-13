require 'active_record'
require_relative '../config/environment'
require_relative "../lib/command_line_interface.rb"

system('clear')
welcome
puts "Are you a returning user?(y or n)"
y_or_n = gets.chomp
system('clear')
case y_or_n

  when "y"
  puts "What is your name?"
  ans_name = gets.chomp
    if @user = User.find_by(name: ans_name)
        system('clear')
        puts "Welcome back #{@user.name}"
        run_app
    else puts "Name not found."
        @user = create_new_user
          puts "Welcome #{@user.name}"
        run_app
    end
  when "n"
  # puts "What is your name?"
  @user = create_new_user
  system('clear')
  puts "Welcome #{@user.name}"
  run_app
else
  puts "Input not found"
  # puts "What is your name?"
  @user = create_new_user
  system('clear')
  puts "Welcome #{@user.name}"
end
