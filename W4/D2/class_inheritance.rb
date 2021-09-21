require "byebug"

class Employee

  attr_accessor :name, :title, :salary, :boss

  def initialize(name, title, salary, boss=nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    bonus = @salary * multiplier
  end

end

class Manager < Employee

  def initialize(name, title, salary, boss, employees)
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    # debugger
    total_salary = 0
    @employees.each do |employee|
      if employee.is_a?(Manager)
        total_salary += employee.salary
        total_salary += employee.bonus(1)
      else
        total_salary += employee.salary
      end
    end
    total_salary * multiplier
  end

end


shawna = Employee.new("Shawna", "TA", 12000)
david = Employee.new("David", "TA", 10000)
darren = Manager.new("Darren", "TA Manager", 78000, nil, [shawna, david])
ned = Manager.new("Ned", "Founder", 1000000, nil, [darren])
shawna.boss = darren
david.boss = darren
darren.boss = ned

p david.is_a?(Manager)


p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000