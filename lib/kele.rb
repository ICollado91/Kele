require 'httparty'
class Kele
    include HTTParty
    base_uri 'https://www.bloc.io/api/v1'
    
    def initialize(email, password)
        post_response = self.class.post("/sessions", body: {"email": email, "password": password})
        raise "There was an error, check your input." if post_response.code != 200  
        @auth_token = post_response["auth_token"]
    end
    
    def get_me
        get_response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
        @user_data = JSON.parse(get_response.body) #user data is now a ruby hash!
    end
    
end