//
//	TBApplicationSettingsBusinessRule.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBApplicationSettingsBusinessRule : NSObject, NSCoding{

	var applePay : Int!
	var codSwitch : Int!
	var expressDeliverySwitch : Int!
	var fullPageAdSwitch : Int!
	var id : Int!
	var isDelivery : String!
	var isSocialMedia : String!
	var knetSwitch : Int!
    var sendPaymentLink : Int!
    var deliverySlotAllowed : Int!
	var is_loyalty_allowed : Int!


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
		applePay = dictionary["apple_pay"] as? Int == nil ? 0 : dictionary["apple_pay"] as? Int
		codSwitch = dictionary["cod_switch"] as? Int == nil ? 0 : dictionary["cod_switch"] as? Int
		expressDeliverySwitch = dictionary["express_delivery_switch"] as? Int == nil ? 0 : dictionary["express_delivery_switch"] as? Int
		fullPageAdSwitch = dictionary["full_page_ad_switch"] as? Int == nil ? 0 : dictionary["full_page_ad_switch"] as? Int
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		isDelivery = dictionary["is_delivery"] as? String == nil ? "" : dictionary["is_delivery"] as? String
		isSocialMedia = dictionary["is_social_media"] as? String == nil ? "" : dictionary["is_social_media"] as? String
		knetSwitch = dictionary["knet_switch"] as? Int == nil ? 0 : dictionary["knet_switch"] as? Int
        sendPaymentLink = dictionary["send_payment_link"] as? Int == nil ? 0 : dictionary["send_payment_link"] as? Int
        deliverySlotAllowed = dictionary["delivery_slot_allowed"] as? Int == nil ? 0 : dictionary["delivery_slot_allowed"] as? Int
        is_loyalty_allowed = dictionary["is_loyalty_allowed"] as? Int == nil ? 0 : dictionary["is_loyalty_allowed"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if applePay != nil{
			dictionary["apple_pay"] = applePay
		}
		if codSwitch != nil{
			dictionary["cod_switch"] = codSwitch
		}
		if expressDeliverySwitch != nil{
			dictionary["express_delivery_switch"] = expressDeliverySwitch
		}
		if fullPageAdSwitch != nil{
			dictionary["full_page_ad_switch"] = fullPageAdSwitch
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isDelivery != nil{
			dictionary["is_delivery"] = isDelivery
		}
		if isSocialMedia != nil{
			dictionary["is_social_media"] = isSocialMedia
		}
		if knetSwitch != nil{
			dictionary["knet_switch"] = knetSwitch
		}
		if sendPaymentLink != nil{
			dictionary["send_payment_link"] = sendPaymentLink
		}
        if deliverySlotAllowed != nil{
            dictionary["delivery_slot_allowed"] = deliverySlotAllowed
        }
        if is_loyalty_allowed != nil{
            dictionary["is_loyalty_allowed"] = is_loyalty_allowed
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         applePay = aDecoder.decodeObject(forKey: "apple_pay") as? Int
         codSwitch = aDecoder.decodeObject(forKey: "cod_switch") as? Int
         expressDeliverySwitch = aDecoder.decodeObject(forKey: "express_delivery_switch") as? Int
         fullPageAdSwitch = aDecoder.decodeObject(forKey: "full_page_ad_switch") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isDelivery = aDecoder.decodeObject(forKey: "is_delivery") as? String
         isSocialMedia = aDecoder.decodeObject(forKey: "is_social_media") as? String
         knetSwitch = aDecoder.decodeObject(forKey: "knet_switch") as? Int
         sendPaymentLink = aDecoder.decodeObject(forKey: "send_payment_link") as? Int
        deliverySlotAllowed = aDecoder.decodeObject(forKey: "delivery_slot_allowed") as? Int
        is_loyalty_allowed = aDecoder.decodeObject(forKey: "is_loyalty_allowed") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if applePay != nil{
			aCoder.encode(applePay, forKey: "apple_pay")
		}
		if codSwitch != nil{
			aCoder.encode(codSwitch, forKey: "cod_switch")
		}
		if expressDeliverySwitch != nil{
			aCoder.encode(expressDeliverySwitch, forKey: "express_delivery_switch")
		}
		if fullPageAdSwitch != nil{
			aCoder.encode(fullPageAdSwitch, forKey: "full_page_ad_switch")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isDelivery != nil{
			aCoder.encode(isDelivery, forKey: "is_delivery")
		}
		if isSocialMedia != nil{
			aCoder.encode(isSocialMedia, forKey: "is_social_media")
		}
		if knetSwitch != nil{
			aCoder.encode(knetSwitch, forKey: "knet_switch")
		}
		if sendPaymentLink != nil{
			aCoder.encode(sendPaymentLink, forKey: "send_payment_link")
		}
        if deliverySlotAllowed != nil{
            aCoder.encode(deliverySlotAllowed, forKey: "delivery_slot_allowed")
        }
        if is_loyalty_allowed != nil{
            aCoder.encode(is_loyalty_allowed, forKey: "is_loyalty_allowed")
        }

	}

}
