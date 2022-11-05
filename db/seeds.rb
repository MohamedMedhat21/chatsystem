# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

app1 = Application.create(name:'app1',token:'bEA2F4D1AKQx9W97WZcdFw')
app2 = Application.create(name:'app2',token:'GB8-6DvTvy2U2tml-F6Szg')

app1_chat1 = Chat.create(application_id:1,number:1)
app1_chat2 = Chat.create(application_id:1,number:2)

app1_chat1_msg1 = Message.create(chat_id:1,number:1,content:"hello from the other side")
app1_chat1_msg2 = Message.create(chat_id:1,number:2,content:"I must've called a thousand times")
app1_chat1_msg2 = Message.create(chat_id:1,number:3,content:"hello from app1 chat 1 msg 3")

app1_chat2_msg1 = Message.create(chat_id:2,number:1,content:"To tell you I'm sorry for everything that I've done")
app1_chat2_msg2 = Message.create(chat_id:2,number:2,content:"hello from app1 chat 2 msg 2")

app2_chat1 = Chat.create(application_id:2,number:1)