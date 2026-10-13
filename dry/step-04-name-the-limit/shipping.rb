Cart = Struct.new(:subtotal, :member)
module ShippingPolicy
  FREE_FROM = 50.0
end

class Checkout
  def shipping_fee(cart)
    return 0.0 if cart.subtotal >= ShippingPolicy::FREE_FROM

    4.99
  end
end

class CartBanner
  def message(cart)
    if cart.subtotal < ShippingPolicy::FREE_FROM
      missing = ShippingPolicy::FREE_FROM - cart.subtotal
      return format("Add $%.2f to ship free", missing)
    end
    "Your order ships free"
  end
end

class OrderEmail
  def shipping_line(cart)
    free = cart.subtotal >= ShippingPolicy::FREE_FROM
    "Shipping: #{free ? 'free' : '$4.99'}"
  end
end
