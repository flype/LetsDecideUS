require 'test_helper'

class StringMonkeyPatchTest < ActiveSupport::TestCase
  test "on hide_at should remove the @" do
    assert_equal( 'wadus on wadus.com', 'wadus@wadus.com'.hide_at )
    assert_equal( ' on wadus.com', '@wadus.com'.hide_at )
    assert_equal( 'wadus on   ', 'wadus@  '.hide_at )
  end
end