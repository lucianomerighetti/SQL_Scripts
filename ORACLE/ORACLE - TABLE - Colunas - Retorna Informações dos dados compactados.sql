SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('CASHOUT - SYS_P16288');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'CASHOUT',
    subobjname      => 'SYS_P16288',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('CASHOUT - SYS_P16435');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'CASHOUT',
    subobjname      => 'SYS_P16435',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('CASHOUT - SYS_P19808');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'CASHOUT',
    subobjname      => 'SYS_P19808',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('RECEIVABLE_ANTICIPATION - SYS_P30399');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'RECEIVABLE_ANTICIPATION',
    subobjname      => 'SYS_P30399',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('RECEIVABLE_ANTICIPATION - SYS_P38909');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'RECEIVABLE_ANTICIPATION',
    subobjname      => 'SYS_P38909',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('RECEIVABLE_UNIT_EXTERNAL - SYS_P8987');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'RECEIVABLE_UNIT_EXTERNAL',
    subobjname      => 'SYS_P8987',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('RECEIVABLE_UNIT_EXTERNAL - SYS_P17021');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'RECEIVABLE_UNIT_EXTERNAL',
    subobjname      => 'SYS_P17021',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('RECEIVABLE_UNIT_EXTERNAL - SYS_P18493');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'RECEIVABLE_UNIT_EXTERNAL',
    subobjname      => 'SYS_P18493',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('RECEIVABLE_UNIT_INTERNAL - SYS_P12829');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'RECEIVABLE_UNIT_INTERNAL',
    subobjname      => 'SYS_P12829',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('RECEIVABLE_UNIT_INTERNAL - SYS_P16980');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'RECEIVABLE_UNIT_INTERNAL',
    subobjname      => 'SYS_P16980',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('RECEIVABLE_UNIT_INTERNAL - SYS_P16887');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'RECEIVABLE_UNIT_INTERNAL',
    subobjname      => 'SYS_P16887',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/


SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('RECEIVABLE_EXTERNAL - SYS_P8989');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'RECEIVABLE_EXTERNAL',
    subobjname      => 'SYS_P8989',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('RECEIVABLE_EXTERNAL - SYS_P17519');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'RECEIVABLE_EXTERNAL',
    subobjname      => 'SYS_P17519',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('RECEIVABLE_EXTERNAL - SYS_P17455');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'RECEIVABLE_EXTERNAL',
    subobjname      => 'SYS_P17455',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('RECEIVABLE_INTERNAL - SYS_P17489');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'RECEIVABLE_INTERNAL',
    subobjname      => 'SYS_P17489',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('RECEIVABLE_INTERNAL - SYS_P19782');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'RECEIVABLE_INTERNAL',
    subobjname      => 'SYS_P19782',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('RECEIVABLE_INTERNAL - SYS_P14803');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'RECEIVABLE_INTERNAL',
    subobjname      => 'SYS_P14803',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('CONTRACTUAL_EFFECT - SYS_P5788');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'CONTRACTUAL_EFFECT',
    subobjname      => 'SYS_P5788',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('CONTRACTUAL_EFFECT - SYS_P16347');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'CONTRACTUAL_EFFECT',
    subobjname      => 'SYS_P16347',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('CONTRACTUAL_EFFECT - SYS_P14786');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'CONTRACTUAL_EFFECT',
    subobjname      => 'SYS_P14786',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/


SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('CCE_RECEIVABLE_EXTERNAL - SYS_P10064');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'CCE_RECEIVABLE_EXTERNAL',
    subobjname      => 'SYS_P10064',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/


SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('CCE_RECEIVABLE_EXTERNAL - SYS_P16528');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'CCE_RECEIVABLE_EXTERNAL',
    subobjname      => 'SYS_P16528',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('CCE_RECEIVABLE_EXTERNAL - SYS_P18915');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'CCE_RECEIVABLE_EXTERNAL',
    subobjname      => 'SYS_P18915',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('CCE_RECEIVABLE_INTERNAL - SYS_P1508');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'CCE_RECEIVABLE_INTERNAL',
    subobjname      => 'SYS_P1508',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('CCE_RECEIVABLE_INTERNAL - SYS_P12831');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'CCE_RECEIVABLE_INTERNAL',
    subobjname      => 'SYS_P12831',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('CCE_RECEIVABLE_INTERNAL - SYS_P15559');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'CCE_RECEIVABLE_INTERNAL',
    subobjname      => 'SYS_P15559',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('CCE_REASSOCIATE_RECEIVABLE - SYS_P37590');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'CCE_REASSOCIATE_RECEIVABLE',
    subobjname      => 'SYS_P37590',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('REC_ANTICIPATION_INTENT - SYS_P17642');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'REC_ANTICIPATION_INTENT',
    subobjname      => 'SYS_P17642',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('PAYMENT_ADDRESS');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'PAYMENT_ADDRESS',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('RECEIVABLE_UNIT_ASSOCIATION');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'RECEIVABLE_UNIT_ASSOCIATION',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('SUSPENSION_HISTORY');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'SUSPENSION_HISTORY',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('PAYMENT_INTENT - JSN_PAYLOAD');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'PAYMENT_INTENT',
    lobname         => 'JSN_PAYLOAD',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('PAYMENT_SUSPENSION - JSN_PAYLOAD');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'PAYMENT_SUSPENSION',
    lobname         => 'JSN_PAYLOAD',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('RECEIVABLE_EXTERNAL - JSN_BUYER_FEE');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'RECEIVABLE_EXTERNAL',
    lobname         => 'JSN_BUYER_FEE',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('RECEIVABLE_INTERNAL - JSN_BUYER_FEE');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'RECEIVABLE_INTERNAL',
    lobname         => 'JSN_BUYER_FEE',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/

SET SERVEROUTPUT ON
DECLARE
  l_blkcnt_cmp    PLS_INTEGER;
  l_blkcnt_uncmp  PLS_INTEGER;
  l_row_cmp       PLS_INTEGER;
  l_row_uncmp     PLS_INTEGER;
  l_cmp_ratio     NUMBER;
  l_comptype_str  VARCHAR2(32767);
BEGIN
  
  DBMS_OUTPUT.PUT_LINE('SUSPENSION - JSN_PAYLOAD');  

  DBMS_COMPRESSION.get_compression_ratio (
    scratchtbsname  => 'TSDRECEIVABLES01',
    ownname         => 'RECEIVABLES_ADM',
    objname         => 'SUSPENSION',
    lobname         => 'JSN_PAYLOAD',
    comptype        => DBMS_COMPRESSION.COMP_ADVANCED, 
    blkcnt_cmp      => l_blkcnt_cmp,
    blkcnt_uncmp    => l_blkcnt_uncmp,
    row_cmp         => l_row_cmp,
    row_uncmp       => l_row_uncmp,
    cmp_ratio       => l_cmp_ratio,
    comptype_str    => l_comptype_str,
    subset_numrows  => DBMS_COMPRESSION.comp_ratio_allrows,
    objtype         => DBMS_COMPRESSION.objtype_table
  );
  DBMS_OUTPUT.put_line('Number of blocks used (compressed)       : ' ||  l_blkcnt_cmp);
  DBMS_OUTPUT.put_line('Number of blocks used (uncompressed)     : ' ||  l_blkcnt_uncmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (compressed)   : ' ||  l_row_cmp);
  DBMS_OUTPUT.put_line('Number of rows in a block (uncompressed) : ' ||  l_row_uncmp);
  DBMS_OUTPUT.put_line('Compression ratio                        : ' ||  l_cmp_ratio);
  DBMS_OUTPUT.put_line('Compression type                         : ' ||  l_comptype_str);
END;
/
