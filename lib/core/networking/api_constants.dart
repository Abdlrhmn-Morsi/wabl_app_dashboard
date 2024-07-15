class ApiConstants {
  static const String apiBaseUrl = 'http://192.168.1.4:8000/api/user/';
  static const String apiBaseUrlStorqge = 'http://192.168.1.4:8000/storage/';
  //*Auth
  static const String login = "auth/login";
  static const String signup = "auth/register";
  static const String forgetPassword = "auth/forget_password";
  static const String checkResetCode = "auth/check_reset_code";
  static const String resetPassword = "auth/reset_password";
  //*profile
  static const String authInfo = "profile/auth_info";
  static const String updateInfo = "profile/update_info";
  static const String updatePassword = "profile/update_password";
  //*services
  static const String services = "service/services";
  //*shops
  static String serviceShops({
    required int serviceId,
    required int pageNumber,
  }) =>
      "shop/service_shops/$serviceId?page=$pageNumber";
  static const String shop = "shop/";
  static const String shopCategories = "shop/categories/";
  //* products
  static String shopProducts({
    required int shopId,
    required int pageNumber,
  }) =>
      "product/shop_products/$shopId?page=$pageNumber";
  static const String product = "product/";
  static const String productVariants = "product/product_variants/";

  //* cart
  static const String addToCart = "cart/add_to_cart";
  static const String shopsInCard = "cart/shops_in_card?page=";
  static String shopCard({
    required int shopId,
    required int pageNumber,
  }) =>
      "cart/shop_card/$shopId?page=$pageNumber";
  static const String destroy = "cart/destroy/";
  static const String editQuantity = "cart/editQuantity/";
  static const String productsCount = "cart/products_count";
  static const String shopShippingPlaces = "cart/shop_shipping_places/";

  //*address
  static const String getUserAddresses = "address/get_user_addresses";
  static const String storeUserAddress = "address/store_user_address";
  static const String deleteAddress = "address/destroy/";
  static const String updateAddress = "address/update_user_address/";
  //*follow
  static const String followShop = "follow/follow_shop";
  static const String getFollowingShops = "follow/get_following";
  //*saved
  static const String saveProduct = "saving/save_product";
  static const String getSavedProducts = "saving/get_saved_products?page=";
  //* order
  static const String createOrder = "order/store";
  static const String getOrders = "order/user_orders?page=";
  static const String getOrderDetails = "order/user_order_details/";
  //* Chat
  static const String getMessages = "chat/getUserChatMessages/";
  static const String getConversations = "chat/getUserConversation?page=";
  static const String sendMessage = "chat/store";
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
