
Pod::Spec.new do |s|


  s.name         = "MHUIKIT"
  s.version      = "0.0.6"
  s.summary      = "iOS一套UI开发框架"
  s.homepage     = "https://github.com/hepassion/MHUIKIT"
  s.license      = "MIT"
  s.author       = { "zhaomh" => "hepassion@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/hepassion/MHUIKIT.git", :tag => "#{s.version}" }
  # s.source_files = 'Classes/*.h'
  s.source_files = 'Classes/**/*.{h,m}'

  s.requires_arc = true
  s.frameworks = "Foundation","UIKit"
  s.description  = "MHUIKIT,包含了一些控件封装，工具类等，可加快开发速度。"

  
  
  





  s.subspec 'Encryption' do |ee|
  ee.requires_arc = true
  ee.source_files        = 'Classes/Encryption/*.{h,m}'
  # ee.public_header_files = 'Classes/Encryption/*.h'
  end





  s.subspec 'Utils' do |uu|
  uu.requires_arc = true
  uu.source_files        = 'Classes/Utils/*.{h,m}'
  # uu.public_header_files = 'Classes/Utils/*.h'
  end
  


  
  s.subspec 'Observer' do |oo|
  oo.requires_arc = true
  oo.source_files        = 'Classes/Observer/*.{h,m}'
  # oo.public_header_files = 'Classes/Observer/*.h'
  oo.dependency 'MHUIKIT/Encryption'
  oo.dependency 'MHUIKIT/Utils'


    # oo.subspec 'Utils' do |oosp|
    # oosp.requires_arc        = true
    # oosp.source_files        = 'Classes/Utils/*.{h,m}'
    # end

    # oo.subspec 'Encryption' do |oosp|
    # oosp.requires_arc        = true
    # oosp.source_files        = 'Classes/Encryption/*.{h,m}'
    # end

    # oo.subspec 'CommonDefine' do |oosp|
    # oosp.requires_arc        = true
    # oosp.source_files        = 'Classes/MHCoreKit/*.{h,m}'

    # end

  end





  s.subspec 'MHCoreKit' do |cc|
  cc.requires_arc = true
  # cc.public_header_files = 'Classes/MHCoreKit/*.h'
  cc.source_files        = 'Classes/MHCoreKit/*.{h,m}'
  cc.dependency 'MHUIKIT/Encryption'
  cc.dependency 'MHUIKIT/Utils'
  cc.dependency 'MHUIKIT/Observer'

 #  cc.subspec 'Utils' do |ccsp|
   #  ccsp.requires_arc        = true
   #  ccsp.source_files        = 'Classes/Utils/*.{h,m}'
   # end


   #  cc.subspec 'Encryption' do |ccsp|
   #  ccsp.requires_arc        = true
   #  ccsp.source_files        = 'Classes/Encryption/*.{h,m}'

   #  end
  



end









end
