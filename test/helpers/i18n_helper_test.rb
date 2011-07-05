require 'test_helper'

class I18nToolbox::I18nHelperTest < ActionView::TestCase  
  test "image_tag given localize => true should return a localized image" do
    I18n.locale = :ja
    assert_match 'images/ja/logo.png', image_tag('logo.png', :localize => true)
    I18n.locale = :en
    assert_match 'images/en/logo.png', image_tag('logo.png', :localize => true)
    assert_match 'images/logo.png', image_tag('logo.png', :localize => false)
  end
  
  test "image_tag should otherwise work as usual" do
    assert_match 'images/logo.png', image_tag('logo.png')
  end
  
  test "possessive should add localized 's" do
    I18n.backend = I18n::Backend::KeyValue.new({})
    I18n.backend.store_translations :en, :i18n_toolbox => {:possessive => "%{name}'s ", :possessive_s => "%{name}' "}
    I18n.backend.store_translations :ja, :i18n_toolbox => {:possessive => "%{name}の", :possessive_s => "%{name}の"}
    
    assert_nil possessive(nil)
    I18n.locale = :en
    assert_equal "Bob's ", possessive('Bob')
    assert_equal "Miles' ", possessive('Miles')
    I18n.locale = :ja
    assert_equal "Bobの", possessive('Bob')
    assert_equal "Milesの", possessive('Miles')
  end
  
  test "truncate should respect different lengths for different locales" do
    I18n.backend = I18n::Backend::KeyValue.new({})
    I18n.backend.store_translations :en, :i18n_toolbox => {:character_ratio => 1}
    I18n.backend.store_translations :ja, :i18n_toolbox => {:character_ratio => 0.5}
    
    I18n.locale = :en
    assert_equal 'Top Gun is one of the best ...', truncate('Top Gun is one of the best movies ever made', :localize => true)
    I18n.locale = :ja
    assert_equal "トップガンは今まで見た映画の中でも特に印象に残るものの...", truncate('トップガンは今まで見た映画の中でも特に印象に残るものの一つです')
    assert_equal "トップガンは今まで見た映...", truncate('トップガンは今まで見た映画の中でも特に印象に残るものの一つです', :localize => true)
    I18n.locale = :da
    assert_equal 'Top Gun is one of the best ...', truncate('Top Gun is one of the best movies ever made', :localize => true)
  end
end