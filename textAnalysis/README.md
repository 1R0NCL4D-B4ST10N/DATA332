# Consumer Complaints Sentiment Analysis

## Overview
This project analyzes consumer complaints using sentiment analysis. We utilize **Bing** and **NRC** sentiment lexicons and visualize the results through various charts, including **sentiment distribution plots** and a **word cloud of issues**.

## Dataset Information
The dataset contains consumer complaints with various details, including:
- **Date received**
- **Product category**
- **Issue and sub-issue**
- **Consumer complaint narrative** (the main textual data for sentiment analysis)

## Data Cleaning Process
Before analysis, the following preprocessing steps were performed:
1. **Dropped unnecessary columns** to retain only essential information.
2. **Filtered out missing complaint narratives**, as they are required for text-based sentiment analysis.
3. **Converted date values** into a proper format.
4. **Tokenized words**, converted to lowercase, and removed stopwords to clean the textual data.

## Sentiment Analysis Approach
Two sentiment lexicons were applied:

### 1. Bing Lexicon
- Categorizes words as **positive** or **negative**.
- Used to determine overall complaint sentiment.
- Implemented using `tidytext::get_sentiments("bing")`.

### 2. NRC Lexicon
- Identifies emotions such as **anger, joy, sadness, fear, trust, and anticipation**.
- Provides deeper insights into the emotions behind consumer complaints.
- Implemented using `tidytext::get_sentiments("nrc")`.

## Data Visualizations
### 1. **Sentiment Bing**
- **Purpose:** Shows the overall distribution of positive and negative sentiment in consumer complaints.
- **Value:** Helps identify trends in consumer dissatisfaction and satisfaction.
![bing_sentiment](https://github.com/user-attachments/assets/9757f3eb-5224-41c2-b4ff-f5b6e286aeeb)

### 2. **Word Cloud of Issues**
- **Purpose:** Highlights the most frequently reported issues in consumer complaints.
- **Value:** Provides insights into which topics consumers report the most, helping prioritize areas of concern.
![wordcloud](https://github.com/user-attachments/assets/fa0a5cde-2626-4d69-9d4c-bf8b2c601adc)

### 3. **Sentiment NRC**
- **Purpose:** Shows more specific distribution of sentiments in consumer complaints
- **Value:** Helps identify more specific sentiments.
![nrc_sentiment](https://github.com/user-attachments/assets/3e4994dd-c6e5-44ed-8732-4ba76bb48f39)


## R Script Documentation
The **R script** follows these steps:
1. **Load and clean data** using `tidyverse`.
2. **Tokenize complaint narratives**, remove stopwords, and normalize text.
3. **Perform sentiment analysis** using `tidytext` and lexicons (`bing`, `nrc`).
4. **Aggregate sentiment counts** and summarize them by category.
5. **Visualize sentiment distributions** using `ggplot2`.
6. **Generate a word cloud** of the most reported consumer issues.

## File Structure
```
├── README.md  # Documentation (this file)
├── textAnalysis.R  # R script for sentiment analysis
├── images/  # Visualizations (charts, word cloud)
├── bing_sentiment.csv  # Processed sentiment data (Bing)
├── nrc_sentiment.csv  # Processed sentiment data (NRC)
├── sentiment_by_product.csv  # Aggregated sentiment by product category
```

## How to Run the Analysis
1. Install required libraries:
   ```r
   install.packages(c("tidyverse", "tidytext", "ggplot2", "wordcloud", "RColorBrewer"))
   ```
2. Set your working directory in the R script:
   ```r
   setwd("your/directory/path")
   ```
3. Download the Consumer_Complaints.csv and put it in the directory.
4. Run the R script:
   ```r
   source("textAnalysis.R")
   ```
5. View charts in the `images/` folder or to the side.

---
*Note: The project structure and requirements may change based on refinements.*

