class SecondAutoIncrementedModel
  include Mongoid::Document
  include Mongoid::AutoIncrement

  self.auto_increment_value_field = "seq"

  auto_incremented :identifier
end
