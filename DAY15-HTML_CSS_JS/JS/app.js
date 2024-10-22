// //creating variables
// //let, const, var 

// var x = 10
// var y = 'hello'

// x = 'Hi'

// console.log(x)

// //functions

// function name(parameter1, parameter2, parameter3){
//     //body
//     //return 
// }

// //javascript objects

// //Number : intergers or floating point numbers. 

// var a = new Number(10);
// console.log(a);

// var b = new Number('hello world');
// console.log(b)
// //NaN
// //1. not equal to any value including itself. 
// console.log(NaN === NaN);

// //2. Operations involving NaN result in NaN.

// console.log(NaN + 14);

// //user defined objects
// //1. object literals

// const employee = {
//     name : 'John',
//     age: 30,
//     location: 'Chicago',
//     greet: function(){
//         return 'Hello, my name is ' + this.name + 'I am ' + this.age + ' years old';
//     }
// };

// console.log(employee.name)
// console.log(employee.age)
// console.log(employee.greet())

// //2.Constructor functions

// function Person(name, age = 23, location = 'Default Value'){
//     this.name = name;
//     this.age = age;
//     this.location = location;
//     this.greet = function(){
//         return 'Hello, my name is ' + this.name + 'I am ' + this.age + ' years old';
//     };
// };

// const person1 = new Person('John', 30, 'New York')
// console.log(person1);
// const person2 = new Person('Alice', 25);
// console.log(person2.greet())
// console.log(person2.location)


// //3.Object.create()

// const newPerson = Object.create(person1);
// const newEmployee = Object.create(employee);
// console.log(newPerson)
// console.log(newEmployee)
// newPerson.age = 44;
// newPerson.name = 'Adam';
// newPerson.location = 'Texas'
// console.log(newPerson)

// //4. classes

// class Book{

//     constructor(title, author, pages = 3){
//         this.title = title;
//         this.author = author;
//         this.pages = pages;
//     }

//     greet(){
//         console.log("hello from book")
//     }

// }

// const newBook = new Book('Harry Potter', 'J.k Rowling');
// console.log(newBook)

// class Novel extends Book {

//     constructor(title, author, pages = 3, genre){
//         super(title, author, pages); //call superclass constructor
//         this.genre = genre;
//     }

//     displayInfo(){
//         console.log("hello from novel")
//     }

// }

// const novel = new Novel("Harry Potter", "J.K Rowling", 400, 'Fantasy');
// console.log(novel.title)
// console.log(novel['title'])
// novel.displayInfo()
// novel.greet()

//Arrays

// var array = [1, true, {name: 'Sarah'}, 12.33, 'Hello World'];

// var array1 = array;
// array1.push(100)
// console.log(array1)
// console.log(array)

// console.log(array)

// array[0] = 4;
//push: adding 

// array.push(10)
// console.log(array)

//pop: remove an element from the end of an array

// array.pop();
// console.log(array)

//shift(): remove first element
// array.shift()
// console.log(array)

//splice()

// array.splice(1,2)
// console.log(array)

//remove element by value without an index
// function demo (val){
//     for(var i = 0; i<array.length; i++){
//         if(array[i] === val){
//             array.splice(i, 1);
//         }
//     }
// }

// demo("Hello World")
// console.log(array)

// == vs ===
//== : checks the equality of the value after converting them into common types; type coercion
// var x = 1;
// var y = '1'
// console.log(x == y)
// console.log(typeof(x))
// console.log(typeof(y))
// console.log( 0 == false)
// console.log(null == undefined)

//=== : check the equality of the values without converting them into common types or without performing type coercion. 

// console.log(1 === '1')
// console.log( 0 === false)
// console.log(null === undefined)


//querySelectors or getElementById

// function validateForm(){
//     const username = document.getElementById('username').value;
//     const password = document.getElementById('password').value;

//     if(username === ""){
//         alert("Please enter your usename");
//         return false;
//     }
//     if(password === ""){
//         alert("Please enter your password")
//         return false;
//     }
//     return true;
// }

