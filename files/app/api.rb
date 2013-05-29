require 'grape'

class API < Grape::API
  format :json
  default_error_formatter :json
  mount ::APIv1 => '/v1'
end