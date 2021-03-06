@students = [] #an empty array accessible to all methods

def input_students
  puts "Please enter the following for each student."
  answer = "Y"
  #while the answer is not Y, repeat this code
  while answer == "Y" do
    puts "Now we have #{@students.count} student(s)"
    #get another name from the user
    puts "Name:"
    name = STDIN.gets.capitalize.chomp
    puts "Cohort:"
    cohort = STDIN.gets.capitalize.chomp
    add_students_to_array(name, cohort)
    puts "Would you like to add another student? (Y/N)"
    answer = STDIN.gets.capitalize.chomp
    while answer != "Y"
      if answer == "N"
        return
      else
        puts "Please enter \"Y\" or \"N\""
        answer = STDIN.gets.capitalize.chomp
      end
    end
  end
end

def add_students_to_array(name, cohort)
  #add a student hash to the @studets array
  @students << {name: name, cohort: cohort}
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
  puts "What would you like to do?"
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
      puts "Thank you, come again!"
      exit
    else
      puts "Please enter a menu number."
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
    add_students_to_array(name, cohort)
  end
  puts "Loaded #{@students.count} student(s) from #{filename}"
  file.close
end

def try_load_students
  filename = ARGV.first #first argument from the command line
  if filename.nil? #if no filename is provided
    load_students("students.csv")
  elsif File.exists?(filename) #if it exists
    load_students(filename)
  else #if it doesn't exist
    puts "Sorry, #{filename} does not exist."
    exit #quit the program
  end
end

try_load_students #attempts to load the list of students
interactive_menu #run the program
