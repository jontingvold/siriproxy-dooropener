require 'cora'
require 'siri_objects'
require 'pp'
require 'open-uri'

#######
# Remember to add other plugins to the "config.yml" file if you create them!
######

class SiriProxy::Plugin::Example < SiriProxy::Plugin
  def initialize(config)
    
    # Answers to questions like "Can you please open the door", "Siri, open the door, please"
  end
  
  def generate_response()
    hour = Time.new.hour
    
    if hour.between(18, 21)
      messages = [
          "Have a pleasant evening sir",
          "As you wish sir",
    elsif hour.between(3, 6)
      messages = [
          "Do you know what time it is",
          "As you wish sir",
    else
      messages = [
        "As you wish sir",
        "Your welcome",
        "Welcome to Geir"]
    end
        
    return messages.sample
  end
  
  def open_the_door(text_message, voice_message)
    say text_message, spoken: voice_message
    
    # sleep 1.0    # Wait one secund before opening the door
    contents  = open('http://door.kulia.no') {}
    puts "Door opened!"
    
    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end

  listen_for /open the door/i do
    open_the_door("Door opened.", generate_message)
  end
  
  listen_for /open door/i do
    response = ask "What is the magic word?" #ask the user for something

        if(response =~ /please/i) #process their response
          open_the_door("Door opened.", "Your welcome")
        else 
          request_completed
        end
  end
  
  listen_for /unlock the door/i do
    open_the_door("Door opened.", generate_message)
  end
  
  listen_for /open up the door/i do
    open_the_door("Door opened.", generate_message)
  end
end
