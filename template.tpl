___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "AB Split Test - Send Conversion",
  "brand": {
    "id": "brand_dummy",
    "displayName": "AB Split Test"
  },
  "description": "Sends a conversion or goal event from Google Tag Manager back to the AB Split Test WordPress plugin via AJAX.",
  "containerContexts": [
    "WEB"
  ],
  "categories": [
    "ANALYTICS",
    "EXPERIMENTATION"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "siteUrl",
    "displayName": "WordPress Site URL",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "help": "The root URL of your WordPress site (e.g. https://example.com). No trailing slash."
  },
  {
    "type": "TEXT",
    "name": "experimentId",
    "displayName": "Experiment ID",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "help": "The AB Split Test experiment ID (eid). Can be a GTM variable."
  },
  {
    "type": "SELECT",
    "name": "conversionType",
    "displayName": "Conversion Type",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "conversion",
        "displayValue": "Conversion"
      },
      {
        "value": "goal",
        "displayValue": "Goal"
      },
      {
        "value": "visit",
        "displayValue": "Visit"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "conversion",
    "help": "Type of event to log in AB Split Test."
  },
  {
    "type": "TEXT",
    "name": "trackerSource",
    "displayName": "Location / Source",
    "simpleValueType": true,
    "defaultValue": "gtm",
    "help": "Identifies where the event originated. Default is gtm."
  },
  {
    "type": "TEXT",
    "name": "orderValue",
    "displayName": "Order Value (optional)",
    "simpleValueType": true,
    "help": "Numeric value for revenue-tracking experiments. Leave blank if not used."
  },
  {
    "type": "TEXT",
    "name": "advancedId",
    "displayName": "Advanced ID / UUID (optional)",
    "simpleValueType": true,
    "help": "abuuid or advanced tracking ID for fingerprint matching. Can be a GTM variable."
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// AB Split Test - Send Conversion Template
// Posts conversion events back to WordPress via AJAX

const callInWindow = require('callInWindow');
const jsonLib = require('JSON');
const log = require('logToConsole');

const siteUrl = data.siteUrl || '';
const eid = data.experimentId || '';
const trackerSource = data.trackerSource || 'gtm';
const orderValue = data.orderValue || '';
const advancedId = data.advancedId || '';

if (!siteUrl || !eid) {
  log('AB Split Test Send Conversion: siteUrl and experimentId are required');
  data.gtmOnFailure();
  return;
}

// Build the endpoint with method=beacon so WordPress reads the JSON body
const endpoint = siteUrl + '/wp-admin/admin-ajax.php?action=abst_event&method=beacon';

// Build payload
const payload = {
  eid: eid,
  type: data.conversionType || 'conversion',
  location: trackerSource
};

if (orderValue) {
  payload.orderValue = orderValue;
}

if (advancedId) {
  payload.ab_advanced_id = advancedId;
}

// Send as JSON POST using the browser's fetch API
const requestBody = jsonLib.stringify(payload);

log('AB Split Test: sending conversion to', endpoint);

const promise = callInWindow('fetch', endpoint, {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: requestBody,
  keepalive: true
});

if (promise && promise.then) {
  promise.then(function(response) {
    if (response && response.ok) {
      data.gtmOnSuccess();
    } else {
      log('AB Split Test: conversion failed with status', response && response.status);
      data.gtmOnFailure();
    }
  }).catch(function() {
    data.gtmOnFailure();
  });
} else {
  data.gtmOnSuccess();
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []
setup: ''


___NOTES___

User Notes: This template sends conversion, goal, or visit events from Google Tag Manager back to the AB Split Test WordPress plugin.


___TERMS_OF_SERVICE___

By using this template, you agree to the terms of service available at https://github.com/SiteSpot/gtm-template-ab-split-test-send-conversion
