require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  def test_feedback__valid
    feedback = Feedback.new(name: 'John Doe', comments: 'I like it!')

    assert feedback.valid?
  end

  def test_feedback__invalid_no_name
    feedback = Feedback.new(name: '', comments: 'I like it!')

    refute feedback.valid?
  end

  def test_feedback__invalid_no_comments
    feedback = Feedback.new(name: 'John Doe', comments: '')

    refute feedback.valid?
  end
end
