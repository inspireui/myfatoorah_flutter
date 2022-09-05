## 2.1.13 - 11/5/2022
* Fix some bugs and make overall enhancement.
## 2.1.12 - 11/5/2022
* Fix some bugs and make overall enhancement.

## 2.1.11 - 8/5/2022
* Fix some bugs and make overall enhancement.

## 2.1.10 - 27/4/2022
* Add `onInvoiceCreated` callback to `executePayment` to return you the `invoiceId` once created.
* Fix some bugs and make overall enhancement.

## 2.1.9 - 24/4/2022
* Add feature of saved cards with embedded payment.
* Fix some bugs and make overall enhancement.

## 2.1.8 - 13/4/2022
* Fix some bugs and make overall enhancement.

## 2.1.7 - 12/4/2022
* Fix some bugs and make overall enhancement.

## 2.1.6 - 10/4/2022
* Add feature of pay with Apple Pay.
* Support save card option with embedded payment to enable you to save your customer's card details to make future payments easier.
* Fix some bugs and make overall enhancement.

## 2.1.5 - 25/1/2022
* Deprecated the `executeRecurringDirectPayment()` method and use instead `RecurringModel` in `MFExecutePaymentRequest` using `executePayment()` or `executeDirectPayment()` method.
* Fix some bugs and make overall enhancement.

## 2.1.4 - 17/1/2022
* Fix some bugs and make overall enhancement.

## 2.1.3 - 29/12/2021
* Fix some bugs and make overall enhancement.

## 2.1.2 - 12/12/2021
* Fix some bugs and make overall enhancement.

## 2.1.0 - 18/10/2021
* Support embedded payment feature (payment card view).
* Fix some bugs and make overall enhancement.

## 2.0.3 - 14/9/2021
* Fix some bugs and make overall enhancement.

## 2.0.2 - 12/9/2021
* Fix some bugs and make overall enhancement.

## 2.0.1 - 15/8/2021
* Fix some bugs and make overall enhancement.

## 2.0.0 - 7/7/2021
* Migrate to null safety.

## 1.0.20 - 14/6/2021
* Fix some bugs and make overall enhancement.

## 1.0.19 - 8/6/2021
* Fix some bugs and make overall enhancement.

## 1.0.18 - 5/5/2021
* Upgrade `device_info` plugin to version `2.0.0`

## 1.0.17 - 13/4/2021
* Upgrade `http` plugin to version `0.13.1`

## 1.0.16 - 24/3/2021
* Deprecated `executeDirectPaymentWithRecurring()` method which takes integer 
value `intervalDays` as a parameter. Used instead `executeRecurringDirectPayment()` method
which takes `MFRecurringType` which is one of four different values 
`daily`, `weekly`, `monthly`, or `custom(days)`.

## 1.0.15 - 17/2/2021
* We deprecated 'supplierCode' and 'supplierValue' and used 'suppliers' list instead.
 Inside the following APIs: 
    - sendPayment
    - executePayment
    - executeDirectPayment
    - executeDirectPaymentWithRecurring
* Fix some bugs and make overall enhancement.

## 1.0.14 - 8/2/2021
* Fix some bugs and make overall enhancement.

## 1.0.13 - 27/1/2021
* Fix some bugs and make overall enhancement.

## 1.0.12 - 11/11/2020
* Fix some bugs and make overall enhancement.

## 1.0.11 - 2/11/2020
* Add CardHolderName field to card info in direct payment.

## 1.0.10 - 19/10/2020
* Fix some bugs and make overall enhancement.

## 1.0.9 - 24/9/2020
* Fix some bugs and make overall enhancement.

## 1.0.8 - 24/9/2020
* Fix some bugs and make overall enhancement.

## 1.0.7 - 16/6/2020
* Fix some bugs and make overall enhancement.

## 1.0.6 - 31/5/2020
* Support Apple Pay for iPhone devices starting from iOS 13.

## 1.0.5 - 19/5/2020
* Fix some bugs and make overall enhancement.

## 1.0.4 - 13/5/2020
* Fix some bugs and make overall enhancement.

## 1.0.3 - 26/3/2020
* Fix some bugs and make overall enhancement.

## 1.0.2 - 25/3/2020

* Add cancelRecurringPayment feature.
* Add cancelToken feature.
* Updating ReadMe and fix some bugs and enhancement.

## 1.0.1 - 24/3/2020

* Adds getPaymentStatus feature.
* Fux bugs and enhancement.

## 1.0.0 - 24/3/2020

* Adds sendPayment feature.
* Adds initiatePayment feature.
* Adds executeRegularPayment feature.
* Adds executeDirectPayment feature.
* Adds executeDirectPaymentWithRecurring feature.

## 0.0.1 - 22/3/2020

* First Beta version of MyFatoorah Flutter Plugin.
