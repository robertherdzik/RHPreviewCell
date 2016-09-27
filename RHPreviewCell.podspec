Pod::Spec.new do |s|
s.name         = "RHPreviewCell"
s.version      = "1.0.0"
s.summary      = "Now you can add extra feature to your TableViewCell, which provides your users to preview content behind the cell."
s.description  = "Now you can add extra feature to your TableViewCell, which provides your users to preview content behind the cell."
s.homepage     = "https://github.com/robertherdzik/RHPreviewCell"

# ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
s.license = { :type => "MIT", :file => "LICENSE" }

# ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
s.author             = { "Robert Herdzik" => "robert.herdzik@yahoo.com" }

# ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
s.source = {
:git => "https://github.com/robertherdzik/RHPreviewCell.git",
:tag => s.version.to_s
}

s.ios.deployment_target = '8.0'
s.requires_arc = true

# ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
s.ios.source_files  = "RHPreviewCell/**/*.{swift}"

end