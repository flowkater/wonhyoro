class PushteasersWorker
	include Sidekiq::Worker
	sidekiq_options retry: false, backtrace: true

	def perform(teaser_id)
		teaser = Teaser.find(teaser_id)
		teaser.gcm_send
	end
end