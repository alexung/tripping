require 'Date'

testProperty = {
  start_date: "2015-01-01",
  availability: "NNNNYYNNNNNNNNNNYYYYYNNNNNNNNYYYNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNYYYYYYYYYNNNNYYYYYYYYNNNNNNNNNNYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY",
  minstay:
"6,5,3,6,6,6,4,6,3,3,6,5,3,3,5,6,6,4,5,2,2,6,3,5,4,6,2,6,6,5,2,4,2,2,4,3,2,5,3,4,2,2,5,4,2,6,3,3,3,3,5,6,5,3,6,4,2,3,2,3,2,4,2,2,6,3,6,4,3,5,4,3,3,2,5,3,4,3,4,6,6,4,4,5,2,3,6,3,5,2,2,4,6,5,5,2,6,6,3,6,2,3,3,6,3,2,3,4,4,4,5,2,2,5,2,3,3,6,5,3,3,3,5,2,4,2,6,5,4,4,3,4,3,3,6,5,5,4,3,3,2,4,6,3,3,6,6,4,2,2,3,4,2,6,5,2,6,3,2,4,3,4,5,6,5,3,6,5,6,2,4,3,4,2,3,5,6,3,2,2,2,6,6,2,5,2,3,2,4,4,4,6,6,4,3,2,4,5,5,2,3,2,4,6,6,5,6,2,6,3,2,6,2,6,2,5,5,5,5,4,2,6,3,2,2,2,6,6,5,5,4,4,5,4,2,2,5,5,5,2,6,4,4,4,3,2,6,3,3,2,4,2,6,6,3,6,4,5,4,4,5,6,6,6,6,3,3,5,5,6,3,5,5,6,6,3,2,4,2,3,5,3,4,3,3,3,3,4,5,2,6,5,6,5,5,4,2,3,3,2,4,6,3,2,3,2,3,3,4,5,3,3,6,5,2,6,4,5,5,6,2,4,6,5,2,5,3,4,6,3,3,3,4,5,4,4,4,5,4,3,6,2,2,2,6,4,2,2,6,4,5,3,3,4,2,5,6,5,6,5,3,5,2,2,5",
  price:
"248,109,138,227,104,207,163,119,249,261,162,286,235,205,210,215,259,227,203,183,181,153,140,258,103,198,253,286,254,133,202,142,163,261,205,133,113,152,130,193,153,140,174,282,128,268,114,199,168,254,296,267,224,249,200,207,160,124,108,165,259,293,143,282,267,129,114,268,249,186,255,124,161,247,297,100,113,170,201,239,283,180,142,220,105,294,226,228,101,108,104,187,238,251,106,259,262,120,174,141,231,207,270,193,292,121,250,166,171,287,220,142,176,195,180,215,155,243,116,249,265,164,172,213,151,132,215,235,116,181,260,199,203,189,251,124,128,152,128,188,140,273,176,208,143,143,108,265,269,273,265,182,275,237,188,183,108,234,137,270,106,273,122,105,171,236,213,278,281,102,117,163,277,104,294,252,210,124,203,253,100,220,205,226,100,236,101,150,148,104,205,110,249,175,131,185,210,262,290,271,214,247,158,210,220,156,137,284,245,212,137,237,235,112,158,278,127,132,272,104,103,274,199,260,154,209,186,260,251,247,180,106,107,102,164,290,166,243,234,244,108,182,249,118,99,131,191,231,247,152,120,146,154,223,209,111,116,194,101,212,163,110,257,196,230,250,273,152,116,185,158,276,293,285,219,101,119,159,170,168,147,104,211,137,235,136,136,152,281,176,134,144,130,298,269,272,101,168,141,198,184,154,186,109,230,185,195,282,265,210,290,265,194,120,122,240,256,280,289,164,109,136,213,267,161,265,162,162,182,196,251,204,191,280,199,243,214,255,180,183,200,114,250,159,267,217,213,263,151,115,223,221,244,261,190,166,112,266,291,283,249,135,102,151,113"
}

#print testProperty[:price]
#availability, minstay, price all have length of 365. 1 per each day of year
#N is not available
#Y is available

#=========
# dates
# (Date.parse('2015-01-01')+ 0).strftime("%Y-%m-%d")
# ==> "2015-01-01"

