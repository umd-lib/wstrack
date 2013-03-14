<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'history.label', default: 'History')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<link href="../css/smoothness/jquery-ui-1.10.1.custom.css" type="text/css" rel="stylesheet" media="screen, projection" />
		<link href="../css/anytime.css" type="text/css" rel="stylesheet" media="screen, projection" />
		<g:javascript src="jquery-1.9.1.js" />
		<g:javascript src="jquery-ui-1.10.1.custom.js" />
		<g:javascript src="jquery-migrate-1.0.0.js" />
		<g:javascript src="anytime.js" />
		<g:javascript src="anytimetz.js" />
		<script type="text/javascript">
			$(document).ready(function() {	
				var rangeDemoFormat = "%Y-%m-%d %H:%i:%s";
				$("#startDate").AnyTime_picker( { format: rangeDemoFormat });
				$("#endDate").AnyTime_picker( { format: rangeDemoFormat });

				rangeDemoFormat = "%Y-%m-%d %H:%i:%s";
				var rangeDemoConv = new AnyTime.Converter({format:rangeDemoFormat});

				var beginDate = new Date();
				beginDate.setDate(beginDate.getDate()-7);
				console.log(beginDate);
				$("#startDate").val(rangeDemoConv.format(beginDate)).change(); 
				var endDate = new Date();
				console.log(endDate);
				$("#endDate").val(rangeDemoConv.format(endDate)).change(); 
				
				$("#clear").click( function(e) {
				    $("#startDate").val("").change(); 
				    $("#endDate").val("").change(); 
				    return false;
				});
			});
		</script>
		<style type="text/css">
			#startDate, #endDate {
				width : 11em;
				height : 1.2em;
			}
			#endDate, #startDate { 
			  	background-image:url("../images/calendar.png");
			    //background-position:right center; 
			    background-position: 99% 50%; 
			    background-repeat:no-repeat;
			    border:1px solid #FFC030;
			    color:#3090C0;
			    font-weight:bold;
			    
			}
			#AnyTime--endDate, #AnyTime--startDate {
				background-color:#EFEFEF;
				border:1px solid #CCC;
			}
			#AnyTime--endDate *, #AnyTime--startDate * {
				font-weight:bold;
			}
			#AnyTime--endDate .AnyTime-btn, #AnyTime--startDate .AnyTime-btn {
				background-color:#F9F9FC;
			    border:1px solid #CCC;
			    color:#3090C0;
			}
			#AnyTime--endDate .AnyTime-cur-btn, #AnyTime--startDate .AnyTime-cur-btn {
				background-color:#FCF9F6;
			    border:1px solid #FFC030;
			    color:#FFC030;
			}
			#AnyTime--endDate .AnyTime-focus-btn, #AnyTime--startDate .AnyTime-focus-btn {
				border-style:dotted;
			}
			#AnyTime--endDate .AnyTime-lbl, #AnyTime--startDate .AnyTime-lbl {
				color:black;
			}
			#AnyTime--endDate .AnyTime-hdr, #AnyTime--startDate .AnyTime-hdr {
				background-color:#FFC030;
				color:white;
			}
		</style>
	</head>
	<body>
		<g:form action="export" >
			<fieldset class="form">
				<div class="fieldcontain">
					<label for="startDate">Start Date						
					</label>
					<g:textField id="startDate" name="startDate" editable="false"/>
				</div>				
				<div class="fieldcontain">
					<label for="endDate">End Date
					</label>
					<g:textField name="endDate" id="endDate" editable="false"/>
				</div>
			</fieldset>		
			<fieldset class="buttons">
				<g:submitButton name="export" class="save" value="Export" />
				<g:submitButton name="clear" class="update" value="Clear" />
			</fieldset>
		</g:form>
	</body>
</html>