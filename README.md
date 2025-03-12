# Cafe-Promotions-Analysis

## Project Background

Maven Cafe, a neighborhood coffee shop, has built a loyal customer base across various age groups. In 2024 August, they launched a new loyalty program featuring a reward system to incentivize repeat purchases. The member customers receive promotional offers, including buy-one-get-one (bogo) offers and discount offers through multiple channels such as web, email, mobile, and social media. These offers can be redeemed within a limited time, and customers who complete a promotional offer by making a qualifying transaction receive the associated reward. Each customer receives a different mix of offers, attempting to maximize their probability of making a purchase. There are also informational offers, simple advertisement of a product.

Maven aims to refine its promotional strategy to drive customer engagement and increase sales. As an Data Analyst at Maven Cafe, I am collaborating with the marketing team to extract data-driven insights and deliver recommendations for providing more effective promotional offers to improve customer participation and revenue comtribution. 

Insights and recommendations are provided on the following key areas:

- Revenue Trends Analysis: Evaluation of historical sales patterns, focusing on offer participation and offer types.
- Promotional Offer Performance Analysis: An analysis of bogo and discount offer performance, including customer engagement, revenue and net sales revenue performance, and comparision of different offers.
- Customer Segment Analysis: An evaluation of sales, offer completion, and marketing channel performance across different age and income segments to indentify targeted customers.

An interactive Tableau dashboard can be found here[].

The SQL queries utilized to prepare data for the dashboard can be found here[].


## Dataset Structure

The dataset consisted of three tables, including customers, events, and offers, with a total row counts of 323,543. 
  1. _customers_: This dataset includes demographic information such as customer id, membership start date, age, gender, and income.
     
  2. _events_normalized_: This dataset tracks customer interactions. The data includes event (transactions, offers received, offers viewed, or offers completed), offer type (bogo, discount, or informational), transaction amounts, and reward.
     
  3. _offers_: This data shows details of all kinds of offers, including the offer id, offer type, difficulty (minimum amount required to spend in order to be able to complete the offer), reward, duration (days a customer has to complete the offer once they have received it), and marketing channels used. 

<img width="857" alt="image" src="https://github.com/user-attachments/assets/560c898a-64ec-4c69-bc55-11a617ae7c89" />

<sub>The original events dataset contained a "value" column that stored multiple types of information in a dictionary format. For clarity and ease of analysis, I used Python to separate these mixed values into distinct columns: amount, offer_id, and reward. The script used for this transformation can be found here []. </sub>


## Executive Summary
![image](https://github.com/user-attachments/assets/42a71940-547d-4aef-9ab3-69d308b2453f)

## Insights Deep-Dive
### Promotional Offer Performance
- **Offer Engagement and Completion Rates:**

  - Bogo offers with low difficulty and rewards had a higher completion rate of 57%, indicating the low minimum amount required works as a strong incentive for customers to redeem the offer.
  - Two specific discount offers, (one with difficulty:7, reward:3, duration:7, and another with difficulty:10, reward:2, duration:10) achieved the highest view rate (96%) and completion rates between 67% and 70%, demonstrating high engagement and strong conversion.
  - Regardless of the offer types, offers with the highest difficulty and reward have not seen conversion success, with completion rates among 44% to 48%.

- **Revenue & Net Sales Revenvue Performance:**
- 
  - Among bogo offers, the one with low difficulty, reward, and duration generate the highest net sale revenue at $81,168. While offers with a difficulty of 10 and a reward of 10 achieved high total revenue and average revenue per transaction, the high reward costs led to a relatively lower net revenue.
  - Despite having a low average revenue, the discount offer with difficulty:10, reward:2, duration:10 achieved $106,523 in net sales revenue, making it the strongest revenue driver.  

![image](https://github.com/user-attachments/assets/0bb3e17d-9464-461c-b994-cf8a377b2a88)

### Customer Segment

This section evaluates **offer completion, revenue impact, and marketing channel performance across age and income groups** to identify engagement trends.  

- **Age Group Insights:**  
  - **Customers aged 50-79** exhibit **higher total revenue contribution (above $300K in total transactions per group)** and **net sales revenue exceeding $100K per segment**, making them a key segment for offer effectiveness.  
  - The **18-29 age group has lower revenue participation (~$150K total transactions)** and a **net sales revenue of $58.1K**, indicating lower engagement compared to older groups.  
  - The **view and completion rates** for **customers aged 50-79 are significantly higher** than younger groups, with engagement peaking in the **50-69 range**.  

- **Income Group Insights:**  
  - **Mid-to-high income customers ($60K-$120K)** drive the highest **net sales revenue (~$90K-$110K per group)** and **show strong engagement across offer types**.  
  - **Lower-income groups (<$40K) have a lower total revenue contribution (~$60K) and lower engagement rates**, suggesting a different response to offers.  
  - The **highest engagement rates are observed in the $80K-$100K range**, where completion rates and net revenue contributions peak.  

- **Marketing Channel Effectiveness:**  
  - **Offers delivered via web and email** drive the **highest view rates (~67%)**, suggesting strong initial engagement.  
  - **Mobile and social channels have stronger completion rates (~50-61%)**, indicating that **customers who engage via these channels are more likely to redeem offers**.  
  - Offers **delivered across multiple channels (web, email, mobile, social) show the highest engagement (~67% view rate, ~58% completion rate)**, compared to **email-only offers (50% completion rate)**.  

By analyzing these insights, Maven Cafe can better understand **how different promotional strategies impact customer engagement and revenue across various segments**.




![image](https://github.com/user-attachments/assets/3989e4d9-adbf-429d-b5a8-256e2d73b07d)

