//
// Este archivo ha sido generado por la arquitectura JavaTM para la implantación de la referencia de enlace (JAXB) XML v2.3.0 
// Visite <a href="https://javaee.github.io/jaxb-v2/">https://javaee.github.io/jaxb-v2/</a> 
// Todas las modificaciones realizadas en este archivo se perderán si se vuelve a compilar el esquema de origen. 
// Generado el: 2024.11.11 a las 09:59:27 PM ART 
//


package com.unla.soap_client.service2;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Clase Java para anonymous complex type.
 * 
 * <p>El siguiente fragmento de esquema especifica el contenido que se espera que haya en esta clase.
 * 
 * <pre>
 * &lt;complexType&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="catalogo" type="{http://spring.io/guides/gs-producing-web-service}catalogoSoap"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "catalogo"
})
@XmlRootElement(name = "postCatalogoRequest")
public class PostCatalogoRequest {

    @XmlElement(required = true)
    protected CatalogoSoap catalogo;

    /**
     * Obtiene el valor de la propiedad catalogo.
     * 
     * @return
     *     possible object is
     *     {@link CatalogoSoap }
     *     
     */
    public CatalogoSoap getCatalogo() {
        return catalogo;
    }

    /**
     * Define el valor de la propiedad catalogo.
     * 
     * @param value
     *     allowed object is
     *     {@link CatalogoSoap }
     *     
     */
    public void setCatalogo(CatalogoSoap value) {
        this.catalogo = value;
    }

}
