<cfsetting enablecfoutputonly="true" /><cfsilent>
<!---
License:
Copyright 2009 GreatBizTools, LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Copyright: GreatBizTools, LLC
Author: Peter J. Farrell (peter@mach-ii.com)
$Id$

Created version: 1.8.0
Updated version: 1.8.0

Notes:
- OPTIONAL ATTRIBUTES
	outputType	= [string] outputs the code to "head" or "inline"
	meida = [string] specifies styles for different media types
	forIEVersion = [string] wraps an IE conditional comment around the incoming code
--->
<cfparam name="attributes.outputType" type="string" 
	default="head" />

<cfparam name="attributes.media" type="string"
	default="" />

<cfparam name="attributes.forIEVersion" type="string"
	default="" />

<cfif thisTag.ExecutionMode IS "end">

	<!--- Setup the tag --->
	<cfinclude template="/MachII/customtags/view/helper/viewTagBuilder.cfm" />

	<cfset variables.js = Chr(13) & '<style type="text/css"' />
	
	<cfif Len(attributes.media)>
		<cfset variables.js = variables.js & ' media="' & attributes.media & '"' />
	</cfif>
			
	<cfset variables.js = variables.js & '>' & Chr(13) & '/* <![CDATA[ */' & Chr(13) & thisTag.GeneratedContent & Chr(13) & '/* ]]> */' & Chr(13) &  '</style>' & Chr(13) />
	
	<!--- Wrap in an IE conditional if defined --->
	<cfif Len(attributes.forIEVersion)>
		<cfset variables.js = wrapIEConditionalComment(attributes.forIEVersion, variables.js) />
	</cfif>
	
	<cfif attributes.outputType EQ "head">
		<cfset caller.this.addHTMLHeadElement(variables.js) />
		<cfset thisTag.GeneratedContent = "" />
	<cfelse>
		<cfset thisTag.GeneratedContent = variables.js />
	</cfif>
</cfif>
</cfsilent><cfsetting enablecfoutputonly="false" />