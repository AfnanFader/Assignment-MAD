class BlogTrending {

  String image;
  String link;
  String title;

  BlogTrending({
    this.image, 
    this.link,
    this.title, 
  });

  BlogTrending.fromMap(Map<String,dynamic> data) {
    image = data['Image'];
    link = data['Link'];
    title = data['Title'];
  }

  Map<String, dynamic> toMap() {
    return {
      'Image' : image,
      'Link' : link,
      'Title' : title,
    };
  }
}

class BlogCats {

  String image;
  String link;
  String title;

  BlogCats({
    this.image, 
    this.link,
    this.title, 
  });

  BlogCats.fromMap(Map<String,dynamic> data) {
    image = data['Image'];
    link = data['Link'];
    title = data['Title'];
  }

  Map<String, dynamic> toMap() {
    return {
      'Image' : image,
      'Link' : link,
      'Title' : title,
    };
  }
}

class BlogDogs {

  String image;
  String link;
  String title;

  BlogDogs({
    this.image, 
    this.link,
    this.title, 
  });

  BlogDogs.fromMap(Map<String,dynamic> data) {
    image = data['Image'];
    link = data['Link'];
    title = data['Title'];
  }

  Map<String, dynamic> toMap() {
    return {
      'Image' : image,
      'Link' : link,
      'Title' : title,
    };
  }
}