# Chat System API

RESTful backend application for chat system

note: if your are on a windows machine and facing error like this: /entrypoint.sh: 2: set: illegal option -

change git line-ending settings with this command and restart your terminal

```bash
git config --global core.autocrlf true
```
or try solutions from this link
https://github.com/carlossg/docker-maven/issues/114#issuecomment-527748335

## Get Started

```bash
# Clone the repo
git clone https://github.com/MohamedMedhat21/chatsystem.git
# in the repo directory
cd chatsystem
# run the app
docker-compose up
```

## Run Tests

```bash
# in the repo directory
docker-compose exec app rspec ./spec/
```

## Walkthrough
Testing the endpoints with [postman](https://www.postman.com/) <br>
The database is already seeded with some data

### Applications endpoints

GET http://localhost:3000/api/v1/applications

POST http://localhost:3000/api/v1/applications

also add this body in postman in JSON

```
{
    "name":"app3"
}
```

GET http://localhost:3000/api/v1/applications/:token


PUT http://localhost:3000/api/v1/applications/:token

also add this body in postman in JSON

```
{
    "name":"application3"
}
```

### Chats endpoints

GET http://localhost:3000/api/v1/applications/:application_token/chats

POST http://localhost:3000/api/v1/applications/:application_token/chats

GET http://localhost:3000/api/v1/applications/:application_token/chats/:number

### Messages endpoints

GET http://localhost:3000/api/v1/applications/:application_token/chats/:chat_number/messages

POST http://localhost:3000/api/v1/applications/:application_token/chats/:chat_number/messages

also add this body in postman in JSON

```
{
    "content":"content for Message"
}
```

GET http://localhost:3000/api/v1/applications/:application_token/chats/:chat_number/messages/:number

PUT http://localhost:3000/api/v1/applications/:application_token/chats/:chat_number/messages/:number

also add this body in postman in JSON

```
{
    "content":"new Message content"
}
```

GET http://localhost:3000/api/v1/applications/:application_token/chats/:chat_number/search

also add this body in postman in JSON

```
{
    "query":"tent"
}
```
