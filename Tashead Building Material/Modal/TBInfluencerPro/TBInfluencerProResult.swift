//
//	TBInfluencerProResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBInfluencerProResult : NSObject, NSCoding{

	var id : Int!
	var name : String!
	var products : [TBInfluencerProProduct]!


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
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		name = dictionary["name"] as? String == nil ? "" : dictionary["name"] as? String
		products = [TBInfluencerProProduct]()
		if let productsArray = dictionary["products"] as? [NSDictionary]{
			for dic in productsArray{
				let value = TBInfluencerProProduct(fromDictionary: dic)
				products.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if id != nil{
			dictionary["id"] = id
		}
		if name != nil{
			dictionary["name"] = name
		}
		if products != nil{
			var dictionaryElements = [NSDictionary]()
			for productsElement in products {
				dictionaryElements.append(productsElement.toDictionary())
			}
			dictionary["products"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         products = aDecoder.decodeObject(forKey: "products") as? [TBInfluencerProProduct]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if products != nil{
			aCoder.encode(products, forKey: "products")
		}

	}

}