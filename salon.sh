#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"

MAIN_MENU() {
  # get salon services
  SALON_SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")

  # display salon services
  echo "$SALON_SERVICES" | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done
  echo "0) Exit"

  # user input
  read SERVICE_ID_SELECTED

  # if option not found
  case $SERVICE_ID_SELECTED in
    1) SERVICE_MENU ;;
    2) SERVICE_MENU ;;
    3) SERVICE_MENU ;;
    4) SERVICE_MENU ;;
    5) SERVICE_MENU ;;
    0) EXIT ;;
    *) echo -e "\nI could not find that service. What would you like today?" 
       MAIN_MENU ;;
  esac
}

SERVICE_MENU() {
  # get service name
  SERVICE_NAME=$($PSQL "SELECT name from services WHERE service_id = '$SERVICE_ID_SELECTED'")

  # get customer info
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # if phone number not found
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get customer name
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME

    # insert new customer
    INSERT_NEW_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi

  # get customer id
  CUSTOMER_ID=$($PSQL "SELECT customer_id from customers WHERE name = '$CUSTOMER_NAME'")

  # get service time
  echo -e "\nWhat time would you like your cut, "$CUSTOMER_NAME"?"
  read SERVICE_TIME

  # insert service as an appointment
  INSERT_CUSTOMER_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', '$SERVICE_ID_SELECTED', '$SERVICE_TIME')")

  # display appointment feedback
  echo -e "\nI have put you down for a"$SERVICE_NAME" at "$SERVICE_TIME", "$CUSTOMER_NAME"."
}

EXIT() {
  echo -e "\nThanks for booking your appointment with My Salon!"
}

# Invoke Main Menu
MAIN_MENU
