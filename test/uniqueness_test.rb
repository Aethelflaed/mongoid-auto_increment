require "test_helper"

class UniquenessTest < BaseTest
  test "single auto increment uniqueness" do
    n = 200

    n.times do
      FirstAutoIncrementedModel.create
    end

    assert_equal n, FirstAutoIncrementedModel.all.uniq.size
  end

  test "double auto increment uniqueness" do
    n = 100

    n.times do
      FirstAutoIncrementedModel.create
      SecondAutoIncrementedModel.create
    end

    assert_equal n, FirstAutoIncrementedModel.all.uniq.size
    assert_equal n, SecondAutoIncrementedModel.all.uniq.size
  end
end
