# Template Pattern
class Restaurant
  def run(method)
	  take_order
	  prepare_food
	  deliver_food(method)
  end
end

# Pizza Pattern 
class Pizza 
  attr_accessor :toppings, :price, :state
  def initialize
  	@toppings = []
  	@price = 0
  	@state = 0
  end
end
 # To Decorator 
module AddCheese
  def self.add_cheese(piz)
  	piz.toppings << "Cheese"
  	piz.price += 1
  	piz
  end
end
 # To Decorator
module AddGreenPeppers 
  def self.add_green_peppers(piz)
  	piz.toppings << "Green Peppers"
  	piz.price += 1
  	piz
  end
end


class PizzaParlor < Restaurant
  attr_accessor :pizza
  def initialize 
  	@pizza = Pizza.new
  end

  # Decorator Pattern
  def take_order(order)
  	case order 
  	when "Cheese"
  	  AddCheese.add_cheese(@pizza)
  	when "Green Peppers"
  	  AddGreenPeppers.add_peppers(@pizza)
  	else
  	  "Sorry Not An Option"
  	end
  end
  # Strategy Pattern
  def deliver_food(strat)
  	strat.prepare_for_customer
  	strat.send_off_food
  	puts "Food Is Delivered"
  end

  # Chain of Responsibility Pattern 
  def prepare_food
    

  end
end


# Strategy Pattern
class SendToHome
  def prepare_for_customer
  	puts "sending to house"
  end
  def send_off_food
  	puts "Food is sending off to HOME!"
  end
end

# Strategy Pattern
class SendToTable
  def prepare_for_customer
  	puts "sending to Table"
  end
  def send_off_food
  	puts "Food is sending off to TABLE!"
  end
end


a = PizzaParlor.new
a.take_order("Cheese")
p a.pizza