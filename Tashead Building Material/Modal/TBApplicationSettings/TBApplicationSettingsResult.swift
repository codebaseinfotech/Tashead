//
//	TBApplicationSettingsResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBApplicationSettingsResult : NSObject, NSCoding{

	var androidAppLink : String!
	var businessrules : TBApplicationSettingsBusinessRule!
	var facebookLink : String!
	var instagramLink : String!
	var iosAppLink : String!
	var officeNumber1 : String!
	var officeNumber2 : String!
	var storeAddress : String!
	var storeAddressLat : String!
	var storeAddressLon : String!
	var supportNumber1 : String!
	var supportNumber2 : String!
	var twitterLink : String!
	var youtubeLink : String!


	/**
	 * Overiding init method
	 */
	init(fromDictionary dictionary: NSDictionary)
	{
		super.init()
		parseJSONData(fromDictionary: dictionary)
	}

	/**
	 * Overiding init method
	 */
	override init(){
	}

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	@objc func parseJSONData(fromDictionary dictionary: NSDictionary)
	{
		androidAppLink = dictionary["android_app_link"] as? String == nil ? "" : dictionary["android_app_link"] as? String
		if let businessrulesData = dictionary["business-rules"] as? NSDictionary{
			businessrules = TBApplicationSettingsBusinessRule(fromDictionary: businessrulesData)
		}
		else
		{
			businessrules = TBApplicationSettingsBusinessRule(fromDictionary: NSDictionary.init())
		}
		facebookLink = dictionary["facebook_link"] as? String == nil ? "" : dictionary["facebook_link"] as? String
		instagramLink = dictionary["instagram_link"] as? String == nil ? "" : dictionary["instagram_link"] as? String
		iosAppLink = dictionary["ios_app_link"] as? String == nil ? "" : dictionary["ios_app_link"] as? String
		officeNumber1 = dictionary["office_number_1"] as? String == nil ? "" : dictionary["office_number_1"] as? String
		officeNumber2 = dictionary["office_number_2"] as? String == nil ? "" : dictionary["office_number_2"] as? String
		storeAddress = dictionary["store_address"] as? String == nil ? "" : dictionary["store_address"] as? String
		storeAddressLat = dictionary["store_address_lat"] as? String == nil ? "" : dictionary["store_address_lat"] as? String
		storeAddressLon = dictionary["store_address_lon"] as? String == nil ? "" : dictionary["store_address_lon"] as? String
		supportNumber1 = dictionary["support_number_1"] as? String == nil ? "" : dictionary["support_number_1"] as? String
		supportNumber2 = dictionary["support_number_2"] as? String == nil ? "" : dictionary["support_number_2"] as? String
		twitterLink = dictionary["twitter_link"] as? String == nil ? "" : dictionary["twitter_link"] as? String
		youtubeLink = dictionary["youtube_link"] as? String == nil ? "" : dictionary["youtube_link"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if androidAppLink != nil{
			dictionary["android_app_link"] = androidAppLink
		}
		if businessrules != nil{
			dictionary["business-rules"] = businessrules.toDictionary()
		}
		if facebookLink != nil{
			dictionary["facebook_link"] = facebookLink
		}
		if instagramLink != nil{
			dictionary["instagram_link"] = instagramLink
		}
		if iosAppLink != nil{
			dictionary["ios_app_link"] = iosAppLink
		}
		if officeNumber1 != nil{
			dictionary["office_number_1"] = officeNumber1
		}
		if officeNumber2 != nil{
			dictionary["office_number_2"] = officeNumber2
		}
		if storeAddress != nil{
			dictionary["store_address"] = storeAddress
		}
		if storeAddressLat != nil{
			dictionary["store_address_lat"] = storeAddressLat
		}
		if storeAddressLon != nil{
			dictionary["store_address_lon"] = storeAddressLon
		}
		if supportNumber1 != nil{
			dictionary["support_number_1"] = supportNumber1
		}
		if supportNumber2 != nil{
			dictionary["support_number_2"] = supportNumber2
		}
		if twitterLink != nil{
			dictionary["twitter_link"] = twitterLink
		}
		if youtubeLink != nil{
			dictionary["youtube_link"] = youtubeLink
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         androidAppLink = aDecoder.decodeObject(forKey: "android_app_link") as? String
         businessrules = aDecoder.decodeObject(forKey: "business-rules") as? TBApplicationSettingsBusinessRule
         facebookLink = aDecoder.decodeObject(forKey: "facebook_link") as? String
         instagramLink = aDecoder.decodeObject(forKey: "instagram_link") as? String
         iosAppLink = aDecoder.decodeObject(forKey: "ios_app_link") as? String
         officeNumber1 = aDecoder.decodeObject(forKey: "office_number_1") as? String
         officeNumber2 = aDecoder.decodeObject(forKey: "office_number_2") as? String
         storeAddress = aDecoder.decodeObject(forKey: "store_address") as? String
         storeAddressLat = aDecoder.decodeObject(forKey: "store_address_lat") as? String
         storeAddressLon = aDecoder.decodeObject(forKey: "store_address_lon") as? String
         supportNumber1 = aDecoder.decodeObject(forKey: "support_number_1") as? String
         supportNumber2 = aDecoder.decodeObject(forKey: "support_number_2") as? String
         twitterLink = aDecoder.decodeObject(forKey: "twitter_link") as? String
         youtubeLink = aDecoder.decodeObject(forKey: "youtube_link") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if androidAppLink != nil{
			aCoder.encode(androidAppLink, forKey: "android_app_link")
		}
		if businessrules != nil{
			aCoder.encode(businessrules, forKey: "business-rules")
		}
		if facebookLink != nil{
			aCoder.encode(facebookLink, forKey: "facebook_link")
		}
		if instagramLink != nil{
			aCoder.encode(instagramLink, forKey: "instagram_link")
		}
		if iosAppLink != nil{
			aCoder.encode(iosAppLink, forKey: "ios_app_link")
		}
		if officeNumber1 != nil{
			aCoder.encode(officeNumber1, forKey: "office_number_1")
		}
		if officeNumber2 != nil{
			aCoder.encode(officeNumber2, forKey: "office_number_2")
		}
		if storeAddress != nil{
			aCoder.encode(storeAddress, forKey: "store_address")
		}
		if storeAddressLat != nil{
			aCoder.encode(storeAddressLat, forKey: "store_address_lat")
		}
		if storeAddressLon != nil{
			aCoder.encode(storeAddressLon, forKey: "store_address_lon")
		}
		if supportNumber1 != nil{
			aCoder.encode(supportNumber1, forKey: "support_number_1")
		}
		if supportNumber2 != nil{
			aCoder.encode(supportNumber2, forKey: "support_number_2")
		}
		if twitterLink != nil{
			aCoder.encode(twitterLink, forKey: "twitter_link")
		}
		if youtubeLink != nil{
			aCoder.encode(youtubeLink, forKey: "youtube_link")
		}

	}

}
