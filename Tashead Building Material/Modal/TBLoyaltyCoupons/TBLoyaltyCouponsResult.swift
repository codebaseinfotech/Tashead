//
//	TBLoyaltyCouponsResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBLoyaltyCouponsResult : NSObject, NSCoding{

	var coupons : [TBLoyaltyCouponsCoupon]!
    var point : String!


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
		coupons = [TBLoyaltyCouponsCoupon]()
		if let couponsArray = dictionary["coupons"] as? [NSDictionary]{
			for dic in couponsArray{
				let value = TBLoyaltyCouponsCoupon(fromDictionary: dic)
				coupons.append(value)
			}
		}
		point = dictionary["point"] as? String == nil ? "" : dictionary["point"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if coupons != nil{
			var dictionaryElements = [NSDictionary]()
			for couponsElement in coupons {
				dictionaryElements.append(couponsElement.toDictionary())
			}
			dictionary["coupons"] = dictionaryElements
		}
		if point != nil{
			dictionary["point"] = point
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         coupons = aDecoder.decodeObject(forKey: "coupons") as? [TBLoyaltyCouponsCoupon]
         point = aDecoder.decodeObject(forKey: "point") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if coupons != nil{
			aCoder.encode(coupons, forKey: "coupons")
		}
		if point != nil{
			aCoder.encode(point, forKey: "point")
		}

	}

}
