namespace :team do
  desc "Backfill country field"
  task backfill_country: :environment do
    team_to_country = {
      "Aberdeen City Council" => "country:GB-SCT",
      "Aberdeenshire Council" => "country:GB-SCT",
      "Angus Council" => "country:GB-SCT",
      "Antrim & Newtownabbey Council" => "country:GB-NIR",
      "Ards and North Down Borough Council" =>	"country:GB-NIR",
      "Argyll and Bute Council" => "country:GB-SCT",
      "Armagh, Banbridge and Craigavon Council" =>	"country:GB-NIR",
      "Barking and Dagenham Borough" =>	"country:GB-ENG",
      "Barnsley Metropolitan Council" =>	"country:GB-ENG",
      "Bath and North East Somerset Council" =>	"country:GB-ENG",
      "Bedford Borough Council" =>	"country:GB-ENG",
      "Belfast City Council" =>	"country:GB-NIR",
      "Birmingham City Council" =>	"country:GB-ENG",
      "Blackburn with Darwen Borough Council" =>	"country:GB-ENG",
      "Blackpool Borough Council" =>	"country:GB-ENG",
      "Blaenau Gwent and Torfaen County Borough Council" =>	"country:GB-WLS",
      "Bolton Metropolitan Borough Council" =>	"country:GB-ENG",
      "Bournemouth, Christchurch and Poole Councils" =>	"country:GB-ENG",
      "Bracknell Forest, West Berkshire and Wokingham Councils" => "country:GB-ENG",
      "Bridgend, Cardiff and the Vale of Glamorgan" =>	"country:GB-WLS",
      "Brighton & Hove City Council" =>	"country:GB-ENG",
      "Bristol City Council" =>	"country:GB-ENG",
      "Buckinghamshire & Surrey Councils" =>	"country:GB-ENG",
      "Bury Metropolitan Borough Council" =>	"country:GB-ENG",
      "Caerphilly County Borough Council" =>	"country:GB-WLS",
      "Cambridgeshire County Council" =>	"country:GB-ENG",
      "Carmarthenshire County Council" =>	"country:GB-WLS",
      "Causeway Coast and Glens Council" =>	"country:GB-NIR",
      "Central Bedfordshire Council" =>	"country:GB-ENG",
      "Ceredigion County Council" =>	"country:GB-WLS",
      "Cheshire East Council" =>	"country:GB-ENG",
      "Cheshire West and Chester Council" =>	"country:GB-ENG",
      "City of Edinburgh Council" => "country:GB-SCT",
      "City of London" =>	"country:GB-ENG",
      "City of Stoke on Trent" => "country:GB-ENG",
      "City of Westminster" => "country:GB-ENG",
      "City of York" => "country:GB-ENG",
      "Comhairle Nan Eilean Siar" => "country:GB-SCT",
      "Conwy County Borough Council" =>	"country:GB-WLS",
      "Cornwall County Council" =>	"country:GB-ENG",
      "Coventry City Council" =>	"country:GB-ENG",
      "Cumbria County Council" =>	"country:GB-ENG",
      "Darlington Borough Council" =>	"country:GB-ENG",
      "Denbighshire County Council" =>	"country:GB-WLS",
      "Derby City Council" =>	"country:GB-ENG",
      "Derbyshire County Council" =>	"country:GB-ENG",
      "Derry City and Strabane Council" =>	"country:GB-NIR",
      "Devon, Somerset and Torbay Councils" =>	"country:GB-ENG",
      "Doncaster Metropolitan Council" =>	"country:GB-ENG",
      "Dorset County Council" =>	"country:GB-ENG",
      "Driving Vehicle Standards Agency" =>	"country:GB",
      "Dudley Metropolitan Borough Council" =>	"country:GB-ENG",
      "Dumfries and Galloway Council" => "country:GB-SCT",
      "Dundee City Council" =>	"country:GB-SCT",
      "Durham County Council" =>	"country:GB-ENG",
      "East Ayrshire Council" =>	"country:GB-SCT",
      "East Dunbartonshire Council" =>	"country:GB-SCT",
      "East Lothian Council" =>	"country:GB-SCT",
      "East Renfrewshire Council" =>	"country:GB-SCT",
      "East Riding of Yorkshire Council" =>	"country:GB-ENG",
      "East Sussex County Council" =>	"country:GB-ENG",
      "Essex County Council" =>	"country:GB-ENG",
      "Falkirk Council" =>	"country:GB-SCT",
      "Fermanagh and Omagh Council" => "country:GB-NIR",
      "Fife Council" =>	"country:GB-SCT",
      "Flintshire County Council" =>	"country:GB-WLS",
      "Gateshead Metropolitan Borough Council" =>	"country:GB-ENG",
      "Glasgow City Council" =>	"country:GB-SCT",
      "Gloucestershire County Council" =>	"country:GB-ENG",
      "Gwynedd County Council" =>	"country:GB-WLS",
      "HSE country:GB-NIR" => "country:GB-NIR",
      "HSE chemical regulations division" => "Great Britain",
      "HSE civil explosives" => "Great Britain",
      "HSE product safety and construction" => "Great Britain",
      "HSE safety unit" => "Great Britain",
      "Halton Borough Council" =>	"country:GB-ENG",
      "Hammersmith & Fulham Borough" =>	"country:GB-ENG",
      "Hampshire County Council" =>	"country:GB-ENG",
      "Hartlepool Borough Council" =>	"country:GB-ENG",
      "Herefordshire Council" =>	"country:GB-ENG",
      "Hertfordshire County Council" =>	"country:GB-ENG",
      "Highland Council" =>	"country:GB-SCT",
      "Hull City Council" =>	"country:GB-ENG",
      "Inverclyde Council" =>	"country:GB-SCT",
      "Isle of Anglesey County Council" =>	"country:GB-WLS",
      "Isle of Wight Council" =>	"country:GB-ENG",
      "Kent County Council" =>	"country:GB-ENG",
      "Knowsley Metropolitan Borough Council" =>	"country:GB-ENG",
      "Lancashire County Council" =>	"country:GB-ENG",
      "Leicester City Council" =>	"country:GB-ENG",
      "Leicestershire County Council" =>	"country:GB-ENG",
      "Lincolnshire County Council" =>	"country:GB-ENG",
      "Lisburn & Castlereagh City Council" =>	"country:GB-NIR",
      "Liverpool City Council" =>	"country:GB-ENG",
      "London Borough of Barnet" =>	"country:GB-ENG",
      "London Borough of Bexley" => "country:GB-ENG",
      "London Borough of Brent" => "country:GB-ENG",
      "London Borough of Bromley" => "country:GB-ENG",
      "London Borough of Camden" => "country:GB-ENG",
      "London Borough of Croydon" => "country:GB-ENG",
      "London Borough of Ealing" => "country:GB-ENG",
      "London Borough of Enfield" => "country:GB-ENG",
      "London Borough of Hackney" => "country:GB-ENG",
      "London Borough of Haringey" => "country:GB-ENG",
      "London Borough of Havering" => "country:GB-ENG",
      "London Borough of Hillingdon" => "country:GB-ENG",
      "London Borough of Hounslow" => "country:GB-ENG",
      "London Borough of Islington" => "country:GB-ENG",
      "London Borough of Lambeth" => "country:GB-ENG",
      "London Borough of Lewisham" => "country:GB-ENG",
      "London Borough of Newham" => "country:GB-ENG",
      "London Borough of Redbridge" => "country:GB-ENG",
      "London Borough of Southwark" => "country:GB-ENG",
      "London Borough of Sutton" => "country:GB-ENG",
      "London Borough of Tower Hamlets" => "country:GB-ENG",
      "London Borough of Waltham Forest" => "country:GB-ENG",
      "London Economics" => "country:GB-ENG",
      "Luton Borough Council" =>	"country:GB-ENG",
      "MHRA Medicine Borderline Section" =>	"country:GB",
      "Manchester City Council" =>	"country:GB-ENG",
      "Medicines and Healthcare Products Regulatory Agency" =>	"country:GB",
      "Medway Council" =>	"country:GB-ENG",
      "Merthyr Tydfil County Borough Council" =>	"country:GB-WLS",
      "Mid & East Antrim Borough Council" =>	"country:GB-NIR",
      "Mid Ulster District Council" =>	"country:GB-NIR",
      "Middlesbrough Borough Council" =>	"country:GB-ENG",
      "Midlothian Council" =>	"country:GB-SCT",
      "Milton Keynes Council" =>	"country:GB-ENG",
      "Monmouthshire County Council" =>	"country:GB-WLS",
      "Moray Council" =>	"country:GB-SCT",
      "Neath Port Talbot County Borough Council" =>	"country:GB-WLS",
      "Newcastle upon Tyne City Council" =>	"country:GB-ENG",
      "Newport City Council" =>	"country:GB-WLS",
      "Newry, Mourne and Down Council" =>	"country:GB-NIR",
      "Norfolk County Council" =>	"country:GB-ENG",
      "North Ayrshire Council" =>	"country:GB-SCT",
      "North East Lincolnshire Council" =>	"country:GB-ENG",
      "North Lanarkshire Council" =>	"country:GB-SCT",
      "North Lincolnshire Council" =>	"country:GB-ENG",
      "North Somerset Council" =>	"country:GB-ENG",
      "North Tyneside Council" =>	"country:GB-ENG",
      "North Yorkshire County Council" =>	"country:GB-ENG",
      "Northamptonshire County Council" =>	"country:GB-ENG",
      "Northumberland County Council" =>	"country:GB-ENG",
      "Nottingham City Council" =>	"country:GB-ENG",
      "Nottinghamshire County Council" =>	"country:GB-ENG",
      "OPSS Analysis" =>	"country:GB",
      "OPSS Behavioural Insights" =>	"country:GB",
      "OPSS Compliance & Testing" =>	"country:GB",
      "OPSS Connections" =>	"country:GB",
      "OPSS Digital" =>	"country:GB",
      "OPSS Ecodesign" =>	"country:GB",
      "OPSS Enforcement" =>	"country:GB",
      "OPSS Engineering & Technology" =>	"country:GB",
      "OPSS Incident Management" =>	"country:GB",
      "OPSS Intelligence" =>	"country:GB",
      "OPSS Legal" =>	"country:GB",
      "OPSS Operational support unit" =>	"country:GB",
      "OPSS PPE business liason" =>	"country:GB",
      "OPSS Policy" =>	"country:GB",
      "OPSS Ports and Borders" =>	"country:GB",
      "OPSS Product Safety Enforcement" =>	"country:GB",
      "OPSS SPOC" =>	"country:GB",
      "OPSS Science" =>	"country:GB",
      "OPSS Stakeholder Engagement" =>	"country:GB",
      "OPSS Trading Standards Co-ordination" =>	"country:GB",
      "Ofcom" =>	"country:GB",
      "Oldham Metropolitan Borough Council" => "country:GB-ENG",
      "Orkney Islands Council" =>	"country:GB-SCT",
      "Oxfordshire County Council" =>	"country:GB-ENG",
      "Pembrokeshire County Council" =>	"country:GB-WLS",
      "Perth and Kinross Council" =>	"country:GB-SCT",
      "Plymouth City Council" =>	"country:GB-ENG",
      "Portsmouth City Council" =>	"country:GB-ENG",
      "Powys County Council" =>	"country:GB-WLS",
      "Reading Borough Council" =>	"country:GB-ENG",
      "Redcar & Cleveland Borough Council" =>	"country:GB-ENG",
      "Renfrewshire Council" =>	"country:GB-SCT",
      "Rhondda Cynon Taf County Borough Council" =>	"country:GB-WLS",
      "Richmond, Merton and Wandsworth Borough" =>	"country:GB-ENG",
      "Rochdale Metropolitan Borough Council" =>	"country:GB-ENG",
      "Rotherham Council" =>	"country:GB-ENG",
      "Royal Borough of Greenwich" =>	"country:GB-ENG",
      "Royal Borough of Kensington and Chelsea" =>	"country:GB-ENG",
      "Royal Borough of Kingston upon Thames" =>	"country:GB-ENG",
      "Royal Borough of Windsor and Maidenhead Council" =>	"country:GB-ENG",
      "Salford City Council" =>	"country:GB-ENG",
      "Sandwell Metropolitan Borough Council" =>	"country:GB-ENG",
      "Scottish Borders Council" =>	"country:GB-SCT",
      "Sefton Metropolitan Borough Council" =>	"country:GB-ENG",
      "Sheffield City Council" =>	"country:GB-ENG",
      "Shetland Islands Council" =>	"country:GB-SCT",
      "Shropshire County Council" =>	"country:GB-ENG",
      "Slough Borough Council" =>	"country:GB-ENG",
      "Solihull Metropolitan Borough Council" =>	"country:GB-ENG",
      "South Ayrshire Council" =>	"country:GB-SCT",
      "South Gloucestershire Council" =>	"country:GB-ENG",
      "South Lanarkshire Council" =>	"country:GB-SCT",
      "South Tyneside Metropolitan Borough Council" =>	"country:GB-ENG",
      "Southampton City Council" =>	"country:GB-ENG",
      "Southend-on-Sea Borough Council" =>	"country:GB-ENG",
      "St Helens Metropolitan Borough Council" =>	"country:GB-ENG",
      "Staffordshire County Council" =>	"country:GB-ENG",
      "Stirling & Clackmannanshire Councils" =>	"country:GB-SCT",
      "Stockport Council" =>	"country:GB-ENG",
      "Stockton-on-Tees Borough Council" =>	"country:GB-ENG",
      "Suffolk County Council" =>	"country:GB-ENG",
      "Sunderland City Council" =>	"country:GB-ENG",
      "Swansea City and County Council" =>	"country:GB-WLS",
      "Swindon Borough Council" =>	"country:GB-ENG",
      "Tameside Council" =>	"country:GB-ENG",
      "Telford & Wrekin Council" =>	"country:GB-ENG",
      "Thurrock  Council" =>	"country:GB-ENG",
      "Trafford Metropolitan Borough Council" =>	"country:GB-ENG",
      "Walsall Metropolitan Borough Council" =>	"country:GB-ENG",
      "Warrington Borough Council" =>	"country:GB-ENG",
      "Warwickshire county Council" =>	"country:GB-ENG",
      "West Dunbartonshire Council" =>	"country:GB-SCT",
      "West Lothian Council" =>	"country:GB-SCT",
      "West Sussex County Council" =>	"country:GB-ENG",
      "West Yorkshire Joint Services" =>	"country:GB-ENG",
      "Wigan Metropolitan Borough Council" =>	"country:GB-ENG",
      "Wiltshire County Council" =>	"country:GB-ENG",
      "Wirral Borough Council" =>	"country:GB-ENG",
      "Wolverhampton City Council" =>	"country:GB-ENG",
      "Worcestershire County Council" =>	"country:GB-ENG",
      "Wrexham County Borough Council" =>	"country:GB-WLS"
    }

    Team.all.each do |team|
      team.update!(country: team_to_country[team.name])
    end

    Investigation.includes(:creator_team).all.each do |investigation|
      investigation.update!(notifying_country: investigation.creator_team.country)
    end
  end
end
