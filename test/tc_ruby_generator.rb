require "src/ruby_generator"
require "test/unit"

class TestRubyRSAGenerator < Test::Unit::TestCase

    def test_rsa
        
        signature = generate_signature("Hello", "keys/myprivkey.pem")

        validation = validate_signature("Hello", "keys/mypubkey.pem", signature)

        assert_equal(true, validation)
    end
end
