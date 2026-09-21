// ode-tooth.fsh — tooth designation extension used on bodySite (a CodeableConcept).
// Context is scoped to the two elements that actually carry it today —
// ServiceRequest.bodySite (referrals.fsh) and Observation.bodySite (clinical.fsh) —
// rather than the unbounded `Element` context. Add a new context entry here (not a
// blanket Element context) if a future profile needs it elsewhere.

Extension: ODETooth
Id: ode-tooth
Title: "Tooth designation"
Description: "Identifies a tooth using the ADA Universal Tooth Designation System as published in HL7 Terminology (THO). ODE does not define its own tooth code system. Confirmed with the ADA that FDI (ISO 3950) notation is not used for US dental data."
* ^context[+].type = #element
* ^context[=].expression = "ServiceRequest.bodySite"
* ^context[+].type = #element
* ^context[=].expression = "Observation.bodySite"
* value[x] only CodeableConcept
* valueCodeableConcept from ODEToothVS (required)
