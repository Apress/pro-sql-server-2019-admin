SELECT 
	  c.name AS ColumnName
	, OBJECT_NAME(c.object_id) AS TableName
	, cek.name AS ColumnEncryptionKey
	, cmk.name AS ColumnMasterKey
	, CASE
		WHEN cmk.allow_enclave_computations = 1
			THEN 'Yes'
		ELSE 'No'
	  END AS SecureEnclaves
FROM sys.columns c
INNER JOIN sys.column_encryption_keys cek 
	ON c.column_encryption_key_id = cek.column_encryption_key_id 
INNER JOIN sys.column_encryption_key_values cekv 
	ON cekv.column_encryption_key_id = cek.column_encryption_key_id 
INNER JOIN sys.column_master_keys cmk 
	ON cmk.column_master_key_id = cekv.column_master_key_id
WHERE allow_enclave_computations = 1
