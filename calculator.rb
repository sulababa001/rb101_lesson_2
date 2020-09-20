require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')
LANGUAGE = 'en'

num1 = ''
num2 = ''

def messages(message, lang)
  MESSAGES[lang][message]
end

def prompt(key)
  message = messages(key, LANGUAGE)
  Kernel.puts("=> #{message}")
end

def name_invalid?(word)
  word.match(/[  ]/) || word.empty?
end

def integer?(num)
  num.to_i().to_s() == num
end

def float?(num)
  num.to_f
end

def get_name
  name = ''
  loop do
    name = Kernel.gets().chomp()
    if name_invalid?(name)
      prompt('inv_name')
    else
      break
    end
  end
  name
end

def get_number
  num = ''
  loop do
    num = Kernel.gets().chomp()
    if !num.match(/[a-z]/i) && integer?(num) && float?(num)
      break
    else
      prompt('inv_num')
    end
  end
  num
end

def get_operator
  operator = ''
  loop do
    operator = Kernel.gets().chomp()
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt('must')
    end
  end
  operator
end

def operator_to_message(op)
  word = case op
         when '1'
           'Addition'
         when '2'
           'Subtraction'
         when '3'
           'Multiplication'
         when '4'
           'Division'
         end
  word
end

def calculate_result(num1, num2, operation)
  result = case operation
           when '1'
             num1.to_i() + num2.to_i()
           when '2'
             num1.to_i() - num2.to_i()
           when '3'
             num1.to_i() * num2.to_i()
           when '4'
             check_zero_division(num1, num2)
           end
  result
end

def check_zero_division(num1, num2)
  loop do
    if num1.to_f != 0 && num2.to_f == 0
      prompt('zero')
      num2 = get_number()
    else
      break
    end
  end
  num1.to_f() / num2.to_f()
end

prompt('dash')
prompt('welcome')
name = get_name()
Kernel.puts 'Hello, ' + name + '!'

loop do
  prompt('num1')
  num1 = get_number
  prompt('num2')
  num2 = get_number
  prompt("operator")
  operation = get_operator()
  result = calculate_result(num1, num2, operation)
  word = operator_to_message(operation)
  Kernel.puts("#{word} of the two numbers is:  #{result}")
  prompt('dash')
  prompt('would')
  response = Kernel.gets().chomp()
  break if response.match(/[^y]/i)
  puts "\e[H\e[2J"
end
prompt('bye')
