# http://localhost:7000/hello_world
require 'ramaze'

class HelloWorld < Ramaze::Controller
  map '/hello_world'
  def index
    'Hello World!'
  end
end

Ramaze.start
