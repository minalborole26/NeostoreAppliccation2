//
//  constant.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 18/10/23.
//

import Foundation


import UIKit

struct apiUrl {
    static let baseUrl = "http://staging.php-dev.in:8844/trainingapp/api/"
    static let registerUrl = "\(baseUrl)users/register"
    static let loginUrl = "\(baseUrl)users/login"
    static let getProductUrl = "\(baseUrl)products/getList?product_category_id="
    static let getProductDetailUrl = "\(baseUrl)products/getDetail?product_id="
    static let setRatingUrl = "\(baseUrl)products/setRating"
    static let fetchProfileUrl = "\(baseUrl)users/getUserData"
    static let addToCartUrl = "\(baseUrl)addToCart"
    static let cartListUrl = "\(baseUrl)cart"
    static let editCartUrl = "\(baseUrl)editCart"
    static let deleteCartUrl = "\(baseUrl)deleteCart"
    static let getAccountUrl = "\(baseUrl)users/getUserData"
    static let updateAccountUrl = "\(baseUrl)users/update"
    static let fetchOrderUrl = "\(baseUrl)order"
    static let orderListUrl = "\(baseUrl)orderList"
    static let orderDetailUrl = "\(baseUrl)orderDetail"
    static let changePasswordUrl = "\(baseUrl)users/change"
    static let forgotPasswordUrl = "\(baseUrl)users/forgot"
}
enum AppStoryboard: String {
    case main = "Main"
    case account = "MyAccountViewController"
    case home = "Home"
    case storeLocator = "StoreLocator"
    case orders = "Orders"
    case address = "Address"
}

struct cellConstant {
    static let ProductDetailsCollectionViewCell = "ProductDetailsCollectionViewCell"
    static let SideMenuTableViewCell = "SideMenuTableViewCell"
    static let MyCartTableViewCell = "MyCartTableViewCell"
    static let CustomFooterView = "CustomFooterView"
    static let AddressListTableViewCell = "AddressListTableViewCell"
    static let AddressFooterView = "AddressFooterView"
    static let MyOrdersTableViewCell = "MyOrdersTableViewCell"
    static let OrderIdTableViewCell = "OrderIdTableViewCell"
    static let OrderIdFooterView = "OrderIdFooterView"
    static let StoreLocatorTableViewCell = "StoreLocatorTableViewCell"
    static let cell = "cell"
    static let male = "M"
    static let female = "F"
    static let baseString = "data:image/jpg;base64,"
}
struct controllerName {
    static let ProductDetailViewController = "ProductDetailViewController"
    static let QuantityPopUpViewController = "QuantityPopUpViewController"
    static let ProductViewController = "ProductViewController"
    static let SideMenuViewController = "SideMenuViewController"
}
struct categoryName {
    static let table = "Category - Table"
    static let chairs = "Category - Chairs"
    static let sofas = "Category - Sofas"
    static let cupboards = "Category - Cupboards"
}
struct navigationTitle {
    static let tables = "Tables"
    static let chairs = "Chairs"
    static let sofas = "Sofas"
    static let cupboards = "Cupboards"
    static let forgotPassword = "Forgot Password"
    static let register = "Register"
    static let neostore = "NeoSTORE"
    static let myCart = "My Cart"
    static let addAddress = "Add Address"
    static let addressList = "Address List"
    static let myOrders = "My Orders"
    static let store = "Store Locator"
    static let editProfile = "Edit Profile"
    static let myAccount = "My Account"
    static let resetPass = "Reset Password"
}
struct userMsg {
    static let failureTitle = "User login unsuccessful."
    static let failureMsg =  "Email or password is wrong. try again"
    static let registerFailed = "Registration failed"
    static let cartEmpty = "Cart is Empty"
    static let selectProduct = "select Product"
    static let fillAddress = "Please Fill the Address Correctly"
    static let selectAddress = "Select address"
    static let addressMissing = "Address is Missing"
}
struct placeHolder {
    static let userName = "Username"
    static let password = "Password"
    static let email = "E-mail"
    static let firstName = "First Name"
    static let lastName = "Last Name"
    static let confirmPass = "Confirm Password"
    static let phone = "Phone Number"
}
struct img {
    static let selectImg = "circle.fill"
    static let unselectImg = "circle"
    static let checkImg = "checked_icon"
    static let uncheckImg = "uncheck_icon"
    static let downarrow = "chevron.down"
    static let delete = "delete"
    static let selectAddress = "circle.inset.filled"
    static let trash = "trash.fill"
}
struct arrName {
    static let menuArr = ["My Cart","Tables","Chairs","Sofas","Cupboards","My Account","Store Locator","My Orders","Logout"]
    static let menuImgArr = [UIImage(named: "shoppingcart_icon"),UIImage(named: "tables_icon"),UIImage(named: "chair"),UIImage(named: "sofa_icon"),UIImage(named: "cupboard"),UIImage(named: "username_icon"),UIImage(named: "storelocator_icon"),UIImage(named: "myorders_icon"),UIImage(named: "logout_icon")]
    static let imgArray = [UIImage(named: "slider_img1"),
                    UIImage(named: "slider_img2"),
                    UIImage(named: "slider_img3"),
                    UIImage(named: "slider_img4")]
}
struct storyBoardName {
    static let main = "Main"
    static let home = "Home"
}
struct key {
    static let addressEntity = "AddressEntity"
    static let address = "address"
    static let landmark = "landmark"
    static let city = "city"
    static let zipcode = "zipcode"
    static let state = "state"
    static let country = "country"
    static let currentPass = "Current Password"
    static let newPass = "New Password"
    static let confirmPass = "Confirm Password"
}

