//
//	TBProductDetailsData.swift
//
//	Create by Ankit Gabani on 24/7/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBProductDetailsData : NSObject, NSCoding{

    
    var pricesIndex : Int!
    var suppliersIndex : Int!

    var catelog : String!

	var createdAt : String!
	var currency : String!
	var favourite : Bool!
	var favouriteData : String!
	var id : Int!
	var isSupplierDetailShow : Int!
	var name : String!
	var productDescriptionAr : String!
	var productDescriptionEn : String!
	var productImages : [TBProductDetailsProductImage]!
	var productNameAr : String!
	var productNameEn : String!
	var status : Int!
	var stepWiseCategoryId : String!
	var subcategoryId : String!
	var suppliers : [TBProductDetailsSupplier]!
	var unitType : String!


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
        
       
        
        pricesIndex = dictionary["pricesIndex"] as? Int == nil ? 0 : dictionary["id"] as? Int
        suppliersIndex = dictionary["suppliersIndex"] as? Int == nil ? 0 : dictionary["suppliersIndex"] as? Int

        catelog = dictionary["catelog"] as? String == nil ? "" : dictionary["catelog"] as? String

		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		currency = dictionary["currency"] as? String == nil ? "" : dictionary["currency"] as? String
		favourite = dictionary["favourite"] as? Bool == nil ? false : dictionary["favourite"] as? Bool
		favouriteData = dictionary["favourite_data"] as? String == nil ? "" : dictionary["favourite_data"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		isSupplierDetailShow = dictionary["is_supplier_detail_show"] as? Int == nil ? 0 : dictionary["is_supplier_detail_show"] as? Int
		name = dictionary["name"] as? String == nil ? "" : dictionary["name"] as? String
		productDescriptionAr = dictionary["product_description_ar"] as? String == nil ? "" : dictionary["product_description_ar"] as? String
		productDescriptionEn = dictionary["product_description_en"] as? String == nil ? "" : dictionary["product_description_en"] as? String
		productImages = [TBProductDetailsProductImage]()
		if let productImagesArray = dictionary["product_images"] as? [NSDictionary]{
			for dic in productImagesArray{
				let value = TBProductDetailsProductImage(fromDictionary: dic)
				productImages.append(value)
			}
		}
		productNameAr = dictionary["product_name_ar"] as? String == nil ? "" : dictionary["product_name_ar"] as? String
		productNameEn = dictionary["product_name_en"] as? String == nil ? "" : dictionary["product_name_en"] as? String
		status = dictionary["status"] as? Int == nil ? 0 : dictionary["status"] as? Int
		stepWiseCategoryId = dictionary["step_wise_category_id"] as? String == nil ? "" : dictionary["step_wise_category_id"] as? String
		subcategoryId = dictionary["subcategory_id"] as? String == nil ? "" : dictionary["subcategory_id"] as? String
		suppliers = [TBProductDetailsSupplier]()
		if let suppliersArray = dictionary["suppliers"] as? [NSDictionary]{
			for dic in suppliersArray{
				let value = TBProductDetailsSupplier(fromDictionary: dic)
				suppliers.append(value)
			}
		}
		unitType = dictionary["unit_type"] as? String == nil ? "" : dictionary["unit_type"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
      
        
        if pricesIndex != nil{
            dictionary["pricesIndex"] = pricesIndex
        }
        if suppliersIndex != nil{
            dictionary["suppliersIndex"] = suppliersIndex
        }
        
        if catelog != nil{
            dictionary["catelog"] = catelog
        }
        
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if currency != nil{
			dictionary["currency"] = currency
		}
		if favourite != nil{
			dictionary["favourite"] = favourite
		}
		if favouriteData != nil{
			dictionary["favourite_data"] = favouriteData
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isSupplierDetailShow != nil{
			dictionary["is_supplier_detail_show"] = isSupplierDetailShow
		}
		if name != nil{
			dictionary["name"] = name
		}
		if productDescriptionAr != nil{
			dictionary["product_description_ar"] = productDescriptionAr
		}
		if productDescriptionEn != nil{
			dictionary["product_description_en"] = productDescriptionEn
		}
		if productImages != nil{
			var dictionaryElements = [NSDictionary]()
			for productImagesElement in productImages {
				dictionaryElements.append(productImagesElement.toDictionary())
			}
			dictionary["product_images"] = dictionaryElements
		}
		if productNameAr != nil{
			dictionary["product_name_ar"] = productNameAr
		}
		if productNameEn != nil{
			dictionary["product_name_en"] = productNameEn
		}
		if status != nil{
			dictionary["status"] = status
		}
		if stepWiseCategoryId != nil{
			dictionary["step_wise_category_id"] = stepWiseCategoryId
		}
		if subcategoryId != nil{
			dictionary["subcategory_id"] = subcategoryId
		}
		if suppliers != nil{
			var dictionaryElements = [NSDictionary]()
			for suppliersElement in suppliers {
				dictionaryElements.append(suppliersElement.toDictionary())
			}
			dictionary["suppliers"] = dictionaryElements
		}
		if unitType != nil{
			dictionary["unit_type"] = unitType
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
      
        
        pricesIndex = aDecoder.decodeObject(forKey: "pricesIndex") as? Int
        suppliersIndex = aDecoder.decodeObject(forKey: "suppliersIndex") as? Int

        catelog = aDecoder.decodeObject(forKey: "catelog") as? String

         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         currency = aDecoder.decodeObject(forKey: "currency") as? String
         favourite = aDecoder.decodeObject(forKey: "favourite") as? Bool
         favouriteData = aDecoder.decodeObject(forKey: "favourite_data") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isSupplierDetailShow = aDecoder.decodeObject(forKey: "is_supplier_detail_show") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         productDescriptionAr = aDecoder.decodeObject(forKey: "product_description_ar") as? String
         productDescriptionEn = aDecoder.decodeObject(forKey: "product_description_en") as? String
         productImages = aDecoder.decodeObject(forKey: "product_images") as? [TBProductDetailsProductImage]
         productNameAr = aDecoder.decodeObject(forKey: "product_name_ar") as? String
         productNameEn = aDecoder.decodeObject(forKey: "product_name_en") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Int
         stepWiseCategoryId = aDecoder.decodeObject(forKey: "step_wise_category_id") as? String
         subcategoryId = aDecoder.decodeObject(forKey: "subcategory_id") as? String
         suppliers = aDecoder.decodeObject(forKey: "suppliers") as? [TBProductDetailsSupplier]
         unitType = aDecoder.decodeObject(forKey: "unit_type") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
        
      
        
        if pricesIndex != nil{
            aCoder.encode(pricesIndex, forKey: "pricesIndex")
        }
        if suppliersIndex != nil{
            aCoder.encode(suppliersIndex, forKey: "suppliersIndex")
        }
        
        if catelog != nil{
            aCoder.encode(catelog, forKey: "catelog")
        }
        
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if currency != nil{
			aCoder.encode(currency, forKey: "currency")
		}
		if favourite != nil{
			aCoder.encode(favourite, forKey: "favourite")
		}
		if favouriteData != nil{
			aCoder.encode(favouriteData, forKey: "favourite_data")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isSupplierDetailShow != nil{
			aCoder.encode(isSupplierDetailShow, forKey: "is_supplier_detail_show")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if productDescriptionAr != nil{
			aCoder.encode(productDescriptionAr, forKey: "product_description_ar")
		}
		if productDescriptionEn != nil{
			aCoder.encode(productDescriptionEn, forKey: "product_description_en")
		}
		if productImages != nil{
			aCoder.encode(productImages, forKey: "product_images")
		}
		if productNameAr != nil{
			aCoder.encode(productNameAr, forKey: "product_name_ar")
		}
		if productNameEn != nil{
			aCoder.encode(productNameEn, forKey: "product_name_en")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if stepWiseCategoryId != nil{
			aCoder.encode(stepWiseCategoryId, forKey: "step_wise_category_id")
		}
		if subcategoryId != nil{
			aCoder.encode(subcategoryId, forKey: "subcategory_id")
		}
		if suppliers != nil{
			aCoder.encode(suppliers, forKey: "suppliers")
		}
		if unitType != nil{
			aCoder.encode(unitType, forKey: "unit_type")
		}

	}

}
