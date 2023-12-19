# SearchIt

The primary goal is to create a feature-rich app that allows users to search for products using eBay APIs, view detailed product information, manage a wishlist, and share product details on Facebook.

The key components of the app include a search form with multiple input fields, a search results page with detailed product listings, a product details page with tabs for different information categories, and a wishlist feature. The project also integrates third-party libraries like Alamofire and Kingfisher for handling HTTP requests and asynchronous operations.

The development adheres to the SwiftUI paradigm, providing a visually appealing and seamless user interface across all Apple devices. The use of MongoDB is specified for storing wishlist data. The project emphasizes proper error handling, validation, and responsiveness to ensure a robust and user-friendly iOS app experience.

# Technologies and Frameworks Used:

SwiftUI  
Alamofire  
Kingfisher   
MongoDB  
NodeJS  
Google Cloud  


# Implementation:

## 1. Search Form:

1. Components include Keyword, Category, Condition checkboxes, Shipping checkboxes, Distance, Custom Location toggle, Zipcode, SEARCH button, CLEAR button.  
1. Current Location: Use Apple's location service or ip-api.com.  
1. Validation: Implement validation for empty keyword and display appropriate messages.  

## 2. Search Results:

1. Display loading spinner while searching.  
1. Show search results as a table with product details.  
1. Each table cell includes product image, title, price, shipping cost, zipcode, condition, and a Wishlist button.  

## 3. Product Details:

1. Tabs for Product Info, Shipping Info, Google Photos, and Similar Products.  
1. Share on Facebook and Wishlist buttons.  
1. Each tab has a loading spinner.  
1. Product Info tab displays product images, title, price, and description.  
1. Shipping Info tab shows seller, shipping, and return policy information.    
1. Google Photos tab fetches images using the product title.  
1. Similar Products tab allows sorting and displays items in a grid.  

## 4. Wish List:

1. Switch between Search and Wish List screens using a favorite icon.  
1. Display Wish List products in a table with the same structure as search results.  
1. Show total number of items and sum of prices in the Wish List.  
1. Use MongoDB to store Wish List data.  
1. Allow users to delete items from the Wish List.  


### Video link for demonstration: https://drive.google.com/file/d/1QjKIxINl3-p6aG3mJxwWKezItVsYisRi/view?usp=drive_link
