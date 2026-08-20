
# Oral Health Data Exchange (ODE) Implementation Guide

## Overview

The Oral Health Data Exchange (ODE) Implementation Guide is an HL7® FHIR® implementation guide focused on enabling interoperable exchange of oral health information across dental, medical, payer, public health, and patient-facing systems.

ODE is being developed through the Oral Health Interoperability Alliance (OHIA) with support from stakeholders across the oral health ecosystem, including the American Dental Association (ADA), the Federal Electronic Health Record Modernization (FEHRM) Program, the Dental Standards Institute (DSI), health care providers, technology vendors, payers, standards organizations, and government partners.

The guide is intended to support:

* Medical-dental interoperability
* Dental-to-dental interoperability
* Oral health clinical data exchange
* Referrals and care coordination
* Patient access to oral health information
* Integration with existing HL7 FHIR implementation guides and standards

## Project Status

This implementation guide is currently under active development.

Contributors are encouraged to submit issues, implementation feedback, proposed changes, and example use cases through GitHub.

## Repository Contents

| Directory | Purpose |
|------------|------------|
| `input/fsh` | FHIR Shorthand (FSH) definitions |
| `input/pagecontent` | Narrative implementation guide content |
| `input/images` | Diagrams and images used by the guide |
| `input/examples` | Example FHIR resources |
| `input/includes` | Shared templates and supporting content |
| `fsh-generated` | Generated artifacts produced by SUSHI |
| `output` | Generated implementation guide output |

## Dependencies

ODE is intended to align with and leverage existing interoperability standards wherever possible, including:

* HL7 FHIR R4
* US Core
* CARIN Blue Button
* Da Vinci Implementation Guides
* SMART on FHIR

The guide follows an "extend only when necessary" philosophy and seeks to maximize reuse of existing standards and implementation guidance.

## Building the Implementation Guide

This project uses:

* FHIR Shorthand (FSH)
* SUSHI
* HL7 IG Publisher

To build the guide:

```bash
_sushi
_genonce
```

or

```bash
./_genonce.sh
```

depending on your local environment.

## Continuous Integration

A continuous integration (CI) build is generated from the main branch and represents the most current draft of the implementation guide.

The CI build should not be considered a published specification.

## Contributing

We welcome contributions from:

* Dental organizations
* Medical organizations
* Health IT vendors
* Payers
* Government agencies
* Standards organizations
* Researchers
* Developers
* Patients and patient advocates

Please use GitHub Issues and Pull Requests to propose changes and discuss implementation approaches.

## Governance

The Oral Health Interoperability Alliance (OHIA) coordinates development of this implementation guide.

OHIA is not a standards development organization and does not publish normative standards. The Alliance supports the adoption and implementation of standards developed through recognized standards development organizations, including HL7®.

## License

See the repository license for details.