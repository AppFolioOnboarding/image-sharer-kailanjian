class Image < ApplicationRecord
  validates :link, format: URI::DEFAULT_PARSER.make_regexp
end
