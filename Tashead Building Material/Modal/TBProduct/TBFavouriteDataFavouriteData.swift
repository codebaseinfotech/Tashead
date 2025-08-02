//
//	TBFavouriteDataFavouriteData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBFavouriteDataFavouriteData : NSObject, NSCoding{

	var createdAt : String!
	var id : Int!
	var isFavouriteProduct : Int!
	var productId : Int!
	var updatedAt : String!
	var userId : Int!


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
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		isFavouriteProduct = dictionary["is_favourite_product"] as? Int == nil ? 0 : dictionary["is_favourite_product"] as? Int
		productId = dictionary["product_id"] as? Int == nil ? 0 : dictionary["product_id"] as? Int
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
		userId = dictionary["user_id"] as? Int == nil ? 0 : dictionary["user_id"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isFavouriteProduct != nil{
			dictionary["is_favourite_product"] = isFavouriteProduct
		}
		if productId != nil{
			dictionary["product_id"] = productId
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if userId != nil{
			dictionary["user_id"] = userId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isFavouriteProduct = aDecoder.decodeObject(forKey: "is_favourite_product") as? Int
         productId = aDecoder.decodeObject(forKey: "product_id") as? Int
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isFavouriteProduct != nil{
			aCoder.encode(isFavouriteProduct, forKey: "is_favourite_product")
		}
		if productId != nil{
			aCoder.encode(productId, forKey: "product_id")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}

	}

}