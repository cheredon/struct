class HashTable
  STARTING_BINS = 16

  attr_reader :table

  def initialize
    # define the average maximum number of entries we will allow in each bin
    @max_density = 5
    @entry_count = 0
    @bin_count   = STARTING_BINS
    @table = Array.new(@bin_count) { [] }
  end

  def grow
    # use bit shifting to get the next power of two and reset the table size
    @bin_count = @bin_count << 1

    # create a new table with a much larger number of bins
    new_table = Array.new(@bin_count) { [] }

    # copy each of the existing entries into the new table at their new location,
    # as returned by index_of(key)
    @table.flatten(1).each do |entry|
      new_table[index_of(entry.first)] << entry
    end

    # Finally we overwrite the existing table with our new, larger table
    @table = new_table
  end

  def full?
    # our bins are full when the number of entries surpasses 5 times the number of bins
    @entry_count > @max_density * @bin_count
  end


  def [](key)
    find(key).last
  end

  def find(key)
    # Enumerable#find here will return the first entry that makes
    # our block return true, otherwise it returns nil.

    bin_for(key) do |entry|
      key == entry.first
    end
  end

def bin_for(key)
    # since hash will always return the same thing we know right where to look
    @table[index_of(key)]
  end

  def index_of(key)
    # a pseudorandom number between 0 and 10
    key.hash % NUM_BINS
  end

  def []=(key, value)
    entry = find(key)

    if entry
      # If we already stored it just change the value
      entry[1] = value
    else
      # grow the table whenever we run out of space
      grow if full?

      bin_for(key) << [key, value]
      @entry_count += 1
    end
  end
end