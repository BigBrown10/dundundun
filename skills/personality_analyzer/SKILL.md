# Skill: personality_analyzer

## Description
This skill processes raw text and digital footprints to predict psychological profiles using the Big Five (OCEAN) and DISC frameworks.

## Parameters
- `text`: The aggregated raw text from a prospect's social activity.
- `context`: Optional context about the prospect's role (e.g., "CISO", "Founder").

## Output
Returns a detailed personality profile:
- `big_five`: Scores (0-1) for Openness, Conscientiousness, Extraversion, Agreeableness, and Neuroticism.
- `disc`: Dominance, Influence, Steadfastness, Conscientiousness markers.
- `confidence`: $R^2$ equivalent confidence score.
- `strategy`: Recommended communication strategy based on the profile.

## Example Usage
```json
{
  "text": "Innovation is our primary driver. We focus on ROI and precision.",
  "context": "Sales Leader"
}
```
