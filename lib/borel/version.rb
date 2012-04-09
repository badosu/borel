module Borel
  MAJOR = 0
  MINOR = 3
  TINY = 2

  VERSION = [MAJOR, MINOR, TINY].join('.')

  def self.version
    VERSION
  end
end
