(function (window, document) {
	var btnBusca = document.getElementById('btnBuscarPersona');
	var btnNuevo = document.getElementById('btnNuevo');

	btnBusca.onclick = function(e){
		buscaPersona(e);
	}

	btnNuevo.onclick = function(e){
		nuevoRegistro(e);
	}

	function nuevoRegistro(e){
		document.getElementById('dtGrilla').style.display = 'none';
		document.getElementById('dtPersonal').style.display = 'inline';
		document.getElementById('dtDireccion').style.display = 'inline';
		document.getElementById('dtTelefono').style.display = 'inline';
		document.getElementById('dtCorreo').style.display = 'inline';
		document.getElementById('btnModificar').style.display = 'none';
		document.getElementById('btnCrear').style.display = 'inline';
		document.getElementById('idpersona').value = '';
		document.getElementById('ci').value = '';
		document.getElementById('ext').options[0].selected = true;
		document.getElementById('primer_apellido').value = '';
		document.getElementById('segundo_apellido').value = '';
		document.getElementById('nombres').value = '';
		document.getElementById('fechaNac').value = '';

	}

	function buscaPersona(e){
		var sw = false;
		document.getElementById('dtPersonal').style.display = 'none';
	    document.getElementById('dtDireccion').style.display = 'none';
	    document.getElementById('dtTelefono').style.display = 'none';
	    document.getElementById('dtCorreo').style.display = 'none';
		var valores = '{';
		var frm = document.getElementById("frmBusqueda");
		for (var i=0; i<frm.length;i++)
			if (frm.elements[i].type == "text"){
				valores = valores + '"' + frm.elements[i].id + '"'  + ':"' + frm.elements[i].value + '",';
				if(frm.elements[i].value != ""){
					sw = true;
				};
			};
		valores = valores.substr(0, (valores.length - 1)) + '}';

		if (sw){
			var objx = new XMLHttpRequest()
			objx.onreadystatechange = function(){
				if (objx.readyState == 4){
					if (objx.status == 200)
						res = JSON.parse(objx.responseText);
						if (res.length >0){
							blanquear('tbPer');
							for(var i=0; i<res.length; i++){
								var fil = tbl.insertRow();
								var celda1 = fil.insertCell(0);
								var celda2 = fil.insertCell(1);
								var celda3 = fil.insertCell(2);
								var celda4 = fil.insertCell(3);
								var celda5 = fil.insertCell(4);
								var celda6 = fil.insertCell(5);
								var celda7 = fil.insertCell(6);
								celda1.innerHTML = res[i].id;
								celda2.innerHTML = res[i].ci + ' ' + res[i].ext;
								celda3.innerHTML = res[i].primer_apellido;
								celda4.innerHTML = res[i].segundo_apellido;
								celda5.innerHTML = res[i].nombres;
								celda6.innerHTML = res[i].fecha_nacimiento;

								var lk = document.createElement('a');
								lk.innerHTML = 'editar';
								lk.setAttribute('href', '#');
								lk.setAttribute('onclick', 'cargarPid(' + res[i].id + ');')
								celda7.appendChild(lk);
							}

							document.getElementById('dtGrilla').style.display = 'inline';

						}else{
							alert('No existen registros con esos criterios de Búsqueda');
						}
				}
			}
			
			
			objx.open('POST', '/buscaP');
			objx.setRequestHeader('Content-Type','application/json');
			objx.send(valores);
		}
		else{
			alert('Digite algun criterio de busqueda');
			document.getElementById('busCi').focus();
		};
	}



}(this, this.document));