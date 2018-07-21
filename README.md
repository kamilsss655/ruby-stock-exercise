Test for Senior Rails Developers
======
Please use git. Please work on the branch `master`.

Please submit your results as a zipped folder, including your commit history.

## Your Task:
You are going to build a simple stock market API - with Bearers who own Stocks, which have varying MarketPrices. Please remember, the goal of this exercise is not to make the application merely "functional". This is an opportunity for you to:

* Show off your development skills
* Utilize good design patterns
* Write clean, extendable, tested code

Treat this like a production application that will be worked on by developers other than yourself. While this test may seem simple, we are not interested in "gotchas" or obscure problems. We **are** interested in how you design and build a maintainable application.  Feel free to configure this project file as you see fit.

#### Instructions:
##### Models:
You should create three models with at minimum the following attributes:

+ `Stock` (name: string)
+ `Bearer` (name: string)
+ `MarketPrice` (currency: string, value_cents: integer)

A stock can only have one bearer and one market price at a time (no joint ownership, or differing buy/sell values in this simple application). Bearers should be **unique by name**, but can own multiple stocks. A market price should be **unique by the combination of currency and value_cents**, but can reflect the price of multiple stocks.

##### JSON API Endpoints:
Via one API endpoint the user should be able to create a `Stock` with a referenced `Bearer` and `MarketPrice`.

Another API endpoint should allow the user to update a `Stock`. `Bearer` and `MarketPrice` cannot be updated, but if attributes of either of those change, new objects need to be created and referenced with the existing `Stock`. If an existing bearer or market price exists already, they should be re-used and connected to the stock instead.

One simple API endpoint should list all stocks, showing information from connected models, and be an efficient database query.

In a last API endpoint it should be possible to soft-delete a stock so it doesn't appear anywhere anymore in regular queries but could still be retrieved when needed (e.g. an audit by financial authorities, or by a BI-Department).

Please keep your controllers very lean, do not implement duplication logic in the controllers.

##### Error Handling:
Error responses should be detailed in a way that they explain what exactly is missing or wrong. In order to test this, consider making validations that forbid `name` fields from containing the string "invalid". How you structurethis is your decision.

##### Testing:
RSpec tests are required. Submissions without tests will be rejected. Where, how, and what to test is up to you! We have included FactoryBot for your convenience.
