local wezterm = require 'wezterm'
local io = require 'io'
local os = require 'os'

local config = wezterm.config_builder()

config.font = wezterm.font 'CaskaydiaCove NF'
config.font_size = 18.0
config.window_background_opacity = 0.9
config.macos_window_background_blur = 30
config.tab_bar_at_bottom = true
config.tab_max_width = 20
config.send_composed_key_when_left_alt_is_pressed = false

-- ==========================================
-- 佈景主題與外觀 (Theme & Appearance)
-- ==========================================
-- 使用內建的 Nord 主題
config.color_scheme = 'nord'

-- 關閉花俏的分頁列，呈現類似 tmux 的簡約風格
config.use_fancy_tab_bar = false
config.show_tab_index_in_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false

-- 歷史捲動行數 (對應 tmux 的 history-limit 10000)
config.scrollback_lines = 10000

-- ==========================================
-- 快捷鍵與 Leader Key 設定 (Keybindings)
-- ==========================================
-- 設定 Leader Key 為 Ctrl-a，等待時間 1000 毫秒
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  -- 【傳送 Leader 鍵本身】
  -- Ctrl-a 接著按 a：傳送原始的 Ctrl-a (例如跳到行首，或傳給遠端 tmux)
  { key = 'a', mods = 'LEADER', action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' } },
  { key = 'a', mods = 'LEADER|CTRL', action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' } },

  -- 【面板與分頁操作】
  -- Ctrl-a, c : 建立新分頁
  { key = 'c', mods = 'LEADER', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  -- Ctrl-a, % : 垂直分割面板 (左右)
  { key = '%', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  -- Ctrl-a, " : 水平分割面板 (上下)
  { key = '"', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  -- Ctrl-a, z : 放大/縮小當前面板
  { key = 'z', mods = 'LEADER', action = wezterm.action.TogglePaneZoomState },
  -- Ctrl-a, [ : 進入複製模式 (Vi Mode)
  { key = '[', mods = 'LEADER', action = wezterm.action.ActivateCopyMode },

  -- 【切換面板 (Vim 風格 h/j/k/l)】
  { key = 'h', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Right' },

  -- 【切換面板 (方向鍵，作為備用)】
  { key = 'LeftArrow',  mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'DownArrow',  mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'UpArrow',    mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'RightArrow', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Right' },

  -- 【命令與搜尋】
  -- Ctrl-a, p : 呼叫 Command Palette
  { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateCommandPalette },

  -- Ctrl-a, x : 關閉當前面板 (預設會跳出確認視窗防呆)
  { key = 'x', mods = 'LEADER', action = wezterm.action.CloseCurrentPane { confirm = true } },

  { key = 's', mods = 'LEADER', action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY | DOMAINS' } },

  { key = 'h', mods = 'LEADER|CTRL', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'l', mods = 'LEADER|CTRL', action = wezterm.action.ActivateTabRelative(-1) },
}

-- ==========================================
-- 右側狀態列 (Status Right) 與非同步天氣快取
-- ==========================================
local weather_cache = ""
local last_weather_update = 0

-- 非同步取得天氣的函數
local function get_weather()
  local current_time = os.time()
  -- 設定快取時間為 900 秒 (15 分鐘)
  if current_time - last_weather_update > 900 then
    -- 在背景執行 curl，並將結果導向到暫存檔
    -- wttr.in/Xindian 會抓取新店區的天氣，format=3 是單行精簡格式
    wezterm.background_child_process({
      'sh', '-c',
      'curl -s -m 5 "wttr.in?format=3" > ~/.wezterm_weather.txt'
    })
    last_weather_update = current_time
  end

  -- 讀取暫存檔內容
  local cache_file = os.getenv("HOME") .. "/.wezterm_weather.txt"
  local f = io.open(cache_file, "r")
  if f then
    -- 讀取第一行並移除換行符號
    local line = f:read("*l")
    if line then
      weather_cache = line:gsub('^%s*(.-)%s*$', '%1') -- 去除前後空白
      weather_cache = weather_cache:gsub(',.-:', '')
    end
    f:close()
  end

  if weather_cache == "" then
    return "🌤 Loading..."
  end
  return weather_cache
end

local function get_current_dir(pane)
  local cwd_uri = pane:get_current_working_dir()
  local cwd = ""

  if cwd_uri then
    cwd = cwd_uri.file_path
    local home = wezterm.home_dir
    cwd = cwd:gsub(home, "~")
  end

  return cwd
end

-- 監聽狀態列更新事件
wezterm.on('update-right-status', function(window, pane)
  local cells = {}

  -- 1. Leader Key 狀態指示器 (對應 tmux 的 ⌨)
  if window:leader_is_active() then
    table.insert(cells, '⌨')
  end

  table.insert(cells, get_current_dir(pane))

  -- 2. 天氣資訊 (從快取讀取)
  table.insert(cells, get_weather())

  -- 3. 日期與時間
  local date = wezterm.strftime '%m/%d %H:%M'
  table.insert(cells, date)

  -- 4. 主機名稱
  table.insert(cells, wezterm.hostname())

  -- 5. 電池資訊 (如果是 Mac mini 這類無電池的桌機，會自動隱藏不顯示)
  local battery_info = ""
  for _, b in ipairs(wezterm.battery_info()) do
    local value = b.state_of_charge
    if value == value then
      battery_info = string.format('%.0f%%', value * 100)
    end
  end
  if battery_info ~= "" then
    table.insert(cells, "🔋 " .. battery_info)
  end

  -- 【組合與上色】
  -- 這裡使用 Nord 主題的色票來美化分隔線與文字
  local elements = {}
  local text_fg = '#d8dee9'  -- Nord 4 (文字顏色)
  local text_bg = '#3b4252'  -- Nord 1 (背景顏色)
  local sep_fg  = '#4c566a'  -- Nord 3 (分隔線顏色)

  for i, cell in ipairs(cells) do
    -- 插入文字區塊
    table.insert(elements, { Foreground = { Color = text_fg } })
    table.insert(elements, { Background = { Color = text_bg } })
    table.insert(elements, { Text = ' ' .. cell .. ' ' })

    -- 插入分隔線 (除了最後一個元素)
    if i < #cells then
      table.insert(elements, { Foreground = { Color = sep_fg } })
      table.insert(elements, { Background = { Color = text_bg } })
      table.insert(elements, { Text = '|' })
    end
  end

  window:set_right_status(wezterm.format(elements))
end)

local function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane
  local title = " " .. (tab.tab_index + 1) .. "."

  if pane.is_zoomed then
    title = title .. "[Z]"
  end

  title = title .. " " .. basename(pane.foreground_process_name) .. " "

  if #title > max_width then
    title = string.sub(title, 1, max_width - 3) .. "..."
  end

  return {
    { Text = title },
  }
end)

return config
