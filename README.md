# Cafe-Promotions-Analysis

## Project Background

Maven Cafe, a neighborhood coffee shop, has built a loyal customer base across various age groups. In 2024 August, they launched a new loyalty program featuring a reward system to incentivize purchases. The member customers receive promotional offers, including buy-one-get-one (bogo) offers and discount offers, through multiple channels such as web, email, mobile, and social media. These offers can be redeemed within a limited time, and customers who complete a promotional offer by making a qualifying transaction receive the associated reward. Each customer receives a different mix of offers, attempting to maximize their probability of making a purchase. There are also informational offers, simple advertisement of a product.

Maven aims to refine its promotional strategy to drive customer engagement and increase sales. As an Data Analyst at Maven Cafe, I am collaborating with the marketing team to extract data-driven insights and deliver recommendations for providing more effective promotional offers to improve customer participation and sales contribution. 

Insights and recommendations are provided on the following key areas:

- __Sales Trends Analysis__: Evaluation of historical sales patterns, focusing on offer participation and offer types.
- __Promotional Offer Performance Analysis__: An analysis of bogo and discount offer performance, including customer engagement, sales and net sales performance, and comparison of different offers.
- __Customer Segment Analysis__: An evaluation of sales, offer completion, and marketing channel performance across different age and income segments to identify targeted customers.

An interactive Tableau dashboard can be found here[].

The SQL queries utilized to prepare data for the dashboard can be found here[].


## Dataset Structure

The dataset consisted of three tables, including customers, events_normalized, and offers, with a total row counts of 323,543. 
  1. _customers_: This dataset includes demographic information such as customer id, membership start date, age, gender, and income.
     
  2. _events_normalized_: This dataset tracks customer interactions. The data includes event (transactions, offers received, offers viewed, or offers completed), offer type (bogo, discount, or informational), transaction amounts, reward, and time.
     
  3. _offers_: This data shows details of all kinds of offers, including the offer id, offer type, difficulty (minimum amount required to spend in order to be able to complete the offer), reward, duration (days a customer has to complete the offer once they have received it), and marketing channels used. 

## Executive Summary
The promotional offer analysis provides key insights into customer engagement and sales performance. Discount offers generate 28.3% higher net sales than bogo offers, making them the strongest sales driver, while bogo offers also maintain high engagement. Customers aged 50-69 and mid-income ($60K-$100K) groups exhibit the highest offer participation and sales contribution, presenting an opportunity for targeted marketing strategies. Multi-channel marketing achieves the highest engagement and completion rates, emphasizing the importance of diversified outreach. Optimizing offer structures, enhancing offers to targeted consumers, and utilizing multi-channel marketing will enhance customer participation and maximize profitability.

## Insights Deep-Dive
### Overall Sales Trends
 - Transactions with offers drive a significant portion of sales ($744,309, 41.92%), particularly through discount and bogo promotions.
 - Discount offers contribute the highest total sales ($293,358), slightly outperforming bogo offers ($275,922).
 - The share of sales from offers has increased over time, suggesting growing adoption and impact of promotional strategies.

