# AB Split Test - Send Conversion

This folder is a draft standalone GitHub repository for the Google Tag Manager Community Template Gallery submission of the `AB Split Test - Send Conversion` template.

## Where this goes

Copy the contents of this folder into its own public GitHub repository root:

- `template.tpl`
- `metadata.yaml`
- `LICENSE`
- `README.md`

Suggested repository name:

- `gtm-template-ab-split-test-send-conversion`

## Template identity

- **Display name**: AB Split Test - Send Conversion
- **Type**: Tag Template
- **Categories**: `ANALYTICS`, `EXPERIMENTATION`

## Template purpose

This template sends a conversion or goal event from Google Tag Manager back to the AB Split Test WordPress plugin.

Recommended endpoint shape:

- `https://example.com/wp-admin/admin-ajax.php?action=abst_event&method=beacon`

Recommended payload shape:

```json
{
  "eid": 123,
  "type": "conversion",
  "location": "gtm",
  "orderValue": 1,
  "ab_advanced_id": "visitor-id"
}
```

## Template fields

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `siteUrl` | Text | *(required)* | WordPress site root URL (no trailing slash) |
| `experimentId` | Text | *(required)* | AB Split Test experiment ID (eid) |
| `eventType` | Select | `conversion` | `conversion`, `goal`, or `visit` |
| `location` | Text | `gtm` | Source identifier |
| `orderValue` | Text | *(empty)* | Revenue value for tracking |
| `advancedId` | Text | *(empty)* | abuuid / advanced tracking ID |

## Recommended use cases

- call tracking conversions
- CRM qualified leads
- third-party form completions
- delayed or offsite conversion events

## Submission checklist

- [ ] Copy this folder into its own public GitHub repository root
- [ ] Update `metadata.yaml` SHA after first commit in the standalone repo
- [ ] Keep `LICENSE` as Apache 2.0 only
- [ ] Ensure GitHub issues are enabled
- [ ] Submit to Google Community Template Gallery
