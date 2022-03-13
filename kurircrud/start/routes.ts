/*
|--------------------------------------------------------------------------
| Routes
|--------------------------------------------------------------------------
|
| This file is dedicated for defining HTTP routes. A single file is enough
| for majority of projects, however you can define routes in different
| files and just make sure to import them inside this file. For example
|
| Define routes in following two files
| ├── start/routes/cart.ts
| ├── start/routes/customer.ts
|
| and then import them inside `start/routes.ts` as follows
|
| import './routes/cart'
| import './routes/customer'
|
*/

import { Request } from '@adonisjs/core/build/standalone'
import Route from '@ioc:Adonis/Core/Route'
import Database from '@ioc:Adonis/Lucid/Database'


Route.get("/test", async() => {
  return {
    message : "Hello"
  }
})

Route.get("/api/listhistory", async({response}) =>{
  const db = await Database.from("history").select("*")

   response.status(200).json({
    message : "Successfully Load History",
    data : db
   })
   return db
})

Route.post("/api/createhistory", async({response,request}) => {
  const inputData = {
    Namabarang : request.input("namabarang"),
    Harga : request.input("harga"),
    Dari : request.input("dari"),
    Ke : request.input('ke'),
    Ekspedisi : request.input("ekspedisi"),
    Status : request.input("status")
  }
  await Database.table("history").insert(inputData)
  response.status(200).json({
    message : "Successfully Create History",
    data : inputData,
  })
  return inputData

})

Route.put("/api/history/:Id", async({request,response,params}) => {
  const inputData = {
    Namabarang : request.input("namabarang"),
    Harga : request.input("harga"),
    Dari : request.input("dari"),
    Ke : request.input('ke'),
    Ekspedisi : request.input("ekspedisi"),
    Status : request.input("status")
  }
  await Database.from("history").where("Id", params.Id).update(inputData)
  response.status(200).json({
    message : "Successfully Edit History",
    id : params.Id,
    data : inputData,
  })

})