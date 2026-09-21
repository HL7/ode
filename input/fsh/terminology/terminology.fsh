// terminology.fsh — terminology needed by the referral profiles, the tooth
// extension, and the referral Task's businessStatus. No claims-sharing terminology
// here.
//
// Unlike the ode-ig sandbox build, this official HL7 IG publishes its terminology
// under its own canonical (http://hl7.org/fhir/us/ode) rather than the OHIA codes
// namespace — no ^url override on ODEReferralSubStatusCS.

ValueSet: ODEToothVS
Id: ode-tooth-vs
Title: "ODE Tooth Designation Value Set"
Description: "All codes in the ADA Universal Tooth Designation System, as published in HL7 Terminology (THO). ODE does not define its own tooth code system and does not use FDI/ISO 3950 notation — confirmed with the ADA that FDI is not used for US dental data."
* ^experimental = false
* include codes from system $tooth


// PUNCHLIST: this code list was synthesized in this session by reading the
// crosswalk's transaction table, not sourced from a shared/reviewed terminology
// artifact. Flagged in workflow.fsh at the businessStatus binding too — verify
// against ode-360x-adapter maintainers before treating it as settled.
CodeSystem: ODEReferralSubStatusCS
Id: ode-referral-sub-status
Title: "ODE Referral Sub-Status"
Description: "Granular referral progress codes carried on Task.businessStatus. Sourced from the 360X<->COW crosswalk (ode-360x-adapter/spec/mapping/360x-cow-crosswalk.md Table 1) — these are the sub-statuses the seven 360X referral transactions (PCC-55...61) actually drive, plus `scheduled`, the OpenAPI contract's own worked example. This is the same list the crosswalk already assumes exists at this CodeSystem's URL; defining it here is this IG fulfilling that assumption, not inventing new states."
* ^caseSensitive = true
* ^experimental = false
* ^content = #complete
* #received "Received" "The referral was received (PCC-55 intake)."
* #scheduled "Scheduled" "An appointment has been scheduled for the referred patient."
* #accepted "Accepted" "The fulfiller accepted the referral (PCC-56 accept)."
* #declined "Declined" "The fulfiller declined the referral (PCC-56 decline)."
* #interim-results "Interim Results" "Interim clinical content has been attached to the open referral (PCC-59 / $append-interim)."
* #appointment-booked "Appointment Booked" "An appointment was booked and notified (PCC-60)."
* #appointment-noshow "Appointment No-Show" "The patient did not attend a booked appointment (PCC-61)."
* #outcome-final "Outcome Final" "The referral outcome was reported and the loop closed (PCC-57)."
* #cancelled "Cancelled" "The referral was cancelled (PCC-58)."

ValueSet: ODEReferralSubStatusVS
Id: ode-referral-sub-status-vs
Title: "ODE Referral Sub-Status Value Set"
Description: "All codes from ODEReferralSubStatusCS. Bound extensibly to Task.businessStatus — a build that needs a sub-status this list doesn't cover may still use local text or another coding, per the extensible binding."
* ^experimental = false
* include codes from system ODEReferralSubStatusCS
