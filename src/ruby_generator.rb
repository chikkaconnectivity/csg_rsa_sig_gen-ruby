#!/bin/ruby

require 'openssl'
require 'base64'

def generate_signature(message, private_key_file)
    # Load Private Key
    private_key = OpenSSL::PKey::RSA.new File.read(private_key_file)
   
    # Generate the Digest to be used
    digest = OpenSSL::Digest::SHA512.new

    # Generate Signature using the Digest
    signature = private_key.sign(digest, message)

    # Encode with Base64 without the New Lines
    base64_encoded_signature = Base64.encode64(signature).gsub(/\n/, '')

    return base64_encoded_signature
    
end

def validate_signature(message, public_key_file, signature)
    # Load Public Key
    public_key = OpenSSL::PKey::RSA.new File.read(public_key_file)

    # Decode Base64-encoded Signature
    sign = Base64.decode64(signature)

    # Generate the Digest to be used
    digest = OpenSSL::Digest::SHA512.new

    # Verify the signature
    # Returns true if valid; false, otherwise
    return public_key.verify(digest, sign, message)
end

if __FILE__ == $0
  
    private_key_file = ARGV[0]
    public_key_file = ARGV[1]

    message = "Hello" 

    signature = generate_signature(message, private_key_file)
    puts "Signature: ", signature
    
    validation = validate_signature(message, public_key_file, signature)
    puts "Valid: ", validation

end
