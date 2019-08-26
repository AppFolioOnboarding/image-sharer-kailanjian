class Image < ApplicationRecord
  acts_as_taggable
  validates :link, format: URI::DEFAULT_PARSER.make_regexp
end
