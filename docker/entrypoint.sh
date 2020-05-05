#!/bin/sh
java -cp app:app/lib/* -Dspring.profiles.active=${springProfiles} "com.aboydfd.App"