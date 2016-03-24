module Codelocks
  class NetCode
    class << self
      # Predefined method for generating a new NetCode
      #
      # @option [String] :lock_id The lock identifier
      # @option [Time] :start_time (Time.now) The start datetime object
      # @option [Integer] :duration The number of hours the generated code should be valid for from the start_time
      # @option [Boolean] :urm Generate an URM code
      #
      # @return [Codelocks::NetCode::Response]

      def generate_netcode(lock_id: nil, start_time: Time.now, duration: 0, urm: false)
        netcode = new(lock_id, start_time, duration, urm)

        Request.create("netcode/ncgenerator/getnetcode",
          id: netcode.lock_id,
          sd: netcode.start_date,
          st: netcode.start_time,
          du: netcode.duration_id
        )
      end
    end

    attr_accessor :lock, :start, :duration

    def initialize(lock, start, duration, urm)
      @lock = lock
      @start = start
      @duration = duration
      @urm = urm
    end

    # NetCode lock identifier
    #
    # @return [String]

    def lock_id
      "N#{lock}"
    end

    # String representing the start date in DD/MM/YYYY format
    #
    # @return [String]

    def start_date
      start.strftime("%d/%m/%Y")
    end

    # String representing the start time hour with leading zero
    #
    # @return [String]

    def start_time
      if urm? && duration_id >= 31 # URM enabled and >= 24 hours duration
        '00'
      else
        start.strftime("%H")
      end
    end

    # NetCode duration ID
    #
    # @return [Integer]

    def duration_id
      base_duration + urm_offset
    end

    # Are URM codes enabled?
    #
    # @return [Boolean]

    def urm?
      @urm
    end

    private

    # Convert a duration in hours to the NetCode duration ID
    #
    # @return [Integer]

    def base_duration
      case duration
      when 0
        0
      when 1..12 # less than 13 hours
        duration - 1
      when 13..24 # 1 day
        12
      when 25..48 # 2 days
        13
      when 49..72 # 3 days
        14
      when 73..96 # 4 days
        15
      when 97..120 # 5 days
        16
      when 121..144 # 6 days
        17
      else # 7 days
        18
      end
    end

    # Convert a URM enabled boolean to a NetCode duration offset
    #
    # @return [Integer]

    def urm_offset
      if urm?
        19
      else
        0
      end
    end
  end
end
