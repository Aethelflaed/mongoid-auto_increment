require 'test_helper'

class SubclassTest < BaseTest
  test 'subclass auto increment' do
    n = 200

    n.times do
      SubclassModel.create
    end

    assert_equal (1..n).to_a, SubclassModel.only(:identifier).map(&:identifier).sort
    assert_equal (1..n).to_a, SubclassModel.only(:count).map(&:count).sort
  end

  test 'subclass auto increment works with base' do
    n = 100

    n.times do |i|
      FirstAutoIncrementedModel.create
      m1 = SubclassModel.create

      assert_equal i * 2 + 2, m1.identifier
    end

    assert_equal (1..n).to_a, SubclassModel.only(:count).map(&:count).sort
  end

  test 'mixed auto increment uniqueness' do
    n = 100

    n.times do
      FirstAutoIncrementedModel.create
      SubclassModel.create
    end

    assert_equal n * 2, FirstAutoIncrementedModel.all.uniq.size
  end

  test 'mixed auto increment consistency' do
    n = 100

    n.times do
      FirstAutoIncrementedModel.create
      SubclassModel.create
    end

    assert_equal (1..(n * 2)).to_a, FirstAutoIncrementedModel.only(:identifier).map(&:identifier).sort
  end
end

