# frozen_string_literal: true

module Philiprehberger
  module Phone
    # Area code metadata for US, CA, GB, and DE
    AREA_CODES = {
      us: {
        '212' => 'New York, NY',
        '213' => 'Los Angeles, CA',
        '214' => 'Dallas, TX',
        '215' => 'Philadelphia, PA',
        '216' => 'Cleveland, OH',
        '224' => 'Northern Illinois',
        '301' => 'Maryland',
        '302' => 'Delaware',
        '303' => 'Denver, CO',
        '305' => 'Miami, FL',
        '310' => 'Los Angeles, CA',
        '312' => 'Chicago, IL',
        '313' => 'Detroit, MI',
        '314' => 'St. Louis, MO',
        '323' => 'Los Angeles, CA',
        '347' => 'New York, NY',
        '404' => 'Atlanta, GA',
        '408' => 'San Jose, CA',
        '410' => 'Baltimore, MD',
        '412' => 'Pittsburgh, PA',
        '415' => 'San Francisco, CA',
        '425' => 'Bellevue, WA',
        '470' => 'Atlanta, GA',
        '480' => 'Phoenix, AZ',
        '503' => 'Portland, OR',
        '504' => 'New Orleans, LA',
        '510' => 'Oakland, CA',
        '512' => 'Austin, TX',
        '513' => 'Cincinnati, OH',
        '515' => 'Des Moines, IA',
        '516' => 'Long Island, NY',
        '551' => 'Northern New Jersey',
        '555' => 'Fictional/Reserved',
        '602' => 'Phoenix, AZ',
        '612' => 'Minneapolis, MN',
        '617' => 'Boston, MA',
        '619' => 'San Diego, CA',
        '626' => 'Pasadena, CA',
        '650' => 'San Mateo, CA',
        '702' => 'Las Vegas, NV',
        '703' => 'Northern Virginia',
        '704' => 'Charlotte, NC',
        '713' => 'Houston, TX',
        '714' => 'Orange County, CA',
        '718' => 'New York, NY',
        '720' => 'Denver, CO',
        '737' => 'Austin, TX',
        '747' => 'Los Angeles, CA',
        '773' => 'Chicago, IL',
        '801' => 'Salt Lake City, UT',
        '802' => 'Vermont',
        '808' => 'Hawaii',
        '818' => 'Los Angeles, CA',
        '832' => 'Houston, TX',
        '847' => 'Northern Illinois',
        '858' => 'San Diego, CA',
        '862' => 'Northern New Jersey',
        '901' => 'Memphis, TN',
        '917' => 'New York, NY',
        '919' => 'Raleigh, NC',
        '925' => 'East Bay, CA',
        '929' => 'New York, NY',
        '949' => 'Orange County, CA',
        '972' => 'Dallas, TX'
      },
      ca: {
        '204' => 'Manitoba',
        '226' => 'Southwestern Ontario',
        '236' => 'British Columbia',
        '249' => 'Northern Ontario',
        '250' => 'British Columbia',
        '289' => 'Greater Toronto Area',
        '306' => 'Saskatchewan',
        '343' => 'Eastern Ontario',
        '365' => 'Greater Toronto Area',
        '403' => 'Alberta (South)',
        '416' => 'Toronto, ON',
        '418' => 'Quebec City, QC',
        '431' => 'Manitoba',
        '437' => 'Toronto, ON',
        '438' => 'Montreal, QC',
        '450' => 'Greater Montreal',
        '506' => 'New Brunswick',
        '514' => 'Montreal, QC',
        '519' => 'Southwestern Ontario',
        '548' => 'Southwestern Ontario',
        '579' => 'Quebec',
        '581' => 'Quebec',
        '587' => 'Alberta',
        '604' => 'Vancouver, BC',
        '613' => 'Ottawa, ON',
        '639' => 'Saskatchewan',
        '647' => 'Toronto, ON',
        '672' => 'British Columbia',
        '705' => 'Northern Ontario',
        '709' => 'Newfoundland',
        '778' => 'British Columbia',
        '780' => 'Alberta (North)',
        '807' => 'Northwestern Ontario',
        '819' => 'Quebec (West)',
        '867' => 'Northern Territories',
        '873' => 'Quebec',
        '902' => 'Nova Scotia/PEI',
        '905' => 'Greater Toronto Area'
      },
      gb: {
        '20' => 'London',
        '21' => 'Birmingham',
        '23' => 'Southampton/Portsmouth',
        '24' => 'Coventry',
        '28' => 'Northern Ireland',
        '29' => 'Cardiff',
        '113' => 'Leeds',
        '114' => 'Sheffield',
        '115' => 'Nottingham',
        '116' => 'Leicester',
        '117' => 'Bristol',
        '118' => 'Reading',
        '121' => 'Birmingham',
        '131' => 'Edinburgh',
        '141' => 'Glasgow',
        '151' => 'Liverpool',
        '161' => 'Manchester',
        '171' => 'London (Historic)',
        '191' => 'Newcastle'
      },
      de: {
        '30' => 'Berlin',
        '40' => 'Hamburg',
        '69' => 'Frankfurt',
        '89' => 'Munich',
        '211' => 'Dusseldorf',
        '221' => 'Cologne',
        '228' => 'Bonn',
        '231' => 'Dortmund',
        '241' => 'Aachen',
        '251' => 'Munster',
        '341' => 'Leipzig',
        '351' => 'Dresden',
        '361' => 'Erfurt',
        '371' => 'Chemnitz',
        '381' => 'Rostock',
        '391' => 'Magdeburg',
        '511' => 'Hannover',
        '521' => 'Bielefeld',
        '551' => 'Gottingen',
        '611' => 'Wiesbaden',
        '621' => 'Mannheim',
        '711' => 'Stuttgart',
        '721' => 'Karlsruhe',
        '911' => 'Nuremberg'
      }
    }.freeze

    module AreaCodeLookup
      def area_code_info
        return nil unless @country

        codes = AREA_CODES[@country]
        return nil unless codes

        # Try different area code lengths (longest first for specificity)
        [4, 3, 2].each do |len|
          next if @national.length < len

          prefix = @national[0, len]
          region = codes[prefix]
          return { area_code: prefix, region: region } if region
        end

        nil
      end
    end
  end
end
