# SimpleNetworkCall

This is library that helps to perform Network Calls.

## Supported functions:
- GET
- POST
- DELETE

## Installation
Swift Package Manager

https://github.com/diondula1/SimpleNetworkCall

## Sample
- GET

This is GET Method 

```TXT

    Network.shared.get(urlString: "www.sample.com") { [weak self] (results: Result<[ResponseObject], Error>) in
        switch(results){
        case .success(let data):
            //Data Return Successfully
            break
        case .failure(let error):
            //Error Message
            break
        }
    }

```

- POST

This is POST Method with Body Parameters 

```TXT

    Network.shared.post(body:RequestObject, urlString: "www.sample.com") { [weak self] (results: Result<[ResponseObject], Error>) in
        switch(results){
        case .success(let data):
            //Data Return Successfully
            break
        case .failure(let error):
            //Error Message
            break
        }
    }
    
```


- DELETE

This is DELETE Method 

```TXT

    Network.shared.delete(urlString: "www.sample.com/{id}") { [weak self] (results: Result<[ResponseObject], Error>) in
        switch(results){
        case .success(let data):
            //Data Return Successfully
            break
        case .failure(let error):
            //Error Message
            break
        }
    }
    
```
