require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "the truth" do
    @question = Factory(:question)
    get( :show, :id => @question.qhash )
    assert_response :success
  end
end
