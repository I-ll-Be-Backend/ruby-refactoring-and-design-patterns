Cart = Struct.new(:subtotal, :member)
class Checkout
  def shipping_fee(cart)
    free_from = cart.member ? 25.0 : 50.0
    return 0.0 if cart.subtotal >= free_from

    4.99
  end
end

class CartBanner
  def message(cart)
    limit = cart.member ? 25.0 : 50.0
    if cart.subtotal < limit
      missing = limit - cart.subtotal
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
