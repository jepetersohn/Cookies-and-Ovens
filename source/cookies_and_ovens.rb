# Answer These Questions:

# - What are essential classes?
#      Cookie and Oven will be the base classes with specific types of cookies inheriting from Cookie.
# - What attributes will each class have?
#      Cookie with have the amount of time its been in the oven. The specific cookies will have the amount of baking
#      time it will take to finish the cookie. Oven will have the current temp and the contents as an array.
# - What interface will each class provide?
#      Cookie will be able to give its status and bake for one minute. Oven will have a check for if it is up to temp
#      to begin baking, preheat that will heat it to a specific temp, put in a specific cookie, take out a specific
#      cookie, elapse one unit of time, turn off which sets temp to 0, the status of the contents of the over, and
#      if something in the oven is done baking.
# - How will the classes interact with each other?
#      The specific types of cookies will just inherit from cookie. Then oven will contain cookies.
# - Which classes will inherit from others, if any?
#      The specific types of cookies will inherit from cookie.


class Cookie
  def initialize
    @time_in_oven = 0
  end

  def status
    return "doughy" if @time_in_oven * 100 / @baking_time < 50
    return "almost_ready" if @time_in_oven * 100 / @baking_time < 99
    return "ready" if @time_in_oven % @baking_time == 0
    return "burnt" if @time_in_oven > @baking_time
  end

  def bake_one_minute
    @time_in_oven += 1
  end
end

class ChocolateChip < Cookie
  def initialize
    super
    @baking_time = 20
  end
end

class SugarCookie < Cookie
  def initialize
    super
    @baking_time = 15
  end
end

class OatmealCookie < Cookie
  def initialize
    super
    @baking_time = 25
  end
end

class Oven
  attr_reader :contents

  def initialize
    @temp = 0
    @contents = []
  end

  def up_to_temp
    @temp == 350
  end

  def preheat(temp)
    @temp = temp
    puts "Oven is preheated to #{@temp}."
  end

  def put_in(cookie)
    if up_to_temp
      @contents.push(cookie)
      puts "#{cookie.class} was put in the oven."
    else
      puts "Oven is not preheated."
    end
  end

  def take_out(cookie)
    @contents.delete(cookie)
    puts "#{cookie.class} was removed from the oven."
  end

  def elapse_one_minute
    @contents.each do |cookie|
      cookie.bake_one_minute
    end
    puts "Something in the oven is ready" if something_ready
  end

  def turn_off
    @temp = 0
    puts "The oven was turned off."
  end

  def status_of_contents
    statuses = {}
    @contents.each do |cookie|
      statuses[cookie.class] = cookie.status
    end
    statuses
  end

  def something_ready
    @contents.each do |cookie|
      return true if cookie.status == "ready"
    end
    false
  end
end

oven = Oven.new

sugar_cookie = SugarCookie.new
oatmeal_cookie = OatmealCookie.new
chocochip_cookie = ChocolateChip.new
oven.put_in(sugar_cookie)
p oven.contents
oven.preheat(350)
oven.put_in(sugar_cookie)
oven.put_in(oatmeal_cookie)
oven.put_in(chocochip_cookie)

20.times { oven.elapse_one_minute }
p oven.status_of_contents
oven.take_out(chocochip_cookie)
p oven.contents
p chocochip_cookie.status
20.times { oven.elapse_one_minute }
p chocochip_cookie.status
p oven.status_of_contents
