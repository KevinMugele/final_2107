class Auction

  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map do |item|
      item.name
    end
  end

  def unpopular_items
    unpopular = []
    @items.each do |item|
      if item.bids.empty?
        unpopular << item
      end
    end
    unpopular
  end

  def potential_revenue
    @items.sum do |item|
      if unpopular_items.include?(item)
        0
      else
        item.current_high_bid
      end
    end
  end

  def bidders
    bidders = []
    @items.each do |item|
      item.bids.each do |attendee, amount|
        bidders << attendee.name
      end
    end
    bidders.uniq
  end
end
