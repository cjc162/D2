# ArguementChecker
class ArguementChecker
  def arguement_check(args)
    result = true

    for i in 0..args.count - 1
      result = false if args[i].to_i.to_s != args[i]
    end

    result = false if args.count != 3 || args[1].to_i < 0 || args[2].to_i < 0

    result
  end
end
