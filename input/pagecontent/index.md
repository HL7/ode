# Oral Health Interoperability Implementation Guide

## Introduction

The Oral Health Interoperability Implementation Guide provides a standardized approach for representing and exchanging oral health information using HL7® FHIR®.

This guide defines the FHIR-based interoperability required for exchanging oral health information across clinical, payer, and patient-facing workflows. By establishing a common implementation framework, the guide seeks to improve care coordination, reduce administrative burden, and enable integration of oral health information into the broader health care ecosystem.

This implementation guide was developed through the Oral Health Interoperability Alliance (OHIA), a multi-sector collaboration dedicated to advancing the secure exchange of oral and medical health information. The work is supported by stakeholders across the oral health ecosystem, including the American Dental Association (ADA), the Federal Electronic Health Record Modernization Program (the FEHRM), the Dental Standards Institute (DSI), health care providers, technology vendors, payers, standards organizations, and government partners. The guide reflects a shared commitment to improving interoperability through the adoption and implementation of open standards.

## Background

Although significant progress has been made in health care interoperability through the adoption of open standards and health information exchange networks, oral health information remains difficult to exchange across organizational and technology boundaries.

Patients frequently have limited access to their dental records. Dental and medical providers often lack efficient mechanisms to exchange information. Health information networks and interoperability initiatives have historically focused on medical data exchange, resulting in limited access to oral health information during care coordination, quality measurement, public health, and administrative workflows. As oral health becomes increasingly recognized as an essential component of whole-person care, the need for standardized oral health interoperability has become increasingly urgent.

## Purpose

The purpose of this implementation guide is to establish a common framework for exchanging oral health information using FHIR. The guide is intended to accelerate adoption by providing implementation guidance, profiles, terminology, examples, and supporting artifacts that enable consistent and scalable interoperability across the oral health ecosystem.

This guide supports the broader goal of making health care simpler, safer, and more connected by enabling the secure exchange of oral and medical health information and reducing barriers to coordinated care. 【3-47803e】

## Scope

This implementation guide provides guidance and conformance resources for the exchange of oral health information using FHIR.

## Use Cases

These scenarios represent the core interoperability workflows addressed by this guide and inform the profiles, extensions, terminology, and examples defined throughout the publication.

* Oral health clinical data exchange, including patterns for exchanging images
* Medical-dental interoperability
* Dental-to-dental interoperability
* Referrals and care coordination
* Patient access to oral health information
* Integration with CARIN Blue Button
* Integration with CARIN Digital Insurance Card
* Integration with Da Vinci implementation guides for prior authorization and other use cases
* SMART on FHIR for dental professionals

This guide focuses on interoperability requirements and implementation guidance. It does not define clinical practice guidelines, reimbursement requirements, certification criteria, or local operational workflows. This guide will reuse as much of U.S. Core, Da Vinci, and CARIN guides as feasible, extending only when necessary to support the unique business of dental.

## How to Use This Guide

This guide is organized to support a variety of audiences and implementation needs.

### New Readers

Readers who are new to oral health interoperability should begin with:

* Background
* Key Concepts
* Use Cases
* General Requirements

These sections introduce the oral health interoperability landscape, explain key concepts, and establish the foundational requirements supported throughout the guide.

### Implementers and Developers

Technical implementers should focus on:

* Profiles
* Extensions
* Terminology
* Search Parameters
* Capability Statements
* Examples

These sections contain the technical artifacts and implementation guidance necessary to support interoperable exchange.

### Providers and Health Care Organizations

Dental and medical organizations should review:

* Use Cases
* General Requirements
* Exchange Workflows
* Examples

These sections provide context regarding how oral health information can be exchanged to support patient care and care coordination.

### Policy, Standards, and Program Leaders

Stakeholders supporting interoperability programs, standards initiatives, and policy efforts should review:

* Background
* Use Cases
* General Requirements
* Adoption Considerations

These sections provide context regarding the challenges, opportunities, and implementation considerations relevant to oral health interoperability.

## Guide Structure

| Section | Description |
|----------|-------------|
| Background | Context, challenges, and vision for oral health interoperability |
| Use Cases | Clinical, administrative, quality measurement, payer, and public health use cases |
| General Requirements | Requirements that apply throughout the guide |
| Profiles | FHIR profiles used to represent oral health information |
| Extensions | Additional elements defined by this guide |
| Terminology | Value sets and code systems used by the guide |
| Search Parameters | Standardized approaches for querying oral health information |
| Capability Statements | Conformance expectations for systems supporting this guide |
| Examples | Sample implementations and reference examples |
| Downloads | Downloadable implementation artifacts |
| Change Log | Documentation of changes across versions |

## Guiding Principles

The development of this guide was informed by the following principles. These principles reflect the shared commitment of the Oral Health Interoperability Alliance and its participating organizations to advance practical, real-world interoperability. 【4-5449b0】【5-b38258】

### Commitment to Implementation

Standards create value only when implemented. This guide is intended to support real-world adoption and deployment of interoperable solutions throughout the oral health ecosystem.

### Patient-Centered Access

Patients should be able to securely access and share their oral health information with authorized caregivers and providers of their choice.

### Interoperability and Open Standards

Open, consensus-based standards promote scalable, sustainable, and vendor-neutral interoperability across health care settings.

### Security and Privacy

The exchange of oral health information must protect patient privacy and support appropriate security safeguards across systems and organizations.

### Collaboration and Innovation

Meaningful interoperability requires collaboration among providers, payers, technology vendors, standards organizations, government agencies, and patients.

### Whole-Person Health

Oral health information should be connected to broader health information to support coordinated care, improve patient outcomes, and advance whole-person health.

## Development and Governance

This implementation guide is maintained through the Oral Health Interoperability Alliance (OHIA). OHIA is a multi-sector coalition committed to advancing the adoption and implementation of interoperable oral health solutions through collaboration, open standards, testing, and implementation activities. OHIA is not a standards development organization and does not publish normative standards. Rather, OHIA seeks to support the adoption and implementation of standards developed through recognized standards development organizations, including HL7®.

## Relationship to Other Standards

This guide is intended to align with existing health care interoperability standards and implementation guides wherever possible. The guide leverages FHIR and seeks to promote consistent implementation patterns that support integration across medical, dental, payer, public health, and consumer-facing systems.

Implementers should review applicable dependencies, referenced specifications, and related implementation guides identified throughout this publication.

## Future Direction

Oral health interoperability continues to evolve alongside broader health care interoperability initiatives. Future versions of this implementation guide may expand support for additional clinical, administrative, public health, research, consumer access, and quality measurement use cases as industry needs and implementation experience mature.

## Acknowledgements

This implementation guide was developed through the contributions of members and stakeholders participating in the Oral Health Interoperability Alliance, including representatives from provider organizations, health plans, health information networks, technology vendors, standards organizations, government agencies, patient advocacy organizations, and subject matter experts dedicated to advancing oral health interoperability.
