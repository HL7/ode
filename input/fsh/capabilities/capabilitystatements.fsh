// The API contract — two actors, mirroring the OpenAPI paths this build covers.
// Trimmed relative to the OpenAPI contract: Claims Sharing (ExplanationOfBenefit)
// and Notifications (Subscription/SubscriptionTopic) are not modeled by this build
// — see profiles/clinical.fsh and instances/search-parameters.fsh notes — so they
// are left out of these CapabilityStatements rather than claimed and not delivered.
//
//   ODEReferralRecipientServer : the dental ODE Native FHIR server (and what the
//                                360X bridge drives).
//   ODEReferralInitiatorClient : a medical/dental system (or the bridge on behalf
//                                of a 360X-only EHR) that creates referrals.
// ============================================================================

Instance: ODEReferralRecipientServer
InstanceOf: CapabilityStatement
Usage: #definition
* id = "ode-referral-recipient-server"
* url = "http://hl7.org/fhir/us/ode/CapabilityStatement/ode-referral-recipient-server"
* name = "ODEReferralRecipientServer"
* title = "ODE Referral Recipient / Fulfiller — Server"
* description = "The dental ODE Native FHIR server role: accepts referral transaction Bundles, exposes the ODE workflow Task and ServiceRequest for read/search/update, and serves supporting documents/images. Also what the 360X bridge drives."
* status = #draft
* date = "2026-09-19"
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #json
* format[+] = #xml
* rest.mode = #server
* rest.documentation = "Accepts referral transaction Bundles, exposes the ODE workflow Task and ServiceRequest for read/search/update, and serves supporting documents/images."
* rest.security.service = $smart#SMART-on-FHIR

// system-level: accept the referral as a transaction Bundle
* rest.interaction[+].code = #transaction
* rest.interaction[+].code = #batch

// Task — the ODE workflow object
* rest.resource[+].type = #Task
* rest.resource[=].supportedProfile = "http://hl7.org/fhir/us/ode/StructureDefinition/ode-referral-task"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].interaction[+].code = #patch
* rest.resource[=].searchParam[+].name = "referral-id"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/us/ode/SearchParameter/ode-referral-id"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].operation[+].name = "append-interim"
* rest.resource[=].operation[=].definition = "http://hl7.org/fhir/us/ode/OperationDefinition/ode-append-interim"
* rest.resource[=].operation[=].documentation = "Attach interim clinical content (Encounter, DiagnosticReport, Observation) to an open referral: creates the resources, attaches them to Task.output, and advances businessStatus (typically to interim-results). The ODE-native equivalent of a 360X PCC-59 Interim Consultation Note — usable with no bridge."

// ServiceRequest — the referral order (three directional profiles)
* rest.resource[+].type = #ServiceRequest
* rest.resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/ode/StructureDefinition/ode-referral-servicerequest"
* rest.resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/ode/StructureDefinition/ode-medical-to-dental-referral"
* rest.resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/ode/StructureDefinition/ode-dental-to-dental-referral"
* rest.resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/ode/StructureDefinition/ode-dental-to-medical-referral"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].searchParam[+].name = "referral-id"
* rest.resource[=].searchParam[=].type = #token

// DocumentReference — supporting data / imaging (support-a-pull) + patient-submitted intraoral photo
* rest.resource[+].type = #DocumentReference
* rest.resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/ode/StructureDefinition/ode-referral-documentreference"
* rest.resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/ode/StructureDefinition/ode-intraoral-photo-documentreference"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].operation[+].name = "submit-attachment"
* rest.resource[=].operation[=].definition = "http://hl7.org/fhir/us/davinci-cdex/OperationDefinition/submit-attachment"
* rest.resource[=].operation[=].documentation = "Da Vinci CDex $submit-attachment — the separate-push imaging path used whenever the receiver is on the medical side (medical->dental, dental->medical). Dental->dental instead uses a pull (GET /DocumentReference/{id})."

// Patient + clinical context (US Core)
* rest.resource[+].type = #Patient
* rest.resource[=].supportedProfile = $ucPatient
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type

// Medication list — US Core MedicationRequest entries, aggregated by an ODE List
* rest.resource[+].type = #MedicationRequest
* rest.resource[=].supportedProfile = $ucMedReq
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[+].type = #List
* rest.resource[=].supportedProfile = "http://hl7.org/fhir/us/ode/StructureDefinition/ode-medication-list"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type

// Clinical content — findings arising DURING a referral episode
* rest.resource[+].type = #Observation
* rest.resource[=].supportedProfile = "http://hl7.org/fhir/us/ode/StructureDefinition/ode-observation"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[+].type = #DiagnosticReport
* rest.resource[=].supportedProfile = "http://hl7.org/fhir/us/ode/StructureDefinition/ode-diagnosticreport"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[+].type = #Encounter
* rest.resource[=].supportedProfile = "http://hl7.org/fhir/us/ode/StructureDefinition/ode-encounter"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type


Instance: ODEReferralInitiatorClient
InstanceOf: CapabilityStatement
Usage: #definition
* id = "ode-referral-initiator-client"
* url = "http://hl7.org/fhir/us/ode/CapabilityStatement/ode-referral-initiator-client"
* name = "ODEReferralInitiatorClient"
* title = "ODE Referral Initiator — Client"
* description = "A medical/dental system (or the 360X bridge on behalf of a 360X-only EHR) that creates referrals, follows Task status by referral-id, and sends/requests supporting data via CDex."
* status = #draft
* date = "2026-09-19"
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #json
* format[+] = #xml
* rest.mode = #client
* rest.documentation = "Creates referrals (transaction Bundle), follows Task status by referral-id, and sends/requests supporting data via CDex. The 360X bridge implements this client role for a 360X-only medical EHR."
* rest.security.service = $smart#SMART-on-FHIR
* rest.interaction[+].code = #transaction

* rest.resource[+].type = #ServiceRequest
* rest.resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/ode/StructureDefinition/ode-medical-to-dental-referral"
* rest.resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/ode/StructureDefinition/ode-dental-to-dental-referral"
* rest.resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/ode/StructureDefinition/ode-dental-to-medical-referral"
* rest.resource[=].interaction[+].code = #create

* rest.resource[+].type = #Task
* rest.resource[=].supportedProfile = "http://hl7.org/fhir/us/ode/StructureDefinition/ode-referral-task"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].searchParam[+].name = "referral-id"
* rest.resource[=].searchParam[=].type = #token

* rest.resource[+].type = #DocumentReference
* rest.resource[=].operation[+].name = "submit-attachment"
* rest.resource[=].operation[=].definition = "http://hl7.org/fhir/us/davinci-cdex/OperationDefinition/submit-attachment"
