require 'test_helper'

class I18nToolbox::LengthValidatorTest < ActiveSupport::TestCase
  load_schema
  
  I18n.backend = I18n::Backend::KeyValue.new({})
  I18n.backend.store_translations :en, :i18n_toolbox => {:character_ratio => 1}
  I18n.backend.store_translations :ja, :i18n_toolbox => {:character_ratio => 0.5}

  class Post < ActiveRecord::Base
    validates_length_of :title, :maximum => 20, :localize => true
    validates_length_of :body, :maximum => 20
  end
  
  test "validates_length_of maximum should change depending on locale if localize => true" do

    I18n.locale = :en
    assert !Post.new(:title => 'This is a long sentence').valid?
    assert Post.new(:title => 'Short sentence').valid?

    I18n.locale = :ja
    assert !Post.new(:title => 'Short sentence').valid?
    assert Post.new(:title => 'Short!').valid?
  end
  
  test "validates_length_of maximum should work normally if localize => false" do
    I18n.locale = :en
    assert Post.new(:body => 'Short sentence').valid?
  
    I18n.locale = :ja
    assert Post.new(:body => 'Short sentence').valid?
  end
  
  #should work with range too
end