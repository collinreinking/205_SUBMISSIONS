import tweepy

consumer_key = "MPvIHbotIx0okQ8t5LYcfHwH5";
#eg: consumer_key = "MPvIHbotIx0okQ8t5LYcfHwH5";


consumer_secret = "Ytsu5I4C9UAj4r00MbJ6BeZbfVLjKMEamkHBTyMpd3verSgA20";
#eg: consumer_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token = "635518217-xjySEuw86WnHt170aMofHtenRueNedt6d8MZpR4e";
#eg: access_token = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token_secret = "3kyzbqAxsOT9Y8Gg1F8RFO6IhZqEQL6kOTAoCUgHSloVY";
#eg: access_token_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";


auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)



