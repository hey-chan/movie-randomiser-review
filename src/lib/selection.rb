require "artii"

def leave_app
  art = Artii::Base.new :font => 'slant'
  puts art.asciify('Good bye')
  puts "          Thanks for using this app"
  puts "               © Matthew Liu"
  exit
end