require 'rest-client'

Given /^a new user registers a device$/ do
  regquery = RestClient::Resource.new(
      "http://servername.com",
      {"twitter_id" => "foo",
       "twitter_user" => "ios_reg1872934",
       "twitter_id" => "787307939",
       "twitter_verified_user" => "true",
       "product_name" => "Dude_6_0",
       "product_version" =>"2_1_4",
       "device_model" =>"5",
       "device_platform" => "IPHONE",
       "device_os_version"=> "IOS_6",
       "location_enabled"=> "true",
       "carrier" => "SuperCarrier",
       "country" => "US",
       "lat" => "42.369706",
       "lon" => "-71.173553",
       "postal_code"=> "48104",
       "email" => "ios_regEmail1872934@qa.com",
       "name" => "ios_regName1872934",
       "language"=> "en"}.to_json

  )
  regquery.headers
  {:content_type => "application/json", :ApiKey => 'blablabla'}
  regquery.post
@response


end
When /^the reg server responds$/ do
 @response.code.should == "200"
end
Then /^user should get a (.*)$/ do  |postalcode|
  @response['postal_code'].should == "#{postalcode}"
end
