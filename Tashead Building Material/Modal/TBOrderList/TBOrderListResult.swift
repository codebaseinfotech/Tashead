//
//	TBOrderListResult.swift
//
//	Create by iMac on 1/1/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBOrderListResult : NSObject, NSCoding{

	var createdDate : String!
	var isPaid : Int!
	var orderId : Int!
	var paymentStatus : String!
	var productName : String!
    var currency : String!
    var payment_type : String!
    
    var send_invoice_to : String!

    var invoice_url : String!
    var total : String!
    var order_status_text : String!

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
		createdDate = dictionary["created_date"] as? String == nil ? "" : dictionary["created_date"] as? String
		isPaid = dictionary["is_paid"] as? Int == nil ? 0 : dictionary["is_paid"] as? Int
		orderId = dictionary["order_id"] as? Int == nil ? 0 : dictionary["order_id"] as? Int
		paymentStatus = dictionary["payment_status"] as? String == nil ? "" : dictionary["payment_status"] as? String
        productName = dictionary["product_name"] as? String == nil ? "" : dictionary["product_name"] as? String
        currency = dictionary["currency"] as? String == nil ? "" : dictionary["currency"] as? String
        payment_type = dictionary["payment_type"] as? String == nil ? "" : dictionary["payment_type"] as? String
        
        send_invoice_to = dictionary["send_invoice_to"] as? String == nil ? "" : dictionary["send_invoice_to"] as? String

        invoice_url = dictionary["invoice_url"] as? String == nil ? "" : dictionary["invoice_url"] as? String
        order_status_text = dictionary["order_status_text"] as? String == nil ? "" : dictionary["order_status_text"] as? String
        total = dictionary["total"] as? String == nil ? "" : dictionary["total"] as? String

	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if createdDate != nil{
			dictionary["created_date"] = createdDate
		}
		if isPaid != nil{
			dictionary["is_paid"] = isPaid
		}
		if orderId != nil{
			dictionary["order_id"] = orderId
		}
		if paymentStatus != nil{
			dictionary["payment_status"] = paymentStatus
		}
		if productName != nil{
            dictionary["product_name"] = productName
        }
        if currency != nil{
			dictionary["currency"] = currency
		}
        if payment_type != nil{
            dictionary["payment_type"] = payment_type
        }
        if send_invoice_to != nil{
            dictionary["send_invoice_to"] = send_invoice_to
        }
        
        
        if invoice_url != nil{
            dictionary["invoice_url"] = invoice_url
        }
        if order_status_text != nil{
            dictionary["order_status_text"] = order_status_text
        }
        if total != nil{
            dictionary["total"] = total
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         createdDate = aDecoder.decodeObject(forKey: "created_date") as? String
         isPaid = aDecoder.decodeObject(forKey: "is_paid") as? Int
         orderId = aDecoder.decodeObject(forKey: "order_id") as? Int
         paymentStatus = aDecoder.decodeObject(forKey: "payment_status") as? String
         productName = aDecoder.decodeObject(forKey: "product_name") as? String
        currency = aDecoder.decodeObject(forKey: "currency") as? String
        payment_type = aDecoder.decodeObject(forKey: "payment_type") as? String

        send_invoice_to = aDecoder.decodeObject(forKey: "send_invoice_to") as? String

        invoice_url = aDecoder.decodeObject(forKey: "invoice_url") as? String
        order_status_text = aDecoder.decodeObject(forKey: "order_status_text") as? String
        total = aDecoder.decodeObject(forKey: "total") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if createdDate != nil{
			aCoder.encode(createdDate, forKey: "created_date")
		}
		if isPaid != nil{
			aCoder.encode(isPaid, forKey: "is_paid")
		}
		if orderId != nil{
			aCoder.encode(orderId, forKey: "order_id")
		}
		if paymentStatus != nil{
			aCoder.encode(paymentStatus, forKey: "payment_status")
		}
		if productName != nil{
            aCoder.encode(productName, forKey: "product_name")
        }
        if currency != nil{
			aCoder.encode(currency, forKey: "currency")
		}
        
        if payment_type != nil{
            aCoder.encode(payment_type, forKey: "payment_type")
        }
        
        if send_invoice_to != nil{
            aCoder.encode(send_invoice_to, forKey: "send_invoice_to")
        }
        
        if invoice_url != nil{
            aCoder.encode(invoice_url, forKey: "invoice_url")
        }
        if order_status_text != nil{
            aCoder.encode(order_status_text, forKey: "order_status_text")
        }
        
        if total != nil{
            aCoder.encode(total, forKey: "total")
        }


	}

}
