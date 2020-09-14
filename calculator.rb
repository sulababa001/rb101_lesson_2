require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')
LANGUAGE = 'en'

def messages(message, lang)
  MESSAGES[lang][message]
end

def prompt(key)
  message = messages(key, LANGUAGE)
  Kernel.puts("=> #{message}")
end

def empty_string?(word)
  word.empty?
end

def integer?(num)
  num.to_i().to_s() == num
end

def float?(num)
  num.to_f
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

prompt('welcome')
name = Kernel.gets().chomp()
if empty_string?(name)
  prompt('inv_name')
else
  Kernel.puts("Hello, #{name}")
end
prompt('dash')

loop do
  num1 = ''

  loop do
    prompt('num1')
    num1 = Kernel.gets().chomp()
    if integer?(num1) || float?(num1)
      break
    else
      prompt('inv_num')
    end
  end

  num2 = ''
  loop do
    prompt('num2')
    num2 = Kernel.gets().chomp()
    if integer?(num2) || float?(num2)
      break
    else
      prompt('inv_num')
    end
  end

  operator = <<-HEREDOC

  1 for Addition
  2 for Subtraction
  3 for Multiplication
  4 for Division
  HEREDOC

  prompt('operator')
  puts("...and press enter #{operator}")

  operation = ''

  loop do
    operation = gets().chomp()
    if %w(1 2 3 4).include?(operation)
      break
    else
      prompt('must')
    end
  end

  result = case operation
           when '1'
             num1.to_i() + num2.to_i()
           when '2'
             num1.to_i() - num2.to_i()
           when '3'
             num1.to_i() * num2.to_i()
           when '4'
             num1.to_f() / num2.to_f()
           end
  Kernel.puts("#{operator_to_message(operation)} of the two numbers: #{result}")
  prompt('dash')
  prompt('would')
  response = Kernel.gets().chomp()
  break unless response.downcase.start_with?('y')
end
prompt('bye')
