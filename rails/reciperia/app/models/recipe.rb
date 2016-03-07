class Recipe
    include HTTParty

    base_uri 'http://food2fork.com/api'
    default_params key: ENV['FOOD2FORK_KEY']
    format :json

    def self.for term
        result = get('/search', query: {q: term})
        result['recipes']
    end

end
