# HasAttachedTags

Provides a general-purpose, typed tagging mechanism for ActiveRecord models.

HasAttachedTags does:
* Use tag types (e.g. Allowing a "Jane" character tag to be separate from a "Jane" artist tag.)
* Allow a model to have multiple, separate lists of tags
* Allow a model to specify only a single tag, rather than a list
* Allow a model to have multiple lists of the same kind of tag (e.g. A user preferences object with an allow-list and a block-list of tags.)
* Uses only run-of-the-mill ActiveRecord models and associations, without introducing any new infrastructural types.

HasAttachedTags does not:
* Parse tags from comma-separate lists
* Embed tag information directly onto a model
* Add any specialized methods for interacting with tags
* Monkey-patch ActiveRecord or any other library

In general, HasAttachedTags handles only the storage and association of tags, and leaves other concerns to the application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'has_attached_tags'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install has_attached_tags

To generate configuration and locale files:

    $ rails g has_attached_tags:install

To generate the database migration:

    $ rails g has_attached_tags:migration

## Usage

In most cases, it's simplest to install HasAttachedTags globally by adding it to the `ApplicationRecord` base class:

```ruby
class ApplicationRecord < ActiveRecord::Base
  extend HasAttachedTags

  # ...
end
```

Alternatively, it's possible to install the tag DSL only for specific models:

```ruby
class Image < ActiveRecord::Base
  extend HasAttachedTags

  # ...
end
```

### Attaching Tags to Models

To define a model that accepts tags, the `has_many_tags` macro helper can be used:

```ruby
class Image < ApplicationRecord
  has_many_tags :characters
end
```

We refer to this association between the model and its tags as an "attachment".
Tags attachments can be used like any other `has_many` association, without any special methods or magic:

```ruby
image = Image.new
image.characters # => #<ActiveRecord::Associations::CollectionProxy [...]>

image.characters << Tag.find_by(name: 'J', type: 'character')
image.save
```

Validations will prevent assigning unsupported tag types to an attachment:

```ruby
image.characters << Tag.find_by(name: 'J', type: 'character')
image.valid? # => true

image.characters << Tag.find_by(name: 'safe', type: 'rating')
image.valid? # => false
```

### Singular Tag Attachments

If only a single tag should be attached to a model, use `has_one_tag` macro helper:

```ruby
class Image < ApplicationRecord
  has_one_tag :rating
end
```

Similarly, the `has_one_tag` attachment uses `has_one` associations under the hood.

```ruby
image = Image.new
image.rating # => nil

image.rating = Tag.new(name: 'safe', type: 'rating')
image.rating # => #<Tag id: nil, name: "safe", type: "rating", ...>
```

### Marking Tags as Required

Sometimes, it might be necessary to validate that as tag is attached to a model. To do this, a `presence: true` validation can be used, however, a `required` option is provided for convenience:

```ruby
class Image < ApplicationRecord
  has_many_tags :artists, required: true
end
```

The `Image` model will now validate that at least 1 artist tag is attached.

```ruby
image = Image.new
image.valid? # => false

image.artists << Tag.new(name: 'J', type: 'artist')
image.valid? # => true
```

This option is available for both `has_one_tag` and `has_many_tags` attachments.

### Specifying a Tag Type

By default, the name of the tags attachment will be used to infer the tag type. (For example `has_one_tag :rating` will assume "rating" or `has_many_tags :characters` will assume "character".)
This value can be customized using the `type` option:

```ruby
class Image < ApplicationRecord
  has_one_tag :source, type: 'website'
end
```

This option is available for both `has_one_tag` and `has_many_tags` attachments.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Mihail-K/has_attached_tags. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the HasAttachedTags project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Mihail-K/has_attached_tags/blob/master/CODE_OF_CONDUCT.md).
