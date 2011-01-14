module Shadchan
  class Shadchan
    =begin rdoc
    Create a new instance of stable marriage problem.
    Instance will be imediately computed and object can be queried for results.

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
    end

    private
    def check_input args
      size = args.first.size
      raise ArgumentError, 'Incorrectly specified input - inconsistent preference list size'
    end

  end
end
