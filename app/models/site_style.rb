class SiteStyle < ActiveRecord::Base
  belongs_to :site
  belongs_to :theme
  serialize :background_style, Hash
  serialize :text_style, Hash
  serialize :block_style, Hash
end
