CREATE OR REPLACE FUNCTION "kaf"."ft_movimiento_af_dep_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Sistema de Activos Fijos
 FUNCION: 		kaf.ft_movimiento_af_dep_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'kaf.tmovimiento_af_dep'
 AUTOR: 		 (admin)
 FECHA:	        16-04-2016 08:14:17
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'kaf.ft_movimiento_af_dep_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SKA_MAFDEP_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		16-04-2016 08:14:17
	***********************************/

	if(p_transaccion='SKA_MAFDEP_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						mafdep.id_movimiento_af_dep,
						mafdep.vida_util,
						mafdep.tipo_cambio_ini,
						mafdep.depreciacion_per_actualiz,
						mafdep.id_movimiento_af,
						mafdep.vida_util_ant,
						mafdep.estado_reg,
						mafdep.monto_vigente,
						mafdep.monto_vigente_ant,
						mafdep.depreciacion_acum_actualiz,
						mafdep.tipo_cambio_fin,
						mafdep.depreciacion_acum,
						mafdep.id_activo_fijo_valor,
						mafdep.factor,
						mafdep.depreciacion_per,
						mafdep.depreciacion,
						mafdep.id_moneda,
						mafdep.depreciacion_per_ant,
						mafdep.monto_actualiz,
						mafdep.depreciacion_acum_ant,
						mafdep.id_usuario_reg,
						mafdep.usuario_ai,
						mafdep.fecha_reg,
						mafdep.id_usuario_ai,
						mafdep.fecha_mod,
						mafdep.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from kaf.tmovimiento_af_dep mafdep
						inner join segu.tusuario usu1 on usu1.id_usuario = mafdep.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = mafdep.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SKA_MAFDEP_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		16-04-2016 08:14:17
	***********************************/

	elsif(p_transaccion='SKA_MAFDEP_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_movimiento_af_dep)
					    from kaf.tmovimiento_af_dep mafdep
					    inner join segu.tusuario usu1 on usu1.id_usuario = mafdep.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = mafdep.id_usuario_mod
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************    
 	#TRANSACCION:  'SKA_MAFDEPRES_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		RCM	
 	#FECHA:		05/05/2016
	***********************************/

	elsif(p_transaccion='SKA_MAFDEPRES_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select mafdep.id_movimiento_af_dep, mafdep.id_movimiento_af, mafdep.id_activo_fijo_valor,
						mafdep.fecha, mafdep.depreciacion_acum_ant, mafdep.depreciacion_per_ant, mafdep.monto_vigente_ant, mafdep.vida_util_ant,
						mafdep.depreciacion_acum_actualiz, mafdep.depreciacion_per_actualiz, mafdep.monto_actualiz,
						mafdep.depreciacion, mafdep.depreciacion_acum,mafdep.depreciacion_per, mafdep.monto_vigente, mafdep.vida_util,
						mafdep.tipo_cambio_ini,mafdep.tipo_cambio_fin, mafdep.factor
						from kaf.tmovimiento_af_dep mafdep
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SKA_MAFDEPRES_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		RCM	
 	#FECHA:		05/05/2016
	***********************************/

	elsif(p_transaccion='SKA_MAFDEPRES_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_movimiento_af_dep)
					    from kaf.tmovimiento_af_dep mafdep
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************    
 	#TRANSACCION:  'SKA_MAFDEPRESCAB_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:			RCM
 	#FECHA:			07/05/2016
	***********************************/

	elsif(p_transaccion='SKA_RESCAB_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						distinct actval.id_activo_fijo_valor,
						actval.id_activo_fijo,
						actval.depreciacion_per,
						actval.estado,
						actval.principal,
						actval.monto_vigente,
						actval.monto_rescate,
						actval.tipo_cambio_ini,
						actval.estado_reg,
						actval.tipo,
						actval.depreciacion_mes,
						actval.depreciacion_acum,
						actval.fecha_ult_dep,
						actval.fecha_ini_dep,
						actval.monto_vigente_orig,
						actval.vida_util,
						actval.vida_util_orig,
						mafdep.id_movimiento_af,
						actval.tipo_cambio_fin,
						actval.codigo
						from kaf.tmovimiento_af_dep mafdep
						inner join kaf.tactivo_fijo_valores actval
						on actval.id_activo_fijo_valor = mafdep.id_activo_fijo_valor
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SKA_MAFDEPRESCAB_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:			RCM
 	#FECHA:			07/05/2016
	***********************************/

	elsif(p_transaccion='SKA_RESCAB_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(mafdep.id_activo_fijo_valor)
					    from kaf.tmovimiento_af_dep mafdep
						inner join kaf.tactivo_fijo_valores actval
						on actval.id_activo_fijo_valor = mafdep.id_activo_fijo_valor
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
					
	else
					     
		raise exception 'Transaccion inexistente';
					         
	end if;
					
EXCEPTION
					
	WHEN OTHERS THEN
			v_resp='';
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
			v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
			v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
			raise exception '%',v_resp;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "kaf"."ft_movimiento_af_dep_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
