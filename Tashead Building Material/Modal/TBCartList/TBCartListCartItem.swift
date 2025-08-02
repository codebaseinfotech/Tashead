//
//	TBCartListCartItem.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBCartListCartItem : NSObject, NSCoding{

	var cartItemId : Int!
	var discount : String!
	var factoryProduct : Int!
	var height : Int!
	var heightType : String!
	var images : [TBCartListImage]!
	var isSupplierDetailShow : Int!
	var length : Int!
	var lengthType : String!
	var maxQuantity : Int!
	var minusQuantity : Int!
	var name : String!
	var originalPrice : String!
	var price : String!
	var productNetPrice : String!
	var productTotal : String!
	var quantity : Int!
	var supplier : String!
	var supplierId : Int!
	var unit : String!
	var weight : Int!
	var weightType : String!
	var width : Int!
	var widthType : String!
    
     

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
        

        
		cartItemId = dictionary["cart_item_id"] as? Int == nil ? 0 : dictionary["cart_item_id"] as? Int
		discount = dictionary["discount"] as? String == nil ? "" : dictionary["discount"] as? String
		factoryProduct = dictionary["factory_product"] as? Int == nil ? 0 : dictionary["factory_product"] as? Int
		height = dictionary["height"] as? Int == nil ? 0 : dictionary["height"] as? Int
		heightType = dictionary["height_type"] as? String == nil ? "" : dictionary["height_type"] as? String
		images = [TBCartListImage]()
		if let imagesArray = dictionary["images"] as? [NSDictionary]{
			for dic in imagesArray{
				let value = TBCartListImage(fromDictionary: dic)
				images.append(value)
			}
		}
		isSupplierDetailShow = dictionary["is_supplier_detail_show"] as? Int == nil ? 0 : dictionary["is_supplier_detail_show"] as? Int
		length = dictionary["length"] as? Int == nil ? 0 : dictionary["length"] as? Int
		lengthType = dictionary["length_type"] as? String == nil ? "" : dictionary["length_type"] as? String
		maxQuantity = dictionary["max_quantity"] as? Int == nil ? 0 : dictionary["max_quantity"] as? Int
		minusQuantity = dictionary["minus_quantity"] as? Int == nil ? 0 : dictionary["minus_quantity"] as? Int
		name = dictionary["name"] as? String == nil ? "" : dictionary["name"] as? String
		originalPrice = dictionary["original_price"] as? String == nil ? "" : dictionary["original_price"] as? String
		price = dictionary["price"] as? String == nil ? "" : dictionary["price"] as? String
		productNetPrice = dictionary["product_net_price"] as? String == nil ? "" : dictionary["product_net_price"] as? String
		productTotal = dictionary["product_total"] as? String == nil ? "" : dictionary["product_total"] as? String
		quantity = dictionary["quantity"] as? Int == nil ? 0 : dictionary["quantity"] as? Int
		supplier = dictionary["supplier"] as? String == nil ? "" : dictionary["supplier"] as? String
		supplierId = dictionary["supplier_id"] as? Int == nil ? 0 : dictionary["supplier_id"] as? Int
		unit = dictionary["unit"] as? String == nil ? "" : dictionary["unit"] as? String
		weight = dictionary["weight"] as? Int == nil ? 0 : dictionary["weight"] as? Int
		weightType = dictionary["weight_type"] as? String == nil ? "" : dictionary["weight_type"] as? String
		width = dictionary["width"] as? Int == nil ? 0 : dictionary["width"] as? Int
		widthType = dictionary["width_type"] as? String == nil ? "" : dictionary["width_type"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
        
        
       
        
		if cartItemId != nil{
			dictionary["cart_item_id"] = cartItemId
		}
		if discount != nil{
			dictionary["discount"] = discount
		}
		if factoryProduct != nil{
			dictionary["factory_product"] = factoryProduct
		}
		if height != nil{
			dictionary["height"] = height
		}
		if heightType != nil{
			dictionary["height_type"] = heightType
		}
		if images != nil{
			var dictionaryElements = [NSDictionary]()
			for imagesElement in images {
				dictionaryElements.append(imagesElement.toDictionary())
			}
			dictionary["images"] = dictionaryElements
		}
		if isSupplierDetailShow != nil{
			dictionary["is_supplier_detail_show"] = isSupplierDetailShow
		}
		if length != nil{
			dictionary["length"] = length
		}
		if lengthType != nil{
			dictionary["length_type"] = lengthType
		}
		if maxQuantity != nil{
			dictionary["max_quantity"] = maxQuantity
		}
		if minusQuantity != nil{
			dictionary["minus_quantity"] = minusQuantity
		}
		if name != nil{
			dictionary["name"] = name
		}
		if originalPrice != nil{
			dictionary["original_price"] = originalPrice
		}
		if price != nil{
			dictionary["price"] = price
		}
		if productNetPrice != nil{
			dictionary["product_net_price"] = productNetPrice
		}
		if productTotal != nil{
			dictionary["product_total"] = productTotal
		}
		if quantity != nil{
			dictionary["quantity"] = quantity
		}
		if supplier != nil{
			dictionary["supplier"] = supplier
		}
		if supplierId != nil{
			dictionary["supplier_id"] = supplierId
		}
		if unit != nil{
			dictionary["unit"] = unit
		}
		if weight != nil{
			dictionary["weight"] = weight
		}
		if weightType != nil{
			dictionary["weight_type"] = weightType
		}
		if width != nil{
			dictionary["width"] = width
		}
		if widthType != nil{
			dictionary["width_type"] = widthType
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        
        
       
        
         cartItemId = aDecoder.decodeObject(forKey: "cart_item_id") as? Int
         discount = aDecoder.decodeObject(forKey: "discount") as? String
         factoryProduct = aDecoder.decodeObject(forKey: "factory_product") as? Int
         height = aDecoder.decodeObject(forKey: "height") as? Int
         heightType = aDecoder.decodeObject(forKey: "height_type") as? String
         images = aDecoder.decodeObject(forKey: "images") as? [TBCartListImage]
         isSupplierDetailShow = aDecoder.decodeObject(forKey: "is_supplier_detail_show") as? Int
         length = aDecoder.decodeObject(forKey: "length") as? Int
         lengthType = aDecoder.decodeObject(forKey: "length_type") as? String
         maxQuantity = aDecoder.decodeObject(forKey: "max_quantity") as? Int
         minusQuantity = aDecoder.decodeObject(forKey: "minus_quantity") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         originalPrice = aDecoder.decodeObject(forKey: "original_price") as? String
         price = aDecoder.decodeObject(forKey: "price") as? String
         productNetPrice = aDecoder.decodeObject(forKey: "product_net_price") as? String
         productTotal = aDecoder.decodeObject(forKey: "product_total") as? String
         quantity = aDecoder.decodeObject(forKey: "quantity") as? Int
         supplier = aDecoder.decodeObject(forKey: "supplier") as? String
         supplierId = aDecoder.decodeObject(forKey: "supplier_id") as? Int
         unit = aDecoder.decodeObject(forKey: "unit") as? String
         weight = aDecoder.decodeObject(forKey: "weight") as? Int
         weightType = aDecoder.decodeObject(forKey: "weight_type") as? String
         width = aDecoder.decodeObject(forKey: "width") as? Int
         widthType = aDecoder.decodeObject(forKey: "width_type") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
 
		if cartItemId != nil{
			aCoder.encode(cartItemId, forKey: "cart_item_id")
		}
		if discount != nil{
			aCoder.encode(discount, forKey: "discount")
		}
		if factoryProduct != nil{
			aCoder.encode(factoryProduct, forKey: "factory_product")
		}
		if height != nil{
			aCoder.encode(height, forKey: "height")
		}
		if heightType != nil{
			aCoder.encode(heightType, forKey: "height_type")
		}
		if images != nil{
			aCoder.encode(images, forKey: "images")
		}
		if isSupplierDetailShow != nil{
			aCoder.encode(isSupplierDetailShow, forKey: "is_supplier_detail_show")
		}
		if length != nil{
			aCoder.encode(length, forKey: "length")
		}
		if lengthType != nil{
			aCoder.encode(lengthType, forKey: "length_type")
		}
		if maxQuantity != nil{
			aCoder.encode(maxQuantity, forKey: "max_quantity")
		}
		if minusQuantity != nil{
			aCoder.encode(minusQuantity, forKey: "minus_quantity")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if originalPrice != nil{
			aCoder.encode(originalPrice, forKey: "original_price")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if productNetPrice != nil{
			aCoder.encode(productNetPrice, forKey: "product_net_price")
		}
		if productTotal != nil{
			aCoder.encode(productTotal, forKey: "product_total")
		}
		if quantity != nil{
			aCoder.encode(quantity, forKey: "quantity")
		}
		if supplier != nil{
			aCoder.encode(supplier, forKey: "supplier")
		}
		if supplierId != nil{
			aCoder.encode(supplierId, forKey: "supplier_id")
		}
		if unit != nil{
			aCoder.encode(unit, forKey: "unit")
		}
		if weight != nil{
			aCoder.encode(weight, forKey: "weight")
		}
		if weightType != nil{
			aCoder.encode(weightType, forKey: "weight_type")
		}
		if width != nil{
			aCoder.encode(width, forKey: "width")
		}
		if widthType != nil{
			aCoder.encode(widthType, forKey: "width_type")
		}

	}

}
