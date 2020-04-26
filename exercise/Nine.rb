class TFTheOne
    def initialize(value)
        @value = value
    end

    def bind(func)
        temp = @value
        @value = method(func).call(temp)
        self
    end

    def printme
        puts @value
    end

    def printVal
        puts "I am still a val"
    end
end

def read_file(path_to_file)
    return File.read(path_to_file).split(/[\W_]+/).map(&:downcase)
end

def remove_stop_words(word_list)
    stop_words = File.read("../stop_words.txt").split(",")
    stop_words.concat(Array("a".."z"))

    return word_list.select{|word| !stop_words.include? word}
end

def frequencies(word_list_filtered)
    word_freqs = {}

    word_list_filtered.each do |word|
        if !word_freqs.include? word
            word_freqs[word] = 1
        else
            word_freqs[word] = word_freqs[word]+1
        end
    end

    return word_freqs
end

def sortWords(word_freqs)
    return word_freqs.sort_by{|word, count| -count}
end

def results(words)
    string = ""
    for(w,c) in words[0..25]
        string += w + " - " + c.to_s + "\n"
    end
    return string
end

TFTheOne.new(ARGV[0])
.bind(:read_file)
.bind(:remove_stop_words)
.bind(:frequencies)
.bind(:sortWords)
.bind(:results)
.printme
        
    