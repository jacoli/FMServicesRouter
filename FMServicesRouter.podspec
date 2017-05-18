Pod::Spec.new do |s|
  s.name         = "FMServicesRouter"
  s.version      = "1.0.1"
  s.summary      = "A services router decoupling modules base on service name."
  s.homepage     = "https://github.com/jacoli/FMServicesRouter"
  s.license      = "MIT"
  s.authors      = { "jacoli" => "jaco.lcg@gmail.com" }
  s.source       = { :git => "https://github.com/jacoli/FMServicesRouter.git", :tag => "1.0.1" }
  s.frameworks   = 'Foundation'
  s.platform     = :ios, '7.0'
  s.source_files = 'source/*.{h,m}'
  s.requires_arc = true
end
