module Shadchan
  class Shadchan
=begin rdoc
Create a new instance of stable marriage problem.
Instance will be imediately solved and object can be queried for results.

parameters - preference lists.
accepts arrays of preferences ('women' first), which contain integers. Length
of preference list must correspond with their number.
There must be equal number of men and women and lists must be valid.

Example:
  Shadchan.new [0, 1], [1, 0], [0, 1], [0, 1]

Woman no.0 prefers Man 0 before Man 1.
Woman no.1 prefers Man 1 before Man 0.
Man no.0 prefers Woman 0 before Woman 1.
Man no.1 prefers Woman 0 before Woman 1.
=end
    def initialize *args
      check_input args
      @women = args.shift(args.size/2)
      @men = args
      @size = @men.size
      stable_matching
      raise(StandardError, 'Found solution not stable') unless check_solution
      self
    end
=begin rdoc
Returns matched pairs [woman, man].
=end
    def match
      result = []
      @matches.each_with_index do |m, w|
        result << [w, m]
      end
      return result
    end
=begin rdoc
Returns matches for men
Match of man 0 -
  s.match_men[0]
=end
    def match_men
      result = match
      match.sort_by(&:last).map(&:first)
    end
=begin rdoc
Returnes matches for women
Match of woman 0 -
  s.match_men[0]
=end
    def match_women
      @matches.dup
    end
    private
    def stable_matching
      men_preferences = @men.map(&:dup)
      matches = Array.new(@size)
      while m = free_man_proposable(men_preferences, matches, @size)
        w = men_preferences[m].shift
        unless matches[w] then
          matches[w] = m
          next
        end
        if @women[w].find_index(m) < @women[w].find_index(matches[w]) then
        # if the men is better match then current match
          matches[w] = m
        end
      end
      @matches = matches
    end

    def free_man_proposable m, matches, size
      @size.times do |i|
        free = !matches.include?(i)
        proposable = !m[i].empty?
        if free and proposable then
          return i
        end
      end
      return nil
    end

=begin rdoc
Checks argument if they are valid SM problem.
It should not be empty.
It should have equal number of men and women
It should state preference for all women and for all men.
It should not state preference twice for one men/women.
=end
    def check_input args
      raise ArgumentError, 'No arguments given' if args.empty?
      size = args.first.size
      
      unless args.all?{|w| w.size == size} then
        raise ArgumentError, 'Incorrectly specified input - inconsistent preference list size. Check your input.'
      end
      
      unless args.size == size*2 then
        raise ArgumentError, 'Incorrect number of men or women. Check your input.'
      end

      args.each do |w|
        size.times do |i|
          raise ArgumentError, 'Error in input - it must be 0..number of men' unless w.include? i
        end
      end
    end


=begin rdoc
Checks if the found solution is valid. It should always be, but better safe then sorry.
Tries to find blocking pairs (m, w), (m', w') such that
w' >m w AND m >w' m'
=end
    def check_solution
      @matches.each_with_index do |m, w|
        #check woman
        w_better_candidates = @women[w].take(@women[w].find_index(m))
        # all these are prefered over current spouse. If they prefer her over their current spouse, matching is not stable.
        w_better_candidates.each do |better_man|
          spouse = @matches.find_index(better_man)
          m_better_spouses = @men[better_man].take(@men[better_man].find_index(spouse))
          return false if m_better_spouses.include? w
        end
      end
      true
    end
  end
end
