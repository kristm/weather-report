module OpenMeteo
  class Errors
    def self.map(code)
      case code
      when 401
        return 'Unauthorized'
      when 404
        return 'Page not found'
      else
        return 'Service unavailable'
      end
    end
  end
end
