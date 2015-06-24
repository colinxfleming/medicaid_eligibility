require 'test_helper'

class ApplicationProcessorTest < ActionDispatch::IntegrationTest
	include ApplicationParser
	include ApplicationProcessor

	@fixtures = load_fixtures

	@fixtures.each do |app|
	  test "the truth #{app[:name]}" do
	  	setup_app app 
	  	p @state
	    assert true
	  end
	end

	# test 'respond_to compute_values' do 
		# respond_to :compute_values! 
	# end
end
