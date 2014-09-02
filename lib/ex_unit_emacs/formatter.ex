defmodule ExUnitEmacs.Formatter do
  @moduledoc false
  use GenEvent

  def init(opts) do
    default_colors = %{success: ["ForestGreen", "White"], failure: ["Firebrick", "White"]}
    config = %{
      client: opts[:emacsclient] || "emacsclient",
      colors: default_colors |> Map.merge(Keyword.get(opts, :emacscolors, %{})),
      failure_counter: 0
    }
    # ExUnit doesn't gracefully handle {:error, reason}, so if we can't find a client
    # we just note it for later. (We don't want to prevent test runs on mixed teams where
    # some members don't use Emacs.
    {:ok, %{config | client: find_client(config.client)}}
  end

  def handle_event({:suite_finished, _run_us, _load_us}, config) do
    case config.failure_counter > 0 do
      true -> notify(config, :failure)
      false -> notify(config, :success)
    end
    :remove_handler
  end
  def handle_event({:case_finished, %ExUnit.TestCase{state: nil}}, config) do
    {:ok, config}
  end

  def handle_event({:case_finished, %ExUnit.TestCase{state: {:failed, _failed}}}, config) do
    {:ok, %{config | failure_counter: config.failure_counter + 1}}
  end

  def handle_event({:test_finished, %ExUnit.Test{state: {:failed, _failed}}}, config) do
    {:ok, %{config | failure_counter: config.failure_counter + 1}}
  end

  def handle_event(_, config) do
    {:ok, config}
  end

  defp notify(config, disposition) when is_atom(disposition) do
    notify(config, config.colors[disposition])
  end

  defp notify(config, [bg, fg]) do
    if config.client do
      os.cmd(~s{#{config.client} --eval "(set-face-attribute 'mode-line nil :background \\"#{bg}\\" :foreground \\"#{fg}\\")" 2&>1 /dev/null} |> String.to_char_list)
    end
  end

  defp find_client(executable_name) when is_binary(executable_name) do
    executable_name |> System.find_executable
  end

end
