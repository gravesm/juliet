require 'csv'

namespace :data do
    desc "Load data exported from Access database"
    task :load, [:publishers, :journals, :aliases] => :environment do |t, args|
        puts "Using #{Rails.env}"
        refalias = RefType.where(:type_name => "Alias").first_or_create
        publishers = {}
        journals = {}

        ActiveRecord::Base.transaction do
            puts "Loading publishers..."
            CSV.foreach(args[:publishers], encoding: "windows-1251:utf-8",
                        headers: true, converters: :numeric) do |row|
                publisher = Publisher.create(name: row['Publisher'])
                publishers[row['ID']] = publisher
                if policy? row
                    Policy.create(policyable: publisher, note: row['Notes'],
                                  method_of_acquisition: policy_method(row))
                end
            end

            puts "Loading journals..."
            CSV.foreach(args[:journals], encoding: "windows-1251:utf-8",
                        headers: true, converters: :numeric) do |row|
                journal = Journal.create(name: row['OfficialTitle'],
                                         publisher: publishers[row['PublisherID']])
                journals[row['ID']] = journal
                if policy? row
                    Policy.create(policyable: journal, note: row['Notes'],
                                  method_of_acquisition: policy_method(row))
                end
            end

            puts "Loading aliases..."
            CSV.foreach(args[:aliases], encoding: "windows-1251:utf-8",
                        headers: true, converters: :numeric) do |row|
                journal = journals[row['JournalID']]
                if row['Title'] != journal.name
                    EntityRef.create(ref_type: refalias, refable: journal,
                                     refvalue: row['Title'])
                end
            end
        end
    end
end

def policy?(row)
    unless policy_method(row) || row['Notes']
        return false
    else
        return true
    end
end

def policy_method(row)
    if row['HarvestFromSite'] == 1
        return "HARVEST"
    elsif row['IndividualHarvest'] == 1
        return "INDIVIDUAL_DOWNLOAD"
    elsif row['AcceptFinalFromAuthor'] == 1
        return "RECRUIT_FROM_AUTHOR"
    end
end
