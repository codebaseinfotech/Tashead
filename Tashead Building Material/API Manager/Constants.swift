//
//  Constants.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 31/05/23.
//


import Foundation
import UIKit


// ************************************** beta  **************************************


//let BASE_URL = "https://beta-admin.tashead.com/api/"
// 
//var oneSignalId = "f729cd86-2ea0-4513-8f8d-3dcfdfd6b2b9"


// ************************************** demo  **************************************

let BASE_URL = "⁠https://demo.tashead.com/api/"

var oneSignalId = "58b16e0d-64a8-44cf-893d-46417ae5a8b1"


// ***************************************************************************************************

let GOOGLE_KEY = "AIzaSyA85KpTqFdcQZH6x7tnzu6tjQRlqyzAn-s"

// **************************************************

//MARK: - Authentication

let LOG_IN = "v1/auth/login"

let SEND_OTP = "v1/otp"

let FORGOT_PASSWORD = "v1/forgot-password"

let VERIFY_OTP = "v1/otp/verify"

let REGISTER_USER = "v1/auth/register"

let GUEST_REGISTER_USER = "v1/guest/user"

let AREA_LIST = "v1/areas"

let GET_GOVERNARATES = "v1/governorates"

let GET_UPDATE_PROFILE = "v1/account/profile"

let GET_CATEGORIES_MASTER = "v1/categories/master"

let GET_CATEGORIES = "v1/categories/subcategory/"

let GET_PRODUCTS = "v1/product"

let GET_PRODUCTS_SEARCH = "v1/product?page="

let GET_PRODUCTS_DETAILS = "v1/product/detail/"

let GET_PRODUCTS_CATEGORIES = "v1/product/category/"

let GET_PROFILE = "v1/account/profile"

let LOGOUT_USER = "v1/auth/logout"

let CHANGE_PASSWORD = "v1/auth/change-password"

let RESET_PASSWORD = "v1/auth/reset-password"

let GET_CATEGORIES_SETP_WISE = "v1/categories/step-wise/master"
    
let GET_STEP_WISE_CATEGORIES = "v1/categories/step-wise/subcategory/"

let GET_STEP_WISE_PRODUCTS = "v1/product/step-wise/"

let GET_ADDRESS = "v1/address/"

let CREATE_ADDRESS = "v1/address/create"

let EDIT_ADDRESS = "v1/address/edit/"

//let DELETE_ADDRESS = "v1/address/delete/"

let CREATE_CART = "v1/cart/create"

let EDIT_CART = "v1/cart/edit"

let MODIFY_CART_INFO = "v1/cart/modify-cart-info"

let DELETE_CART = "v1/cart/delete-item"

let GET_MY_CART_BY_USER = "v1/cart/mycart"

let GET_CART = "v1/cart/"

let CHEOUT_USER = "v1/cart/checkout"

let GET_ORDER = "v1/order"

let ORDER_DETAILS = "v1/order/detail/"

let COMMISSION_LIST = "v1/account/commission"

let WISHLIST_ADD = "v1/wishlist/add"

let WISHLIST_REMOVE = "v1/wishlist/remove"

let WISHLIST_LIST = "v1/wishlist"

let INFLUENCERS_LIST = "v1/influencers"

let INFLUENCERS_PRODUCT_LIST = "v1/influencers/get-influencer-product"

let REND_ORDER_DO_PAYMENT = "v1/order/resend/do-payment"

let ORDER_DO_PAYMENT = "v1/order/do-payment"

let ABOUT_US = "v1/common/about-us"

let TERMS_AND_CONDITIONS = "v1/common/terms-and-conditions"

let APPLICATION_SETTINGS = "v1/application/settings"

let DELETE_ADDRESS = "v1/address/delete"

let GUEST_SEND_OTP = "v1/guest/send-otp"

let GUEST_VERIFY_OTP = "v1/guest/verify-otp"

let GUEST_REGISTER = "v1/guest/register"

let SOCIAL_LOGIN = "v1/auth/social-login"

let SOCIAL_REGISTER = "v1/auth/social-register"

//let GET_BANNERS = "v1/banners"
let GET_BANNERS = "v1/cms/banner"

let PROMOCODE_APPLY = "v1/promocode/apply"

let PROMOCODE_REMOVE = "v1/promocode/remove"

let COMMON_BUSINESS_RULE = "v1/common/business-rules"

let CONTACT_US = "v1/contact-us"

let FEEDBACK_FORM = "v1/common/feedback"

let WALLET = "v1/account/credit"

let ORDER_GET_PAYMENT_LINK = "v1/order/get-payment-link"

let CREDIT_PAY_CREDIT_BILL = "v1/credit/pay-credit-bill"

let CREDIT_HISTROY = "v1/account/credit/history"

let CMC_ADVERD = "v1/cms/adverd"

let GET_DELIVERY_SLOT = "v1/common/delivery-slots"

let GET_COUPON_LOYALTY = "v1/loyalty-coupons"

// **************************************************
let appDelegate = UIApplication.shared.delegate as? AppDelegate
