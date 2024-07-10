# frozen_string_literal: true

require_relative '../../test_helper'
require 'pagy/extras/keyset'
require 'pagy/extras/items'

require_relative '../../files/models'
require_relative '../../mock_helpers/app'

describe 'pagy/extras/keyset' do
  describe '#pagy_keyset' do
    it 'returns Pagy::Keyset object and records' do
      app = MockApp.new(params: { page: nil })
      pagy, records = app.send(:pagy_keyset,
                               Pet.order(:animal, :name, :id),
                               row_comparison: true,
                               items: 10)
      _(pagy).must_be_instance_of Pagy::Keyset
      _(records.size).must_equal 10
      _(pagy.next).must_equal "eyJhbmltYWwiOiJjYXQiLCJuYW1lIjoiRWxsYSIsImlkIjoxOH0"
    end
    it 'pulls the page from params' do
      app = MockApp.new(params: { page: "eyJpZCI6MTB9", items: 10 })
      pagy, records = app.send(:pagy_keyset,
                               Pet.order(:id),
                               row_comparison: true)
      _(records.first.id).must_equal 11
      _(pagy.next).must_equal "eyJpZCI6MjB9"
    end
  end
end