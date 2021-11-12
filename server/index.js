const express = require('express')
const app = express()
const port = 3000
const axios = require('axios');
const cors = require("cors");
const { response } = require('express');
app.use(cors())
app.use(express.json())


app.get('/', (req, res) => {
  res.send('Hello World!')
})


/* ***** get_package_info  *****
    desc: get the details of a package
    inputs: 
      trackingNumber: tracking number of the package to retrieve information
    outputs: 
      code 200: succesfully retrieved the information 
      code 400: unable to get package information
*/ 
app.get('/get_package_info', (req, res) =>{
    if(req.query.trackingNumber == undefined){
        res.status(400).send("Requires a tracking number!");
    }
    axios({
        method: 'get', //you can set what request you want to be
        url: 'https://api.pkge.net/v1/packages?',
        params: {trackNumber: req.query.trackingNumber},
        headers: {
            'Accept': 'application/json',
            'X-Api-Key': process.env.PKGE_API_KEY
        }
      }).then((response) => {
        res.status(200).send(JSON.stringify(response.data.payload));
      }).catch((err) => {
        res.status(400).send(JSON.stringify(err.response.data))
      });

})


/* ***** add_package  *****
    desc: add a package to start tracking
    inputs: 
      trackingNumber: tracking number of the package to track
    outputs: 
      code 200: successfully adds the new package
      code 400: unable to add package, more error codes and error messages in the return response
*/ 
app.post('/add_package', (req, res) => {
  if(req.query.trackingNumber == undefined){
    res.status(400).send("Requires a tracking number!");
  }

  axios({
    method: 'post', 
    url: 'https://api.pkge.net/v1/packages?',
    params: {
      trackNumber: req.query.trackingNumber,
      courierId: -1
    },
    headers: {
      'Accept': 'application/json',
      'X-Api-Key': process.env.PKGE_API_KEY
    }
  }).then((response) => {
    res.status(200).send(JSON.stringify(response.data))
  }).catch((err) => {
    res.status(400).send(JSON.stringify(err.response.data))
  });
})




/* ***** delete_package  *****
    desc: delete a package that is currently being tracked
    inputs: 
      trackingNumber: tracking number of the package to delete
    outputs: 
      code 200: successfully deleted package
      code 404: package with provided tracking number not found
*/ 
app.delete('/delete_package', (req, res) => {
  if(req.query.trackingNumber == undefined){
    res.status(400).send("Requires a tracking number!");
  }

  axios({
    method: 'delete', 
    url: 'https://api.pkge.net/v1/packages?', 
    params: {
      trackNumber: req.query.trackingNumber
    }, 
    headers:{
      'Accept': 'application/json', 
      'X-Api-Key': process.env.PKGE_API_KEY
    }
  }).then((response) => {
    res.status(200).send(JSON.stringify(response.data))
  }).catch((err) => {
    res.status(404).send("Package with tracking number not found!")
  })
})



/* ***** get_packages  *****
    desc: get a list of packages that are currently being tracked
    inputs: 
      
    outputs: 
      code 200: succesfully returns the list of packages
*/ 
app.get('/get_packages', (req, res) => {
  axios({
    method: 'get', 
    url: 'https://api.pkge.net/v1/packages/list', 
    headers: {
      'Accept': 'application/json',
      'X-Api-Key': process.env.PKGE_API_KEY
    }
  }).then((response) =>{
    res.status(200).send(response.data.payload)
  }).catch((err) => console.log(err))
})

/* ***** update_package  *****
    desc: updates the package to get the latest checkpoints and status
    inputs: 
      trackingNumber: tracking number of the package to update
    outputs: 
      code 200: successfully queues the update process. This update process may take a while and does not immediately update the status of the package
      code 404: package with provided tracking number not found
      code 400: unable to update package, more information is sent back to the client
        903	Failed to update the package. Not enough time has passed since the last update, or the package has already been delivered. Followed by the date of the next possible update in 'payload' if an update is possible
        909	Failed to update the package. The maximum number of packages allowed is currently being updated. Wait for the next package to complete the update and repeat the request
        910	Package update progress check requests are too frequent. Repeat the request later.
*/ 
app.post('/update_package', (req, res) => {
  if(req.query.trackingNumber == undefined){
    res.status(400).send("Requires a tracking number!")
  }
  axios({
    method: 'post',
    url: 'https://api.pkge.net/v1/packages/update?',
    params: {
      trackNumber: req.query.trackingNumber
    },
    headers: {
      'Accept': 'application/json', 
      'X-Api-Key': process.env.PKGE_API_KEY
    }
  }).then((response) => {
    res.status(200).send("Retrieving updated information on package...")
  }).catch((err) => {
    if(err.response.status == 404){
      res.status(404).send("Package with trracking number not found!")
    }else{
      res.status(400).send(err.response.data)
    }
  })

})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})