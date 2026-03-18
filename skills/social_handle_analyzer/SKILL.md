# Skill: social_handle_analyzer

## Description
This skill extracts digital footprint markers from social media handles (LinkedIn/X). It is used by the Librarian agent to gather raw data and by the Momus agent to feed the personality prediction pipeline.

## Parameters
- `handle`: The social media handle to analyze (e.g., "@test_user").
- `platform`: The platform to scrape (LinkedIn, X, Reddit).
- `limit`: The number of recent posts/activities to extract (default: 10).

## Output
Returns a structured object containing:
- `raw_text`: Aggregated text from recent posts.
- `metadata`: Engagement levels, frequency, and platform-specific markers.
- `status`: Success or failure of the scraping operation.

## Example Usage
```json
{
  "handle": "@elonmusk",
  "platform": "X",
  "limit": 5
}
```
