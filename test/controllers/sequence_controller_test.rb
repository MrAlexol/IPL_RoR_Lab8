# frozen_string_literal: true

require 'test_helper'

class SequenceControllerTest < ActionDispatch::IntegrationTest
  test 'should get input' do
    get sequence_input_url
    assert_response :success
  end

  test 'should get view with error msg if no params supplied' do
    get sequence_view_url
    assert_response :success
    assert_nil assigns[:input]
    assert_nil assigns[:result]
    assert_equal 'Последовательность не задана', assigns[:error]
  end

  test 'should get view with error msg if not valid params supplied' do
    get sequence_view_url, params: { values: '10' }
    assert_response :success
    assert_nil assigns[:result]
    assert_equal 'Последовательность короче 10 чисел', assigns[:error]
  end

  test 'should return correct answer' do
    get sequence_view_url, params: { values: '10  1 2 3 4  3 4 5 4   0' }
    assert_response :success
    assert_nil assigns[:error]
    assert_includes assigns[:result], [1, 2, 3, 4]
    assert_includes assigns[:result], [3, 4, 5]
    assert_equal [1, 2, 3, 4], assigns[:result][-1]
    assert_equal 3, assigns[:result].length
  end
end