![image](https://github.com/user-attachments/assets/db0ec736-800a-4a7c-9396-3774b77cdac7)

### Promotional Offer Performance
- **Offer Engagement and Completion Rates:**

  - Bogo offers with low difficulty and rewards had a higher completion rate of 57%, indicating the low minimum amount required works as a strong incentive for customers to redeem the offer.
  - Two specific discount offers, (one with difficulty:7, reward:3, duration:7, and another with difficulty:10, reward:2, duration:10) achieved the highest view rate at 96% and completion rates between 67% and 70%, demonstrating high engagement and strong conversion.
  - Regardless of the offer types, offers with the highest difficulty and reward have not seen conversion success, with completion rates among 44% to 48%.

- **Sales & Net sales Performance:**
  
  - Among bogo offers, the one with low difficulty, reward, and duration generate the highest net sale at $81,168. While offers with a difficulty of 10 and a reward of 10 achieved high total sales and average sales per transaction, the high reward costs led to a relatively lower net sales.
  - Despite having a low average sales, the discount offer with difficulty:10, reward:2, duration:10 achieved $106,523 in net sales, making it the strongest sales driver.  

![image](https://github.com/user-attachments/assets/f2a320ec-2cfb-4ebc-9460-66020d4e4a4f)


### Customer Segment

- **Age Group Insights:**  
  - Customers aged 50-79 exhibit a higher sales contribution at $1,053,794, with 49% of it generated through offer completion and net sales from offers exceeding $100K per group.
  - The view and completion rates for customers aged 50-79 are significantly higher than those in the 18-29 age group, with view rates over 75% and completion rates over 63%.

- **Income Group Insights:**  
  - Mid income customers ($60K-$100K) drive the highest total transaction amounts, offer sales, and net sales (~$195K-$200K per group).
  - Over half of transactions (51%-55%) by customers with income between 80K and 120K are completed using offers, indicating high engagement and promotional offer adoption within this segment.

- **Promotional Offer Type Preference:**
  - Bogo and discount offers show similar trends in customer engagement and sales contributions, with mid-age customers (50-69) and mid-income ($60-100K) customers being the most responsive.
  - Customers aged 50-69 contribute the highest net sales for both bogo and discount offers among all age groups. Due to the high reward costs of bogo offers, while discount offer completions are only 8.6%-15% higher than bogo, their net sales is 20.9%-34.7% higher.
  - Mid-income customers ($60K-$100K) drive the highest total net sales for both bogo and discount offers. However, due to differences in average transaction amounts, while offer completions in the $60K-$80K group are 49.5% higher than those in the $80K-$100K group, their net sales is only 2.7% higher.

- **Marketing Channel Effectiveness:**  
  - Offers delivered via [web, email, mobile, social] and [email, mobile, social] drive the highest view rates (96% and 89%), indicating strong initial engagement.  
  - The [web, email, mobile, social] channel combination achieves the highest completion rate at 67%.
  - Overall, offers delivered across multiple channels, especially those including mobile and social, show higher engagement and completion rates. 

![image](https://github.com/user-attachments/assets/bc4fd599-6b5b-405b-9889-28e9a0e4af1c)


## Recommendations
### Promotional Offer Structure
1. Expand Effective Discount Offers: Discount offers with difficulty:10, reward:2, duration:10 showed the highest net sales ($106,523), and Bogo offers with low difficulty and rewards generated the highest completion rates bogo offers. Increasing the availability of similar low-reward offers could further boost sales.
2. Increase the Share of Discount Offers: Discount offers generated 28.3% higher net sales than bogo offers. Allocating more promotions toward discount offers could improve overall profitability.
3. Refine Bogo Offer Settings: While bogo offers achieve strong total sales, high reward costs have led to significantly lower net sales. Adjusting reward structures could help preserve engagement while improving profitability.

### Targeted Customer Segments
1. Focus on Mid-Age (50-69) Customers: Customers aged 50-69 contributed the highest net sales ($331K) and exhibited higher engagement (completion rates >63%). Providing more targeted offers and tailoring promotions to their preferences could drive sales growth.
2. Target Mid-Income ($60K-$100K) Customers: These customers drove the highest net sales (~$195K-$200K per group), making them a key segment for promotional targeting. Expanding targeted offers for this group could maximize sales.
3. Toilor offers for different segments: While the $60K-$80K group had 49.5% more offer completions than the $80K-$100K group, their net sales was only 2.7% higher, indicating two opportunities: 1) Encourage higher spending per transaction through strategic offer designs for $60K-$80K group; 2) Boost engagement among the $80K-$100K group by personalized marketing efforts to increase offer participation rates.

### Multi-Channel Marketing
1. Expand Multi-Channel Offer Delivery: Offers sent through [web, email, mobile, social] had the highest view rate (96%) and completion rate (67%). Prioritizing multi-channel distribution will enhance offer visibility and conversions.
2. Segment Multi-Channel Targeting: Tailor channel preferences by customer groups. Senior customers (50-69) may respond better to email and web offers, while younger and mid-income customers ($60K-$100K) are more engaged with mobile and social channels. Use A/B testing to analyze performance and refine which offer types perform best on each channel.

## Assumptions and Caveats
Throughout the analysis, multiple assumptions were made to manage challenges with the data. These assumptions and caveats are noted below:

  1. The original events dataset contained a "value" column that stored multiple types of information in a dictionary format. For clarity and ease of analysis, I used Python to separate these mixed values into distinct columns: amount, offer_id, and reward. The script used for this transformation can be found [here](event_normalization.py).
  2. Every purchase is marked as a transaction, regardless of offer participation. For a transaction to be attributed to an offer, it must occur at the same time as when the offer was "completed" by the customer. As recorded in the events dataset, a customer can complete more than one offer by a single transaction.
  3. Events related to informational offers only include offer received and offer viewed. For the calculation of sales generated by informational offers, a transaction occurring after an offer is viewed and within the offer’s duration is considered to have been influenced by the offer and is counted as completed by the offer.
