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


// Start writing functions
// https://firebase.google.com/docs/functions/typescript

const restApiKey = defineSecret("REST");
const userAuthKey = defineSecret("USER");
const appId = "347f29ed-6636-469f-bc56-9feeefe1aaeb";

export const triggerOfferStatusChanged = onRequest({
  concurrency: 500,
}, async (request, response) => {
  const configuration = OneSignal.createConfiguration({
    restApiKey: restApiKey.value(),
    userAuthKey: userAuthKey.value(),
  });

  const client = new OneSignal.DefaultApi(configuration);
  const notification = new OneSignal.Notification();
  notification.app_id = appId;

  notification.name = "Party Has Tickets";
  notification.contents = {
    en: `Your offer has been ${request.body.data.accepted ? "accepted" : "Declined"} for ${request.body.data.postName}`,
  };
  notification.data = {"path": "/events/"};
  // required for Huawei
  notification.headings = {
    en: "Offer Update!",
  };

  notification.filters = [
    {field: "tag", key: "emailTag", relation: "=", value: request.body.data.ext},
  ];
  const notificationResponse = await client.createNotification(notification);
  // return response.json();
  return Promise.resolve(notificationResponse.errors ?? true);
});


export const triggerOfferMadeForPost = onRequest({
  concurrency: 500,
}, async (request, _) => {
  const configuration = OneSignal.createConfiguration({
    restApiKey: restApiKey.value(),
    userAuthKey: userAuthKey.value(),
  });

  const client = new OneSignal.DefaultApi(configuration);
  const notification = new OneSignal.Notification();
  notification.app_id = appId;

  notification.name = "Offer Created";
  notification.contents = {
    en: `An offer has been made by ${request.body.data.sender } for ${request.body.data.postName}`,
  };
  notification.data = {"path": "/events/"};
  // required for Huawei
  notification.headings = {
    en: "You recieved an offer!",
  };

  notification.filters = [
    {field: "tag", key: "emailTag", relation: "=", value: request.body.data.reciever},
  ];
  const notificationResponse = await client.createNotification(notification);
  return Promise.resolve(notificationResponse.errors ?? true);
});
