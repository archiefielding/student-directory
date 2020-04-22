def input_students
  puts "Please enter the following for each student."
  puts "To finish, simply hit return twice."
  #create empty array
  students = []
  #get the first name
  puts "Name:"
  name = gets.capitalize.chomp
  #get the country of birth
  puts "Country of Birth:"
  cob = gets.capitalize.chomp
  #while the name or COB is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the array
    students << {name: name, cohort: :November, cob: cob}
    puts "Now we have #{students.count} student(s)"
    #get another name from the user
    puts "Name:"
    name = gets.capitalize.chomp
    #get the country of birth
    puts "Country of Birth:"
    cob = gets.capitalize.chomp
  end
  #return the array of students
  students
end

def print_header
  puts "The Students of Villains Academy"
  puts "----------------"
end

def print(students)
  students.each_with_index do |student, index|
      puts "#{index+1}: #{student[:name]}, #{student[:cob]}, (#{student[:cohort]} cohort)"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students."
end

students = input_students
print_header
print(students)
print_footer(students)
