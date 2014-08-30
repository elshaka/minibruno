module ReportsHelper
  @@ac = ApplicationController.new

  def render_flot(view, data, width, height)
    File.open("tmp/#{view}.jpg", 'wb') do |file|
      file << IMGKit.new(
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
      ).to_jpg
      file.path
    end
  end
end