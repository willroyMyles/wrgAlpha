/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import {onRequest} from "firebase-functions/v2/https";
// import * as logger from "firebase-functions/logger";
import * as OneSignal from "@onesignal/node-onesignal";
import {defineSecret} from "firebase-functions/params";
import * as functions from "firebase-functions";


// Start writing functions
// https://firebase.google.com/docs/functions/typescript

const restApiKey = defineSecret("REST");
const userAuthKey = defineSecret("USER");
const appId = "347f29ed-6636-469f-bc56-9feeefe1aaeb";

export const triggerOfferStatusChanged = onRequest({
  concurrency: 500,
}, async (req, response) => {
  try {
    const configuration = OneSignal.createConfiguration({
      restApiKey: restApiKey.value(),
      userAuthKey: userAuthKey.value(),
    });

    const client = new OneSignal.DefaultApi(configuration);
    const notification = new OneSignal.Notification();
    notification.app_id = appId;

    functions.logger.info(`before body function ${req.body.data}`);


    notification.name = "Offer Update!";
    notification.contents = {
      en: `Your offer has been ${req.body.data.accepted ? "accepted" : "Declined"} for ${req.body.data.postName}`,
    };
    notification.data = {"path": "/events/"};
    // required for Huawei
    notification.headings = {
      en: "Offer Update!",
    };

    notification.filters = [
      {field: "tag", key: "emailTag", relation: "=", value: req.body.data.ext},
    ];

    functions.logger.log(`before sending function ${notification}`);
    const notificationResponse = await client.createNotification(notification);
    functions.logger.log(`after sending function ${notificationResponse.errors}`);
    // return response.json();
    return Promise.resolve(notificationResponse.errors ?? true);
  } catch (e) {
    functions.logger.log(`something went wring ${e}`);
    return Promise.reject(response.sendStatus(400));
  }
});


export const triggerOfferMadeForPost = onRequest({
  concurrency: 500,
}, async (request, _) => {
  try {
    const configuration = OneSignal.createConfiguration({
      restApiKey: restApiKey.value(),
      userAuthKey: userAuthKey.value(),
    });

    const client = new OneSignal.DefaultApi(configuration);
    const notification = new OneSignal.Notification();
    notification.app_id = appId;

    notification.name = "Offer Created";
    notification.contents = {
      en: `An offer has been made by ${request.body.data.sender} for ${request.body.data.postName}`,
    };
    notification.data = {"path": "/events/"};
    // required for Huawei
    notification.headings = {
      en: "You recieved an offer!",
    };

    notification.filters = [
      {field: "tag", key: "emailTag", relation: "=", value: request.body.data.reciever},
    ];

    functions.logger.log(`before sending function ${notification}`);
    const notificationResponse = await client.createNotification(notification);
    functions.logger.log(`after sending function ${notificationResponse.errors}`);

    return Promise.resolve(notificationResponse.errors ?? true);
  } catch (e) {
    functions.logger.log(`something went wring ${e}`);
    return Promise.reject(_.sendStatus(400));
  }
});
