require 'httparty'
class Kele
    include HTTParty
    base_uri 'https://www.bloc.io/api/v1'
    
    def initialize(email, password)
        @auth = self.class.post('/sessions', {email: email, password: password})
    end
end