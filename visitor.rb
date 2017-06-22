module Visitable
  def accept(visitor)
    visitor.visit(self)
  end
end

class Employee
  include Visitable
  attr_accessor :name, :hours_worked

  def initialize(name)
    @name = name
    @hours_worked = 0
  end

  def work
    @hours_worked += 1
  end
end

class PizzaParlor
  attr_accessor :budget, :name, :employees
  def initialize(name)
    @name = name
    @budget = 1000
  end
end

class Cashier < Employee
  attr_accessor :sales

  def initialize(name)
    super
    @sales = []
  end

  def work
    super
    @sales << [*1..5].sample
  end
end

class Manager < Employee
  attr_accessor :pizza_parlor
  def initialize(name, pizza_parlor)
    super name
    @pizza_parlor = pizza_parlor
  end

  def work
    super
    pizza_parlor.budget += [*-10..10].sample
  end

  def accept(visitor)
    puts "Manager: I generated that report you asked for"
    puts "\n"
    pizza_parlor.employees.each do |emp|
      visitor.visit(emp)
    end
  end
end

class Cook < Employee
  attr_accessor :pizza_count

  def initialize(name)
    super
    @pizza_count = 0
  end

  def work
    super
    @pizza_count += [*1..5].sample
  end
end

class PizzaParlorEmployeeVisitor
  def visit(employee)
    a = employee.class
    case [a]
      when [Cashier]
        cashier_report(employee)
      when [Cook]
        cook_report(employee)
      when [Manager]
        manager_report(employee)
      else
        puts "¯\\_(ツ)_/¯"
    end
  end

  def cashier_report(cashier)
    puts "#{cashier.name} sells an average of #{cashier.sales.reduce(:*) / cashier.hours_worked} pizza(s) an hour"
    puts "Remind #{cashier.name} to smile when selling pizza!"
    puts "\n"
  end

  def cook_report(cook)
    puts "#{cook.name} cooks an average of #{cook.pizza_count / cook.hours_worked} pizza(s) an hour"
    puts "#{cook.name} must love pizza by now"
    puts "\n"
  end

  def manager_report(manager)
    current_budget = manager.pizza_parlor.budget
    puts "When I started, #{manager.pizza_parlor.name} had a budget of $1000"
    puts "#{manager.pizza_parlor.name} now has a budget of $#{current_budget}"
    if current_budget < 1000
      puts "I need to cut some corners"
    else
      puts "Thanks me!"
    end
    puts "\n"
  end
end

pp = PizzaParlor.new('Pizza Planet')
ca = Cashier.new('Becky')
co = Cook.new('Tony')
m = Manager.new('Rick', pp)
emp = Employee.new('Mike')
ppev = PizzaParlorEmployeeVisitor.new
employees = [ca, co, m, emp]
pp.employees = employees.each do |e|
  [*1..5].sample.times {e.work}
end
m.accept(ppev)
