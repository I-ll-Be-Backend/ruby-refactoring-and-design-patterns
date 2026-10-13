Cart = Struct.new(:subtotal, :member)
module ShippingPolicy
  FREE_FROM = 50.0
  FEE = 4.99

  def self.ships_free?(cart)
    cart.subtotal >= FREE_FROM
  end
end

class Checkout
  def shipping_fee(cart)
    return 0.0 if ShippingPolicy.ships_free?(cart)

    ShippingPolicy::FEE
  end
end

class CartBanner
  def message(cart)
    unless ShippingPolicy.ships_free?(cart)
      missing = ShippingPolicy::FREE_FROM - cart.subtotal
      return format("Add $%.2f to ship free", missing)
    end
    "Your order ships free"
  end
end

class OrderEmail
  def shipping_line(cart)
    free = cart.subtotal >= ShippingPolicy::FREE_FROM
    "Shipping: #{free ? 'free' : format('$%.2f', ShippingPolicy::FEE)}"
  end
end
