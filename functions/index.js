const {onDocumentCreated} = require("firebase-functions/v2/firestore");
const logger = require("firebase-functions/logger");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendNoticeNotification = onDocumentCreated("notices/{noticeId}", async (event) => {
  const newNotice = event.data.data();

  const message = {
    notification: {
      title: "New Notice",
      body: newNotice.title, // Assuming the notice has a 'title' field
    },
    topic: "all", // Send to all devices subscribed to the 'all' topic
  };

  try {
    await admin.messaging().send(message);
    logger.info("Notification sent successfully", {structuredData: true});
  } catch (error) {
    logger.error("Error sending notification:", error);
  }
});
