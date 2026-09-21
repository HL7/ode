// workflow.fsh — the ODE workflow object: ODEReferralTask.
//
// Parented on the real HL7 Clinical Order Workflows (COW) Coordination Task profile
// (hl7.fhir.uv.cow#1.0.0-ballot), per CLAUDE.md decision D1: the three directional
// ServiceRequests stay on US Core; COW conformance is carried here. This is the
// second of the two ODE classes that do not inherit US Core (US Core has no Task
// profile; ODEMedicationList/List is the other, see clinical.fsh).
//
// Element choices are constrained to the subset the 360X<->COW crosswalk (§3,
// "COW subset adopted") actually exercises: status, businessStatus, input, output,
// owner (accepting-provider identity only, no baton-passing), requester, note. The
// crosswalk explicitly puts Task.restriction.period.end and Task.statusReason
// in scope too (accept timeframe / decline reason) — deferred here as a gap since
// the OpenAPI contract's ODEReferralTask schema doesn't surface them yet.
// ============================================================================

Profile: ODEReferralTask
Parent: $cowTask
Id: ode-referral-task
Title: "ODE Referral Task (workflow)"
Description: "The ODE workflow object and single source of truth for referral state, inheriting the HL7 Clinical Order Workflows (COW) Coordination Task profile. Per the 360X<->COW crosswalk, this Task is what a PCC-55 Referral Request produces alongside the referral ServiceRequest, and what the bridge mirrors to/from 360X transactions (PCC-56/57/58/59/60/61) — it never invents state beyond what that crosswalk assigns."

* identifier 1..* MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier contains referralId 1..1 MS
* identifier[referralId].system = $referralId (exactly)
* identifier[referralId].value 1..1 MS
* identifier[referralId] ^short = "The 360X<->COW loop key: v2 ORC-2 on the wire, this identifier on the FHIR side."

// PUNCHLIST: same open-binding call as ODEReferralServiceRequest.status — left at
// full base task-status rather than constrained to the crosswalk's six values.
// Same open question: intentional flexibility, or should this IG enforce it?
* status MS
* status ^short = "Per the crosswalk, this build exercises requested | accepted | in-progress | completed | rejected | cancelled — the full base task-status value set stays bound (required) since COW itself allows more."

// PUNCHLIST: businessStatus is extensible against ODEReferralSubStatusCS, a code
// list this build invented by reading the crosswalk's transaction table, not one
// pulled from an existing authoritative source. Nobody outside this session has
// confirmed these nine codes are the right/complete set — verify against the real
// ode-360x-adapter maintainers before treating this as settled.
* businessStatus MS
* businessStatus from ODEReferralSubStatusVS (extensible)

* intent = #order (exactly)

* code 1..1 MS
* code = $taskcode#fulfill

* focus 1..1 MS
* focus only Reference(ODEReferralServiceRequest)

* for 1..1 MS
* for only Reference($ucPatient)

* requester MS

* owner MS
* owner only Reference($ucPractitionerRole or $ucOrganization or $ucPractitioner)
* owner ^short = "Scoped to the accepting-provider identity only (who accepted on PCC-56 accept) — not full COW baton-passing/reassignment, per the crosswalk's explicit out-of-scope list. Do not populate at initial intake, before a fulfiller has accepted."

* note MS
* note ^short = "Free-text notes, including an informal inter-provider information request — the base COW IG's 'Requesting additional information' pattern (RESTful query / letter / instruction; a note here implements 'letter'). The request itself has no dedicated resource; resulting content attaches via $append-interim."

* input MS
* input ^short = "The referral package on intake (e.g. Condition, MedicationRequest, ODEMedicationList, AllergyIntolerance) — adopted COW scope per the crosswalk §3."

* output MS
* output ^short = "Interim or outcome resources attached as the referral progresses (e.g. via $append-interim) — adopted COW scope per the crosswalk §3."

// PUNCHLIST: Task.restriction.period.end (accept timeframe) and Task.statusReason
// (decline reason) are both explicitly in the crosswalk's adopted COW scope §3 but
// are NOT modeled on this profile, because the OpenAPI contract's ODEReferralTask
// schema doesn't surface them. This is a real gap between the two source documents,
// not a decision — pick one and close it (either add the elements or drop them from
// the crosswalk's claimed scope).
