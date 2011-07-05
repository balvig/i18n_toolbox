module I18nToolbox
  module I18nHelper
    def image_tag(source, options = {})
      source = "#{I18n.locale}/#{source}" if options.delete(:localize)
      super(source, options)
    end
    
    def possessive(name)
      t(name.last == 's' ? :'i18n_toolbox.possessive_s' : :'i18n_toolbox.possessive', :name => name) if name.present?
    end

    def truncate(text, options = {})
      options.reverse_merge!(:length => 30)
      options[:length] = options[:length] * I18nToolbox.character_ratio if options.delete(:localize)
      super(text, options)
    end
  end
end