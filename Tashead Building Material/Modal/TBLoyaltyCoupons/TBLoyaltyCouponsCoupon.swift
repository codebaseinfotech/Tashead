//
//	TBLoyaltyCouponsCoupon.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBLoyaltyCouponsCoupon : NSObject, NSCoding{

	var amount : String!
	var id : Int!
	var image : String!
	var point : Int!
	var title : String!
	var titleAr : String!


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
		amount = dictionary["amount"] as? String == nil ? "" : dictionary["amount"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		image = dictionary["image"] as? String == nil ? "" : dictionary["image"] as? String
		point = dictionary["point"] as? Int == nil ? 0 : dictionary["point"] as? Int
		title = dictionary["title"] as? String == nil ? "" : dictionary["title"] as? String
		titleAr = dictionary["title_ar"] as? String == nil ? "" : dictionary["title_ar"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if amount != nil{
			dictionary["amount"] = amount
		}
		if id != nil{
			dictionary["id"] = id
		}
		if image != nil{
			dictionary["image"] = image
		}
		if point != nil{
			dictionary["point"] = point
		}
		if title != nil{
			dictionary["title"] = title
		}
		if titleAr != nil{
			dictionary["title_ar"] = titleAr
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         amount = aDecoder.decodeObject(forKey: "amount") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         image = aDecoder.decodeObject(forKey: "image") as? String
         point = aDecoder.decodeObject(forKey: "point") as? Int
         title = aDecoder.decodeObject(forKey: "title") as? String
         titleAr = aDecoder.decodeObject(forKey: "title_ar") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if amount != nil{
			aCoder.encode(amount, forKey: "amount")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if point != nil{
			aCoder.encode(point, forKey: "point")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}
		if titleAr != nil{
			aCoder.encode(titleAr, forKey: "title_ar")
		}

	}

}