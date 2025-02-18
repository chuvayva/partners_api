class SkipMiddlewareByPath
  def initialize(app, middleware_class, options = {})
    @app = app
    @middleware_class = middleware_class
    @middleware_options = options.except(:except)
    @except_regexes = Array(options[:except])
  end

  def call(env)
    request = Rack::Request.new(env)

    if @except_regexes.any? { |regex| request.path.match?(regex) }
      return @app.call(env)
    end

    middleware_instance = @middleware_class.new(@app, **@middleware_options)
    middleware_instance.call(env)
  end
end
