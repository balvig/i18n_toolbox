require 'i18n_toolbox/helpers/i18n_helper'
require 'i18n_toolbox/active_model/validations/length'

module I18nToolbox
  ActionController::Base.helper(I18nHelper)

  def self.character_ratio
    I18n.t(:'i18n_toolbox.character_ratio', :default => 1)
  end
end
