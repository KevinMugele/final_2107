class Item

  attr_reader :name, :bids, :open_bidding

  def initialize(name)
    @name = name
    @bids = Hash.new(0)
    @open_bidding = true
  end

  def add_bid(attendee, amount)
    @bids[attendee] += amount if @open_bidding
  end

  def close_bidding
    @open_bidding = false
  end

  def current_high_bid
    all_bids = []
    @bids.each do |attendee, amount|
      all_bids << amount
    end
    all_bids.max
  end

  def attendee_by_high_bid
    attendee =  @bids.max_by do |attendee, amount|
      amount
    end
    attendee.first
  end
end
