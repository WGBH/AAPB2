module TranscriptViewerHelper

  def build_transcript(transcript_parts, source_type)

    @buffer = ''
    @para_counter = 1

    case source_type
    when 'transcript'
      last_end_time = transcript_parts.first['start_time'].to_f
    when 'caption'
      last_end_time = transcript_parts.first.start_time.to_f
    else
    end

    Nokogiri::XML::Builder.new do |doc_root|
      doc_root.div(class: 'root') do
        
        transcript_parts.each do |part|

          new_end_time, text = timecode_parts(part, source_type)
          if (new_end_time - last_end_time) > 60
            @buffer += text
            build_transcript_row(doc_root, last_end_time, new_end_time, text)
            puts "Set new end time #{new_end_time}"
            puts "buffered #{@buffer}"
            last_end_time = new_end_time
            @buffer = ''
            @para_counter += 1
          else
            @buffer += text.gsub("\n", " ")
            # puts "@buffer up! #{@buffer}"
          end
        end
      end
    end.doc.root.children
  end

  def build_transcript_row(root, start_time, end_time, text)
    root.div(class: 'transcript-row') do
      root.span(' ', class: 'play-from-here', 'data-timecode' => as_timestamp(start_time))
      root.div(
        id: "para#{@para_counter}",
        class: 'para',
        'data-timecodebegin' => as_timestamp(start_time),
        'data-timecodeend' => as_timestamp(end_time)
      ) do
        # Text content is just to prevent element collapse and keep valid HTML.
        root.text(@buffer)
        # puts "FINSIH HIM #{@buffer}"
      end
    end
  end

  def timecode_parts(part, source_type)
    case source_type
    when 'transcript'
      return part['start_time'].to_f, part['text']
    when 'caption'
      return part.start_time.to_f, part.text.first
    else
    end
  end
end