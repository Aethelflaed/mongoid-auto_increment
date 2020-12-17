require "test_helper"

class ConsistencyTest < BaseTest
  test "single auto increment consistency" do
    n = 200

    n.times do
      FirstAutoIncrementedModel.create
    end

    assert_equal (1..n).to_a, FirstAutoIncrementedModel.only(:identifier).map(&:identifier).sort
  end

  test "pre incrementing should not be overriden" do
    n = 200

    n.times do
      model = FirstAutoIncrementedModel.new
      model.auto_increment!
      model.save
    end

    assert_equal (1..n).to_a, FirstAutoIncrementedModel.only(:identifier).map(&:identifier).sort
  end

  test "dup should create new identifier" do
    n = 100

    n.times do
      model = FirstAutoIncrementedModel.create
      model.dup.save
    end

    assert_equal (1..(n * 2)).to_a, FirstAutoIncrementedModel.only(:identifier).map(&:identifier).sort
  end

  test "double auto increment consistency" do
    n = 100

    n.times do
      FirstAutoIncrementedModel.create
      SecondAutoIncrementedModel.create
    end

    assert_equal (1..n).to_a, FirstAutoIncrementedModel.only(:identifier).map(&:identifier).sort
    assert_equal (1..n).to_a, SecondAutoIncrementedModel.only(:identifier).map(&:identifier).sort
  end
end
