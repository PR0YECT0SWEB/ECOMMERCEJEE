/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package view;

import JavaBeans.Item;
import JavaBeans.Producto;
import cad.ProductoCad;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author D3RL3
 */
public class Cart extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if(request.getParameter("action")!=null){
                String a = request.getParameter("action");
                int webId = Integer.parseInt(request.getParameter("id"));;
                Producto p;
                HttpSession session = request.getSession();
                
                // SE REALIZA UN SESSION SCOPE CON CART EL CUAL ES UN ARREGLO DE TIPO ITEM EL CUAL TIENE EL OBEJTO PRODUCTO POR ENDE HEREDA TODOS
                // ATRIBUTOS DE PRODUCTO
                if(a.equals("order")){
//                    webId = 
                    if(session.getAttribute("cart")==null){
                        ArrayList<Item> cart = new ArrayList<>();
                        p = ProductoCad.consultarProducto(session.getAttribute("moneda").toString(), webId);
                        cart.add(new Item(p, 1));
                        session.setAttribute("cart", cart);
                    }else{
                        ArrayList<Item> cart = (ArrayList<Item>) session.getAttribute("cart");
                        int indice = existeProducto(webId, cart);
                        if(indice == -1){
                            p = ProductoCad.consultarProducto(session.getAttribute("moneda").toString(), webId);
                            cart.add(new Item(p, 1));
                        }else{
                            int cantidad = cart.get(indice).getCantidad()+1;
                            cart.get(indice).setCantidad(cantidad);
                                    
                        }
                        session.setAttribute("cart", cart);
                    }
                }else if(a.equals("delete")){
                    
                    ArrayList<Item> cart = (ArrayList<Item>) session.getAttribute("cart");
                    int indice = existeProducto(webId, cart);
                    cart.remove(indice);
                    session.setAttribute("cart", cart);                    
                }else if(a.equals("finish")){
                    ArrayList<Item> cart = (ArrayList<Item>) session.getAttribute("cart");
                    cart.clear();
                    session.setAttribute("cart", cart);   
                    response.setContentType("text/html;charset=UTF-8");
                    request.getRequestDispatcher("Inicio").forward(request, response);
                }
            }
        
        
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("WEB-INF/cart.jsp").forward(request, response);
    }
    
    private int existeProducto(int webId, ArrayList<Item> cart){
        for(int i = 0; i < cart.size(); i++){
            if(cart.get(i).getP().getWebId() == webId){
                return i;
            }
        }
        return -1;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
