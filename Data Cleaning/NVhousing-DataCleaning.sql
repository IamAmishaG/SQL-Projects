select * from NVhousing;

--------------------------- SaleDate changing datetime to date format --------------------------
select SaleDate, CONVERT(date, SaleDate) from NVhousing; 

Alter table NVhousing
Add SaleDateConv date;

Update NVhousing
set SaleDateConv = CAST(SaleDate AS date); 


---------------------------- Populate Property Address ------------------------------------------


--select ParcelID, PropertyAddress from NVhousing 
--where PropertyAddress IS NULL 
--order by ParcelID;

--select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.propertyAddress, b.PropertyAddress)
--from NVhousing a join NVhousing b on a.ParcelID = b.ParcelID and a.[UniqueID ] <> b.[UniqueID ] 
--where a.PropertyAddress IS NULL; 

Update a
set PropertyAddress = ISNULL(a.propertyAddress, b.PropertyAddress)
from NVhousing a join NVhousing b on a.ParcelID = b.ParcelID and a.[UniqueID ] <> b.[UniqueID ] 
where a.PropertyAddress IS NULL; 

------------------------------ Segregating Address into separate coloumns ---------------------

--select PropertyAddress from NVhousing;

--select SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1), 
--SUBSTRING(PropertyAddress, (CHARINDEX(',',PropertyAddress)+1), LEN(PropertyAddress))
--from NVhousing;

Alter table NVhousing
add PropertyAddressPlace nvarchar(255) ,
PropertyAddressCity nvarchar(255);


Update NVhousing
set PropertyAddressPlace = LEFT(PropertyAddress, CHARINDEX(',',PropertyAddress)-1) from NVhousing;

Update NVhousing
set PropertyAddressCity = RIGHT(PropertyAddress, CHARINDEX(',',REVERSE(PropertyAddress))-1) from NVhousing;


/*select 
PARSENAME(REPLACE(OwnerAddress, ',', '.'),3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'),2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)
from NVhousing;
*/

Alter table NVhousing
add OwnerAddressPlace nvarchar(255) ,
OwnerAddressCity nvarchar(255),
OwnerAddressState nvarchar(255); 

Update NVhousing
set OwnerAddressPlace = PARSENAME(REPLACE(OwnerAddress, ',', '.'),3); 

Update NVhousing
set OwnerAddressCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'),2);

Update NVhousing
set OwnerAddressState = PARSENAME(REPLACE(OwnerAddress, ',', '.'),1); 


---------------------------------------- Change Y/N to YES/NO -----------------------------------

--to maintain discrepancy

/*select Distinct(SoldAsVacant), COUNT(SoldAsVacant) from NVhousing group by SoldAsVacant order by 2;

Select  SoldAsVacant, Case 
	when SoldAsVacant = 'Y' then  'Yes'
	when SoldAsVacant = 'N' then 'NO'
	else SoldAsVacant
end
from NVhousing; 
*/

Update NVhousing
set SoldAsVacant = Case 
	when SoldAsVacant = 'Y' then  'Yes'
	when SoldAsVacant = 'N' then 'NO'
	else SoldAsVacant
end; 

--------------------------------------- Remove Duplicates -----------------------------------------

with rownumCTE AS(
select *, 
	ROW_NUMBER() over(partition by ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
	order by UniqueID) row_num
from NVhousing
)

delete from rownumCTE where row_num> 1 

--select * from rownumCTE where row_num> 1 order by PropertyAddress

---------------------------------------Delete unused columns --------------------------------------

Alter table NVhousing 
drop column SaleDate, PropertyAddress, OwnerAddress, TaxDistrict;

--select * from NVhousing;