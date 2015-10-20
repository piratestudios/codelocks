module Codelocks
  module NetCode
    class NetCodeError < CodelocksError; end

    class << self
      # Predefined method for generating a new NetCode
      #
      # @option [String] :lock_id The lock identifier
      # @option [Time] :start_time (Time.now) The start datetime object
      # @option [Integer] :duration The number of hours the generated code should be valid for from the start_time
      #
      # @return [Codelocks::NetCode::Response]

      def generate_netcode(lock_id: nil, start_time: Time.now, duration: nil)
        Request.create("netcode/ncgenerator/getnetcode", {
          id: lock_id,
          sd: start_time.strftime("%d/%m/%Y"),
          st: start_time.strftime("%H"),
          du: convert_duration(duration)
        })
      end

      private

      # Convert a duration in hours to the NetCode duration option
      #
      # @param [Integer] duration number of hours duration
      #
      # @return [Integer]

      def convert_duration(duration = 0)
        case
        when duration == 0
          duration
        when duration <= 12 # less than 13 hours
          duration -1
        when 13..24.include?(duration) # 1 day
          12
        when 25..48.include?(duration) # 2 days
          13
        when 49..72.include?(duration) # 3 days
          14
        when 73..96.include?(duration) # 4 days
          15
        when 97..120.include?(duration) # 5 days
          16
        when 121..144.include?(duration) # 6 days
          17
        when 145..168.include?(duration) # 7 days
          18
        when duration > 168 # more than 7 days, generates a URM code
          19
        end
      end
    end
  end
end
