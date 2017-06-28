require 'httparty'
require './lib/roadmap.rb'

class Kele
    include HTTParty
    include Roadmap
    
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
    
    def get_mentor_availability(mentor_id)
        get_response = self.class.get("/mentors/#{mentor_id}/student_availability", {headers: {authorization: @auth_token}})
        @mentor_sched = JSON.parse(get_response.body)
        @mentor_sched.to_a #mentor availability as a Ruby array
    end
    
    def get_messages(page = nil)
        puts "#{page} pages"
        message_threads = Array.new
        if page == nil
            get_response = self.class.get("/message_threads/", headers: { "authorization" => @auth_token })
            message_threads.push(JSON.parse(get_response.body))
        elsif page > 0
            get_response = self.class.get("/message_threads/#{page}", body: {page: page}, headers: { "authorization" => @auth_token })
            message_threads.push(JSON.parse(get_response.body))
        end
        message_threads
    end
    
    def create_message(sender_email, recipient_id, subject = "", message)
        inputs = {body: {user_id: sender_email, recipient_id: recipient_id, subject: subject, "stripped-text": message}, headers: { "authorization" => @auth_token }}
        post_response = self.class.post("/messages", inputs)
        raise "There was an error, check your input." if post_response.code != 200
    end
    
end