module ReportsHelper
  @@ac = ApplicationController.new

  def render_flot(view, data, width, height)
    IMGKit.new(
      @@ac.render_to_string(
        "reports/#{view}.flot",
        layout: 'flot',
        locals: {
          data: data,
          width: width,
          height: height
        }
      ),
      crop_w: width,
      crop_h: height
    ).to_file("tmp/#{view}.jpg").path
  end
end