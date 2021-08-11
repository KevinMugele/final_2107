require 'date'

class Auction

  attr_reader :items

  def initialize
    @items = []
  end

  def date
    Date.today.strftime("%d/%m/%Y")
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
    @items.find_all do |item|
      item.bids.empty?
    end
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

  def bidder_info
    bidder_info = {}
    @items.each do |item|
      item.bids.each do |attendee, amount|
        if bidder_info[attendee].nil?
          bidder_info[attendee] = {
            :budget => attendee.budget,
            :items => [item]}
        else
          bidder_info[attendee][:items] << item
        end
      end
    end
    bidder_info
  end
end
