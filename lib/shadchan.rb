module Shadchan
  libdir = File.join(File.dirname(File.expand_path(__FILE__)), self.name.downcase, '')
  require libdir + 'solver.rb' # Your code goes here...
end
