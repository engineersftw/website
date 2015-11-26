json.id video.id
json.url video_url(video)
json.youtube_id video.video_id
json.description video.description
json.published_at video.published_at.to_time.strftime('%Y-%m-%d %T %z')
