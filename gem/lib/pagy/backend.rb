# See Pagy::Backend API documentation: https://ddnexus.github.io/pagy/docs/api/backend
# frozen_string_literal: true

class Pagy
  # Define a few generic methods to paginate a collection out of the box,
  # or any collection by overriding pagy_get_records and/or pagy_get_vars in your controller
  # See also the extras if you need specialized methods to paginate Arrays or other collections
  module Backend
    private

    # Return Pagy object and paginated items/results
    def pagy(collection, **vars)
      pagy = Pagy.new(**pagy_get_vars(collection, vars))
      [pagy, pagy_get_records(collection, pagy)]
    end

    # Get the count from the collection
    def pagy_get_count(collection, vars)
      count_args = vars[:count_args] || DEFAULT[:count_args]
      (count     = collection.count(*count_args)).is_a?(Hash) ? count.size : count
    end

    # Override for items extra
    def pagy_get_items(vars); end

    # Get the page integer from the params
    # Overridable by the jsonapi extra
    def pagy_get_page(vars)
      params[vars[:page_param] || DEFAULT[:page_param]]
    end

    # Sub-method called only by #pagy: here for easy customization of record-extraction by overriding
    # You may need to override this method for collections without offset|limit
    def pagy_get_records(collection, pagy)
      collection.offset(pagy.offset).limit(pagy.items)
    end

    # Sub-method called only by #pagy: here for easy customization of variables by overriding
    # You may need to override the count call for non AR collections
    def pagy_get_vars(collection, vars)
      vars.tap do |v|
        v[:count] ||= pagy_get_count(collection, v)
        v[:items] ||= pagy_get_items(v)
        v[:page]  ||= pagy_get_page(v)
      end
    end
  end
end
