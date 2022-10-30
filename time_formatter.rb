class TimeFormatter

  DESIGNATION = {'year'=> '%Y', 'month'=> '%m', 'day'=> '%d', 'hour'=> '%H', 'minute'=> '%m', 'second'=> '%S'}

  attr_reader :invalid

  def initialize(params)
    @valid = []
    @invalid = []
    @formats = params.split(',')
    detect_formats
  end

  def valid?
    invalid.empty?
  end

  def call
    Time.now.strftime(@valid.join('-'))
  end

  private

  def detect_formats
    @formats.each do |format|
      if DESIGNATION[format]
        @valid << DESIGNATION[format]
      else
        @invalid << format
      end
    end
  end
end
