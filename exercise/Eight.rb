def read_file(path_to_file, func)
    data = File.read(path_to_file).split(/[\W_]+/).map(&:downcase)
    method(func).call(data, :frequencies)
end


def remove_stop_words(word_list, func)
    stop_words = File.read("../stop_words.txt").split(",")
    stop_words.concat(Array("a".."z"))

    word_list_filtered = word_list.select{|word| !stop_words.include? word}
    
    method(func).call(word_list_filtered, :sortWords)

end

def frequencies(word_list_filtered, func)
    word_freqs = {}

    word_list_filtered.each do |word|
        if !word_freqs.include? word
            word_freqs[word] = 1
        else
            word_freqs[word] = word_freqs[word]+1
        end
    end

    method(func).call(word_freqs,:printResults)
end

def sortWords(word_freqs, func)
    method(func).call(word_freqs.sort_by{|word, count| -count})
end

def printResults(results)
    for (w, c) in results[0..25]
        puts( w+ " - "+ c.to_s)
    end
end

read_file(ARGV[0], :remove_stop_words)

