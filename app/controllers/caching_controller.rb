class CachingController < ApplicationController
  def index
    xs = (-2.9..2.9).step(0.1).map { |num| num.round(1) }
    @values = Rails.cache.fetch('xs', expires_in: 1.day) do
      xs.collect(&method(:sin))
    end
  end

  def factorial(number)
    Rails.cache.fetch('factorial' + number.to_s, expires_in: 1.day) do
      return 1 if number == 1
      number * factorial(number - 1)
    end
  end

  def sin(x)
    Rails.cache.fetch('sin' + x.to_s, expires_in: 1.day) do
      # Maclaurin series expansion of sin(x) http://en.wikipedia.org/wiki/Taylor_series
      (0..10).sum { |j| taylor_series_formula(x, j) }
    end
  end

  def taylor_series_formula(x, number)
    n = 1 + (number * 2)
    p = x**n / factorial(n)
    s = 1 - ((number % 2) * 2)
    s * p
  end

  add_method_tracer :sin, 'Custom/compute_sine'
end
