---
title: Keyset
categories:
- Backend
- Extra
---

# Keyset Extra

Paginate with the Pagy keyset pagination technique. This is a tiny wrapper around the 
[Pagy::Keyset class](/docs/api/keyset.md) that implements the actual pagination. Please refer to the class documentation for a fuller undersanding of keyset pagination:

[!ref Keyset Pagination: Concepts and Overview](/docs/api/keyset.md)

This extra adds a `pagy_keyset` constructor method that can be used in your controllers and provides the automatic setting of the variables from the request `params`.

## Synopsis

```ruby pagy.rb (initializer)
require 'pagy/extras/keyset'

# useful optionals for APIs
# require 'pagy/extras/items'
# require 'pagy/extras/jsonapi'
# require 'pagy/extras/headers'
```

```ruby Controller (action)
# The set argument must be an uniquely ORDERED Activerecord Scope or Sequel Dataset 

# minimal unique ordering with the primary key
set = Product.order(:id)
@pagy, @records = pagy_keyset(set, **vars)

# using same-direction ordering keyset (all :asc, or all :desc) 
# notice the primary key as the last column as a tie-breaker for uniqueness
set = Product.order(:brand, :model, :id)
# allow using the row_comparison query, which requires a B-tree index ordered exactly as the set (for performance)
@pagy, @records = pagy_keyset(set, row_comparison: true)

# ordering with mixed-direction ordering keyset
set = Product.order(:brand, model: :desc, :id)
# the row_comparison would be ignored 
@pagy, @records = pagy_keyset(set, **vars)
```

## Variables

See the [Pagy::Keyset variables](/docs/api/keyset.md#variables)

## Methods

==- `pagy_keyset(set, **vars)`

This method is similar to the offset `pagy` method. It returns the `pagy` object (instance of `Pagy::Keyset`), and the array 
of `records` (not a scope).

==- `pagy_keyset_get_vars(vars)`

This sub-method is called only by the `pagy_keyset` method. It automatically sets the `:page` variable and - if you use the 
[items extra](/docs/extras/items.md) also the`:items` variables from the request `params`.

===

[!button corners="pill" variant="success" text=":icon-play: Try it now!"](/playground.md#5-keyset-app)
