// referrals.fsh — the referral family: base + three directional profiles.
//
// Source of requirements: ../openapi.yaml equivalent, i.e.
// ohia-fhirr4-scratchpad/interfaces/openapi.yaml (ODEReferralBase / ODEMedicalToDentalReferral /
// ODEDentalToDentalReferral / ODEDentalToMedicalReferral schemas) — authored fresh against
// that contract, not ported from the scratchpad FSH.
//
// COW conformance: per the 360X<->COW crosswalk (ode-360x-adapter/spec/mapping/360x-cow-crosswalk.md
// §4), these ServiceRequests are what PCC-55 creates alongside the coordination Task
// (ODEReferralTask, out of scope for this build — COW conformance is carried there, not here,
// per CLAUDE.md decision D1: the three directional requests stay parented on US Core).
// What IS in scope here, taken directly from the crosswalk:
//   - the referral-id identifier slice is the 360X<->COW loop key (v2 ORC-2 <-> this identifier)
//   - Request.status lifecycle is constrained to the crosswalk's Table 1 "Request.status" column:
//     active -> completed / revoked (not the full base FHIR request-status value set in practice,
//     though the binding stays open since 360X may not be the only initiator of a build using this IG)
//
// Coding is directional: each referral is coded for the world the RECEIVING clinician acts and
// bills in (openapi.yaml "Unifying coding rule").
// ============================================================================

Profile: ODEReferralServiceRequest
Parent: $ucServiceRequest
Id: ode-referral-servicerequest
Title: "ODE Referral (ServiceRequest)"
Description: "The dental-medical referral order, inheriting US Core ServiceRequest. Per the 360X<->COW crosswalk, this is what a PCC-55 Referral Request (OMG^O19) produces on the FHIR side, alongside the coordination Task. Do not instantiate directly — use one of the three directional profiles."

* identifier 1..* MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier contains referralId 1..1 MS
* identifier[referralId].system = $referralId (exactly)
* identifier[referralId].value 1..1 MS
* identifier[referralId] ^short = "The 360X<->COW loop key: v2 ORC-2 on the wire, this identifier on the FHIR side."

// PUNCHLIST: status binding left at full base request-status rather than a value
// set constrained to {active, completed, revoked}. Reasonable if non-360X
// initiators are expected, wrong if this IG should hard-enforce the crosswalk's
// lifecycle. Needs an explicit decision, not just a comment.
* status MS
* status ^short = "Request.status. Per the 360X<->COW crosswalk (Table 1), the lifecycle this referral actually exercises is active -> completed / revoked; the binding is left at base FHIR request-status (required) rather than further constrained, since a non-360X initiator is not ruled out by this IG."

* intent = #order (exactly)

* category MS

* code 1..1 MS

* reasonCode MS
* reasonCode ^short = "Directional profiles set their own cardinality and coding must-support on this element — see each child profile."

* bodySite MS
* bodySite.extension contains ODETooth named tooth 0..1 MS
* bodySite ^short = "Carries the ode-tooth extension for tooth-specific referrals. Required (1..*, tooth 1..1 MS) on ODEDentalToDentalReferral; should-support elsewhere."

* subject 1..1 MS
* subject only Reference($ucPatient)

* requester MS
* requester only Reference($ucPractitioner or $ucPractitionerRole or $ucOrganization)

// PUNCHLIST: supportingInfo target types are Condition/DocumentReference only. The
// 360X<->COW crosswalk routes the medication list and allergies through
// supportingInfo too (-> ODEMedicationList, AllergyIntolerance) and Condition
// through reasonReference instead. This profile has no reasonReference element at
// all (openapi.yaml's ODEReferralBase schema doesn't declare one either) — real
// discrepancy between the OpenAPI contract and the crosswalk, not resolved here.
* supportingInfo MS
* supportingInfo only Reference($ucCondition or $ucDocRef)
* supportingInfo ^short = "Directional profiles set their own cardinality on this element — see each child profile."


Profile: ODEMedicalToDentalReferral
Parent: ODEReferralServiceRequest
Id: ode-medical-to-dental-referral
Title: "ODE Medical-to-Dental Referral"
Description: "A referral originating in a medical system. Medical billing codes are must-support so the dentist need not look them up or run a CDT crosswalk: reasonCode is ICD-10-CM, and any requested service is CPT/HCPCS. CDT is NOT must-support in this direction. Tooth is should-support — the medical sender often will not know it. Imaging follows as a separate push after this referral (medical-side receivers expose no inbound pull) — see the Attachments interface, not modeled by this profile."

