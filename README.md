You'll be required to create 2 apps, the first app would handle the booking creation process whereas the second app would handle the dispatching/driver assignment process.

For the first app, you would need to create 2 set of APIs.
The first set would allow me to:
1) create a passenger record with my phone number
2) retrieve my system generated password based on my phone number.

The second set you would need to be able to:
1) create a booking as a passenger (the passenger needs to be authenticated with the correct system generated password)
2) retrieve the booking id of the newly created booking.
3) retrieve the details of the booking with the driver's name and phone number.

For the second app, I would like you to mimic our nodejs/dispatcher system. The first thing that you need to do is to create a rake task that would populate the database with 10 drivers with randomly generated latitude and longitude.
After that, you will create a set of API that assigns the nearest driver to a booking. Once a driver is assigned, you will call a background worker (like Sidekiq) to send out an SMS to the driver (you can just print out the message for the purposes of this test).

Now for the twist, once a booking is created in the first app, you will need to use a model callback to call the driver assignment API in the second app (only the booking id can be sent from the first app).
