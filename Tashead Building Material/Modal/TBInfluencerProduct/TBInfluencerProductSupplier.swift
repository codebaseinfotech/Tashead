//
//	TBInfluencerProductSupplier.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBInfluencerProductSupplier : NSObject, NSCoding{

	var prices : [TBInfluencerProductPrice]!
	var supplier : String!
	var supplierId : Int!


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
		prices = [TBInfluencerProductPrice]()
		if let pricesArray = dictionary["prices"] as? [NSDictionary]{
			for dic in pricesArray{
				let value = TBInfluencerProductPrice(fromDictionary: dic)
				prices.append(value)
			}
		}
		supplier = dictionary["supplier"] as? String == nil ? "" : dictionary["supplier"] as? String
		supplierId = dictionary["supplier_id"] as? Int == nil ? 0 : dictionary["supplier_id"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if prices != nil{
			var dictionaryElements = [NSDictionary]()
			for pricesElement in prices {
				dictionaryElements.append(pricesElement.toDictionary())
			}
			dictionary["prices"] = dictionaryElements
		}
		if supplier != nil{
			dictionary["supplier"] = supplier
		}
		if supplierId != nil{
			dictionary["supplier_id"] = supplierId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         prices = aDecoder.decodeObject(forKey: "prices") as? [TBInfluencerProductPrice]
         supplier = aDecoder.decodeObject(forKey: "supplier") as? String
         supplierId = aDecoder.decodeObject(forKey: "supplier_id") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if prices != nil{
			aCoder.encode(prices, forKey: "prices")
		}
		if supplier != nil{
			aCoder.encode(supplier, forKey: "supplier")
		}
		if supplierId != nil{
			aCoder.encode(supplierId, forKey: "supplier_id")
		}

	}

}