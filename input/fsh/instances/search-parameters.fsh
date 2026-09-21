// referral-id — the token search parameter used across the OpenAPI contract
// (GET /ServiceRequest, GET /Task, GET /Encounter, GET /Observation, ...) to follow
// a referral end to end by its urn:ohia:referral-id identifier.
//
// NOTE: the OpenAPI contract's Notifications tag (Topic-based Subscriptions on
// ode-referral-status) is deferred here — it requires either the R4B/R5
// SubscriptionTopic resource or the Topic-based Subscriptions Backport package,
// neither of which is a declared dependency of this build. Add the backport
// package and the SubscriptionTopic instance together if that interface is needed.

Instance: ode-referral-id
InstanceOf: SearchParameter
Usage: #definition
* url = "http://hl7.org/fhir/us/ode/SearchParameter/ode-referral-id"
* name = "ODEReferralId"
* status = #draft
* experimental = false
* description = "Search ServiceRequest and Task by the ODE referral identifier (system urn:ohia:referral-id)."
* code = #referral-id
* base[+] = #ServiceRequest
* base[+] = #Task
* type = #token
* expression = "ServiceRequest.identifier.where(system='urn:ohia:referral-id') | Task.identifier.where(system='urn:ohia:referral-id')"
