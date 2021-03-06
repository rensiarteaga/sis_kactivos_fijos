CREATE OR REPLACE FUNCTION "kaf"."ft_movimiento_af_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Sistema de Activos Fijos
 FUNCION: 		kaf.ft_movimiento_af_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'kaf.tmovimiento_af'
 AUTOR: 		 (admin)
 FECHA:	        18-03-2016 05:34:15
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

	v_nombre_funcion = 'kaf.ft_movimiento_af_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SKA_MOVAF_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		18-03-2016 05:34:15
	***********************************/

	if(p_transaccion='SKA_MOVAF_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						movaf.id_movimiento_af,
						movaf.id_movimiento,
						movaf.id_activo_fijo,
						movaf.id_cat_estado_fun,
						movaf.id_movimiento_motivo,
						movaf.estado_reg,
						movaf.importe,
						movaf.respuesta,
						movaf.vida_util,
						movaf.fecha_reg,
						movaf.usuario_ai,
						movaf.id_usuario_reg,
						movaf.id_usuario_ai,
						movaf.id_usuario_mod,
						movaf.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						af.codigo as cod_af,
						af.denominacion,
						cat.descripcion as estado_fun,
						mmot.motivo
						from kaf.tmovimiento_af movaf
						inner join segu.tusuario usu1 on usu1.id_usuario = movaf.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = movaf.id_usuario_mod
						inner join kaf.tactivo_fijo af on af.id_activo_fijo = movaf.id_activo_fijo
						left join param.tcatalogo cat on cat.id_catalogo = movaf.id_cat_estado_fun
						left join kaf.tmovimiento_motivo mmot on mmot.id_movimiento_motivo = movaf.id_movimiento_motivo
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SKA_MOVAF_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		18-03-2016 05:34:15
	***********************************/

	elsif(p_transaccion='SKA_MOVAF_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_movimiento_af)
					    from kaf.tmovimiento_af movaf
					    inner join segu.tusuario usu1 on usu1.id_usuario = movaf.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = movaf.id_usuario_mod
						inner join kaf.tactivo_fijo af on af.id_activo_fijo = movaf.id_activo_fijo
						left join param.tcatalogo cat on cat.id_catalogo = movaf.id_cat_estado_fun
						left join kaf.tmovimiento_motivo mmot on mmot.id_movimiento_motivo = movaf.id_movimiento_motivo
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
ALTER FUNCTION "kaf"."ft_movimiento_af_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
