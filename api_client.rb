require 'faraday'
require 'faraday/net_http'
require 'json'

Faraday.default_adapter = :net_http

class SMSActivate
    def initialize(api_key)
        @conn = Faraday.new(
            url: 'https://api.sms-activate.org/stubs/handler_api.php',
            params: {api_key: api_key},
            headers: {'Content-Type' => 'application/json'},
        )
        @dict = {
            "glovo" => "aq_0",
            "ukr" => "1",
            "mold" => "85",
        }
    end

    def status(country)
        #hardcoded to glovo
        response = @conn.get(
            '', 
            {
                action: 'getNumbersStatus',
                country: @dict[country],
            },
        )
        Integer(JSON.parse(response.body)[@dict["glovo"]])
    end

    def get_number() 
        response = @conn.post(
            '',
            {
                action: 'getNumberV2',
                service: 'aq',
                country: '1',
            }
        )
        @activation_id = JSON.parse(response.body)["activationId"]
        
        response
    end

    def set_status(activation_id, status)
        response = @conn.post(
            '',
            {
                action: 'setStatus',
                id: activation_id,
                status: status,
            }
        )
    end

    def get_status(activation_id)
        response = @conn.get(
            '',
            {
                action: 'getStatus',
                id: activation_id,
            }
        )
    end
end



