enum ForumCategory {
  clubs,
  sports,
  food,
  buildings,
  classes,
  other,
}

class ForumCategoryHelper {
  static getViewName(ForumCategory forumCategory) {
    switch (forumCategory) {
      case ForumCategory.clubs:
        return "Clubs";
      case ForumCategory.sports:
        return "Sports";
      case ForumCategory.food:
        return "Food";
      case ForumCategory.buildings:
        return "Buildings";
      case ForumCategory.classes:
        return "Classes";
      default:
        return "Other";
    }
  }
}
