<script type="text/javascript">
//date formatter
function formatedDate(unformatedDate) {
	var dt = unformatedDate.split('-');
	var y = dt[0];
	var m = dt[1];
	var d = dt[2];
	return d + "/" + m + "/" + y;
}
	$('#updateEmprInfo').click(function() {
		
		if($('#EmprId').val()==''){
			$('#updateEmployerPersonalInfo').hide();
			$('#saveEmployerPersonalInfo').show();
			
		}else{
			$('#employerId').val($('#EmprId').val())
			$('#firstNameEmployer').val($(this).attr('data-firsName'));
			$('#middleNameEmployer').val($(this).attr('data-middleName'));
			$('#lastNameEmployer').val($(this).attr('data-lastName'));
			$('#phoneEmployer').val($(this).attr('data-phone'));
			$('#updateEmployerPersonalInfo').show();
			$('#saveEmployerPersonalInfo').hide();
		}
	});
	$('#addEmployerWorkBtn').click(function(){
		$('#updateEmployerWrokExp').hide();
		$('#saveEmployerWrokExp').show();
	});
	$('#workExpList').delegate('.trigerEdit','click',function(e) {
		$('#saveEmployerWrokExp').hide();
		$('#updateEmployerWrokExp').show();
		var listIndexToBeChange = $(this).closest('li').index();
		$('#employerWorkExpModal .editIndex').val(listIndexToBeChange);
		$('#employerWorkExpModal .editId').val($(this).attr("data-id"));
		$('#employerWorkExpModal .editPostion').val($(this).attr("data-position"));
		$('#editCompany').val($(this).attr("data-company"));
		$('#employerWorkExpModal .prevCompanyId').val($(this).attr("data-company"));
		$('#editCompany').selectpicker('render');
		var std = $(this).attr("data-start").split(' ');
		var fmtDt = formatedDate(std[0]);
		$('.startDate').val(fmtDt);
		var iscurrent=$(this).attr("data-currentlyworking");
		if(iscurrent=="true"){
			var todayDate=new Date();
			var d = todayDate.getDate();
			var m = todayDate.getMonth()+1; //January is 0!
			var y = todayDate.getFullYear();
			var fDate=d+"/"+m+"/"+y;
			$('.endDate').val(fDate);
		}else{
			var enddt = $(this).attr("data-end").split(' ');
			var fmtEndDt = formatedDate(enddt[0]);
			$('.endDate').val(fmtEndDt);
		}
		$('#isCurrentlyChk').prop('checked',$(this).attr("data-currentlyWorking")=='true'?true:false);
	});
	
	$('#workExpList').delegate('.deleteWorkBtn','click',function(e) {
// 		var parrentUli = $(this).parent().parent();
		var selectedLisIndex = $(this).closest('li').index();
		var idtodelete = $(this).attr('data-idToDelete');
		$('#nameItemToBeDeleted').html("Work Experience");
		$('#deleteConfirmationMessage').html("Do you want the work exprinace to be deleted?");
		$('#deleteConfirmedBtn').attr('data-idToBeDelete',idtodelete);
		$('#deleteConfirmedBtn').attr('data-deleteItem','Employer Work Experience');
		$('#deleteConfirmedBtn').attr('data-deleteIndex',selectedLisIndex);
		$('#delet_Modal').modal('toggle');
	});
</script>