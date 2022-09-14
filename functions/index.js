const functions = require("firebase-functions");
const admin = require("firebase-admin");
const stripe = require("stripe")("sk_test_51LTfx1E9NMiJV8v5VKXtNVVqmmNztLwIzy3E3j458KU4ORU1VhqaTg1lj5gwSYAgiKMBkn767yyA6v8MMY5xKF0I00allPUqpN");

admin.initializeApp(functions.config().functions);

exports.stripePaymentIntentRequest = functions.https.onRequest(async (req, res) => {
    try {
        let customerId;

        //Gets the customer who's email id matches the one sent by the client
        const customerList = await stripe.customers.list({
            email: req.body.email,
            limit: 1
        });
                
        //Checks the if the customer exists, if not creates a new customer
        if (customerList.data.length !== 0) {
            customerId = customerList.data[0].id;
        }
        else {
            const customer = await stripe.customers.create({
                email: req.body.email
            });
            customerId = customer.data.id;
        }

        //Creates a temporary secret key linked with the customer 
        const ephemeralKey = await stripe.ephemeralKeys.create(
            { customer: customerId },
            { apiVersion: '2020-08-27' }
        );

        //Creates a new payment intent with amount passed in from the client
        const paymentIntent = await stripe.paymentIntents.create({
            amount: parseInt(req.body.amount),
            currency: 'usd',
            customer: customerId,
        })

        res.status(200).send({
            paymentIntent: paymentIntent.client_secret,
            ephemeralKey: ephemeralKey.secret,
            customer: customerId,
            success: true,
        })
        
    } catch (error) {
        res.status(404).send({ success: false, error: error.message })
    }
});


//New Order Func
exports.orderPlaced = functions.firestore.document('orders/{orderId}').onCreate(async (snapshot, context) => 
{

    const orderId = context.params.orderId;
    const orderStatus = snapshot.data().orderStatus;
    const uid = snapshot.data().deliveryAddressDetails.uid;




    var payload = null;

    payload = {
        notification: {
            title: 'Your Order Placed Successfully',
            body: "Thanks for choosing us",
            sound: 'default',
        },
        data: {
            type: 'orderStatus',
            orderId: orderId,
            orderStatus: orderStatus,
            click_action: 'FLUTTER_NOTIFICATION_CLICK',
        }
    };

    return admin.firestore().collection('users').doc(uid).get().then(async (queryResult) => {
        const tokenId = queryResult.data().token;

        var uuid = createUUID();

        let notificationMap = {
            notificationBody: payload.notification['body'],
            notificationId: uuid,
            notificationTitle: payload.notification['title'],
            notificationType: 'ORDER_NOTIFICATION',
            orderId: orderId,
            timestamp: admin.firestore.Timestamp.fromDate(new Date())
        };

        await admin.firestore().collection('users').doc(uid).collection("notification").add({
            'notification': notificationMap,
            'unread': true,
        }, {
            merge: true
        });

        return admin
            .messaging()
            .sendToDevice(tokenId, payload)
            .then((response) => {
                // Response is a message ID string.
                console.log('TOKEN ID:: ', tokenId);
                console.log('Successfully sent message:', response);
                console.log(response.results[0].error);
            })
            .catch((error) => {
                console.log('Error sending message:', error);
            });
    });
});


function createUUID() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = Math.random() * 16 | 0,
            v = c == 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
    });
}