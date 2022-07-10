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

    def getNumbersStatus(country)
        #hardcoded to glovo
        response = @conn.get(
            '', 
            {
                action: 'getNumbersStatus',
                country: @dict[country],
            },
        )
        return Integer(JSON.parse(response.body)[@dict["glovo"]])
    end

    def getNumber 
        response = @conn.post(
            '',
            {
                action: 'getNumberV2',
                service: 'aq',
                country: '1',
            }
        )
        @activation_id = JSON.parse(response.body)["activationId"]
        
        return response
    end

    def setStatus(activation_id, status)
        response = @conn.post(
            '',
            {
                action: 'setStatus',
                id: activation_id,
                status: status,
            }
        )
    end

    def getStatus(activation_id)
        response = @conn.get(
            '',
            {
                action: 'getStatus',
                id: activation_id,
            }
        )
    end

end