* reasonCode 1..* MS
* reasonCode ^slicing.discriminator.type = #value
* reasonCode ^slicing.discriminator.path = "coding.system"
* reasonCode ^slicing.rules = #open
* reasonCode contains icd10 1..* MS
* reasonCode[icd10].coding.system = $icd10cm (exactly)

* code 1..1 MS
* code.coding ^slicing.discriminator.type = #value
* code.coding ^slicing.discriminator.path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains cpt 0..* MS and hcpcs 0..* MS
* code.coding[cpt].system = $cpt (exactly)
* code.coding[hcpcs].system = $hcpcs (exactly)

* bodySite ^short = "SHOULD support — the medical sender often will not know the tooth."

* supportingInfo 1..* MS
* supportingInfo ^short = "MS: referral/clinical note. Imaging is NOT embedded here — it follows as a separate push after this referral."


Profile: ODEDentalToDentalReferral
Parent: ODEReferralServiceRequest
Id: ode-dental-to-dental-referral
Title: "ODE Dental-to-Dental Referral"
Description: "A dentist-to-dentist referral. CDT is the working vocabulary and is must-support on the requested service. SNODENT is should-support for diagnostic/clinical granularity — modeled as an optional (non-MS) slice documented as SHOULD, because FHIR has no native should-support flag. No medical codes are required. Supporting imaging uses support-a-pull (receiver retrieves it) — see the Attachments interface, not modeled by this profile."

* code 1..1 MS
* code.coding ^slicing.discriminator.type = #value
* code.coding ^slicing.discriminator.path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains cdt 1..* MS and snodent 0..*
* code.coding[cdt].system = $cdt (exactly)
* code.coding[snodent].system = $snodent (exactly)
* code.coding[snodent] ^short = "SHOULD support — SNODENT diagnostic/clinical detail (optional slice, not MS)."
* code.coding[snodent] ^comment = "Senders SHOULD populate SNODENT when available; receivers MUST NOT reject a referral that omits it. Represented as a non-must-support slice because FHIR's only conformance flag is Must Support."

* bodySite 1..* MS
* bodySite.extension[tooth] 1..1 MS
* bodySite ^short = "MS, REQUIRED: the tooth (ode-tooth) — you cannot extract 'a tooth'."

* reasonCode MS

* supportingInfo MS
* supportingInfo ^short = "MS: clinical note; periodontal charting when perio-relevant. Supporting imaging is referenced elsewhere; the receiver retrieves it via support-a-pull, not in the initial submission."


Profile: ODEDentalToMedicalReferral
Parent: ODEReferralServiceRequest
Id: ode-dental-to-medical-referral
Title: "ODE Dental-to-Medical Referral"
Description: "A dentist refers to a physician (e.g. AI sleep-apnea screening to sleep medicine). The physician acts and bills medically, so medical codes are must-support and CDT is not; SNODENT is should-support to preserve the dental finding. The screening/finding result that motivated the referral is must-support in supportingInfo. Imaging follows as a separate push after this referral (medical-side receivers expose no inbound pull)."

* reasonCode 1..* MS
* reasonCode ^slicing.discriminator.type = #value
* reasonCode ^slicing.discriminator.path = "coding.system"
* reasonCode ^slicing.rules = #open
* reasonCode contains icd10 1..* MS
* reasonCode[icd10].coding.system = $icd10cm (exactly)

* code 1..1 MS
* code.coding ^slicing.discriminator.type = #value
* code.coding ^slicing.discriminator.path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains cpt 0..* MS and hcpcs 0..* MS and snodent 0..*
* code.coding[cpt].system = $cpt (exactly)
* code.coding[hcpcs].system = $hcpcs (exactly)
* code.coding[snodent].system = $snodent (exactly)
* code.coding[snodent] ^short = "SHOULD support — SNODENT preserves the dental finding/origin (optional slice, not MS)."

* supportingInfo 1..* MS
* supportingInfo ^short = "MS, REQUIRED: the screening/finding result that motivated the referral, plus the clinical note. Supporting imaging (if any) follows as a separate push after this referral, not embedded here."
