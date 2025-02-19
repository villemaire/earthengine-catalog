local id = 'NRCan/CDEM';
local subdir = 'NRCan';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.ogl_canada_2_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
  ],
  id: id,
  title: 'SCANFI: the Spatialized CAnadian National Forest Inventory data product',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This data publication contains a set of 30m resolution raster files representing 2020 Canadian wall-to-wall maps of broad land cover type, forest canopy height, degree of crown closure and aboveground tree biomass, along with species composition of several major tree species. The Spatialized CAnadian National Forest Inventory data product (SCANFI) was developed using the newly updated National Forest Inventory photo-plot dataset, which consists of a regular sample grid of photo-interpreted high-resolution imagery covering all of Canada’s non-arctic landmass. SCANFI was produced using temporally harmonized summer and winter Landsat spectral imagery along with hundreds of tile-level regional models based on a novel k-nearest neighbours and random forest imputation method.

    A full description of all methods and validation analyses can be found in Guindon et al. (2024). As the Arctic ecozones are outside NFI’s covered areas, the vegetation attributes in these regions were predicted using a single random forest model. The vegetation attributes in these arctic areas could not be rigorously validated. The raster file « SCANFI_aux_arcticExtrapolationArea.tif » identifies these zones.

    SCANFI is not meant to replace nor ignore provincial inventories which could include better and more regularly updated inputs, training data and local knowledge. Instead, SCANFI was developed to provide a current, spatially-explicit estimate of forest attributes, using a consistent data source and methodology across all provincial boundaries and territories. SCANFI is the first coherent 30m Canadian wall-to-wall map of tree structure and species composition and opens novel opportunities for a plethora of studies in a number of areas, such as forest economics, fire science and ecology.

    Full metadata and download links can be found on Canada Open:
    [https://doi.org/10.23687/18e6a919-53fd-41ce-b4e2-44a9707c52dc](https://doi.org/10.23687/18e6a919-53fd-41ce-b4e2-44a9707c52dc)

    Details on the product development and validation can be found in the following publication:
    [Guindon, L., Manka, F., Correia, D.L.P., Villemaire, P., Smiley, B., Bernier, P., Gauthier, S., Beaudoin, A., Boucher, J., and Boulanger, Y. 2024. A new approach for Spatializing the Canadian National Forest Inventory (SCANFI) using Landsat dense time series. Can. J. For. Res.](https://doi.org/10.1139/cjfr-2023-0118)

    Please cite this dataset as:
    Guindon L., Villemaire P., Correia D.L.P., Manka F., Lacarte S., Smiley B. 2023. SCANFI: Spatialized CAnadian National Forest Inventory data product. Natural Resources Canada, Canadian Forest Service, Laurentian Forestry Centre, Quebec, Canada. https://doi.org/10.23687/18e6a919-53fd-41ce-b4e2-44a9707c52dc

    Contains information licensed under the
    [Open Government Licence - Canada](https://open.canada.ca/en/open-government-licence-canada).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://ftp.maps.canada.ca/pub/nrcan_rncan/Forests_Foret/SCANFI/v1/',
    },
  ],
  keywords: [
    'canada',
    'nrcan',
    'forest attributes maps', 
    'Forests',
    'Forest management',
    'Trees',
    'Forest fires',
    'Modelling',
  ],
  providers: [
    ee.producer_provider('NRCan', 'https://open.canada.ca/data/en/dataset/18e6a919-53fd-41ce-b4e2-44a9707c52dc'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-142.0, 41.0, -52.0, 84.0,
                    '2020-01-01T00:00:00Z', '2021-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      30,
    ],
    'eo:bands': [
      {
        name: 'Landcover',
        description: 'NFI land cover class values: Land cover classes include Bryoid (1), Herbs (2), Rock (3), Shrub (4), Treed broadleaf (5), Treed conifer (6), Treed mixed (7) and  Water (8)',
        'gee:units': units.meter,
        name: 'NFI_land_cover',
        description: 'Main crop-specific land cover classification.',
        'gee:classes': [
          {value: 1, color: 'e64bfa', description: 'Bryoid'},
          {value: 2, color: 'e7e56c', description: 'Herbs'},
          {value: 3, color: '000000', description: 'Rock'},
          {value: 4, color: 'bd0006', description: 'Shrub'},
          {value: 5, color: '95ea4b', description: 'Treed broadleaf'},
          {value: 6, color: '048e4e', description: 'Coniferous'},
          {value: 7, color: '16d132', description: 'Treed mixed'},
          {value: 8, color: '3be5ff', description: 'Water'},
        ],
      },
      {
        name: 'Biomass',
        description: 'Aboveground tree biomass (tons/ha): biomass derived from total merchantable volume estimates produced by provincial agencies',
        'gee:units': units.tons_per_hectare,
      },
      {
        name: 'Height',
        description: 'Height (meters): vegetation height',
        'gee:units': units.meter,
      },
      {
        name: 'Crown_closure',
        description: 'Crown closure (%): percentage of pixel covered by the tree canopy',
        'gee:units': ee_const.var_type.double,
      },
      {
        name: 'Balsam_fir',
        description: 'Balsam fir (%): estimated as the proportion of the canopy covered by Abies balsamea',
        'gee:units': ee_const.var_type.double,
      },
      {
        name: 'Black_spruce',
        description: 'Black spruce (%): estimated as the proportion of the canopy covered by Picea mariana',
        'gee:units': ee_const.var_type.double,
      },
      {
        name: 'Douglas_fir',
        description: 'Douglas fir (%): estimated as the proportion of the canopy covered by Pseudotsuga menziesii',
        'gee:units': ee_const.var_type.double,
      },
      {
        name: 'Jack_pine',
        description: 'Jack pine (%): estimated as the proportion of the canopy covered by Pinus banksiana',
        'gee:units': ee_const.var_type.double,
      },
      {
        name: 'Lodgepole_pine',
        description: 'Lodgepole pine (%): estimated as the proportion of the canopy covered by Pinus contorta',
        'gee:units': ee_const.var_type.double,
      },
      {
        name: 'Ponderosa_pine',
        description: 'Ponderosa pine (%): estimated as the proportion of the canopy covered by Pinus ponderosa',
        'gee:units':ee_const.var_type.double,
      },
      {
        name: 'Tamarack',
        description: 'Tamarack_tree (%): estimated as the proportion of the canopy covered by Larix laricina',
        'gee:units': ee_const.var_type.double,
      },
      {
        name: 'White_and_red_pine',
        description: 'White and red pine (%): estimated as the proportion of the canopy covered by Pinus strobus and Pinus resinosa',
        'gee:units': ee_const.var_type.double,
      },
      {
        name: 'Broadleaf',
        description: 'Broadleaf tree cover in percentage (PrcB)',
        'gee:units':ee_const.var_type.double,
      },
      {
        name: 'Other_coniferous',
        description: 'Other coniferous tree cover in percentage (PrcC)',
        'gee:units': ee_const.var_type.double,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'NFI land cover ',
        lookat: {
          lat: 60,
          lon: -95,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              8.0,
            ],
            palette: [
              'e64bfa', 'e7e56c', '000000', 'bd0006', 
              '95ea4b', '048e4e', '16d132', '3be5ff',
            ],
            bands: [
              'Landcover',
            ],
          },
        },
      },
    ],
    Landcover: {
      minimum: 1.0,
      maximum: 8.0,
      'gee:estimated_range': false,
    },
  },
  'gee:terms_of_use': |||
    Licensed under the
    [Open Government Licence - Canada](https://open.canada.ca/en/open-government-licence-canada).
  |||,
}
