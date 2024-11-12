//
// Este archivo ha sido generado por la arquitectura JavaTM para la implantación de la referencia de enlace (JAXB) XML v2.3.0 
// Visite <a href="https://javaee.github.io/jaxb-v2/">https://javaee.github.io/jaxb-v2/</a> 
// Todas las modificaciones realizadas en este archivo se perderán si se vuelve a compilar el esquema de origen. 
// Generado el: 2024.11.11 a las 09:59:26 PM ART 
//


package com.unla.soap_client.service1;

import java.util.ArrayList;
import java.util.List;
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
 *         &lt;element name="createdProducts" type="{http://spring.io/guides/gs-producing-web-service}ProductBulkDTO" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="errors" type="{http://spring.io/guides/gs-producing-web-service}ProductParseErrorSoap" maxOccurs="unbounded"/&gt;
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
    "createdProducts",
    "errors"
})
@XmlRootElement(name = "ProductBulkUploadResponse")
public class ProductBulkUploadResponse {

    protected List<ProductBulkDTO> createdProducts;
    @XmlElement(required = true)
    protected List<ProductParseErrorSoap> errors;

    /**
     * Gets the value of the createdProducts property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the createdProducts property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getCreatedProducts().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link ProductBulkDTO }
     * 
     * 
     */
    public List<ProductBulkDTO> getCreatedProducts() {
        if (createdProducts == null) {
            createdProducts = new ArrayList<ProductBulkDTO>();
        }
        return this.createdProducts;
    }

    /**
     * Gets the value of the errors property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the errors property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getErrors().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link ProductParseErrorSoap }
     * 
     * 
     */
    public List<ProductParseErrorSoap> getErrors() {
        if (errors == null) {
            errors = new ArrayList<ProductParseErrorSoap>();
        }
        return this.errors;
    }

}
