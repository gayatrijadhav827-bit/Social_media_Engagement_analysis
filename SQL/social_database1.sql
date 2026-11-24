CREATE DATABASE social_media_analysis;
USE social_media_analysis;

CREATE TABLE social_posts (
    post_id VARCHAR(50) PRIMARY KEY,
    timestamp DATETIME,
    day_of_week VARCHAR(20),
    platform VARCHAR(50),
    user_id VARCHAR(50),
    location VARCHAR(100),
    language VARCHAR(20),
    text_content TEXT,
    hashtags TEXT,
    mentions TEXT,
    keywords TEXT,
    topic_category VARCHAR(100),
    sentiment_score FLOAT,
    sentiment_label VARCHAR(30),
    emotion_type VARCHAR(50),
    toxicity_score FLOAT,
    likes_count INT,
    shares_count INT,
    comments_count INT,
    impressions INT,
    engagement_rate FLOAT,
    brand_name VARCHAR(100),
    product_name VARCHAR(100),
    campaign_name VARCHAR(100),
    campaign_phase VARCHAR(50),
    user_past_sentiment_avg FLOAT,
    user_engagement_growth FLOAT,
    buzz_change_rate FLOAT
);

