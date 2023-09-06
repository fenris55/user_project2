require "yaml"
require "sinatra"
require "sinatra/reloader"
require 'tilt/erubis'

before do  
   @users = YAML.load_file("users.yaml")
   @total_users = @users.keys.size
   @total_interests = get_total_interests(@users)
end

helpers do 
  def get_total_interests(users)
    count = 0
    @users.each do |name, data|
      count += data[:interests].size
    end
    count
  end
end

get "/" do 
  redirect "/users"
end

get "/users" do 
 erb :users
end

get "/users/:name" do 
  @user = params[:name]
  @email = @users[@user.to_sym][:email]
  @interests = @users[@user.to_sym][:interests]
  erb :user
end