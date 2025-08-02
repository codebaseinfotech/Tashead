//
//	TBCategoriesResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBCategoriesResult : NSObject, NSCoding{

	var categoryNameAr : String!
	var categoryNameEn : String!
	var id : Int!
	var image : String!
	var isStepCategory : Int!
	var name : String!
	var parentId : Int!
	var status : Int!


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
		categoryNameAr = dictionary["category_name_ar"] as? String == nil ? "" : dictionary["category_name_ar"] as? String
		categoryNameEn = dictionary["category_name_en"] as? String == nil ? "" : dictionary["category_name_en"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		image = dictionary["image"] as? String == nil ? "" : dictionary["image"] as? String
		isStepCategory = dictionary["is_step_category"] as? Int == nil ? 0 : dictionary["is_step_category"] as? Int
		name = dictionary["name"] as? String == nil ? "" : dictionary["name"] as? String
		parentId = dictionary["parent_id"] as? Int == nil ? 0 : dictionary["parent_id"] as? Int
		status = dictionary["status"] as? Int == nil ? 0 : dictionary["status"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if categoryNameAr != nil{
			dictionary["category_name_ar"] = categoryNameAr
		}
		if categoryNameEn != nil{
			dictionary["category_name_en"] = categoryNameEn
		}
		if id != nil{
			dictionary["id"] = id
		}
		if image != nil{
			dictionary["image"] = image
		}
		if isStepCategory != nil{
			dictionary["is_step_category"] = isStepCategory
		}
		if name != nil{
			dictionary["name"] = name
		}
		if parentId != nil{
			dictionary["parent_id"] = parentId
		}
		if status != nil{
			dictionary["status"] = status
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         categoryNameAr = aDecoder.decodeObject(forKey: "category_name_ar") as? String
         categoryNameEn = aDecoder.decodeObject(forKey: "category_name_en") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         image = aDecoder.decodeObject(forKey: "image") as? String
         isStepCategory = aDecoder.decodeObject(forKey: "is_step_category") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         parentId = aDecoder.decodeObject(forKey: "parent_id") as? Int
         status = aDecoder.decodeObject(forKey: "status") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if categoryNameAr != nil{
			aCoder.encode(categoryNameAr, forKey: "category_name_ar")
		}
		if categoryNameEn != nil{
			aCoder.encode(categoryNameEn, forKey: "category_name_en")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if isStepCategory != nil{
			aCoder.encode(isStepCategory, forKey: "is_step_category")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if parentId != nil{
			aCoder.encode(parentId, forKey: "parent_id")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}

	}

}