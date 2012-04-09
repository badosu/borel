module Borel
  MAJOR = 0
  MINOR = 3
  TINY = 1

  VERSION = [MAJOR, MINOR, TINY].join('.')

  def self.version
    VERSION
  end
end
