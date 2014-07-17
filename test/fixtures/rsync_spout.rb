require 'red_storm'
require 'rsync'
require 'lib/jetstream'


class RsyncSpout < RedStorm::DSL::Spout
  attr_reader :feed_info
  on_init do
    @dest = @config['dest']
    @found_files = []
    @flags = "-ru"
    @remove_sent_opt = "--remove-sent-files"
    @feed_info = Jetstream::FeedInfo.new(feed: @config['feed'], subfeed: @config['subfeed'], uri: @config['source'])
    #TODO: make dest directory
  end

  output_fields :parcel
  on_send do
    begin
      result = Rsync.run("#{@flags} #{@remove_sent_opt}", File.join(@feed_info.uri, '*'), @dest)
      filenames = result.changes.map(&:filename)
      filenames.each do |filename|
        file_contents = File.read(File.join(@dest, filename))
        original_uri = File.join(@feed_info.uri, filename)
        parcel = Jetstream::Parcel.new(filename, file_contents, original_uri: original_uri, posted_timestamp: Time.now.to_i, feed_info: @feed_info)
        @found_files.unshift(parcel)
      end
      @found_files.pop.to_serializable unless @found_files.empty?
    rescue Errno::EBADF => e
      log.error "Rsync failed: #{e.message}"
    end
  end
end
