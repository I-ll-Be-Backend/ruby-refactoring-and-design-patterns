Cart = Struct.new(:subtotal, :member)
module ShippingPolicy
  FREE_FROM = 50.0
  MEMBER_FREE_FROM = 25.0
  FEE = 4.99
  private_constant :FREE_FROM, :MEMBER_FREE_FROM

  def self.ships_free?(cart)
    cart.subtotal >= free_from(cart)
  end

  def self.amount_to_free(cart)
    free_from(cart) - cart.subtotal
  end

  def self.free_from(cart)
    cart.member ? MEMBER_FREE_FROM : FREE_FROM
  end
  private_class_method :free_from
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
      missing = ShippingPolicy.amount_to_free(cart)
      return format("Add $%.2f to ship free", missing)
    end
    "Your order ships free"
  end
end

class OrderEmail
  def shipping_line(cart)
    free = ShippingPolicy.ships_free?(cart)
    "Shipping: #{free ? 'free' : format('$%.2f', ShippingPolicy::FEE)}"
  end
end
