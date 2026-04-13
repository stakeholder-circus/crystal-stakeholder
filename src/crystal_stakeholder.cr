require "./crystal_stakeholder/runtime"

result = Stakeholder::App.run(ARGV)
STDOUT.puts(result.stdout) unless result.stdout.empty?
STDERR.puts(result.stderr) unless result.stderr.empty?
exit result.exit_code
