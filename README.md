# i18n_toolbox [![Build Status](https://secure.travis-ci.org/balvig/i18n_toolbox.png?branch=master)](https://travis-ci.org/balvig/i18n_toolbox)

I18n_toolbox is a collection of helpers and active_model additions that solve basic problems that kept showing up when working with multiple language sites:

* Showing different images for different locales
* Different validates_length_of values for different locales
* Truncating text to different lengths depending on locale
* Applying "possessive case" correctly with correct use of apostrophes for different languages (ie "Jack's Recipes", "Miles' Recipes", "Recettes de Julien")

## Usage

### image_tag

Serve up a different image depending on locale.

```ruby
I18n.locale = :en
image_tag('logo.png', localize: true) # => /images/en/logo.png
I18n.locale = :ja
image_tag('logo.png', localize: true) # => /images/ja/logo.png
```

### truncate

Truncate text that appears longer on screen (such as 2 byte Japanese) to avoid breaking layouts dependent on length of text.

*config/locales/ja.yml*

```yaml
ja:
  i18n_toolbox:
    character_ratio: 0.5
```

*Output:*

```ruby
I18n.locale = :en
truncate("2 byte characters are wider", length: 20, localize: true) # => "2 byte characters..." (20 chars)
I18n.locale = :ja
truncate("2 byte characters are wider", length: 20, localize: true) # => "2 byte ..." (10 chars)
```

### validates_length_of

Have different validation lengths for different locales.

*config/locales/ja.yml*

```yaml
ja:
  i18n_toolbox:
    character_ratio: 0.5
```

*Model:*
```ruby
class Post < ActiveRecord::Base
  validates_length_of :title, maximum: 40, localize: true
  # ...
end

I18n.locale = :en
Post.new(title: 'English sentences use more chars').valid? # => true, length is under 40
I18n.locale = :ja
Post.new(title: 'Japanese sentences use fewer chars').valid? # => false, length is over 20
```

### possessive

Often used for user page titles, such as "Michael's Activity Feed" etc.

*config/locales/en.yml*

```yaml
en:
  i18n_toolbox:
    possessive: "%{owner}'s %{thing}"
    possessive_s: "%{owner}' %{thing}"
```

*config/locales/fr.yml*

```yaml
fr:
  i18n_toolbox:
    possessive: "%{thing} de %{owner}"
```

*Output:*

```ruby
I18n.locale = :en
possessive('Jack', 'Recipes') # => "Jack's Recipes"
possessive('Miles', 'Recipes') # => "Miles' Recipes"

I18n.locale = :fr
possessive('Julien', 'Recettes') # => "Recettes de Julien"
possessive('Jacques', 'Recettes') # => "Recettes de Jacques"
```

## License

MIT License. Copyright 2012 Cookpad Pte http://cookpad.it
