// clinical.fsh — supporting content that rides with or after a referral.
// Authored fresh against the OpenAPI schemas (ODEMedicationList, ODEEncounter,
// ODEDiagnosticReport, ODEObservation, ODEIntraoralPhotoDocumentReference) plus
// ODEReferralDocumentReference, which the OpenAPI paths reference by canonical URL
// ($submit-attachment example, the DocumentReference read path) without giving it
// its own named schema. All inherit US Core except ODEMedicationList (base FHIR
// List — US Core has no List profile; this is the second of the two ODE classes
// that don't inherit US Core, the other being ODEReferralTask).
// ============================================================================

Profile: ODEReferralDocumentReference
Parent: $ucDocRef
Id: ode-referral-documentreference
Title: "ODE Referral DocumentReference (supporting data / imaging)"
Description: "Supporting documents and images for a referral. Used both as a support-a-pull target (dental->dental: GET /DocumentReference/{id}) and as the resource carried in a $submit-attachment push (medical-side receivers). content.attachment.data carries small inline bytes; content.attachment.url is a retrievable pointer (FHIR Binary, or an ImagingStudy/WADO-RS endpoint for DICOM). Large DICOM must use ImagingStudy + WADO-RS, never inline bytes."
* category MS
* type MS
* content 1..* MS
* content.attachment MS
* content.attachment.contentType 1..1 MS
* content.attachment.data MS
* content.attachment.url MS
* context MS


Profile: ODEIntraoralPhotoDocumentReference
Parent: $ucDocRef
Id: ode-intraoral-photo-documentreference
Title: "ODE Intraoral Photo DocumentReference (patient-submitted)"
Description: "A patient-submitted, non-radiographic intraoral photograph, conveyed inline with a dental->dental referral submission (POST / supportingInfo) and retrievable at GET /DocumentReference/{id}. Modeled as US Core DocumentReference rather than R4 Media, per the OpenAPI contract's own rationale: Media is removed in R5/R6 while DocumentReference is stable, and US Core has no Media profile. This is explicitly NOT the DICOM radiograph path (ImagingStudy + WADO-RS). R4 DocumentReference has no bodySite element, so the affected tooth is correlated via a companion ODEObservation (bodySite = tooth + derivedFrom -> this DocumentReference)."
* category MS
* category ^short = "Clinical photography (patient-submitted image)."
* type MS
* type = $loinc#72170-4
* type ^short = "LOINC 72170-4 Photographic image (should-populate; extensible binding, not fixed, since the OpenAPI contract states this is SHOULD not MS)."
* content 1..* MS
* content.attachment MS
* content.attachment.contentType 1..1 MS
* content.attachment.contentType = #image/jpeg
* content.attachment.data MS
* content.attachment.url MS
* author MS
* author only Reference($ucPatient or $ucPractitioner or $ucPractitionerRole or $ucOrganization)
* author ^short = "Patient-authored for patient-submitted photos; the capturing app/provider may also be recorded."
* context MS
* context.encounter MS
* context.encounter ^short = "The virtual (teledentistry) encounter the photo was captured during."


// PUNCHLIST: entry.item is constrained to $ucMedReq only. The OpenAPI contract's
// ODEMedicationList description mentions MedicationStatement accepted "where a
// source system conveys patient-reported history that way" — dropped here for a
// tighter, single-target reference rather than silently carrying it forward. If a
// real source system needs MedicationStatement, this needs to be reopened, not
// assumed closed.
Profile: ODEMedicationList
Parent: List
Id: ode-medication-list
Title: "ODE Medication List"
Description: "A point-in-time medication list conveyed with a referral so the receiving clinician has the patient's current medications before the encounter. Inherits base FHIR List (US Core has no List profile) — one of the two ODE classes that don't inherit US Core, the other being ODEReferralTask. Entries reference US Core MedicationRequest (ordered, or patient-reported via reportedBoolean)."
* status = #current (exactly)
* mode = #snapshot (exactly)
* code 1..1 MS
* code = $loinc#10160-0
* subject 1..1 MS
* subject only Reference($ucPatient)
* date MS
* source MS
* entry MS
* entry.item 1..1 MS
* entry.item only Reference($ucMedReq)


Profile: ODEEncounter
Parent: $ucEncounter
Id: ode-encounter
Title: "ODE Encounter"
Description: "A visit within a referral episode, inheriting US Core Encounter. basedOn links the visit back to the originating referral. Created via POST /Encounter directly, or as part of an interim-content bundle via $append-interim. NOTE: FHIR R4 Encounter has no `note` element — an informal inter-provider information request belongs on Task.note or Observation.note, never invented here."
* status MS
* class MS
* subject 1..1 MS
* subject only Reference($ucPatient)
* basedOn MS
* basedOn only Reference(ODEReferralServiceRequest)
* basedOn ^short = "Reference to the originating referral ServiceRequest."


Profile: ODEDiagnosticReport
Parent: $ucDiagReportNote
Id: ode-diagnosticreport
Title: "ODE Diagnostic Report"
Description: "A diagnostic report arising during a referral episode, inheriting the US Core DiagnosticReport Note profile. Created via POST /DiagnosticReport directly, or as part of an interim-content bundle via $append-interim."
* status MS
* code 1..1 MS
* subject 1..1 MS
* subject only Reference($ucPatient)
* encounter MS
* encounter only Reference(ODEEncounter)
* conclusion MS


Profile: ODEObservation
Parent: $ucObs
Id: ode-observation
Title: "ODE Observation"
Description: "A clinical finding arising during a referral episode, inheriting US Core Observation Clinical Result. Created via POST /Observation directly, or as part of an interim-content bundle via $append-interim. Where no established code system exists for the finding, use code.text rather than fabricating a coding — the OpenAPI contract's own worked example is site-specific radiation dosimetry for pre-radiation dental clearance."
* status MS
* code 1..1 MS
* code ^comment = "Use code.text (NOT a fabricated coding) where no established code system exists for the finding."
* code.text MS
* subject 1..1 MS
* subject only Reference($ucPatient)
* encounter MS
* encounter only Reference(ODEEncounter)
* value[x] MS
* bodySite MS
* bodySite.extension contains ODETooth named tooth 0..1 MS
* derivedFrom MS
* derivedFrom ^short = "R4 tooth-image correlation: point at the intraoral photo DocumentReference (ODEIntraoralPhotoDocumentReference) this finding is read from."
* derivedFrom ^comment = "Because R4 DocumentReference has no bodySite element, an oral image is bound to a tooth by a companion Observation that carries bodySite (ODETooth) AND derivedFrom -> the photo. A receiver answers 'which tooth is this photo of?' off this Observation, not off the image resource."
* note MS
* note ^short = "Free-text note — e.g. that the value was obtained via an informal inter-provider information request (COW 'letter' pattern) rather than a formal order."
