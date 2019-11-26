class FirstAutoIncrementedModel
  include Mongoid::Document
  include Mongoid::AutoIncrement

  auto_incremented :identifier
end
