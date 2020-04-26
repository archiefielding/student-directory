@students = [] #an empty array accessible to all methods

def input_students
  puts "Please enter the following for each student."
  puts "To finish, simply hit return twice."
  #create empty array
#  students = []
  #get the first name
  puts "Name:"
  name = gets.capitalize.chomp
  #while the name is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the array
    @students << {name: name, cohort: :November}
    puts "Now we have #{@students.count} student(s)"
    #get another name from the user
    puts "Name:"
    name = gets.capitalize.chomp
  end
end

def print_header
  puts "|--------------------------------|"
  puts "|The Students of Villains Academy|"
  puts "|--------------------------------|"
end

def print_students_list
  @students.each_with_index do |student, index|
      puts "#{index+1}: #{student[:name]}, (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students."
  puts "----------------------------------"
end

def print_menu
  puts "1. Input the students."
  puts "2. Show the list of students."
  puts "3. Save the list to students.csv"
  puts "9. Exit."
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def save_students
  #open the file for writing
  file = File.open("students.csv", "w")
  #iterate over the list of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(", ")
    file.puts csv_line
  end
  file.close
end

interactive_menu
