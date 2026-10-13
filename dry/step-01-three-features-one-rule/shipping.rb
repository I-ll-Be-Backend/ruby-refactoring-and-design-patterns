Cart = Struct.new(:subtotal, :member)
class Checkout
  def shipping_fee(cart)
    return 0.0 if cart.subtotal >= 50.0

    4.99
  end
end

class CartBanner
  def message(cart)
    if cart.subtotal < 50.0
      missing = 50.0 - cart.subtotal
      return format("Add $%.2f to ship free", missing)
    end
    "Your order ships free"
  end
end

class OrderEmail
  def shipping_line(cart)
    free = cart.subtotal >= 50.0
    "Shipping: #{free ? 'free' : '$4.99'}"
  end
end
