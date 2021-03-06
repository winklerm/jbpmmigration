<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:jpdl="urn:jbpm.org:jpdl-3.2"
  xmlns="http://www.omg.org/spec/BPMN/20100524/MODEL">

  <xsl:template match="jpdl:transition">
  	
  	<xsl:param name="superstate" />
    
    <sequenceFlow>
      <xsl:attribute name="id">
  		<xsl:text>flow_</xsl:text>
   		<xsl:value-of select="translate(../@name,' ','_')" />
		<xsl:value-of select='position()' />
	  </xsl:attribute>
      <xsl:attribute name="sourceRef">
      	<xsl:if test="string-length($superstate) > 0">
       		<xsl:value-of select="$superstate" />
			<xsl:text>/</xsl:text>
		</xsl:if>
     	<xsl:value-of select="translate(../@name,' ','_')" />
	  </xsl:attribute>
	  
	  <xsl:choose>
		  <xsl:when test="starts-with(@to, '../')">
		    <xsl:choose>
			    <xsl:when test="contains((jpdl:super-state), 'superstate-leave')">
				  <xsl:attribute name="targetRef">
				  	<xsl:text>javanode_leavenode_</xsl:text>
			        <xsl:value-of select="translate(@name,' ','_')" />
				  </xsl:attribute>		  		  	
			  	</xsl:when>
			  	<xsl:otherwise>
				  <xsl:attribute name="targetRef">			    
				    <xsl:value-of select="substring-after(@to,'../')" />
				  </xsl:attribute>
				</xsl:otherwise>
		    </xsl:choose>
		  </xsl:when>
		  <xsl:when test="starts-with(@name, 'super-state')">
			  <xsl:attribute name="targetRef">
				<xsl:value-of select="translate(@name,' ','_')" />
			  </xsl:attribute>		  
		  </xsl:when>
		  
		  <xsl:otherwise>
			  <xsl:attribute name="targetRef">
			  	<xsl:if test="string-length($superstate) > 0">
          			<xsl:value-of select="$superstate" />
					<xsl:text>/</xsl:text>
			    </xsl:if>
		    	<xsl:value-of select="translate(@to,' ','_')" />
			 </xsl:attribute>
		  </xsl:otherwise>	      
	  </xsl:choose>
	  
    </sequenceFlow>
  </xsl:template>

  <xsl:template match="jpdl:transition" mode="start-event-javanode">
    <sequenceFlow>
      <xsl:attribute name="id">
		<xsl:text>flow_</xsl:text>
		<xsl:value-of select="translate(../@name,' ','_')" />
		<xsl:value-of select='position()' />
	  </xsl:attribute>
      <xsl:attribute name="sourceRef">
		<xsl:text>javanode_</xsl:text>
	    <xsl:value-of select="translate(../@name,' ','_')" />
	  </xsl:attribute>
      <xsl:attribute name="targetRef">
	    <xsl:value-of select="translate(@to,' ','_')" />
	  </xsl:attribute>
    </sequenceFlow>
  </xsl:template>

  <xsl:template match="jpdl:transition" mode="signal-leave">
    <sequenceFlow>
      <xsl:attribute name="id">
		<xsl:text>flow_</xsl:text>
		<xsl:value-of select="translate(../@name,' ','_')" />
		<xsl:value-of select='position()' />
	  </xsl:attribute>
      <xsl:attribute name="sourceRef">
		<xsl:text>signal: </xsl:text>
	    <xsl:value-of select="translate(../@name,' ','_')" />
	  </xsl:attribute>
      <xsl:attribute name="targetRef">
	    <xsl:value-of select="translate(@to,' ','_')" />
	  </xsl:attribute>
    </sequenceFlow>
  </xsl:template>
  
  <xsl:template match="jpdl:transition" mode="node-leave-event">
    <sequenceFlow>
      <xsl:attribute name="id">
		<xsl:text>flow_</xsl:text>
		<xsl:value-of select="translate(../@name,' ','_')" />
		<xsl:value-of select='position()' />
	  </xsl:attribute>
      <xsl:attribute name="sourceRef">
		<xsl:text>javanode_leavenode_</xsl:text>
	    <xsl:value-of select="translate(../@name,' ','_')" />
	  </xsl:attribute>
      <xsl:attribute name="targetRef">
	    <xsl:value-of select="translate(@to,' ','_')" />
	  </xsl:attribute>
    </sequenceFlow>
  </xsl:template>
  
  <xsl:template match="jpdl:transition" mode="node-leave-humantask">
    <sequenceFlow>
      <xsl:attribute name="id">
		<xsl:text>flow_</xsl:text>
		<xsl:value-of select="translate(../@name,' ','_')" />
		<xsl:value-of select='position()' />
	  </xsl:attribute>
      <xsl:attribute name="sourceRef">
		<xsl:text>usertask_</xsl:text>
	    <xsl:value-of select="translate(../@name,' ','_')" />
	  </xsl:attribute>
      <xsl:attribute name="targetRef">
	    <xsl:value-of select="translate(@to,' ','_')" />
	  </xsl:attribute>
    </sequenceFlow>
  </xsl:template>

  <xsl:template match="jpdl:transition" mode="leave-scripttask">
    <sequenceFlow>
      <xsl:attribute name="id">
		<xsl:text>flow_</xsl:text>
		<xsl:value-of select="translate(../@name,' ','_')" />
		<xsl:value-of select='position()' />
	  </xsl:attribute>
      <xsl:attribute name="sourceRef">
		<xsl:text>nodetask_</xsl:text>
	    <xsl:value-of select="translate(../@name,' ','_')" />
	  </xsl:attribute>
      <xsl:attribute name="targetRef">
	    <xsl:value-of select="translate(@to,' ','_')" />
	  </xsl:attribute>
    </sequenceFlow>
  </xsl:template>
  
 <xsl:template match="jpdl:transition" mode="javanode-leavenode-humantask">
    <sequenceFlow>
      <xsl:attribute name="id">
		<xsl:text>flow_</xsl:text>
		<xsl:value-of select="translate(../@name,' ','_')" />
		<xsl:value-of select='position()' />
	  </xsl:attribute>
      <xsl:attribute name="sourceRef">
		<xsl:text>javanode_leavenode_</xsl:text>
	    <xsl:value-of select="translate(../@name,' ','_')" />
	  </xsl:attribute>
      <xsl:attribute name="targetRef">
	    <xsl:value-of select="translate(@to,' ','_')" />
	  </xsl:attribute>
    </sequenceFlow>
  </xsl:template>
</xsl:stylesheet>
