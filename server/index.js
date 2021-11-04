const express = require('express')
const app = express()
const port = 3000
const axios = require('axios');
const cors = require("cors");
app.use(cors())
app.use(express.json())


app.get('/', (req, res) => {
  res.send('Hello World!')
})

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
      }).catch((err) => console.log(err));

})
app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})