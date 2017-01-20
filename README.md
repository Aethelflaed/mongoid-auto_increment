# mongoid-auto_increment

This projects aims to provide auto-incremented fields for Mongoid the same way you have them in traditional SQL databases.

I am relying on mongoid-sequence project and Mongoid to create this gem.

Please report any issue you may find.

If you'd like to contribute, but pull requests are welcome!

## Install

```ruby
gem 'mongoid-auto_increment'
```

## How to use

In your models, add:

```ruby
class User
  include Mongoid::Document
  include Mongoid::AutoIncrement

  field :name

  auto_increment :count
end
```

## Notes

This gem is originally a fork from mongoid-sequence but I added some new features and needed it for other gems
so I had to upload it to rubygems.

Changes from mongoid-sequence:

* Support for Mongoid 6
* Calling `auto_increment!` creation callback only if the auto incremented field has not already been generated.
This permets to `auto_increment!` a new record before persisting it.
* Removed the auto_increment on `id` as it was buggy on Mongoid 4
* Fixed use of `dup` to reset the auto incremented fields.
* Removed prefix, which is not consistent for multiple sequence in same class and quite useless to me. (You need it? I can add it back !)
* Inherit auto_increments from parents automatically
* Added some personalization of the collection name and class prefix

## License

This project rocks and uses MIT-LICENSE.

Copyright 2014 Geoffroy Planquart

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
