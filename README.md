
# Video Games List App

This is a simple IOS game database application made using API data.


## Technologies

**Swift Version:** 15.3

**XCode Version:** 5.10

**Design Pattern:** MVC

**Used Apps**: Postman, Quicktype etc.

  
## API Usage

#### https://rawg.io/apidocs
#### https://rapidapi.com/accujazz/api/rawg-video-games-database 

#### Gets list of the games

```http
  GET /api/games/api_key
```

| Parametre | Tip     | Açıklama                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **A Must**. Your API key. |

#### Gets game details of that id

```http
  GET /api/games/${id}/api_key
```

| Parametre | Tip     | Açıklama                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **A Must**. Key value of the item to be called| 



  
## Explanation

In this project, first of all, a request was made to the API to get the game list. Two struct models named Game and Detail were created. The responses returned from the requests were recorded in the appropriate fields through arrays created from these models. Additionally, the images were downloaded by sending an http request. The first 3 images were displayed in the interface in the collection view and scroll view, and the rest were listed under the games. Searchbar was made in home view to search by game name within the game list, after 3 letters.Tabbar Controller was used for Home and Favorites. Opening and returning to the Details page was done using the navigation controller. When you click on the game list, the details are displayed.

  
## Screenshots
<img width="340" alt="Screenshot 2024-04-29 at 10 04 11" src="https://github.com/zeynephamza/VideoGamesApp/assets/15521642/140ea574-7ba3-48be-90dd-01e50c571b2f"> 
<img width="335" alt="Screenshot 2024-04-29 at 10 03 38" src="https://github.com/zeynephamza/VideoGamesApp/assets/15521642/85ef81d3-b585-4322-b315-8e296ccde6c7"
![Uygulama<img width="338" alt="Screenshot 2024-04-29 at 10 03 19" src="https://github.com/zeynephamza/VideoGamesApp/assets/15521642/93bd788d-7499-41c8-b2f0-aeb285f11c4b"><img width="338" alt="Screenshot 2024-04-29 at 10 03 19" src="https://github.com/zeynephamza/VideoGamesApp/assets/15521642/234e269c-7d9d-450a-8465-6208d2dfee5c">

<img width="334" alt="Screenshot 2024-04-29 at 10 05 13" src="https://github.com/zeynephamza/VideoGamesApp/assets/15521642/fb6fd285-7494-45ee-9524-feeaec14f68c">

  
## Instructor

- My profound thanks to [@kcaglarr](https://www.github.com/kcaglarr) 

  
