# SimpleNetworkCall

This is library that helps to perform Network Calls.

## Supported functions:
- GET
- POST
- Delete

## Installation
Swift Package Manager

https://github.com/diondula1/SimpleNetworkCall

## Sample
- GET

This is GET Method without Body Parameters

```TXT

   Network.shared.fetchData(httpMethodType: .Get, urlString: "www.sample.com") { [weak self] (results: Result<[Project], Error>) in
            switch(results){
            case .success(let data):
                //Data Return Successfully
                break
            case .failure(let error):
                //Error Message
            }
        }
        
```

- POST

This is POST Method with Body Parameters 

```TXT

   Network.shared.fetchData(body:RequestObject, httpMethodType: .Post, urlString: "www.sample.com") { [weak self] (results: Result<[Project], Error>) in
            switch(results){
            case .success(let data):
                //Data Return Successfully
                break
            case .failure(let error):
                //Error Message
            }
        }
        
```
