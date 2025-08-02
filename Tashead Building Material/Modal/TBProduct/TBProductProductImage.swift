//
//	TBProductProductImage.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBProductProductImage : NSObject, NSCoding{

	var image : String!
	var mainImage : Int!


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
		image = dictionary["image"] as? String == nil ? "" : dictionary["image"] as? String
		mainImage = dictionary["main_image"] as? Int == nil ? 0 : dictionary["main_image"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if image != nil{
			dictionary["image"] = image
		}
		if mainImage != nil{
			dictionary["main_image"] = mainImage
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         image = aDecoder.decodeObject(forKey: "image") as? String
         mainImage = aDecoder.decodeObject(forKey: "main_image") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if mainImage != nil{
			aCoder.encode(mainImage, forKey: "main_image")
		}

	}

}