[![E3SM Logo](https://e3sm.org/wp-content/themes/e3sm/assets/images/e3sm-logo.png)](https://e3sm.org)

Energy Exascale Earth System Model (E3SM)
================================================================================
E3SM is a state-of-the-art fully coupled model of the Earth's climate including
important biogeochemical and cryospheric processes. It is intended to address
the most challenging and demanding climate-change research problems and
Department of Energy mission needs while efficiently using DOE Leadership
Computing Facilities.  

DOI: [10.11578/E3SM/dc.20180418.36](http://dx.doi.org/10.11578/E3SM/dc.20180418.36)

Please visit the [project website](https://e3sm.org) for further details.

## Modified Longwave radiation (ice scattering + realistic surface emissivity) 
### By Prof. Xianglei Huang's group at U-Michigan.

* Contribute Authors:
	* Yi-Hsuan Chen (yihsuan@umich.edu)
	* Xiuhong Chen (xiuchen@umich.edu)
	* Xianwen Jing (xianwen@umich.edu)

* History:
	* 2019/12/30  First release
	* 2020/02/26  Add discription of spectral emissivity modification and three iceflags for ice scattering optics.
	* 2020/04/02  Add overview. Modify discription of spectral emissivity (more files are changed). Add discription of changes in rrtmgp.

```
*********************** overview of U-Mich modifications *************************
```
 
#### &&& CAM:
* Path 1: $E3SM_root/components/cam/src/physics/rrtmg/
	* cloud_rad_props.F90
	* radconstants.F90
	* radiation.F90
	* radlw.F90
	* rrtmg_state.F90
* Path 2: $E3SM_root/components/cam/src/physics/rrtmg/ext/rrtmg_lw/
	* rrlw_cld.f90
	* rrtmg_lw_init.f90
* Path 3: $E3SM_root/components/cam/src/physics/rrtmg/ext/rrtmg_mcica/
	* mcica_subcol_gen_lw.f90
	* rrtmg_lw_rad.f90
	* rrtmg_lw_rtrnmc.f90
* Path 4: $E3SM_root/components/cam/src/cpl/
	* atm_comp_mct.F90
	* atm_import_export.F90
	* cam_cpl_indices.F90
* Path 5: $E3SM_root/components/cam/src/control/
	* camsrfexch.F90
* Path 6: $E3SM_root/components/cam/bld/namelist_files/
	* namelist_definition.xml
* Path_for_RRTMGP:$E3SM_root/components/cam/src/physics/rrtmgp/ 
	* cam_optics.F90
	* cloud_rad_props.F90
	* mc6_ice_optics.F90  (newly added)
	* radconstants.F90
	* radiation.F90

#### &&& CIME:
* Path 7: $E3SM_root/cime/src/drivers/mct/shr/
	* seq_flds_mod.F90

#### &&& CLM:
* Path 8: $E3SM_root/components/clm/src/cpl/
	* lnd_import_export.F90
	* clm_cpl_indices.F90
* Path 9: $E3SM_root/components/clm/src/main/
	* lnd2atmType.F90
	* lnd2atmMod.F90
	* atm2lndType.F90
	* clm_driver.F90

#### &&& Runtime setups:
* Setups in run_scripts
	* If use RRTMG: ln -s /global/cscratch1/sd/xianwen/data/emis/surface_emissivity_1x1_RRTMG_53deg.nc $case_run_dir/surface_emissivity_1x1_UMRad_53deg.nc
	* If use RRTMGP: ln -s /global/cscratch1/sd/xianwen/data/emis/surface_emissivity_1x1_RRTMGP_53deg.nc $case_run_dir/surface_emissivity_1x1_UMRad_53deg.nc
* Setups in usr_nl_cam
	* flag_mc6=.true.
	* flag_emis=.true.
	* flag_scat=.true.
	* flag_rtr2=.true. (this is not used if RRTMGP is selected.)

```
********************** End U-Mich modification overview **********************
```

Table of Contents 
--------------------------------------------------------------------------------
- [Quick Start](#quickstart)
- [Supported Machines](#supportedmachines)
- [Running](#running)
- [Contributing](#contributing)
- [Acknowledge](#acknowledge)
- [License](#license)

Quick Start
--------------------------------------------------------------------------------
The [Quick Start](https://e3sm.org/model/running-e3sm/e3sm-quick-start/) page 
includes instructions on obtaining the necessary code and input data for model 
setup and execution.

Supported Machines 
--------------------------------------------------------------------------------
E3SM is high-performance computing application and generally requires a cluster
with several hundred nodes to run a scientifically validated case at a useful
simulation speed.

To run E3SM, it is recommended that you obtain time on a 
[Supported Machine](https://e3sm.org/model/running-e3sm/supported-machines/).

Running
--------------------------------------------------------------------------------
Please refer to [Running E3SM](https://e3sm.org/model/running-e3sm/) 
 for instructions on running the model. 

Contributing
--------------------------------------------------------------------------------
Please refer to [Contributing](CONTRIBUTING.md) for details on our code development
process for submitting pull requests.

Acknowledgement
--------------------------------------------------------------------------------
The Energy Exascale Earth System Model (E3SM) Project should be acknowledged in
publications as the origin of the model using
[these guidelines](https://e3sm.org/resources/policies/acknowledge-e3sm/).

In addition, the software should be cited.  For your convenience,
the following BibTeX entry is provided.
```TeX
@misc{e3sm-model,
	title = {{Energy Exascale Earth System Model (E3SM)}},
	author = {{E3SM Project}},
	abstractNote = {{E3SM} is a state-of-the-art fully coupled model of the {E}arth's 
		climate including important biogeochemical and cryospheric processes.},
	howpublished = {[Computer Software] \url{https://dx.doi.org/10.11578/E3SM/dc.20180418.36}},
	url = {https://dx.doi.org/10.11578/E3SM/dc.20180418.36},
	doi = {10.11578/E3SM/dc.20180418.36},
	year = 2018,
	month = apr,
}
```

License
--------------------------------------------------------------------------------
The E3SM model became open development at the time of first model and data release.
Please see [LICENSE](LICENSE) for details.

