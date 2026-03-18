# Skill: crm_integrator

## Description
This skill synchronizes lead data and win-loss records between the ASO and external CRMs (Salesforce, HubSpot). Used by Hephaestus for metrics tracking and pipeline hygiene.

## Parameters
- `action`: The operation to perform (e.g., "get_leads", "update_status", "sync_closed_lost").
- `filters`: Optional filters for data retrieval (e.g., date ranges, deal stages).
- `payload`: Data for write/update operations.

## Output
Returns sync status and retrieved data objects.

## Example Usage
```json
{
  "action": "sync_closed_lost",
  "filters": { "timeframe": "last_week" }
}
```