// function resetForm(){

//     document.forms["myForm"]["username"].value = ""
//      document.forms["myForm"]["password"].value = ""
// }

// const btn = document.querySelector(".btn");
// btn.addEventListener('click', ()=>{
//     document.body.style.backgroundColor = 'orange'
// })

//querySelectorAll

//cookies,local storage and session storage

//cookie is always sent to the server in the http header. 

//document.cookie = "key = value"

// document.cookie = "username = John Doe"
// document.cookie = "theme = dark"
// console.log(document.cookie)

//1. Cookies are scoped to the websites that created them. 
//2. Cookie is automatically sent in the http header to the server in every http request. 
//3. max size is 4kb

//localStorage vs sessionStorage
//1. Session storage stores data only for the session. Local storage stores data that persists beyond the current session;
//saves data until it is explicity removed. 

//local storage
// localStorage.setItem('username', 'John')
// console.log(localStorage.getItem('username'))

// localStorage.setItem('theme', 'dark')
// console.log(localStorage.getItem('theme'))

// localStorage.removeItem('username')

// localStorage.clear()

// //sessin storage

// sessionStorage.setItem('language', 'Javascript')
// console.log(sessionStorage.getItem('language'))

// //sessionStorage.removeItem('language')

// sessionStorage.clear()

//local storage: 5 MB; session storage: 5 - 10 MB


//local storage: used for user preferences, settings, theme..
//session storage: used for storing sensitive data
//cookies: 



//ways of making http request in js

// HTTP Request: header + body
// HTTP Response : header + body

//1. XHR

//Get request

// var oReq = new XMLHttpRequest();
// oReq.addEventListener("load", reqListener);
// oReq.open('GET', "https://jsonplaceholder.typicode.com/posts");
// oReq.send();

// function reqListener(){
//     console.log(this.responseText);
// }

//post request
// var oReq = new XMLHttpRequest();
// oReq.addEventListener("load", reqListener);
// oReq.open('POST', "https://jsonplaceholder.typicode.com/posts")
// oReq.send("userId=100&Id=200&title=xhr demo for post reuqest &body=post req")

// function reqListener(){
//     console.log(this.responseText);
// }


//2. Fetch Api
//promises

//Asynchronous Programming: 1. Callbacks and closures
                        //2. Promises

//Callbacks: functions that are passed as parameters to other functions. 

// function fetchData(callback){
//     setTimeout(()=>{
//         const data = "Data fetched succesfully"
//         callback(data)
//     }, 2000 );
// }

// function handleData(data){
//     console.log(data)
// }

// fetchData(handleData)

// console.log('hello world')

 //Closures

//  function OuterFunction(){
//     let outerVariable = 'I am from outer Variable'

//     function innerFunction(){
//         console.log(outerVariable)
//     }
//     return innerFunction;
//  }

//  const innerFunc = OuterFunction()

//  innerFunc()

// //Promises: resolved or rejected 

// function myPromiseFunction(){
//     return new Promise ((resolve, reject)=>{
//         setTimeout(()=>{
//             const randomNumber = Math.random();
//             if(randomNumber>0.5){
//                 resolve(randomNumber);
//             }else{
//                 reject('Number is too small')
//             }
//         }, 1000)
//     });
// }

// myPromiseFunction().then(result=> console.log(result)).catch(error=>console.error(error) )

//2. Fetch Api 

//get request
fetch("https://jsonplaceholder.typicode.com/posts")
.then(response=> response.json())
.then(response=>console.log(response))
.catch(error=> console.log(error))

//post request

fetch("https://jsonplaceholder.typicode.com/posts",{
    method: 'POST',
    body: JSON.stringify({
        title: 'Fetch post request',
        body:'this is a body',
        userId: 2,
        Id: 3
    }),
    headers:{
        'Content-type' : 'application/json'
    }
})
.then(response=> response.json())
.then(response=> console.log(response))
.catch(error=> console.error(error))