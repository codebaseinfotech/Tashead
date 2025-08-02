//
//	TBCmsAdverdResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBCmsAdverdResult : NSObject, NSCoding{

	var adDuration : String!
	var adDurationUnit : String!
	var image : String!
	var type : String!
	var value : String!


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
		adDuration = dictionary["ad_duration"] as? String == nil ? "" : dictionary["ad_duration"] as? String
		adDurationUnit = dictionary["ad_duration_unit"] as? String == nil ? "" : dictionary["ad_duration_unit"] as? String
		image = dictionary["image"] as? String == nil ? "" : dictionary["image"] as? String
		type = dictionary["type"] as? String == nil ? "" : dictionary["type"] as? String
		value = dictionary["value"] as? String == nil ? "" : dictionary["value"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if adDuration != nil{
			dictionary["ad_duration"] = adDuration
		}
		if adDurationUnit != nil{
			dictionary["ad_duration_unit"] = adDurationUnit
		}
		if image != nil{
			dictionary["image"] = image
		}
		if type != nil{
			dictionary["type"] = type
		}
		if value != nil{
			dictionary["value"] = value
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         adDuration = aDecoder.decodeObject(forKey: "ad_duration") as? String
         adDurationUnit = aDecoder.decodeObject(forKey: "ad_duration_unit") as? String
         image = aDecoder.decodeObject(forKey: "image") as? String
         type = aDecoder.decodeObject(forKey: "type") as? String
         value = aDecoder.decodeObject(forKey: "value") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if adDuration != nil{
			aCoder.encode(adDuration, forKey: "ad_duration")
		}
		if adDurationUnit != nil{
			aCoder.encode(adDurationUnit, forKey: "ad_duration_unit")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}
		if value != nil{
			aCoder.encode(value, forKey: "value")
		}

	}

}
