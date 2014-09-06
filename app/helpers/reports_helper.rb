module ReportsHelper
  @@ac = ApplicationController.new

  def render_flot(view, data, width, height, options = {})
    jpg_path = "tmp/#{view}-#{current_user.id}-#{options[:suffix]}.jpg"
    html_path = "tmp/#{view}-#{current_user.id}.html"
    File.open(html_path, 'w') do |file|
      file << @@ac.render_to_string(
        "reports/#{view}.flot",
        layout: 'flot',
        locals: {
          data: data,
          width: width,
          height: height
        }
      )
    end
    %x(wkhtmltoimage --crop-h #{height} --crop-w #{width} #{html_path} #{jpg_path})
    jpg_path
  end
end
