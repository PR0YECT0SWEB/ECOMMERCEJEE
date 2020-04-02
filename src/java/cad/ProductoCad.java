/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cad;

import JavaBeans.Producto;
import JavaBeans.ProductoMoneda;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author D3RL3
 */
public class ProductoCad {
     public static boolean registrarProducto(Producto p,ProductoMoneda cop, ProductoMoneda usd, ProductoMoneda pen){
        try {
            String sql="{CALL SP_REGISTRARPRODUCTO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
            Connection c = Conexion.conectar();
            CallableStatement sentencia = (CallableStatement) c.prepareCall(sql);
            sentencia.setString(1, p.getNombre());
            sentencia.setFloat(2, p.getPrecio());
            sentencia.setFloat("P_PRECIONUEVO", p.getPrecioNuevo());
            sentencia.setInt("P_STOCK", p.getStock());
            sentencia.setBoolean(5, p.isNuevo());
            sentencia.setBoolean("P_RECOMENDADO", p.isRecomendado());
            sentencia.setString(7, p.getDescripcion());
            sentencia.setBoolean(8, p.isVisible());
            sentencia.setInt(9, p.getMarca());
            sentencia.setInt("P_CODIGO_CATEGORIA", p.getCategoria());
            sentencia.setString(11, p.getImg());
            
            sentencia.setString(12, cop.getMoneda());
            sentencia.setFloat(13, cop.getPrecio());
            sentencia.setFloat(14, cop.getNuevoPrecio());
           
            
            sentencia.setString("P_MONEDA_USD", usd.getMoneda());
            sentencia.setFloat("P_PRECIO_USD", usd.getPrecio());
            sentencia.setFloat("P_PRECIONUEVO_USD", usd.getNuevoPrecio());
            
            sentencia.setString(18, pen.getMoneda());
            sentencia.setFloat(19, pen.getPrecio());
            sentencia.setFloat(20, pen.getNuevoPrecio());
            
            return sentencia.executeUpdate()> 0;
        } catch (SQLException ex) {
            return false;
        }
    }
     public static  ArrayList<Producto> listarProductosRecomendados(String moneda){
        try {
            String sql="{CALL SP_LISTARRECOMENDADOS(?)}";
            Connection c = Conexion.conectar();
            CallableStatement sentencia = (CallableStatement) c.prepareCall(sql);
            sentencia.setString(1, moneda);
                       
            ResultSet res = sentencia.executeQuery();
            ArrayList<Producto> lista = new ArrayList<>();
            while(res.next()){
                Producto p = new Producto();
                p.setWebId(res.getInt("webid"));
                p.setNombre(res.getString("nombre"));
                p.setImg(res.getString("img"));
                p.setStock(res.getInt("stock"));
                p.setNuevo(res.getBoolean("nuevo"));                
                if (!moneda.equalsIgnoreCase("MXN")){
                    p.setPrecio(res.getFloat("PRECIO2"));
                    p.setPrecioNuevo(res.getFloat("PRECIONUEVO2"));
                }else{
                    p.setPrecio(res.getFloat("precio"));
                    p.setPrecioNuevo(res.getFloat("precionuevo"));
                }
                lista.add(p);
            }
            return lista;
        } catch (SQLException ex) {
            return null;
        }
    }
}
