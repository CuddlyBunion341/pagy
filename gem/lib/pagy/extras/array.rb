# See the Pagy documentation: https://ddnexus.github.io/pagy/docs/extras/array
# frozen_string_literal: true

class Pagy # :nodoc:
  # Paginate arrays efficiently, avoiding expensive array-wrapping and without overriding
  module ArrayExtra
    private

    # Return Pagy object and paginated items
    def pagy_array(array, **vars)
      pagy = Pagy.new(**pagy_array_get_vars(array, vars))
      [pagy, array[pagy.offset, pagy.limit]]
    end

    # Sub-method called only by #pagy_array: here for easy customization of variables by overriding
    def pagy_array_get_vars(array, vars)
      vars[:count] ||= array.size
      pagy_get_vars(array, vars)
    end
  end
  Backend.prepend ArrayExtra
end
