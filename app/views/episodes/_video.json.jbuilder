json.id video.id
json.url video_url(video)
json.video_site video.video_site
json.video_id video.video_id
json.description video.description
json.published_at video.published_at.to_time.strftime('%Y-%m-%d %T %z')