# (Date.parse('2015-01-01')+ 3).strftime("%Y-%m-%d")
# ==> "2015-01-04"
#=========

# ==> all available contiguous date ranges
# i.e. [[start_date, end_date], [start_date, end_date]]
# Do i take into account the minstay property? NO...
def available_ranges(property)
  @result = []
  @availability = property[:availability].split('')
  @tempArr = []

  # iterate through @availability
  @availability.each_with_index do |avail, i|
    # finding the current date based on every iteration
    @currentDate = (Date.parse(property[:start_date]) + i).strftime("%Y-%m-%d")

    if avail == "Y"

      # if tempArr is ever empty or of length 1, push @currentDate into it
      if @tempArr.length < 2
        @tempArr.push(@currentDate)
      end

      # if we're iterating through and find a 'Y', but there's already 2 dates in @tempArr
      if @tempArr.length == 2
        @tempArr[1] = @currentDate
      end

      # if we ever hit the end of the arr and it's all 'Y' then we'll push into result
      if i == (@availability.length-1)
        @result.push(@tempArr)
      end

    else
      # if we ever hit an 'N', but our tempArr is full, push it into result
      if @tempArr.length == 2
        @result.push(@tempArr)
      end

      #make tempArr empty
      @tempArr = []
    end
  end

  return @result
end

#should return nested arr of all available dates
print available_ranges(testProperty)


# could go through object every time and check start_date + end_date to see if they're all yes'
# then adding up all associated prices
# make sure that the minstay also applies for the start date

# EXAMPLE: cost_of_booking(testProperty, "2015-01-01", "2015-01-03")
# ==> total cost of booking the property for that date range
# i.e. $1000 if property is available during that date range, 0 if it's unavailable for any date in that range
def cost_of_booking(property, start_date, end_date)
  @available_dates = available_ranges(property)
  @availability = property[:availability].split('')
  @minstays = property[:minstay].split(',')
  @prices = property[:price].split(',')
  @sum = 0

  @available_dates.each_with_index do |available_date, i|
    # if the start_date and end_date fall within our ranges where it's available
    if Date.parse(start_date) >= Date.parse(available_date[0]) && Date.parse(end_date) <= Date.parse(available_date[1])
      @start = available_date[0]
      @end = available_date[1]
      break;
      # this means we're in one of the nested arr's! let's break from this loop to continue
    else
      # if it's not in this range, we don't need to move further in the function
      return 0
    end

  end

  @availability.each_with_index do |avail, i|
    # finding the current date based on every iteration
    @currentDate = (Date.parse(property[:start_date]) + i).strftime("%Y-%m-%d")

    # get start_index
    if @currentDate == @start
      @start_index = i
    end

    #get end_index
    if @currentDate == @end
      @end_index = i
    end

  end
  #now we have start_index and end_index

  #minstay
  calc_minstay(@minstays)

  #if difference between start and end date > @minstay_for_start
  #return 0
  check_minstay(@minstay_for_start, end_date, start_date)

  #save index from start_date and save index from end_date
  calc_prices(@prices)

  return @sum

end

def check_available_dates(available_dates, start_date, end_date)
  available_dates.each_with_index do |available_date, i|
    # if the start_date and end_date fall within our ranges where it's available
    if Date.parse(start_date) >= Date.parse(available_date[0]) && Date.parse(end_date) <= Date.parse(available_date[1])
      @start = available_date[0]
      @end = available_date[1]
      break;
      # this means we're in one of the nested arr's! let's break from this loop to continue
    else
      # if it's not in this range, we don't need to move further in the function
      return 0
    end

  end
end

def calc_minstay(minstays)
  minstays.each_with_index do |min_num_nights, i|
    if i == @start_index
      @minstay_for_start = min_num_nights
    end
  end
end

def check_minstay(minstay_for_start, end_date, start_date)
  if (Date.parse(end_date) - Date.parse(start_date)) > minstay_for_start.to_i
    return 0
  end
end

def calc_prices(prices)
  prices.each_with_index do |price, i|
    if i >= @start_index && i <= @end_index
      # if i is within our start and end bounds, we'll add it to sum
      @sum+=price.to_i
    end
  end
end


# should return 311
puts cost_of_booking(testProperty, "2015-01-05", "2015-01-06")

# should return 0
puts cost_of_booking(testProperty, "2015-01-04", "2015-01-06")
