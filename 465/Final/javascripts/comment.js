$('#comment_button').click(function () {
  var input = CKEDITOR.instances.editor1.getData();
  CKEDITOR.instances.editor1.setData("");
  var newEntry = $('<hr><div class = "panel-body"><div class = "row"><div class = "col-sm-11 content">' + input + '</div></div></div>');
  $(newEntry).insert;
  });
  
function commenter(thing) {
	var input = CKEDITOR.instances.editor1.getData();
	alert(input);
}

function post(thing) {
	var temp = document.forms[0];

	var newNewName = temp.elements["name"];
	var newNewNewName = newNewName.value; 
	

	var newNewDesc = temp.elements["desc"];
	var newNewNewDesc = newNewDesc.value; 
	

	var newNewAttr = temp.elements["attr"];
	var newNewNewAttr = newNewAttr.value; 
	
	var input = CKEDITOR.instances.editor1.getData();
	alert(newNewNewName +"   " + newNewNewDesc + "  " + newNewNewAttr + "  " + input);

}
