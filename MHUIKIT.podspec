
Pod::Spec.new do |s|


  s.name         = "MHUIKIT"
  s.version      = "0.0.1"
  s.summary      = "iOS一套UI开发框架"

  s.description  = "MHUIKIT,包含了一些控件封装，工具类等，可加快开发速度。"

  s.homepage     = "https://github.com/hepassion/MHUIKIT"
  
  s.license      = "MIT"
  
  

  s.author             = { "zhaomhgrdk" => "zhaomhgrdk@ccic-net.com.cn" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/hepassion/MHUIKIT.git", :tag => "#{s.version}" }



  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  

end
