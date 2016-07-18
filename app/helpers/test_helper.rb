module TestHelper

  def test_variables_for(test)
    test.test_variables.map(&:name).join(', ')
  end

  def time_limit_for(test)
    seconds = test.time_limit
    test.time_limit ? "#{ seconds } seconds / #{ seconds / 60 } minutes" : 'Unlimited'
  end

end
