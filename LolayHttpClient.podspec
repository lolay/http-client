Pod::Spec.new do |s|

    s.name              = 'LolayHttpClient'
    s.version           = '1'
    s.summary           = 'Based on 0.5 http client from google code http://code.google.com/p/objective-c-http-client/ with a lot of customization, etc.'
    s.homepage          = 'https://github.com/Lolay/http-client'
    s.license           = {
        :type => 'Apache',
        :file => 'LICENSE'
    }
    s.author            = {
        'Lolay' => 'support@lolay.com'
    }
    s.source            = {
        :git => 'https://github.com/lolay/http-client.git',
        :tag => "1"
    }
    s.source_files      = '*.{h,m}'
    s.requires_arc      = true
	s.library = 'z'
	s.ios.deployment_target = '7.0'
end
