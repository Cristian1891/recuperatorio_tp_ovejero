//
// Este archivo ha sido generado por la arquitectura JavaTM para la implantación de la referencia de enlace (JAXB) XML v2.3.0 
// Visite <a href="https://javaee.github.io/jaxb-v2/">https://javaee.github.io/jaxb-v2/</a> 
// Todas las modificaciones realizadas en este archivo se perderán si se vuelve a compilar el esquema de origen. 
// Generado el: 2024.11.11 a las 05:01:01 PM ART 
//


package com.unla.soap_client.service1;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Clase Java para ProductBulkDTO complex type.
 * 
 * <p>El siguiente fragmento de esquema especifica el contenido que se espera que haya en esta clase.
 * 
 * <pre>
 * &lt;complexType name="ProductBulkDTO"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="codigo" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="nombre" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="color" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="talle" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="foto" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="tiendasAsignadas" type="{http://spring.io/guides/gs-producing-web-service}tiendasAsignadasType"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ProductBulkDTO", propOrder = {
    "codigo",
    "nombre",
    "color",
    "talle",
    "foto",
    "tiendasAsignadas"
})
public class ProductBulkDTO {

    @XmlElement(required = true)
    protected String codigo;
    @XmlElement(required = true)
    protected String nombre;
    @XmlElement(required = true)
    protected String color;
    @XmlElement(required = true)
    protected String talle;
    @XmlElement(required = true)
    protected String foto;
    @XmlElement(required = true)
    protected TiendasAsignadasType tiendasAsignadas;

    /**
     * Obtiene el valor de la propiedad codigo.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCodigo() {
        return codigo;
    }

    /**
     * Define el valor de la propiedad codigo.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCodigo(String value) {
        this.codigo = value;
    }

    /**
     * Obtiene el valor de la propiedad nombre.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * Define el valor de la propiedad nombre.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNombre(String value) {
        this.nombre = value;
    }

    /**
     * Obtiene el valor de la propiedad color.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getColor() {
        return color;
    }

    /**
     * Define el valor de la propiedad color.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setColor(String value) {
        this.color = value;
    }

    /**
     * Obtiene el valor de la propiedad talle.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTalle() {
        return talle;
    }

    /**
     * Define el valor de la propiedad talle.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTalle(String value) {
        this.talle = value;
    }

    /**
     * Obtiene el valor de la propiedad foto.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFoto() {
        return foto;
    }

    /**
     * Define el valor de la propiedad foto.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFoto(String value) {
        this.foto = value;
    }

    /**
     * Obtiene el valor de la propiedad tiendasAsignadas.
     * 
     * @return
     *     possible object is
     *     {@link TiendasAsignadasType }
     *     
     */
    public TiendasAsignadasType getTiendasAsignadas() {
        return tiendasAsignadas;
    }

    /**
     * Define el valor de la propiedad tiendasAsignadas.
     * 
     * @param value
     *     allowed object is
     *     {@link TiendasAsignadasType }
     *     
     */
    public void setTiendasAsignadas(TiendasAsignadasType value) {
        this.tiendasAsignadas = value;
    }

}