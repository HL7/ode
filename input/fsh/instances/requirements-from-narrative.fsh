// requirements-from-narrative.fsh — ported from HL7/ode's Requirements-fromNarrative.json.
// Traceability placeholder: conformance statements drawn from the five OHIA use-case
// narratives (UC01-UC05, input/pagecontent/) will be consolidated here as they're
// extracted, mirroring the balloted IG's approach of tying every Requirement back to
// a specific narrative statement rather than inventing conformance rules ungrounded
// in a use case.

Instance: FromNarrative
InstanceOf: Requirements
Usage: #definition
* id = "fromNarrative"
* url = "http://hl7.org/fhir/us/ode/Requirements/fromNarrative"
* name = "FromNarrative"
* title = "Narrative Conformance Statements"
* status = #active
* experimental = false
* description = "Conformance statements found throughout the use-case narratives (UC01-UC05) consolidated into this computable resource for traceability purposes."
