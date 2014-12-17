if RUBY_VERSION < "1.7.0"
  class Array
    alias values_at indices
  end
end
