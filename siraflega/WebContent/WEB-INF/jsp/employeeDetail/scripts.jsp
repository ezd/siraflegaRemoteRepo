<script>
	//date formatter
	function formatedDate(unformatedDate) {
		var dt = unformatedDate.split('-');
		var y = dt[0];
		var m = dt[1];
		var d = dt[2];
		return d + "/" + m + "/" + y;
	}
	$(document).ready(function() {
	$('.triggerAdd').on('click', function() {
		$('#updateWrokExp').hide();
		$('#saveWrokExp').show();
	});					
	
	$('#addEducationBtn').on('click', function() {
		$('#updateEducation').hide();
		$('#saveEducation').show();
	});
	
	$('#addLanguageBtn').on('click', function() {
		$('#updateLanguage').hide();
		$('#saveLanguage').show();
	});
	
	$('#workExpList').delegate('.trigerEdit','click',function(e) {
		$('#updateWrokExp').show();
		$('#saveWrokExp').hide();
		var listIndexToBeChange = $(this).closest('li').index();
		alert("this is to update:"+$(this).closest('li').index());
		$('#editWorkExpModal .editIndex').val(listIndexToBeChange);
		$('#editWorkExpModal .editId').val($(this).attr("data-id"));
		$('#editWorkExpModal .editPostion').val($(this).attr("data-position"));
		var company_id = $(this).attr("data-company");
		$('#editCompany').val(company_id);
		$('#editWorkExpModal .prevCompanyId').val(company_id);
		$('#editCompany').selectpicker('render');
		var std = $(this).attr("data-start").split(' ');
		var fmtDt = formatedDate(std[0]);
		$('.startDate').val(fmtDt);
		var enddt = $(this).attr("data-end").split(' ');
		var fmtEndDt = formatedDate(enddt[0]);
		$('.endDate').val(fmtEndDt);
		$('.editDescription').val($(this).attr("data-discription"));
		$('#isCurrentlyChk').prop('checked',$(this).attr("data-currentlyWorking")=='true'?true:false);
		alert("is checked?"+$(this).attr("data-currentlyWorking"));
	});
	$('#educationList').delegate('.trigerEducationEdit','click',function(e) {
		$('#updateEducation').show();
		$('#saveEducation').hide();
		var listIndexToBeChange = $(this).closest('li').index();
		$('#educationEditIndex').val(listIndexToBeChange);
		$('#educationEditId').val($(this).attr("data-educationId"));
		$('#educationInstitutionName').val($(this).attr("data-institute"));
		$('#educationLevel').val($(this).attr("data-educationLevel"));
		$('#educationTitle').val($(this).attr("data-educationTitle"));
		var std = $(this).attr("data-educationStart").split(' ');
		var fmtDt = formatedDate(std[0]);
		$('.startEducationDate').val(fmtDt);
		var enddt = $(this).attr("data-educationEnd").split(' ');
		var fmtEndDt = formatedDate(enddt[0]);
		$('.endEducationDate').val(fmtEndDt);
		$('#educationRemark').val($(this).attr("data-educationRemark"));
	});
	$('#languageProfLevel').delegate('.trigerLanguageEdit','click',function(e) {
		$('#updateLanguage').show();
		$('#saveLanguage').hide();
		var listIndexToBeChange = $(this).parent().parent().index();
		$('#languageEditIndex').val(listIndexToBeChange);
		$('#languageEditId').val($(this).attr("data-languageId"));
		$('#languageName').val($(this).attr("data-name"));
		$('#proficiencyLevel').val($(this).attr("data-languageLevel"));
		$('#proficiencyLevel').selectpicker('render');
	});
	$('#workExpList').delegate('.deleteWorkBtn','click',function(e) {
		var parrentUli = $(this).parent().parent();
		var selectedLisIndex = $(this).parent().index();
		var idtodelete = $(this).attr('data-idToDelete');
		$('#nameItemToBeDeleted').html("Work Experience");
		$('#deleteConfirmationMessage').html("Do you want the work exprinace to be deleted?");
		$('#deleteConfirmedBtn').attr('data-idToBeDelete',idtodelete);
		$('#deleteConfirmedBtn').attr('data-deleteItem','Work Experience');
		$('#deleteConfirmedBtn').attr('data-deleteIndex',selectedLisIndex);
		$('#delet_Modal').modal('toggle');
	});
	$('#educationList').delegate('.deleteEducationBtn','click',function(e) {
		var parrentUli = $(this).parent().parent();
		var selectedLisIndex = $(this).parent().index();
		var idtodelete = $(this).attr('data-educationToDelete');
		$('#nameItemToBeDeleted').html("Education");
		$('#deleteConfirmationMessage').html("Do you want the Education to be deleted?");
		$('#deleteConfirmedBtn').attr('data-idToBeDelete',idtodelete);
		$('#deleteConfirmedBtn').attr('data-deleteItem','Education');
		$('#deleteConfirmedBtn').attr('data-deleteIndex',selectedLisIndex);
		$('#delet_Modal').modal('toggle');
	});
	$('#languageProfLevel').delegate('.deleteLanguageBtn','click',function(e) {
		var parrentUli = $(this).parent().parent();
		var selectedLisIndex = $(this).parent().parent().index();
		var idtodelete = $(this).attr('data-languageToDelete');
		$('#nameItemToBeDeleted').html("Language");
		$('#deleteConfirmationMessage').html("Do you want the Language to be deleted?");
		$('#deleteConfirmedBtn').attr('data-idToBeDelete',idtodelete);
		$('#deleteConfirmedBtn').attr('data-deleteItem','Language');
		$('#deleteConfirmedBtn').attr('data-deleteIndex',selectedLisIndex);
		$('#delet_Modal').modal('toggle');
	});
	
});
</script>