# Replication Scripts — Modelling NULL Values Representation in an OLTP Database Instance

Bachelor End Project, TU/e
Author: Jan Austin Galić | Supervisors: prof. dr. Robert Brijder, prof. Hildo Bijl

## Prerequisites

### Dataset
- AdventureWorks2019 backup file, available at:
  https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/adventure-work

### SQL
- SQL Server 2022

### Python
- `matplotlib==3.6.2`
- `numpy==1.26.4`

## Repository Structure

| Folder | Appendix | Contents |
|--------|----------|----------|
| `setup/` | A | Database restore, attribute selection, 6NF creation, Status Column creation |
| `taxonomy/` | B | Distributional analysis queries |
| `evaluation/` | C | Each schema's version of the seven representative queries, generating performance measurements |
| `visualisation/` | E | Python scripts for generating figures within the report |

```
null-modelling-oltp-evaluation/
│
├── setup/
│   ├── restore.sql                            
│   ├── 01_generate_union.sql                  
│   ├── 02_missingness_filter.sql            
│   ├── 6nf/
│   │   ├── 01_create_child_tables.sql         
│   │   ├── 02_insert_data_into_child_tables.sql      
│   │   └── 03_delete_data_from_parent_table.sql       
│   └── status_column/
│   │   ├── 01_add_status_columns.sql          
│   │   ├── 02_populate_status_columns.sql
│   │   └── 03_add_constraints_on_status_cols.sql
│   └── taxonomy/
│   │   ├── 01_middle-name.sql                    
│   │   ├── 02_color.sql                        
│   │   ├── 03_size_size-unit-measure-code.sql                         
│   │   ├── 04_weight_weight-unit-measure-code.sql                           
│   │   ├── 05_class.sql
│   │   ├── 06_currency-rate-id.sql
│   │   ├── 07_carrier-tracking-number.sql
│   │   ├── 08_style.sql
│   │   ├── 09_product-line.sql                  
│   │   └── 10_product-model-id_product_subcat-id.sql                 
│
├── evaluation/
│   ├── Baseline.sql                        
│   ├── 6NF.sql                             
│   └── status_column.sql                   
│
├── visualisation/
│   └── Figures.ipynb           
│
└── README.md
```

## Execution Order

### 1. Database setup (`setup/`)

The scripts (`restore.sql`, `01_generate_union.sql`, `02_missingness_filter.sql`) are run once against the unmodified baseline instance. 
> **Note:** `setup/restore.sql` contains file paths specific to this project, thereby, need to be adjusted accordingly.
Scripts within `setup/6nf/` and `setup/status_column/` need to be exectured in the order of its prefixes. 

### 2. Taxonomy derivation (`taxonomy/`)

Run each script against the unmodified baseline instance. The output of each script is the distributional evidence that supports the missingness reasons classification used within this project.

### 3. Evaluation (`evaluation/`)

Run each script against its respective schema instance:

| Script | Schema instance |
|--------|----------------|
| `baseline.sql` | Unmodified AdventureWorks2019 |
| `6NF.sql` | Instance after running all `setup/6nf/` scripts |
| `status_column.sql` | Instance after running all `setup/status_column/` scripts |

Each script clears the buffer pool and procedure cache before execution (`CHECKPOINT`, `DBCC DROPCLEANBUFFERS`, `DBCC FREEPROCCACHE`), runs each query five times, discards run 1 to eliminate plan compilation effects, and returns average runtime in microseconds.
Logical I/O values are written to the Messages pane via `SET STATISTICS IO ON`.

### 4. Visualisation (`visualisation/`)

Contains a jupyter notebook, in which each cell generates one of the visualizations used in the report.

## Notes

- The 6NF and Status Column schema instances are destructive modifications of AdventureWorks2019. Restore a fresh copy of the
  database before setting up each schema instance, or maintain three separate databases in parallel.
