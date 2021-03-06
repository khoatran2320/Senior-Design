const express = require('express');
const app = express();
const cors = require('cors');

// Firebase Setup
const admin = require('firebase-admin');
const serviceAccount = require('../boxi_key.json');
admin.initializeApp({
	credential: admin.credential.cert(serviceAccount)
});

// App Setup
const PORT = 3000;
const packageRouter = require('./routes/package');
const boxiRouter = require('./routes/boxi');
const mobileRouter = require('./routes/mobile');

app.use(cors());
app.use(express.json());

// API Routes
app.get('/', (req, res) => {
	res.send('Hello World!');
});
app.use('/package', packageRouter);
app.use('/boxi', boxiRouter);
app.use('/mobile', mobileRouter);

function get_ip_addr(){
    return Object.values(require('os').networkInterfaces()).reduce((r, list) => r.concat(list.reduce((rr, i) => rr.concat(i.family==='IPv4' && !i.internal && i.address || []), [])), [])[0]
}

console.log(get_ip_addr())
app.listen(PORT, () => {
	console.log(`Example app listening at http://localhost:${PORT}`);
});
