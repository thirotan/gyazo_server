# frozen_string_literal :true

module SinatraApp
  module Helper
    def h(text:)
      Rack::Utils.escape_html(text)
    end
  end
end
