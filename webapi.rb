# http://localhost:4567/
require 'sinatra'
require 'json'
require 'gyoku'

users = {
  thibault: { first_name: 'Thibault', last_name: 'Denizet', age: 25 },
  simon:    { first_name: 'Simon', last_name: 'Random', age: 26 },
  john:     { first_name: 'John', last_name: 'Smith', age: 28 }
}

helpers do
  def json_or_default?(type)
    ['application/json', 'application/*', '*/*'].include?(type.to_s)
  end

  def xml?(type)
    type.to_s == 'application/xml'
  end

  def accepted_media_type
    return 'json' unless request.accept.any?

    request.accept.each do |mt|
      return 'json' if json_or_default?(mt)
      return 'xml' if xml?(mt)
    end

    halt 406, 'Not Acceptable'
  end
end

get '/' do
  'Master Ruby Web APIs - Chapter 2'
end

get '/users' do
  type = accepted_media_type

  if type == 'json'
    content_type 'application/json'
    users.map { |name, data| data.merge(id: name) }.to_json
  elsif type == 'xml'
    content_type 'application/xml'
    Gyoku.xml(users: users)
  end
end
