# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Default set of Locations
Location.find_or_create_by(code: 'MCK1F', name: 'McKeldin Library 1st floor', regex: '(?i)^LIBRWKMCK[PM]1F.*$')
Location.find_or_create_by(code: 'MCK2F', name: 'McKeldin Library 2nd floor', regex: '(?i)^LIBRWKMCK[PM]2F.*$')
Location.find_or_create_by(code: 'MCK3F', name: 'McKeldin Library 3rd floor', regex: '(?i)^LIBRWKMCK[PM]3F.*$')
Location.find_or_create_by(code: 'MCK4F', name: 'McKeldin Library 4th floor', regex: '(?i)^LIBRWKMCK[PM]4F.*$')
Location.find_or_create_by(code: 'MCK5F', name: 'McKeldin Library 5th floor', regex: '(?i)^LIBRWKMCK[PM]5F.*$')
Location.find_or_create_by(code: 'MCK6F', name: 'McKeldin Library 6th floor', regex: '(?i)^LIBRWKMCK[PM]6F[12]$')
Location.find_or_create_by(code: 'MCK6F1', name: 'McKeldin Library 6th floor RM 6101', regex: '(?i)^LIBRWKMCK[PM]6FL.*$')
Location.find_or_create_by(code: 'MCK6F3', name: 'McKeldin Library 6th floor RM 6103', regex: '(?i)^LIBRWKMCK[PM]6F3.*$')
Location.find_or_create_by(code: 'MCK6F7', name: 'McKeldin Library 6th floor RM 6107', regex: '(?i)^LIBRWKMCK[PM]6F7.*$')
Location.find_or_create_by(code: 'MCK7F', name: 'McKeldin Library 7th floor', regex: '(?i)^LIBRWKMCK[PM]7F.*$')
Location.find_or_create_by(code: 'EPL1F', name: 'STEM Library 1st floor', regex: '(?i)^LIBRWKSTEM[PM]1F.*$')
Location.find_or_create_by(code: 'EPL2F', name: 'STEM Library 2nd floor', regex: '(?i)^LIBRWKSTEM[PM]2F.*$')
Location.find_or_create_by(code: 'EPL3F', name: 'STEM Library 3rd floor', regex: '(?i)^LIBRWKSTEM[PM]3F.*$')
Location.find_or_create_by(code: 'CHM1F', name: 'Chemistry Library 1st floor', regex: '(?i)^LIBRWKCHM[PM]1F.*$')
Location.find_or_create_by(code: 'CHM2F', name: 'Chemistry Library 2nd floor', regex: '(?i)^LIBRWKCHM[PM]2F.*$')
Location.find_or_create_by(code: 'CHM3F', name: 'Chemistry Library 3rd floor', regex: '(?i)^LIBRWKCHM[PM]3F.*$')
Location.find_or_create_by(code: 'LMSBF', name: 'Library Media Services Ground floor', regex: '(?i)^LIBRWKLMS[PM]BF.*$')
Location.find_or_create_by(code: 'MDR1F', name: 'MARYLANDIA', regex: '(?i)^LIBRWKMDR[PM]1F.*$')
Location.find_or_create_by(code: 'PAL1F', name: 'PAL 1st floor', regex: '(?i)^LIBRWKPAL[PM]1F.*$')
Location.find_or_create_by(code: 'PAL2F', name: 'PAL 2nd floor', regex: '(?i)^LIBRWKPAL[PM]2F.*$')
Location.find_or_create_by(code: 'ART1F', name: 'Art Library 1st floor', regex: '(?i)^LIBRWKART[PM]1F.*$')
Location.find_or_create_by(code: 'ARC1F', name: 'Arch Library', regex: '(?i)^LIBRWKARC[PM]1F.*$')
