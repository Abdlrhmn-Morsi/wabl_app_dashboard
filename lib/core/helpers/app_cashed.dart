class AppCashe {
  static int employee = 0;
  static int usersStatistic = 0;
  static int postsStatistic = 0;
  static int posts = 0;
  static int categories = 0;
  static int saveds = 0;
  static int chats = 0;
  static int userData = 0;
  static int groups = 0;

  //! reset
  static void reset() {
    posts = 0;
    categories = 0;
    saveds = 0;
    employee = 0;
    usersStatistic = 0;
    postsStatistic = 0;
    chats = 0;
    userData = 0;
    groups = 0;
  }

  //! Posts
  static bool isPostCashed() {
    return posts == 1 ? true : false;
  }

  static void cashePost() {
    posts = 1;
  }

  //! categories
  static void casheCategories() {
    categories = 1;
  }

  static bool isCategoriesCashed() {
    return categories == 1 ? true : false;
  }

  //! saveds
  static void casheSaveds() {
    saveds = 1;
  }

  static bool isSavedsCashed() {
    return saveds == 1 ? true : false;
  }

  //! employee
  static void casheEmployee() {
    employee = 1;
  }

  static bool isEmployeeCashed() {
    return employee == 1 ? true : false;
  }

  //! employeeStatistic
  static void casheUsersStatistic() {
    usersStatistic = 1;
  }

  static bool isUsersStatisticCashed() {
    return usersStatistic == 1 ? true : false;
  }

  //! postsStatistic
  static void cashePostsStatistic() {
    postsStatistic = 1;
  }

  static bool isPostsStatisticCashed() {
    return postsStatistic == 1 ? true : false;
  }

  //! chats
  static void casheChats() {
    chats = 1;
  }

  static bool isChatsCashed() {
    return chats == 1 ? true : false;
  }

  //! userData
  static void casheUserData() {
    userData = 1;
  }

  static bool isUserDataCashed() {
    return userData == 1 ? true : false;
  }

  //! groups

  static void casheGroups() {
    groups = 1;
  }

  static bool isGroupsCashed() {
    return groups == 1 ? true : false;
  }
}
