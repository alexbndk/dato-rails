module Dato
  class Client < GQLi::Client
    def initialize(api_token = ENV["DATO_API_TOKEN"], validate_query: true)
      super(
        "https://graphql.datocms.com/",
        headers: {
          "Authorization" => api_token
        },
        validate_query: validate_query
      )
    end
  end
end
