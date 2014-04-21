require 'uri'
require 'net/http'
require 'src/ruby_generator'

if __FILE__ == $0

    #private_key = "/tmp/myprivkey.pem"
    private_key = "keys/conn_priv_key.pem"
    #private_key = "/tmp/meow_private.pem"
    #private_key = "keys/eej_private_key.pem"
    #post_body = "body=Hello"
    #post_body = "sgnmsg=engot+sun&uri=/kahitano"
    post_body = "sgnmsg=engot+sun&uri=/kahitano"

    #uri = URI.parse("http://10.11.3.172:6505")
    uri = URI.parse("http://10.11.2.180:8090/kahitano")
    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Post.new("/")
    request.body = post_body
    
    signature = generate_signature(post_body, private_key)
    request.add_field("SIG", signature)
   
    puts signature

    response = http.request(request)

    puts "Response Code:     #{response.code}"
    puts "Response Message:  #{response.message}"
    puts "Response Body:     #{response.body}"

end
