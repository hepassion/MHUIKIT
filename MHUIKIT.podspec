
Pod::Spec.new do |s|


  s.name         = "MHUIKIT"
  s.version      = "0.1.8"
  s.summary      = "iOS一套UI开发框架"
  s.homepage     = "https://github.com/hepassion/MHUIKIT"
  s.license      = "MIT"
  s.author       = { "zhaomh" => "hepassion@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/hepassion/MHUIKIT.git", :tag => "#{s.version}" }
  s.source_files = 'Classes/*.h'
  s.requires_arc = true
  s.frameworks = "Foundation","UIKit", "WebKit"
  s.description  = "MHUIKIT,包含了一些控件封装，工具类等，可加快开发速度。"


  

  s.subspec 'MHDubgger' do |sp|
  sp.requires_arc   = true
  sp.source_files   = 'Classes/MHDubgger/*.{h,m}'
  sp.dependency     'Aspects', '~> 1.4.1'
  end


  s.subspec 'Encryption' do |sp|
  sp.requires_arc = true
  sp.source_files        = 'Classes/Encryption/*.{h,m}'
  end



  s.subspec 'Utils' do |sp|
  sp.requires_arc = true
  sp.source_files        = 'Classes/Utils/*.{h,m}'
  end
  

  
  s.subspec 'Observer' do |sp|
  sp.requires_arc = true
  sp.source_files        = 'Classes/Observer/*.{h,m}'
  sp.dependency 'MHUIKIT/Encryption'
  sp.dependency 'MHUIKIT/Utils'
  end


  s.subspec 'SBPlayer' do |sp|
  sp.requires_arc        = true
  sp.source_files        = 'Classes/SBPlayer/*.{h,m}'
  sp.dependency          'Masonry', '~> 1.1.0'

  end




  s.subspec 'MHCoreKit' do |sp|
  sp.requires_arc = true
  sp.source_files        = 'Classes/MHCoreKit/*.{h,m}'
  # sp.resources = ["Assets/*.png"]

  sp.resource_bundles = {
    'MHUIKIT' => ['Assets/*.png']
  }
  sp.dependency 'MHUIKIT/Encryption'
  sp.dependency 'MHUIKIT/Utils'
  sp.dependency 'MHUIKIT/Observer'
end









end
