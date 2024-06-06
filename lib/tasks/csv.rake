namespace :csv do
  task :import, [:directory] => [:environment] do |task, args|
    abort("No directory provided") if args.directory.blank?
    directory = args.directory
    ret = Movies::CsvImporter.run(directory)
    puts ret
  end
end