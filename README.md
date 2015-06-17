# Test Case Description Language

This is a legacy project. We offer that to the community to foster
more work in the area of accessibility testing or even web testing
in general. More information about this project can be found in:
[http://bentoweb.org/](http://bentoweb.org/)

## Test Case Description Language version 1.1

The Test Case Description Language (TCDL) is an XML-based language
defined by BenToWeb to store metadata for the test cases in the test
suites. For each individual test cases, it describes:

+ formal metadata, such as author, date, title and a short description;
+ technologies (the technologies and technology features used in the test);
+ test mode and test scenarios for end user evaluation;
+ the “rules” that are tested (WCAG 2.0 success criteria or other rules);
+ namespace mappings used in some of the previous sections.

TCDL is defined as a W3C XML Schema and uses the namespace

[http://bentoweb.org/refs/TCDL1.1](http://bentoweb.org/refs/TCDL1.1)

The XML Schema is available at

[http://bentoweb.org/refs/schemas/tcdl1.1.xsd](http://bentoweb.org/refs/schemas/tcdl1.1.xsd)

and contains detailed documentation. Some brief descriptions of the
components can be found in the
[RDDL file of the TCDL 1.1 namespace](http://bentoweb.org/refs/TCDL1.1/).

## Test Case Description Language version 2.0

The Test Case Description Language version 2.0 is an XML vocabulary for
describing test files, intended to be included in test suites for user
interface guidelines such as the Web Content Accessibility Guidelines
(WCAG) 2.0. It is an adaptation of the version 1.1, to be used by the WCAG
2.0 Test Samples Development Task Force (TSD TF) from W3C, where our work
is being migrated. The main references are:

+ [RDDL file of the TCDL 2.0 namespace](http://bentoweb.org/refs/TCDL2.0).
+ [TCDL 2.0 Schema](http://bentoweb.org/refs/schemas/tcdl2.0.xsd).
+ [TCDL 2.0 Specification and Guide](http://bentoweb.org/refs/TCDL2.0.html).
+ [ISO Schematron for initial review of TSD TF](http://bentoweb.org/refs/TCDL2.0/tcdl2.0.tsdtf.html).
+ [How to Validate Test Sample Metadata (TCDL 2.0) with ISO Schematron](http://bentoweb.org/refs/TCDL2.0/tsdtf_schematron.html).
+ [XSLT for HTML view of TCDL metadata](http://bentoweb.org/refs/TCDL2.0/tcdl2.0tsdtf_to_xhtml.xslt).

## Related resources

* [[DRAFT] WCAG 2.0 Test Samples: Overview](http://www.w3.org/WAI/ER/tests/)
