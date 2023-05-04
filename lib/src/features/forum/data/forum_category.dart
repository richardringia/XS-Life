enum ForumCategory {
  category1,
  category2,
  category3,
  category4,
  category5,
}

class ForumCategoryHelper {
  static getViewName(ForumCategory forumCategory) {
    switch (forumCategory) {
      case ForumCategory.category2:
        return "Category 2";
      case ForumCategory.category3:
        return "Category 3";
      case ForumCategory.category4:
        return "Category 4";
      case ForumCategory.category5:
        return "Category 5";
      default:
        return "Category 1";
    }
  }
}
