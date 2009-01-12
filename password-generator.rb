class PasswordGenerator
  
  @@an   = (65..122).to_a
  @@anp  = (33..126).to_a
  
  def PasswordGenerator.run(entry)
    range, num = parse(entry)
    password = ''
    num.times { password << randomize(range) } # Here happens all the magic!
    return password
  end
  
  def PasswordGenerator.parse(entry)
    chars, num = split(entry)
    return get_range(chars), num.to_i
  rescue
    # Error handling?
  end
  
  def PasswordGenerator.split(entry)
    chars = entry.match(/A[a-z]+/).to_s     # extracts the range variable name
    num = entry[chars.length, entry.length] # extracts the number
    return chars, num
  end
  
  def PasswordGenerator.get_range(chars)
    class_variable_get "@@#{chars}" # if class_variable_defined? "@@#{chars}"
  rescue
    # Error handling?
  end
  
  def PasswordGenerator.randomize(range)
    range[rand(range.length)].chr
  end
 
  private_class_method :parse, :split, :get_range, :randomize
end
 
 
# Define the valid entries for this program
valid_entries = ['an8', 'an16', 'anp8', 'anp16']
 
greeting = <<HERE
 
PASSWORD GENERATOR
------------------
At the prompt
   >> an8   generates an 8 digit alphanumeric password
   >> an16  generates a 16 digit alphanumeric password
   >> anp8  generates an 8 digit alphanumeric password with punctuation
   >> anp16 generates a 16 digit alphanumeric password with punctuation
HERE
 
print greeting + ">> "
entry = gets.chomp
farewell = 'Here is your new password: '
 
while entry
  if valid_entries.include? entry
    puts "\n#{farewell} #{PasswordGenerator.run(entry)}\n\n"
    exit
  else
    puts "Wrong value. Please try again."
    print ">> "
    entry = gets.chomp
  end
end