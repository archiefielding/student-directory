@students = [] #an empty array accessible to all methods

def input_students
  puts "Please enter the following for each student."
  puts "To finish, simply hit return twice."
  #create empty array
#  students = []
  #get the first name
  puts "Name:"
  name = STDIN.gets.capitalize.chomp
  #while the name is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the array
    @students << {name: name, cohort: :November}
    puts "Now we have #{@students.count} student(s)"
    #get another name from the user
    puts "Name:"
    name = STDIN.gets.capitalize.chomp
  end
end

def print_header
  #print the student list header
  puts "|--------------------------------|"
  puts "|The Students of Villains Academy|"
  puts "|--------------------------------|"
end

def print_students_list
  #print the list of students
  @students.each_with_index do |student, index|
      puts "#{index+1}: #{student[:name]}, (#{student[:cohort]} cohort)"
  end
end

def print_footer
  #print the stude list footer
  puts "Overall, we have #{@students.count} great students."
  puts "----------------------------------"
end

def print_menu
  #print the menu options
  puts "1. Input the students."
  puts "2. Show the list of students."
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit."
end

def show_students
  #show the header, student list and footer
  print_header
  print_students_list
  print_footer
end

def process(selection)
  #run method based off menu selection
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def interactive_menu
  #constantly run the interactive menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
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
  puts "Saved to file."
end

def load_students(filename = "students.csv")
  #open the filename for reading
  file = File.open(filename, "r")
  #iterate the file lines into the @students array
  file.readlines.each do |line|
    name, cohort = line.chomp.split(', ')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first #first argument from the command line
  return if filename.nil? #get out of the method if it isn't given
  if File.exists?(filename) #if it exists
    load_students(filename)
    puts "Loaded #{@students.count} student(s) from #{filename}"
  else #if it doesn't exist
    puts "Sorry, #{filename} does not exist."
    exit #quit the program
  end
end

try_load_students #attempts to load the list of students
interactive_menu #run the program
