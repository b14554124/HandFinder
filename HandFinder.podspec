Pod::Spec.new do |s|

  s.name         = "HandFinder"
  s.version      = "1.0.0"
  s.summary      = "Vision +  ML  = 🤚:D , One Code One Result."

  s.homepage     = "https://github.com/b14554124/HandFinder"

  s.license= { :type => "MIT", :file => "LICENSE" }

  s.author             = { "b14554124" => "505763451@qq.com" }

  s.platform     = :ios, "11.0"


  s.source       = { :git => "https://github.com/b14554124/HandFinder.git", :tag => "1.0.0" }

  s.source_files  = "HandFinder", "HandFinder/**/*.{h,m,mlmodel}"

  s.requires_arc = true


end