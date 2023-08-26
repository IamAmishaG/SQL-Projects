# Nashville Housing Dataset Cleaning and Preparation

This dataset, sourced from Kaggle.com, required thorough cleaning and preparation to ensure its suitability for analysis. The following steps were undertaken using SQL to achieve this:

## Data Cleaning with SQL Functions

A variety of SQL functions were employed to clean and refine the Nashville Housing Dataset. These functions facilitated the process of transforming raw data into a structured and usable format. DDL (Data Definition Language) and DML (Data Manipulation Language) commands were utilized in queries to carry out the cleaning process.

## Addressing Missing Values

Handling missing values is crucial for accurate analysis. In this project, missing values in the dataset were addressed using a combination of techniques. String split functions and trim functions were employed to extract and standardize data from other columns, specifically focusing on addresses. By updating records with appropriate values, the dataset's integrity was maintained.

## Duplicate Records Identification and Removal Using CTEs

Common Table Expressions (CTEs) were leveraged to identify and eliminate duplicate records. Duplicate entries can distort analysis results and lead to erroneous conclusions. Through CTEs, a systematic approach was implemented to detect duplicates and subsequently remove them from the dataset.

## Removal of Unused Columns

To streamline the dataset and focus on relevant information, unused columns were removed. This decluttering process was executed after ensuring that the essential data had been extracted and refined. By trimming away unnecessary columns, the dataset's overall usability and efficiency were enhanced.

## Conclusion

By effectively managing and preparing the dataset, the stage is set for in-depth exploration, data-driven decision-making, and the discovery of valuable trends and patterns within the Nashville housing market.
