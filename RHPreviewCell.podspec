Pod::Spec.new do |s|

  s.name         = "RHPreviewCell"
  s.version      = "1.0.0"
  s.summary      = "Now you can add extra feature to your TableViewCell, which provides your users to preview content behind the cell."
  s.description  = "Now you can add extra feature to your TableViewCell"

  s.homepage     = "https://github.com/robertherdzik/RHPreviewCell"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license = { :type => "MIT", :file => "LICENSE" }

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author             = { "Robert Herdzik" => "robert.herdzik@yahoo.com" }

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source       = { :git => "http://github.com/robertherdzik/RHPreviewCell", :tag => "#{s.version}" }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files  = "RHPreviewCell/**/*.{swift}"

end
