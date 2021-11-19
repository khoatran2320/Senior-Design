const axios = require('axios');
module.exports = {
  addPackage: function (trackingNumber) {
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

  getPackages: function () {
    return new Promise((resolve, reject) => {
      axios({
        method: 'get',
        url: 'https://api.pkge.net/v1/packages/list',
        headers: {
          'Accept': 'application/json',
          'X-Api-Key': process.env.PKGE_API_KEY
        }
      }).then((response) => {
        resolve(response.data.payload)
      }).catch((err) => reject(err))
    })
  },
  getPackage: function (trackingNumber) {
    return new Promise((resolve, reject) => {
      axios({
        method: 'get',
        url: 'https://api.pkge.net/v1/packages?',
        params: { trackNumber: trackingNumber },
        headers: {
          'Accept': 'application/json',
          'X-Api-Key': process.env.PKGE_API_KEY
        }
      }).then((response) => {
        resolve(response.data.payload);
      }).catch((err) => reject(err.response.data))
    })
  },
  updatePackage: function (trackingNumber) {
    return new Promise((resolve, reject) => {
      axios({
        method: 'post',
        url: 'https://api.pkge.net/v1/packages/update?',
        params: {
          trackNumber: trackingNumber
        },
        headers: {
          Accept: 'application/json',
          'X-Api-Key': process.env.PKGE_API_KEY
        }
      })
        .then((response) => {
          resolve('Package tracking information is being updated...');
        })
        .catch((err) => {
          if (err.response.status == 404) {
            reject('Package with tracking number not found!');
          } else {
            reject(err.response.data);
          }
        });
    })
  },
  deliveryStatus: {
    0: "PACKAGE_ADDED",               //The package was added to the system but hasn't been updated yet
    1: "INITIAL_UPDATE",              //Initial package update in progress
    2: "INITIAL_UPDATE_COMPLETED",    //The package update has been completed, but no information was received from the delivery service
    3: "IN_TRANSIT",                  //Package in transit
    4: "AWAITING_DELIVERY",           //Package arrived at delivery point
    5: "DELIVERED",                   //Package delivered to recipient
    6: "DELIVERY_UNSUCCESSFUL",       //The package was not delivered. For example, if there was an unsuccessful attempt to deliver
    7: "PACKAGE_DESTROYED",           //Package delivery error. For example, a package is destroyed
    8: "PREPARING_FOR_SHIPMENT",      //The package is being prepared for shipment. The delivery service received information about the package, but the package has not departed yet
    9: "EXPORTED"                     //The end of the package tracking route. For example, for international packages that are only tracked when in the country of origin
  }
}