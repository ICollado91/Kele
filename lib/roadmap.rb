module Roadmap
    
    def get_roadmap(roadmap_id)
        get_response = self.class.get("/roadmaps/#{roadmap_id}", {headers: { "authorization" => @auth_token }})
        @roadmap = JSON.parse(get_response.body)
    end
    
    def get_checkpoint(checkpoint_id)
        get_response = self.class.get("/checkpoints/#{checkpoint_id}", {headers: { "authorization" => @auth_token }})
        @checkpoint = JSON.parse(get_response.body)
    end
    
end