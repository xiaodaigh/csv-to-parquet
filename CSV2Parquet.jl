module CSV2Parquet

using DataConvenience

Base.@ccallable function julia_main()::Cint
    try
        real_main()
    catch
        Base.invokelatest(Base.display_error, Base.catch_stack())
        return 1
    end
    return 0
end

function real_main()
    for file in ARGS
        if !isfile(file)
            error("could not find file $file")
        end

        chunks = DataConvenience.CsvChunkIterator(file)
        for (n, chunk) in enumerate(chunks)
            println("chunk #: ", n)
            println("chunk size: ", size(chunk))
        end
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    real_main()
end

end # module
