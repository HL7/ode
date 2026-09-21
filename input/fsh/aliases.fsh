// aliases.fsh — global aliases for the ODE IG (SUSHI aliases are project-wide).
// Scope note: only what the referral profiles (base + 3 directional) and their
// tooth extension need. No CARIN Blue Button, no claims aliases — that profile
// family is not part of this build.

Alias: $cdt          = http://www.ada.org/cdt
Alias: $snodent      = http://www.ada.org/snodent
Alias: $tooth        = http://terminology.hl7.org/CodeSystem/ADAUniversalToothDesignationSystem
Alias: $icd10cm      = http://hl7.org/fhir/sid/icd-10-cm
Alias: $cpt          = http://www.ama-assn.org/go/cpt
// HCPCS Level II — carries procedure codes AND modifiers. DEFINITIVE: this is the
// Official URL on the HL7 THO CodeSystem `hcpcs-Level-II` (v1.0.2, OID
// 2.16.840.1.113883.6.285). Note it is http://, NOT https:// — THO corrected this
// 2023-11-13 ("Fix technical error with HCPCS uri", JIRA UP-472). Do not "normalize"
// to https://; FHIR system URIs are exact-match strings.
Alias: $hcpcs        = http://www.cms.gov/Medicare/Coding/HCPCSReleaseCodeSets

Alias: $loinc        = http://loinc.org

// ODE referral identifier system — the 360X<->COW loop key (ORC-2 on the v2 side).
Alias: $referralId   = urn:ohia:referral-id
Alias: $taskcode     = http://hl7.org/fhir/CodeSystem/task-code
Alias: $smart        = http://terminology.hl7.org/CodeSystem/restful-security-service

// COW — the referral Task's parent. Everything else in this IG stays on US Core;
// Task is one of the two ODE classes that don't (List is the other, see ODEMedicationList).
Alias: $cowTask      = http://hl7.org/fhir/uv/cow/StructureDefinition/coordination-task

// US Core 6.1.0 profiles (reused, not redefined). The three directional referral
// profiles stay parented on US Core ServiceRequest — COW conformance is carried by
// the referral Task (ODEReferralTask), not the request.
Alias: $ucServiceRequest = http://hl7.org/fhir/us/core/StructureDefinition/us-core-servicerequest
Alias: $ucPatient        = http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient
Alias: $ucPractitioner   = http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner
Alias: $ucPractitionerRole = http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole
Alias: $ucOrganization   = http://hl7.org/fhir/us/core/StructureDefinition/us-core-organization
Alias: $ucCondition      = http://hl7.org/fhir/us/core/StructureDefinition/us-core-condition-problems-health-concerns
Alias: $ucDocRef         = http://hl7.org/fhir/us/core/StructureDefinition/us-core-documentreference
Alias: $ucMedReq         = http://hl7.org/fhir/us/core/StructureDefinition/us-core-medicationrequest
Alias: $ucEncounter      = http://hl7.org/fhir/us/core/StructureDefinition/us-core-encounter
Alias: $ucObs            = http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-clinical-result
Alias: $ucDiagReportNote = http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-note
