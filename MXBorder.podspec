Pod::Spec.new do |s|
  s.name         = "MXPopover"
  s.version      = "0.1.0"
  s.summary      = "Pop over any view"
  s.description  = "Pop over any view with animation"
  s.homepage     = "https://github.com/longminxiang/MXPopover"
  s.license      = "MIT"
  s.author       = { "Eric Lung" => "longminxiang@gmail.com" }
  s.source       = { :git => "https://github.com/longminxiang/MXPopover.git", :tag => "v" + s.version.to_s }
  s.requires_arc = true
  s.platform     = :ios, '7.0'
  s.source_files = "MXPopover/*.{h,m}"
end
