module TestHelper

  def test_variables_for(test)
    test.test_variables.map(&:name).join(', ')
  end

end
