Maid.rules do
  rule 'Remove old TV-show downloads' do
    dir('~/Downloads/**/*.mkv').each do |mkv|
      trash(mkv) if 2.weeks.since?(accessed_at(mkv))
    end
  end

  rule 'Remove old converted TV-shows' do
    trash(dir('~/Downloads/**/*.mp4'))
    trash(dir('~/Downloads/**/*.m4v'))
  end

  rule 'Remove old apps' do
    trash(dir('~/Downloads/*.dmg'))
    trash(dir('~/Downloads/*.pkg'))
    trash(dir('~/Downloads/*.zip'))
    trash(dir('~/Downloads/*.iso'))
    trash(dir('~/Downloads/*.tar'))
    trash(dir('~/Downloads/*.tar.*'))
  end

  rule 'Remove empty folders' do
    trash(dir('~/Downloads/**/*').select { |path| File.directory?(path) && (File.stat(path).size < 1.megabyte || dir("#{path}/*").empty? ) })
  end

  rule 'Remove old files' do
    dir('~/Downloads/**/*').each do |file|
      trash(file) if 4.weeks.since?(accessed_at(file))
    end
  end

  rule 'Clean up Mail Downloads' do
    trash(dir('~/Library/Containers/com.apple.mail/Data/Library/Mail\ Downloads/*'))
  end
end
