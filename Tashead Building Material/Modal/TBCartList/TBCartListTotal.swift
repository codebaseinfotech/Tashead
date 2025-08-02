//
//	TBCartListTotal.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBCartListTotal : NSObject, NSCoding{

	var cartDeliveryCharge : String!
	var cartSubTotal : String!
	var cartTotal : String!
    var promocode_value : String!
    var total_before_discount : String!


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
		cartDeliveryCharge = dictionary["cart_delivery_charge"] as? String == nil ? "" : dictionary["cart_delivery_charge"] as? String
		cartSubTotal = dictionary["cart_sub_total"] as? String == nil ? "" : dictionary["cart_sub_total"] as? String
		cartTotal = dictionary["cart_total"] as? String == nil ? "" : dictionary["cart_total"] as? String
        
        promocode_value = dictionary["promocode_value"] as? String == nil ? "" : dictionary["promocode_value"] as? String
        total_before_discount = dictionary["total_before_discount"] as? String == nil ? "" : dictionary["total_before_discount"] as? String

	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if cartDeliveryCharge != nil{
			dictionary["cart_delivery_charge"] = cartDeliveryCharge
		}
		if cartSubTotal != nil{
			dictionary["cart_sub_total"] = cartSubTotal
		}
		if cartTotal != nil{
			dictionary["cart_total"] = cartTotal
		}
        
        if promocode_value != nil{
            dictionary["promocode_value"] = promocode_value
        }
        if total_before_discount != nil{
            dictionary["total_before_discount"] = total_before_discount
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         cartDeliveryCharge = aDecoder.decodeObject(forKey: "cart_delivery_charge") as? String
         cartSubTotal = aDecoder.decodeObject(forKey: "cart_sub_total") as? String
         cartTotal = aDecoder.decodeObject(forKey: "cart_total") as? String

        promocode_value = aDecoder.decodeObject(forKey: "promocode_value") as? String
        total_before_discount = aDecoder.decodeObject(forKey: "total_before_discount") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if cartDeliveryCharge != nil{
			aCoder.encode(cartDeliveryCharge, forKey: "cart_delivery_charge")
		}
		if cartSubTotal != nil{
			aCoder.encode(cartSubTotal, forKey: "cart_sub_total")
		}
		if cartTotal != nil{
			aCoder.encode(cartTotal, forKey: "cart_total")
		}
        
        if promocode_value != nil{
            aCoder.encode(promocode_value, forKey: "promocode_value")
        }
        if total_before_discount != nil{
            aCoder.encode(total_before_discount, forKey: "total_before_discount")
        }

	}

}
