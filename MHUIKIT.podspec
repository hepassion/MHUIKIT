
Pod::Spec.new do |s|


  s.name         = "MHUIKIT"
  s.version      = "0.0.2"
  s.summary      = "iOS一套UI开发框架"

  s.description  = "MHUIKIT,包含了一些控件封装，工具类等，可加快开发速度。"

  s.homepage     = "https://github.com/hepassion/MHUIKIT"
  
  s.license      = "MIT"
  
  

  s.author       = { "zhaomh" => "hepassion@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/hepassion/MHUIKIT.git", :tag => "#{s.version}" }
  s.requires_arc = true


  #s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.public_header_files = 'Classes/MHUIKIT.h'
  s.source_files = 'Classes/MHUIKIT.h'

  # s.exclude_files = "Classes/Exclude"

  
  s.subspec 'MHCoreKit' do |cc|
  cc.source_files = 'Classes/MHCoreKit/*.{h,m}'
  cc.public_header_files = 'Classes/MHCoreKit/*.h'
  end


  



  
  s.subspec 'Observer' do |oo|
  oo.source_files = 'Classes/Observer/*.{h,m}'
  oo.public_header_files = 'Classes/Observer/*.h'
  end



  s.subspec 'Utils' do |uu|
  uu.source_files = 'Classes/Utils/*.{h,m}'
  uu.public_header_files = 'Classes/Utils/*.h'
  end








end
