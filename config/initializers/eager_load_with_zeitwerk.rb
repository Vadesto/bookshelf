# frozen_string_literal: true

module Rails
  class Application
    def eager_load!
      Zeitwerk::Loader.eager_load_all
    end
  end
end
