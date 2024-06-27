module Dato
  class Gql < GQLi::Client
    def initialize(api_token, environment, validate_query, preview, live)
      @api_token = api_token
      @environment = environment
      super(
        "https://graphql#{"-listen" if live}.datocms.com/#{"preview" if preview}",
        headers: {
          "Authorization" => @api_token,
          "X-Environment" => @environment
        },
        validate_query: validate_query && !live
      )
    end

    def live!(query)
      http_response = request.post(@url, params: @params, json: {query: query.to_gql})

      fail "Error: #{http_response.reason}\nBody: #{http_response.body}" if http_response.status >= 300

      parsed_response = JSON.parse(http_response.to_s)
      errors = parsed_response["errors"]
      GQLi::Response.new(parsed_response, errors, query)
    end
  end
end
