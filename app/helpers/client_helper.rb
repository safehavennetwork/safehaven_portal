module ClientHelper
  def apply_review?
    request.env["HTTP_REFERER"].include?('apply')
  end
end
