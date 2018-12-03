## Introduction to the Internet and Networking

**Reading**  
Mozilla Developer Network - [How does the internet work?](https://developer.mozilla.org/en-US/docs/Learn/Common_questions/How_does_the_Internet_work)


The **internet** is the backbone of the web, the technical infrastructure that makes the web possible. At its most basic, the internet is a large network of computers which communicate all together. 

**Finding computers**   
A computer connected to a network has a unique identifier known as an IP address _(internet protocol)_. An example of an IP address would be 192.168.2.10

That IP address is perfectly fine for computers, but for human readability we use an alias called the **domain name**. For example, apple.com is the domain name used on top of the IP address 17.142.160.59 So using the domain name is the easiest way for us to reach a computer on the internet. Websites can be reached directly using their IP address. You can find the IP address of a website by typing its domain into a tool like [IP Checker](https://ipinfo.info/html/ip_checker.php)

**Clarification**  
The internet is a technical infrastructure which allows billions of computers to be connected all together. Among those computers, some computers (called Web servers) can send messages intelligle to web browsers. The internet is an infrastructure, whereas the _Web_ is a service built on top of the infrastructure. Some other services on top the internet, are email and IRC.

## Clients and servers 

Computers connected to the web are called **clients** and **servers**. 

![Clients and Servers](https://mdn.mozillademos.org/files/8973/Client-server.jpg)

- Clients are the typical web user's internet-connected devices (for example, your computer connected to your Wi-Fi, or your phone connected to your mobile network) and web accessing software available on those devices (usually a web browser like Safari or Chrome). 
- Servers are computers that store webpages, sites, or apps. When a client device wants to access a webpage, a copy of the webpage is downloaded from the server onto the client machine to be displayed in the user's web browser.

In addition to the client and the server, we also need to say hello to: 
- **Your internet connection:** allows you to send and receive data on the web. 
- **TCP/IP** transmission control protocol and internet protocol are communication protocols that define how data should travel across the web. 
- **DNS** Domain Name Servers are like an address book for websites. 
- **HTTP** Hypertext Transfer Protocol is an application protocol that defines a language for clients and servers to speak to each other. 

**So what happens, exactly?**   
When you type a web address into your browser: 

1. The browser goes to teh DNS server, and finds the real address of the server that the website lives on. 
2. The browser sends an HTTP request message to the server, asking it to send a copy of the the website to the client. The message, and all other data sent between the client and the server, is send across your internet connection using TCP/IP. 
3. If the server approves the client's request, the server send the client a "200 Ok" message, which means "of course you can look at that website, here it is" and then starts sending the website's files to the browser as a series of small chunks called data packets. 
4. The browser assembles the small chunks into a complete website and displays it to you. 


**Let's see what a request -> response looks like using curl**   
Go to your terminal and type in the following [curl](https://en.wikipedia.org/wiki/CURL) command:

The command below makes a requst to the following website  

```curl -I https://www.apple.com```

The above curl command will give you header infomation of the requested website

> HTTP/1.1 200 OK  
Server: Apache  
X-Frame-Options: SAMEORIGIN  
X-Xss-Protection: 1; mode=block  
X-Content-Type-Options: nosniff  
Content-Type: text/html; charset=UTF-8  
Cache-Control: max-age=134  
Expires: Sun, 02 Dec 2018 14:28:42 GMT  
Date: Sun, 02 Dec 2018 14:26:28 GMT  
Connection: keep-alive  
Set-Cookie: geo=US; path=/; domain=.apple.com  
Set-Cookie: ccl=a/ku6WIhzEikkJn6N+c0h1NGAKDJgMgek4hZeH4vjQc=; path=/; domain=.apple.com  

Using curl to make a request to an [API](https://en.wikipedia.org/wiki/Web_API) (more about APIs in this current unit)   
```curl https://itunes.apple.com/search?term=swift+over+coffee&media=podcast```  

[JSON](https://json.org/) response
```json 
{
	"resultCount": 1,
	"results": [{
		"wrapperType": "track",
		"kind": "podcast",
		"collectionId": 1435076502,
		"trackId": 1435076502,
		"artistName": "Paul Hudson and Sean Allen",
		"collectionName": "Swift over Coffee",
		"trackName": "Swift over Coffee",
		"collectionCensoredName": "Swift over Coffee",
		"trackCensoredName": "Swift over Coffee",
		"collectionViewUrl": "https://itunes.apple.com/us/podcast/swift-over-coffee/id1435076502?mt=2&uo=4",
		"feedUrl": "https://anchor.fm/s/572fc68/podcast/rss",
		"trackViewUrl": "https://itunes.apple.com/us/podcast/swift-over-coffee/id1435076502?mt=2&uo=4",
		"artworkUrl30": "https://is2-ssl.mzstatic.com/image/thumb/Music118/v4/73/24/2c/73242c65-1b6f-0dce-9740-fa84a92607e1/source/30x30bb.jpg",
		"artworkUrl60": "https://is2-ssl.mzstatic.com/image/thumb/Music118/v4/73/24/2c/73242c65-1b6f-0dce-9740-fa84a92607e1/source/60x60bb.jpg",
		"artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Music118/v4/73/24/2c/73242c65-1b6f-0dce-9740-fa84a92607e1/source/100x100bb.jpg",
		"collectionPrice": 0.00,
		"trackPrice": 0.00,
		"trackRentalPrice": 0,
		"collectionHdPrice": 0,
		"trackHdPrice": 0,
		"trackHdRentalPrice": 0,
		"releaseDate": "2018-11-26T15:47:00Z",
		"collectionExplicitness": "cleaned",
		"trackExplicitness": "cleaned",
		"trackCount": 7,
		"country": "USA",
		"currency": "USD",
		"primaryGenreName": "Technology",
		"contentAdvisoryRating": "Clean",
		"artworkUrl600": "https://is2-ssl.mzstatic.com/image/thumb/Music118/v4/73/24/2c/73242c65-1b6f-0dce-9740-fa84a92607e1/source/600x600bb.jpg",
		"genreIds": ["1318", "26"],
		"genres": ["Technology", "Podcasts"]
	}]
}
```

## HTTP Response Codes 

Servers send HTTP status codes to provide quick information on the response sent by the client.

- 1xx (Informational): Request recieved, continuing process
- 2xx (Successful): the action was successfully received, understood, and accepted
- 3xx ( Redirection): Further action needs to be taken in order to complete the request 
- 4xx (Client Error): The request contains bad syntax or cannot be fulfilled 
- 5xx (Server Error): The server failed to fulfill an apparently valid request

## Vocabulary 

- **URI:** a system for identifying pieces of information on the network. [URI](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier)
- **HTTP Methods:** the protocol currently contains 8 methods for requesting a URI: OPTIONS, GET, HEAD, POST, PUT, DELETE, TRACE, CONNECT. 
- **HTTP Headers:** the headers are additional data sent by the user again to give more context about the transaction going on between the client and the server. Some of them will help the server reply in the most appropriate way.
