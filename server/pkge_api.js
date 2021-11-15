const axios = require('axios');
module.exports = {
    addPackage: function (trackingNumber){
        return new Promise((resolve, reject) => {
            axios({
                method: 'post', 
                url: 'https://api.pkge.net/v1/packages?',
                params: {
                  trackNumber: trackingNumber,
                  courierId: -1
                },
                headers: {
                  'Accept': 'application/json',
                  'X-Api-Key': process.env.PKGE_API_KEY
                }
              }).then((response) => {
                resolve(JSON.stringify(response.data));
              }).catch((err) => {
              //   console.log(JSON.stringify(err.response.data));
                reject(JSON.stringify(err.response.data));
              });
          });
      }, 
    
    getPackages: function(){
        return new Promise((resolve, reject) => {
            axios({
                method: 'get', 
                url: 'https://api.pkge.net/v1/packages/list', 
                headers: {
                  'Accept': 'application/json',
                  'X-Api-Key': process.env.PKGE_API_KEY
                }
              }).then((response) =>{
                resolve(response.data.payload)
              }).catch((err) => reject(err))
        })
    }
}