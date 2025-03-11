# Cafe-Promotions-Analysis

## Project Background

Maven Cafe, a neighborhood coffee shop, has built a loyal customer base across various age groups. In 2024 August, they launched a new loyalty program featuring a reward system to incentivize repeat purchases. The member customers receive promotional offers, including buy-one-get-one (bogo) offers and discount offers through multiple channels such as web, email, mobile, and social media. These offers can be redeemed within a limited time, and customers who complete a promotional offer by making a qualifying transaction receive the associated reward.


Maven aims to refine its promotional strategy to drive customer engagement and increase sales. As an Data Analyst at Maven Cafe, I am collaborating with the marketing team to extract data-driven insights and deliver recommendations for providing more effective promotional offers to improve customer participation and revenue comtribution. 

Insights and recommendations are provided on the following key areas:

- Revenue Trends Analysis: Evaluation of historical sales patterns, focusing on offer participation and offer types.
- Promotional Offer Performance: An analysis of bogo and discount offer performance, including customer engagement, revenue and net sales revenue performance, and comparision of different offers.
- Customer Segment Analysis: An evaluation of sales, offer completion, and marketing channel performance across different age and income segments to indentify targeted customers.

An interactive Tableau dashboard can be found here[].

The SQL queries utilized to prepare data for the dashboard can be found here[].


## Dataset Structure

The dataset consisted of three tables, including customers, events, and offers, with a total row counts of 323,543. 

<img width="857" alt="image" src="https://github.com/user-attachments/assets/560c898a-64ec-4c69-bc55-11a617ae7c89" />

The original events dataset contained a "value" column that stored multiple types of information in a dictionary format. For clarity and ease of analysis, I used Python to separate these mixed values into distinct columns: amount, offer_id, and reward. The script used for this transformation can be found here [].




## ...

Data that simulates the behavior of Cafe Rewards members over a 30-day period, including their transactions and responses to promotional offers.

Customers receive offers once every few days and have a limited time to redeem them. These can be informational offers (simple advertisement of a product), discount offers, or "buy one, get one" (BOGO) offers. Each customer receives a different mix of offers, attempting to maximize their probability of making a purchase.

Every customer purchase during the period is marked as a transaction. For a transaction to be attributed to an offer, it must occur at the same time as when the offer was "completed" by the customer.

I can confirm that all customers in the events file are indeed present in the customers file. 




Objective
the effectiveness of different offer types and channels
target audience


Key Findings About Informational Offers

Largest Transactions After Informational Offers:

The largest transaction after receiving an informational offer was $1,062.28
This occurred 54 hours after the customer received the offer
The top 10 largest transactions after informational offers ranged from $594.23 to $1,062.28


Transaction Volume:

14,816 transactions occurred within 72 hours of customers receiving informational offers
This represents 10.66% of all transactions in the dataset
The total amount spent after informational offers was $186,867.79


Customer Response Rate:

10,547 customers received informational offers
66.45% of these customers made transactions within the offer window
This is a significant conversion rate for a no-reward offer type


Transaction Value:

Average transaction amount after informational offers: $12.61
Average transaction amount overall: $12.78
The transaction values are very similar, suggesting informational offers don't significantly increase or decrease transaction size


Multiple Transactions After Informational Offers
The data clearly shows that informational offers frequently lead to multiple transactions for many customers:
Transaction Frequency

66.45% of customers who received informational offers made at least one transaction
36.02% made multiple transactions (2 or more)
19.11% made 3 or more transactions

Breakdown of Transaction Counts

30.43% of customers made exactly 1 transaction
16.91% made 2 transactions
9.79% made 3 transactions
4.57% made 4 transactions
4.74% made 5 or more transactions

Key Statistics

The average number of transactions per customer (among those who transacted) is 2.11
Some customers made as many as 11-13 transactions after receiving an informational offer
The top transactor made 13 transactions totaling $35.03

Spending Patterns

Average amount spent per customer: $26.66
Most customers (2,536) spent under $10 total
However, 166 customers spent over $100 after receiving informational offers
The highest spending customer made only 3 transactions but spent $1,411.77


Valid Completions: Only 67.29% (19,511) of completed offers followed the expected sequence (received → viewed → completed) within the valid time period.
