module Phase2
  class ControllerBase
    attr_reader :req, :res, :already_built_response

    # Setup the controller
    def initialize(req, res)
      @req = req
      @res = res
    end

    # Helper method to alias @already_built_response
    def already_built_response?
      @already_built_response
    end

    # Set the response status code and header
    def redirect_to(url)
      unless already_built_response?
        @res.status = 302
        @res["location"] = url
        @already_built_response = true
      else
        fail
      end
    end

    # Populate the response with content.
    # Set the response's content type to the given type.
    # Raise an error if the developer tries to double render.
    def render_content(content, content_type)

      unless already_built_response?
        @res.content_type = content_type
        @res.body = content
        @already_built_response = true
      else
        fail
      end

    end
  end
end
