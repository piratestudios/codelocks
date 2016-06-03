module Codelocks
  class NetCode
    class << self
      # Predefined method for generating a new NetCode
      #
      # @option [String] :lock_id The lock identifier
      # @option [String] :lock_model (K3CONNECT) The type of lock
      # @option [Time] :start (Time.now) The start datetime object
      # @option [Integer] :duration (0) The number of hours the generated code should be valid for from the start_time
      # @option [Boolean] :urm (false) Generate an URM code
      # @option [String] :identifier (Codelocks.access_key) The access key or lock identifier
      #
      # @return [Codelocks::NetCode::Response]

      def generate_netcode(opts = {})
        netcode = new(opts)

        if !netcode.identifier
          raise CodelocksError.new("Either a lock identifier or an access key must be provided")
        end

        p netcode.inspect

        Request.create("netcode/#{netcode.lock_id}",
          "id": netcode.lock_id,
          "start": netcode.start_datetime,
          "duration": netcode.duration_id,
          "lockmodel": netcode.lock_model,
          "identifier": netcode.identifier
        )
      end
    end

    attr_accessor :opts

    def initialize(opts = {})
      self.opts = {
        url_id: nil,
        lock_model: nil || "K3CONNECT",
        lock_id: nil,
        start: nil,
        duration: 0,
        urm: false,
        identifier: nil
      }.merge!(opts)
    end

    def method_missing(method, *args, &block)
      return opts[method] if opts.include?(method)
      super
    end

    # Return either a supplied identifier or the predefined access key
    #
    # @return [String]

    def identifier
      opts[:identifier] || Codelocks.access_key
    end

    # String representing the start date in YYYY-MM-DD format
    #
    # @return [String]

    def start_date
      start.strftime("%Y-%m-%d")
    end

    # String representing the start time. Hour has a leading zero
    #
    # @return [String]

    def start_time
      if urm? && duration_id >= 31 # URM enabled and >= 24 hours duration
        "00:00"
      else
        start.strftime("%H:%M")
      end
    end

    # Full date time formatted for API use
    #
    # @return [String]

    def start_datetime
      [start_date, start_time].join(" ")
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
      !!urm
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
