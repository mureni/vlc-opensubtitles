--[[
VLC-OpenSubtitles Extension for VLC media player 1.1 and 2.0
Copyright 2013 Guillaume Le Maout
Authors:  Guillaume Le Maout
Contact: 
http://addons.videolan.org/messages/?action=newmessage&username=exebetche
Bug report: http://addons.videolan.org/content/show.php/?content=148752
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston MA 02110-1301, USA.
--]]


            --[[ Global var ]]-- 

-- You can set here your default language by replacing nil with
-- your language code (see below).Example: 
-- language = "fre", 
-- language = "ger", 
-- language = "eng",
-- ...

local options = {
  language = nil,
  downloadBehaviour = 'save',
  langExt = false,
  removeTag = false,
  showMediaInformation = true,
  progressBarSize = 80,
  intLang = 'eng',
  translations_avail = {
    eng = 'English',
    cze = 'Czech', 
    dan = 'Danish', 
    dut = 'Nederlands',
    fin = 'Finnish',
    fre = 'Français',
    ell = 'Greek',
    baq = 'Basque',
    pob = 'Brazilian Portuguese',
    por = 'Portuguese (Portugal)',
    rum = 'Romanian',
    slo = 'Slovak',
    spa = 'Spanish',
    swe = 'Swedish',
    ukr = 'Ukrainian',
    hun = 'Hungarian',
    scc = 'Serbian'
  },
  translation = {
    int_all = 'All',
    int_descr = 'Download subtitles from OpenSubtitles.org',
    int_research = 'Research',
    int_config = 'Config',
    int_configuration = 'Configuration',
    int_help = 'Help',
    int_search_hash = 'Search by hash',
    int_search_name = 'Search by name',
    int_title = 'Title',
    int_season = 'Season (series)',
    int_episode = 'Episode (series)',
    int_show_help = 'Show help',
    int_show_conf = 'Show config',
    int_dowload_sel = 'Download selection',
    int_close = 'Close',
    int_ok = 'Ok',
    int_save = 'Save',
    int_cancel = 'Cancel',
    int_bool_true = 'Yes',
    int_bool_false = 'No',
    int_search_transl = 'Search translations',
    int_searching_transl = 'Searching translations ...',
    int_int_lang = 'Interface language',
    int_default_lang = 'Subtitles language',
    int_dowload_behav = 'What to do with subtitles',
    int_dowload_save = 'Load and save',
    int_dowload_load = 'Load only',
    int_dowload_manual =  'Manual download',
    int_display_code = 'Display language code in file name',
    int_remove_tag = 'Remove tags',
    int_VLC-OpenSubtitles_work_dir = 'VLC-OpenSubtitles working directory',
    int_os_username = 'Username',
    int_os_password = 'Password',
    int_help_mess =[[
      Download subtitles from 
      <a href='http://www.opensubtitles.com/'>
      opensubtitles.com
      </a> and display them while watching a video.<br>
      <br>
      <b><u>Usage:</u></b><br>
      <br>
      Start your video. If you use VLC-OpenSubtitles witout playing a video 
      you will get a link to download the subtitles in your browser 
      but the subtitles won't be saved and loaded automatically.<br>
      <br>
      Choose the language for your subtitles and click on the 
      button corresponding to one of the two research methods 
      provided by VLC-OpenSubtitles:<br>
      <br>
      <b>Method 1: Search by hash</b><br>
      It is recommended to try this method first, because it 
      performs a research based on the video file print, so you 
      can find subtitles synchronized with your video.<br>
      <br>
      <b>Method 2: Search by name</b><br>
      If you have no luck with the first method, just check the 
      title is correct before clicking. If you search subtitles 
      for a series, you can also provide a season and episode 
      number.<br>
      <br>
      <b>Downloading Subtitles</b><br>
      Select one subtitle in the list and click on 'Download'.<br>
      It will be put in the same directory that your video, with 
      the same name (different extension)
      so VLC will load them automatically the next time you'll 
      start the video.<br>
      <br>
      <b>/!\\ Beware :</b> Existing subtitles are overwritten 
      without asking confirmation, so put them elsewhere if 
      they're important.<br>
      <br>
      Find more VLC extensions at 
      <a href='http://addons.videolan.org'>addons.videolan.org</a>.
      ]],
    int_no_support_mess = [[
      <strong>VLC-OpenSubtitles is not working with Vlc 2.1.x on 
      any platform</strong>
      because the lua "net" module needed to interact 
      with opensubtitles has been 
      removed in this release for the extensions.
      <br>
      <strong>Works with Vlc 2.2 on mac and linux.</strong>
      <br>
      <strong>On windows you have to install an older version 
      of Vlc (2.0.8 for example)</strong>
      to use VLC-OpenSubtitles:
      <br>
      <a target="_blank" rel="nofollow" 
      href="http://download.videolan.org/pub/videolan/vlc/2.0.8/">
      http://download.videolan.org/pub/videolan/vlc/2.0.8/</a><br>
    ]],
  
    action_login = 'Logging in',
    action_logout = 'Logging out',
    action_noop = 'Checking session',
    action_search = 'Searching subtitles',
    action_hash = 'Calculating movie hash',
    
    mess_success = 'Success',
    mess_error = 'Error',
    mess_no_response = 'Server not responding',
    mess_unauthorized = 'Request unauthorized',
    mess_expired = 'Session expired, retrying',
    mess_overloaded = 'Server overloaded, please retry later',
    mess_no_input = 'Please use this method during playing',
    mess_not_local = 'This method works with local file only (for now)',
    mess_not_found = 'File not found',
    mess_not_found2 = 'File not found (illegal character?)',
    mess_no_selection = 'No subtitles selected',
    mess_save_fail = 'Unable to save subtitles',
    mess_click_link = 'Click here to open the file',
    mess_complete = 'Research complete',
    mess_no_res = 'No result',
    mess_res = 'result(s)',
    mess_loaded = 'Subtitles loaded',
    mess_not_load = 'Unable to load subtitles',
    mess_downloading = 'Downloading subtitle',
    mess_dowload_link = 'Download link',
    mess_err_conf_access ='Can\'t find a suitable path to save'..
      'config, please set it manually',
    mess_err_wrong_path ='the path contains illegal character, '..
      'please correct it',
    mess_err_cant_download_interface_translation='could not download interface translation'
  }
}

local languages = {
  {'alb', 'Albanian'},
  {'ara', 'Arabic'},
  {'arm', 'Armenian'},
  {'baq', 'Basque'},
  {'ben', 'Bengali'},
  {'bos', 'Bosnian'},
  {'bre', 'Breton'},
  {'bul', 'Bulgarian'},
  {'bur', 'Burmese'},
  {'cat', 'Catalan'},
  {'chi', 'Chinese'},
  {'hrv', 'Croatian'},
  {'cze', 'Czech'},
  {'dan', 'Danish'},
  {'dut', 'Dutch'},
  {'eng', 'English'},
  {'epo', 'Esperanto'},
  {'est', 'Estonian'},
  {'fin', 'Finnish'},
  {'fre', 'French'},
  {'glg', 'Galician'},
  {'geo', 'Georgian'},
  {'ger', 'German'},
  {'ell', 'Greek'},
  {'heb', 'Hebrew'},
  {'hin', 'Hindi'},
  {'hun', 'Hungarian'},
  {'ice', 'Icelandic'},
  {'ind', 'Indonesian'},
  {'ita', 'Italian'},
  {'jpn', 'Japanese'},
  {'kaz', 'Kazakh'},
  {'khm', 'Khmer'},
  {'kor', 'Korean'},
  {'lav', 'Latvian'},
  {'lit', 'Lithuanian'},
  {'ltz', 'Luxembourgish'},
  {'mac', 'Macedonian'},
  {'may', 'Malay'},
  {'mal', 'Malayalam'},
  {'mon', 'Mongolian'},
  {'nor', 'Norwegian'},
  {'oci', 'Occitan'},
  {'per', 'Persian'},
  {'pol', 'Polish'},
  {'por', 'Portuguese'},
  {'pob', 'Brazilian Portuguese'},
  {'rum', 'Romanian'},
  {'rus', 'Russian'},
  {'scc', 'Serbian'},
  {'sin', 'Sinhalese'},
  {'slo', 'Slovak'},
  {'slv', 'Slovenian'},
  {'spa', 'Spanish'},
  {'swa', 'Swahili'},
  {'swe', 'Swedish'},
  {'syr', 'Syriac'},
  {'tgl', 'Tagalog'},
  {'tel', 'Telugu'},
  {'tha', 'Thai'},
  {'tur', 'Turkish'},
  {'ukr', 'Ukrainian'},
  {'urd', 'Urdu'},
  {'vie', 'Vietnamese'}
}

-- Languages code conversion table: iso-639-1 to iso-639-3
-- See https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
local lang_os_to_iso = {
  sq = "alb",
  ar = "ara",
  hy = "arm",
  eu = "baq",
  bn = "ben",
  bs = "bos",
  br = "bre",
  bg = "bul",
  my = "bur",
  ca = "cat",
  zh = "chi",
  hr = "hrv",
  cs = "cze",
  da = "dan",
  nl = "dut",
  en = "eng",
  eo = "epo",
  et = "est",
  fi = "fin",
  fr = "fre",
  gl = "glg",
  ka = "geo",
  de = "ger",
  el = "ell",
  he = "heb",
  hi = "hin",
  hu = "hun",
  is = "ice",
  id = "ind",
  it = "ita",
  ja = "jpn",
  kk = "kaz",
  km = "khm",
  ko = "kor",
  lv = "lav",
  lt = "lit",
  lb = "ltz",
  mk = "mac",
  ms = "may",
  ml = "mal",
  mn = "mon",
  no = "nor",
  oc = "oci",
  fa = "per",
  pl = "pol",
  pt = "por",
  po = "pob",
  ro = "rum",
  ru = "rus",
  sr = "scc",
  si = "sin",
  sk = "slo",
  sl = "slv",
  es = "spa",
  sw = "swa",
  sv = "swe",
  tl = "tgl",
  te = "tel",
  th = "tha",
  tr = "tur",
  uk = "ukr",
  ur = "urd",
  vi = "vie"
}

local dlg = nil
local input_table = {} -- General widget id reference
local select_conf = {} -- Drop down widget / option table association 

local app_name = "VLC OpenSubtitles.com Downloader";
local app_version = "0.0.1";
local app_useragent = app_name.." "..app_version;

            --[[ VLC extension stuff ]]--

function descriptor()
  return { 
    title = app_useragent,
    version = app_version,
    author = "exebetche+mureni",
    url = 'http://www.opensubtitles.com',
    shortdesc = app_name;
    description = options.translation.int_descr,
    capabilities = {"menu", "input-listener" }
  }
end

function activate()
  vlc.msg.dbg("[VLC-OpenSubtitles] Welcome")
  
  if not check_config() then 
  	vlc.msg.err("[VLC-OpenSubtitles] Unsupported VLC version")
  	return false 
  end
  	
  if vlc.input.item() then
    openSub.getFileInfo()
    openSub.getMovieInfo()
  end
  
  show_main()
end

function close()
  vlc.deactivate()
end

function deactivate()
  vlc.msg.dbg("[VLC-OpenSubtitles] Bye bye!")
  if dlg then
    dlg:hide() 
  end
  
  if openSub.session.token and openSub.session.token ~= "" then
    openSub.request("LogOut")
  end
end

function menu()
  return { 	  
    lang.int_research, 
    lang.int_config, 
    lang.int_help
  }
end

function meta_changed()
  return false
end

function input_changed()
  collectgarbage()
  set_interface_main()
  collectgarbage()
end

            --[[ Interface data ]]--

function interface_main()
  dlg:add_label(lang["int_default_lang"]..':', 1, 1, 1, 1)
  input_table['language'] =  dlg:add_dropdown(2, 1, 2, 1)
  dlg:add_button(lang["int_search_hash"], 
    searchHash, 4, 1, 1, 1)
  
  dlg:add_label(lang["int_title"]..':', 1, 2, 1, 1)
  input_table['title'] = dlg:add_text_input(
    openSub.movie.title or "", 2, 2, 2, 1)
  dlg:add_button(lang["int_search_name"], 
    searchIMBD, 4, 2, 1, 1)
  dlg:add_label(lang["int_season"]..':', 1, 3, 1, 1)
  input_table['seasonNumber'] = dlg:add_text_input(
    openSub.movie.seasonNumber or "", 2, 3, 2, 1)
  dlg:add_label(lang["int_episode"]..':', 1, 4, 1, 1)
  input_table['episodeNumber'] = dlg:add_text_input(
    openSub.movie.episodeNumber or "", 2, 4, 2, 1)
  input_table['mainlist'] = dlg:add_list(1, 5, 4, 1)
  input_table['message'] = nil
  input_table['message'] = dlg:add_label(' ', 1, 6, 4, 1)
  dlg:add_button(
    lang["int_show_help"], show_help, 1, 7, 1, 1)
  dlg:add_button(
    '   '..lang["int_show_conf"]..'   ', show_conf, 2, 7, 1, 1)
  dlg:add_button(
    lang["int_dowload_sel"], download_subtitles, 3, 7, 1, 1)
  dlg:add_button(
    lang["int_close"], close, 4, 7, 1, 1) 
  
  assoc_select_conf(
    'language',
    'language',
    openSub.conf.languages, 
    2, 
    lang["int_all"])
    
  display_subtitles()
end

function set_interface_main()
  -- Update movie title and co. if video input change
  if not type(input_table['title']) == 'userdata' then return false end
  
  openSub.getFileInfo()
  openSub.getMovieInfo()
  
  input_table['title']:set_text(
    openSub.movie.title or "")
  input_table['episodeNumber']:set_text(
    openSub.movie.episodeNumber or "")
  input_table['seasonNumber']:set_text(
    openSub.movie.seasonNumber or "")
end

function interface_config()
  input_table['intLangLab'] = dlg:add_label(
    lang["int_int_lang"]..':', 1, 1, 1, 1)
  input_table['intLangBut'] = dlg:add_button(
    lang["int_search_transl"],
    get_available_translations, 2, 1, 1, 1)
  input_table['intLang'] = dlg:add_dropdown(3, 1, 1, 1)	
  dlg:add_label(
    lang["int_default_lang"]..':', 1, 2, 2, 1)
  input_table['default_language'] = dlg:add_dropdown(3, 2, 1, 1)	
  dlg:add_label(
    lang["int_dowload_behav"]..':', 1, 3, 2, 1)
  input_table['downloadBehaviour'] = dlg:add_dropdown(3, 3, 1, 1)
  dlg:add_label(
    lang["int_display_code"]..':', 1, 4, 0, 1)
  input_table['langExt'] = dlg:add_dropdown(3, 4, 1, 1)
  dlg:add_label(
    lang["int_remove_tag"]..':', 1, 5, 0, 1)
  input_table['removeTag'] = dlg:add_dropdown(3, 5, 1, 1)
    
  if openSub.conf.dirPath then
    if openSub.conf.os == "win" then
      dlg:add_label(
        "<a href='file:///"..openSub.conf.dirPath.."'>"..
        lang["int_VLC-OpenSubtitles_work_dir"].."</a>", 1, 6, 2, 1)
    else
      dlg:add_label(
        "<a href='"..openSub.conf.dirPath.."'>"..
        lang["int_VLC-OpenSubtitles_work_dir"].."</a>", 1, 6, 2, 1)
    end
  else
    dlg	:add_label(
      lang["int_VLC-OpenSubtitles_work_dir"], 1, 6, 2, 1)
  end
  
  input_table['dir_path'] = dlg:add_text_input(
    openSub.conf.dirPath, 2, 6, 2, 1)
  
  dlg:add_label(
    lang["int_os_username"]..':', 1, 7, 0, 1)
  input_table['os_username'] = dlg:add_text_input(
    type(openSub.option.os_username) == "string" 
    and openSub.option.os_username or "", 2, 7, 2, 1)
  dlg:add_label(
    lang["int_os_password"]..':', 1, 8, 0, 1)
  input_table['os_password'] = dlg:add_password(
    type(openSub.option.os_password) == "string" 
    and openSub.option.os_password or "", 2, 8, 2, 1)
        
  input_table['message'] = nil
  input_table['message'] = dlg:add_label(' ', 1, 9, 3, 1)
  
  dlg:add_button(
    lang["int_cancel"],
    show_main, 2, 10, 1, 1)
  dlg:add_button(
    lang["int_save"],
    apply_config, 3, 10, 1, 1)
  
  input_table['langExt']:add_value(
    lang["int_bool_"..tostring(openSub.option.langExt)], 1)
  input_table['langExt']:add_value(
    lang["int_bool_"..tostring(not openSub.option.langExt)], 2)
  input_table['removeTag']:add_value(
    lang["int_bool_"..tostring(openSub.option.removeTag)], 1)
  input_table['removeTag']:add_value(
    lang["int_bool_"..tostring(not openSub.option.removeTag)], 2)
  
  assoc_select_conf(
    'intLang',
    'intLang',
    openSub.conf.translations_avail,
    2)
  assoc_select_conf(
    'default_language',
    'language',
    openSub.conf.languages,
    2,
    lang["int_all"])
  assoc_select_conf(
    'downloadBehaviour',
    'downloadBehaviour',
    openSub.conf.downloadBehaviours,
    1)
end

function interface_help()
  local help_html = lang["int_help_mess"]
    
  input_table['help'] = dlg:add_html(
    help_html, 1, 1, 4, 1)
  dlg:add_label(
    string.rep ("&nbsp;", 100), 1, 2, 3, 1)
  dlg:add_button(
    lang["int_ok"], show_main, 4, 2, 1, 1)
end

function interface_no_support()
  local no_support_html = lang["int_no_support_mess"]
    
  input_table['no_support'] = dlg:add_html(
    no_support_html, 1, 1, 4, 1)
  dlg:add_label(
    string.rep ("&nbsp;", 100), 1, 2, 3, 1)
end

function trigger_menu(dlg_id)
  if dlg_id == 1 then
    close_dlg()
    dlg = vlc.dialog(
      openSub.conf.useragent)
    interface_main()
  elseif dlg_id == 2 then
    close_dlg()
    dlg = vlc.dialog(
      openSub.conf.useragent..': '..lang["int_configuration"])
    interface_config()
  elseif dlg_id == 3 then
    close_dlg()
    dlg = vlc.dialog(
      openSub.conf.useragent..': '..lang["int_help"])
    interface_help()
  end
  collectgarbage() --~ !important	
end 

function show_main()
  trigger_menu(1)
end

function show_conf()
  trigger_menu(2)
end

function show_help()
  trigger_menu(3)
end

function close_dlg()
  vlc.msg.dbg("[VLC-OpenSubtitles] Closing dialog")

  if dlg ~= nil then 
    --~ dlg:delete() -- Throw an error
    dlg:hide() 
  end
  
  dlg = nil
  input_table = nil
  input_table = {}
  collectgarbage() --~ !important	
end

            --[[ Drop down / config association]]--

function assoc_select_conf(select_id, option, conf, ind, default)
-- Helper for i/o interaction between drop down and option list
  select_conf[select_id] = {
    cf = conf,
    opt  = option,
    dflt = default,
    ind = ind
  }
  set_default_option(select_id)
  display_select(select_id)
end

function set_default_option(select_id)
-- Put the selected option of a list in first place of the associated table 
  local opt = select_conf[select_id].opt
  local cfg = select_conf[select_id].cf
  local ind = select_conf[select_id].ind
  if openSub.option[opt] then
    table.sort(cfg, function(a, b) 
      if a[1] == openSub.option[opt] then
        return true
      elseif b[1] == openSub.option[opt] then
        return false
      else
        return a[ind] < b[ind] 
      end
    end)
  end
end

function display_select(select_id)
-- Display the drop down values with an optional default value at the top
  local conf = select_conf[select_id].cf
  local opt = select_conf[select_id].opt
  local option = openSub.option[opt]
  local default = select_conf[select_id].dflt
  local default_isset = false
    
  if not default then 
    default_isset = true
  end
  
  for k, l in ipairs(conf) do
    if default_isset then
      input_table[select_id]:add_value(l[2], k)
    else
      if option then
        input_table[select_id]:add_value(l[2], k)
        input_table[select_id]:add_value(default, 0)
      else
        input_table[select_id]:add_value(default, 0)
        input_table[select_id]:add_value(l[2], k)
      end
      default_isset = true
    end
  end
end

            --[[ Config & interface localization]]--

function check_config()
  -- Make a copy of english translation to use it as default 
  -- in case some element aren't translated in other translations
  eng_translation = {}
  for k, v in pairs(openSub.option.translation) do
    eng_translation[k] = v
  end
  
  -- Get available translation full name from code
  trsl_names = {}
  for i, lg in ipairs(languages) do
    trsl_names[lg[1]] = lg[2]
  end
  
  if is_window_path(vlc.config.datadir()) then
    openSub.conf.os = "win"
    slash = "\\"
  else
    openSub.conf.os = "lin"
    slash = "/"
  end
  
  local path_generic = {"lua", "extensions", "userdata", "VLC-OpenSubtitles"}
  local dirPath = slash..table.concat(path_generic, slash)
  local filePath	= slash.."VLC-OpenSubtitles_conf.xml"
  local config_saved = false
  sub_dir = slash.."VLC-OpenSubtitles_subtitles"
  
  -- Check if config file path is stored in vlc config
  local other_dirs = {}
  
  for path in 
  vlc.config.get("sub-autodetect-path"):gmatch("[^,]+") do
    if path:match(".*"..sub_dir.."$") then
      openSub.conf.dirPath = path:gsub(
        "%s*(.*)"..sub_dir.."%s*$", "%1")
      config_saved = true
    end
    table.insert(other_dirs, path)
  end
  
  -- if not stored in vlc config
  -- try to find a suitable config file path 
  
  if openSub.conf.dirPath then
    if not is_dir(openSub.conf.dirPath) and
    (openSub.conf.os == "lin"  or
    is_win_safe(openSub.conf.dirPath)) then
      mkdir_p(openSub.conf.dirPath)
    end
  else
    local userdatadir = vlc.config.userdatadir()
    local datadir = vlc.config.datadir()
    
    -- check if the config already exist
    if file_exist(userdatadir..dirPath..filePath) then
      -- in vlc.config.userdatadir()
      openSub.conf.dirPath = userdatadir..dirPath
      config_saved = true
    elseif file_exist(datadir..dirPath..filePath) then
      -- in vlc.config.datadir()
      openSub.conf.dirPath = datadir..dirPath
      config_saved = true
    else
      -- if not found determine an accessible path
      local extension_path = slash..path_generic[1]
        ..slash..path_generic[2]
      
      -- use the same folder as the extension if accessible
      if is_dir(userdatadir..extension_path) 
      and file_touch(userdatadir..dirPath..filePath) then
          openSub.conf.dirPath = userdatadir..dirPath
      elseif file_touch(datadir..dirPath..filePath) then
        openSub.conf.dirPath = datadir..dirPath
      end
      
      -- try to create working dir in user folder
      if not openSub.conf.dirPath
      and is_dir(userdatadir) then
        if not is_dir(userdatadir..dirPath) then
          mkdir_p(userdatadir..dirPath)
        end
        if is_dir(userdatadir..dirPath) and
        file_touch(userdatadir..dirPath..filePath) then
          openSub.conf.dirPath = userdatadir..dirPath
        end
      end
      
      -- try to create working dir in vlc folder	
      if not openSub.conf.dirPath and
      is_dir(datadir) then
        if not is_dir(datadir..dirPath) then
          mkdir_p(datadir..dirPath)
        end
        if file_touch(datadir..dirPath..filePath) then
          openSub.conf.dirPath = datadir..dirPath
        end
      end
    end
  end
  
  if openSub.conf.dirPath then
    vlc.msg.dbg("[VLC-OpenSubtitles] Working directory: " ..
      (openSub.conf.dirPath or "not found"))
    
    openSub.conf.filePath = openSub.conf.dirPath..filePath 
    openSub.conf.localePath = openSub.conf.dirPath..slash.."locale"
    
    if config_saved 
    and file_exist(openSub.conf.filePath) then
      vlc.msg.dbg(
        "[VLC-OpenSubtitles] Loading config file: "..openSub.conf.filePath)
      load_config()
    else
      vlc.msg.dbg("[VLC-OpenSubtitles] No config file")
      getenv_lang()
      config_saved = save_config()
      if not config_saved then
        vlc.msg.dbg("[VLC-OpenSubtitles] Unable to save config")
      end
    end
    
    -- Check presence of a translation file 
    -- in "%VLC-OpenSubtitles_directory%/locale"
    -- Add translation files to available translation list
    local file_list = list_dir(openSub.conf.localePath)
    local translations_avail = openSub.conf.translations_avail
    
    if file_list then
      for i, file_name in ipairs(file_list) do
        local lg =  string.gsub(
          file_name,
          "^(%w%w%w).xml$",
          "%1")
        if lg 
        and not openSub.option.translations_avail[lg] then
          table.insert(translations_avail, {
            lg,
            trsl_names[lg]
          })
        end
      end
    end
    
    -- Load selected translation from file
    if openSub.option.intLang ~= "eng" 
    and not openSub.conf.translated
    then
      local transl_file_path = openSub.conf.localePath..
        slash..openSub.option.intLang..".xml"
      if file_exist(transl_file_path) then
        vlc.msg.dbg(
          "[VLC-OpenSubtitles] Loading translation from file: "..
          transl_file_path)
        load_transl(transl_file_path)
      end
    end
  else
    vlc.msg.dbg("[VLC-OpenSubtitles] Unable to find a suitable path"..
      "to save config, please set it manually")
  end
  
  lang = nil
  lang = options.translation -- just a short cut
  
  if not vlc.net or not vlc.net.poll then
    dlg = vlc.dialog(
      openSub.conf.useragent..': '..lang["mess_error"])
    interface_no_support()
    dlg:show()
    return false
  end
  
  SetDownloadBehaviours()
  if not openSub.conf.dirPath then
    setError(lang["mess_err_conf_access"])
  end
    
  -- Set table list of available translations from assoc. array 
  -- so it is sortable
  
  for k, l in pairs(openSub.option.translations_avail) do		
    if k == openSub.option.int_research then
      table.insert(openSub.conf.translations_avail, 1, {k, l})
    else
      table.insert(openSub.conf.translations_avail, {k, l})
    end
  end
  collectgarbage()
  return true
end

function load_config()
-- Overwrite default conf with loaded conf
  local tmpFile = io.open(openSub.conf.filePath, "rb")
  if not tmpFile then return false end
  local resp = tmpFile:read("*all")
  tmpFile:flush()
  tmpFile:close()
  local option = parse_xml(resp)
  
  for key, value in pairs(option) do
    if type(value) == "table" then
      if key == "translation" then
        openSub.conf.translated = true
        for k, v in pairs(value) do
          openSub.option.translation[k] = v
        end
      else
        openSub.option[key] = value
      end
    else
      if value == "true" then
        openSub.option[key] = true
      elseif value == "false" then
        openSub.option[key] = false
      else
        openSub.option[key] = value
      end
    end
  end
  collectgarbage()
end

function load_transl(path)
-- Overwrite default conf with loaded conf
  local tmpFile = assert(io.open(path, "rb"))
  local resp = tmpFile:read("*all")
  tmpFile:flush()
  tmpFile:close()
  openSub.option.translation = nil
  
  openSub.option.translation = parse_xml(resp)	
  collectgarbage()
end

function apply_translation()
-- Overwrite default conf with loaded conf
  for k, v in pairs(eng_translation) do
    if not openSub.option.translation[k] then
      openSub.option.translation[k] = eng_translation[k]
    end
  end
end

function getenv_lang()
-- Retrieve the user OS language 
  local os_lang = os.getenv("LANG")
  
  if os_lang then -- unix, mac
    os_lang = string.sub(os_lang, 0, 2)
    if type(lang_os_to_iso[os_lang]) then
      openSub.option.language = lang_os_to_iso[os_lang]
    end
  else -- Windows
    local lang_w = string.match(
      os.setlocale("", "collate"),
      "^[^_]+")
    for i, v in ipairs(openSub.conf.languages) do
     if v[2] == lang_w then
      openSub.option.language = v[1]
     end
    end 
  end
end

function apply_config()
-- Apply user config selection to local config
  local lg_sel = input_table['intLang']:get_value()
  local sel_val
  local opt
  local sel_cf
  
  if lg_sel and lg_sel ~= 1 
  and openSub.conf.translations_avail[lg_sel] then
    local lg = openSub.conf.translations_avail[lg_sel][1]
    if not set_translation(lg) then
      vlc.msg.err("[VLC-OpenSubtitles] Couldn't not set translation")
      return false
    end
    SetDownloadBehaviours()
  end
  
  for select_id, v in pairs(select_conf) do
    if input_table[select_id] 
    and select_conf[select_id] then
      sel_val = input_table[select_id]:get_value()
      sel_cf = select_conf[select_id]
      opt = sel_cf.opt
      
      if sel_val == 0 then
        openSub.option[opt] = nil
      else
        openSub.option[opt] = sel_cf.cf[sel_val][1]
      end
      
      set_default_option(select_id)
    end
  end
  
  
  openSub.option.os_username = input_table['os_username']:get_text()
  openSub.option.os_password = input_table['os_password']:get_text()
  
  if input_table["langExt"]:get_value() == 2 then
    openSub.option.langExt = not openSub.option.langExt
  end
  
  if input_table["removeTag"]:get_value() == 2 then
    openSub.option.removeTag = not openSub.option.removeTag
  end
  
  -- Set a custom working directory
  local dir_path = input_table['dir_path']:get_text()
  local dir_path_err = false
  if trim(dir_path) == "" then dir_path = nil end
  
  if dir_path ~= openSub.conf.dirPath then
    if openSub.conf.os == "lin" 
    or is_win_safe(dir_path) 
    or not dir_path then
      local other_dirs = {}
    
      for path in 
      vlc.config.get(
        "sub-autodetect-path"):gmatch("[^,]+"
      ) do
        path = trim(path)
        if path ~= (openSub.conf.dirPath or "")..sub_dir then
          table.insert(other_dirs, path)
        end
      end
      openSub.conf.dirPath = dir_path
      if dir_path then
        table.insert(other_dirs, 
        string.gsub(dir_path, "^(.-)[\\/]?$", "%1")..sub_dir)
        
        if not is_dir(dir_path) then
          mkdir_p(dir_path)
        end
        
        openSub.conf.filePath = openSub.conf.dirPath..
          slash.."VLC-OpenSubtitles_conf.xml"
        openSub.conf.localePath = openSub.conf.dirPath..
          slash.."locale"
      else
        openSub.conf.filePath = nil
        openSub.conf.localePath = nil
      end
      vlc.config.set(
        "sub-autodetect-path",
        table.concat(other_dirs, ", "))
    else
      dir_path_err = true
      setError(lang["mess_err_wrong_path"]..
        "<br><b>"..
        string.gsub(
          dir_path,
          "[^%:%w%p%s§¤]+",
          "<span style='color:#B23'>%1</span>"
        )..
        "</b>")
    end
  end
  
  if openSub.conf.dirPath and
  not dir_path_err then
    local config_saved = save_config()
    trigger_menu(1)
    if not config_saved then
      setError(lang["mess_err_conf_access"])
    end
  else
    setError(lang["mess_err_conf_access"])
  end
end

function save_config()
-- Dump local config into config file 
  if openSub.conf.dirPath
  and openSub.conf.filePath then
    vlc.msg.dbg(
      "[VLC-OpenSubtitles] Saving config file:  "..
      openSub.conf.filePath)
    
    if file_touch(openSub.conf.filePath) then
      local tmpFile = assert(
        io.open(openSub.conf.filePath, "wb"))
      local resp = dump_xml(openSub.option)
      tmpFile:write(resp)
      tmpFile:flush()
      tmpFile:close()
      tmpFile = nil
    else
      return false
    end
    collectgarbage()
    return true
  else
    vlc.msg.dbg("[VLC-OpenSubtitles] Unable fount a suitable path "..
      "to save config, please set it manually")
    setError(lang["mess_err_conf_access"])
    return false
  end
end

function SetDownloadBehaviours()
  openSub.conf.downloadBehaviours = nil 
  openSub.conf.downloadBehaviours = { 
    {'save', lang["int_dowload_save"]},
    {'manual', lang["int_dowload_manual"]}
  }
end

function get_available_translations()
-- Get all available translation files from the internet
-- (drop previous direct download from github repo 
-- causing error  with github https CA certficate on OS X an XP)
-- https://github.com/exebetche/VLC-OpenSubtitles/tree/master/locale

  local translations_url = "http://addons.videolan.org/CONTENT/"..
    "content-files/148752-VLC-OpenSubtitles_translations.xml"
  
  if input_table['intLangBut']:get_text() == lang["int_search_transl"] 
  then
    openSub.actionLabel = lang["int_searching_transl"]
    
    local translations_content = get(translations_url)
    if not translations_content then
      collectgarbage()
      return false
    end
    local translations_avail = openSub.option.translations_avail
    all_trsl = parse_xml(translations_content)
    local lg, trsl
    
    for lg, trsl in pairs(all_trsl) do
      if lg ~= options.intLang[1] 
      and not translations_avail[lg] then
        translations_avail[lg] = trsl_names[lg] or ""
        table.insert(openSub.conf.translations_avail, {
          lg,
          trsl_names[lg]
        })
        input_table['intLang']:add_value(
          trsl_names[lg],
          #openSub.conf.translations_avail)
      end
    end
    
    setMessage(success_tag(lang["mess_complete"]))
    collectgarbage()
  end
  return true
end

function set_translation(lg)
  openSub.option.translation = nil
  openSub.option.translation = {}
  
  if lg == 'eng' then
    for k, v in pairs(eng_translation) do
      openSub.option.translation[k] = v
    end
  else
    -- If translation file exists in /locale directory load it
    if openSub.conf.localePath 
    and file_exist(openSub.conf.localePath..
      slash..lg..".xml") then
      local transl_file_path = openSub.conf.localePath..
      slash..lg..".xml"
      vlc.msg.dbg("[VLC-OpenSubtitles] Loading translation from file: "..
        transl_file_path)
      load_transl(transl_file_path)
      apply_translation()
    else
      -- Load translation file from internet
      if not all_trsl and not get_available_translations() then
        setMessage(error_tag(lang["mess_err_cant_download_interface_translation"]))
        return false
      end

      if not all_trsl or not all_trsl[lg] then
        vlc.msg.dbg("[VLC-OpenSubtitles] Error, translation not found")
        return false
      end
      openSub.option.translation = all_trsl[lg]
      apply_translation()
      all_trsl = nil
    end
  end
  
  lang = nil
  lang = openSub.option.translation
  collectgarbage()
  return true
end 

            --[[ Core ]]--

openSub = {
  itemStore = nil,
  actionLabel = "",
  conf = {
    url = "https://api.opensubtitles.com/api/v1",
    path = nil,
    HTTPVersion = "1.1",
    userAgentHTTP = app_useragent,
    useragent = app_useragent,
    translations_avail = {},
    downloadBehaviours = nil,
    languages = languages
  },
  option = options,
  session = {
    loginTime = 0,
    token = ""
  },
  file = {
    hasInput = false,
    uri = nil,
    ext = nil,
    name = nil,
    path = nil,
    protocol = nil,
    cleanName = nil,
    dir = nil,
    hash = nil,
    bytesize = nil,
    fps = nil,
    timems = nil,
    frames = nil
  },
  movie = {
    title = "",
    seasonNumber = "",
    episodeNumber = "",
    sublanguageid = ""
  },
  request = function(methodName)
    local apiEndpoint = openSub.methods[methodName].apiEndpoint
    local httpCommand = openSub.methods[methodName].httpCommand
    local params = openSub.methods[methodName].params()
    local reqTable = openSub.getMethodBase(methodName, params)
    local request = dump_json(reqTable)
    local host, path = parse_url(openSub.conf.url)
    local header = {
      httpCommand.." "..path.."/"..apiEndpoint.." HTTP/"..openSub.conf.HTTPVersion, 
      -- "Host: "..host, 
      "User-Agent: "..openSub.conf.userAgentHTTP,
      "Content-Type: application/json",      
      -- "Content-Length: "..string.len(request),
      "Api-Key: "..openSub.options.os_apikey
      "",
      ""
    }
    request = table.concat(header, "\r\n")..request
    
    local response
    local status, responseStr = http_req(host, 80, request)
    
    if status == 200 then 
      response = parse_json(responseStr)
      
      if response then
        if response.status == "200 OK" then
          return openSub.methods[methodName]
            .callback(response)
        elseif response.status == "406 No session" then
          openSub.request("LogIn")
        elseif response then
          setError("code '"..
            response.status..
            "' ("..status..")")
          return false
        end
      else
        setError("Server not responding")
        return false
      end
    elseif status == 401 then
      setError("Request unauthorized")
      response = parse_json(responseStr)
      if openSub.session.token ~= response.token then
        setMessage("Session expired, retrying")
        openSub.session.token = response.token
        openSub.request(methodName)
      end
      return false
    elseif status == 503 then 
      setError("Server overloaded, please retry later")
      return false
    end
    
  end,
  getMethodBase = function(methodName, param, apiEndpoint, httpCommand)
    if openSub.methods[methodName].methodName then
      methodName = openSub.methods[methodName].methodName            
    end
    if openSub.methods[methodName].apiEndpoint then
      apiEndpoint = openSub.methods[methodName].apiEndpoint
    else
      setError("API Endpoint not defined for "..methodName..". Unable to process request.")
      return false
    end
    if openSub.methods[methodName].httpCommand then
      httpCommand = openSub.methods[methodName].httpCommand
    else
      setError("HTTP request type not defined for "..methodName..". Unable to process request.")
      return false
    end
    
    local request = {
     methodCall={
      methodName=methodName,
      params={ param=param },
      apiEndpoint=apiEndpoint,
      httpCommand=httpCommand
    }}
    
    return request
  end,
  methods = {
    LogIn = {
      apiEndpoint = "login",
      httpCommand = "POST",
      params = function()
        openSub.actionLabel = lang["action_login"]
        return {
          { value={ string=openSub.option.os_username } },
          { value={ string=openSub.option.os_password } },
          { value={ string=openSub.movie.sublanguageid } },
          { value={ string=openSub.conf.useragent } } 
        }
      end,
      callback = function(resp)
        openSub.session.token = resp.token
        openSub.session.loginTime = os.time()
        return true
      end
    },
    LogOut = {
      params = function()
        openSub.actionLabel = lang["action_logout"]
        return {
          { value={ string=openSub.session.token } } 
        }
      end,
      callback = function()
        return true
      end
    },
    NoOperation = {
      params = function()
        openSub.actionLabel = lang["action_noop"]
        return {
          { value={ string=openSub.session.token } } 
        }
      end,
      callback = function(resp)
        return true
      end
    },
    SearchSubtitlesByHash = {
      methodName = "SearchSubtitles",
      apiEndpoint = "subtitles",
      httpCommand = "GET"
      params = function()
        openSub.actionLabel = lang["action_search"]
        setMessage(openSub.actionLabel..": "..progressBarContent(0))
        
        return {
          { value={ string=openSub.session.token } },
          { value={
            array={ data={
              value={ struct={ member={
                 { name="languages", value={ string=openSub.movie.sublanguageid } },
                 { name="query", value={ string=openSub.movie.title } },
                 { name="moviehash", value={ string=openSub.file.hash } }--,
                 --{ name="moviebytesize", value={ 
                 -- double=openSub.file.bytesize } } 
              }}}
            }}
          }}
        }
      end,
      callback = function(resp)
        openSub.itemStore = resp.data
      end
    },
    SearchSubtitles = {
      methodName = "SearchSubtitles",
      apiEndpoint = "subtitles",
      httpCommand = "GET",
      params = function()
        openSub.actionLabel = lang["action_search"]
        setMessage(openSub.actionLabel..": "..progressBarContent(0))
                
        local member = {
             { name="languages", value={ string=openSub.movie.sublanguageid } },
             { name="query", value={ string=openSub.movie.title } }
        }
                     
        if openSub.movie.seasonNumber ~= nil then
          table.insert(member, { name="season_number", value={ string=openSub.movie.seasonNumber } })
        end 
        
        if openSub.movie.episodeNumber ~= nil then
          table.insert(member, { name="episode_number", value={ string=openSub.movie.episodeNumber } })
        end 
        
        return {
          { value={ string=openSub.session.token } },
          { value={
            array={
             data={
              value={
               struct={
                member=member
                  }}}}}}
        }
      end,
      callback = function(resp)
        openSub.itemStore = resp.data
      end
    },
    SearchSubtitles2 = {
      methodName = "SearchSubtitles",
      params = function()
        openSub.actionLabel = lang["action_search"]
        setMessage(openSub.actionLabel..": "..
          progressBarContent(0))
                
        local member = {
             { name="sublanguageid", value={ 
              string=openSub.movie.sublanguageid } },
             { name="tag", value={ 
              string=openSub.file.completeName } } }
        
        return {
          { value={ string=openSub.session.token } },
          { value={
            array={
             data={
              value={
               struct={
                member=member
                  }}}}}}
        }
      end,
      callback = function(resp)
        openSub.itemStore = resp.data
      end
    }
  },
  getInputItem = function()
    return vlc.item or vlc.input.item()
  end,
  getFileInfo = function()
  -- Get video file path, name, extension from input uri
    local item = openSub.getInputItem()
    local file = openSub.file
    if not item then
      file.hasInput = false;
      file.cleanName = nil;
      file.protocol = nil;
      file.path = nil;
      file.ext = nil;
      file.uri = nil;
    else
      vlc.msg.dbg("[VLC-OpenSubtitles] Video URI: "..item:uri())
      local parsed_uri = vlc.net.url_parse(item:uri())
      file.uri = item:uri()
      file.protocol = parsed_uri["protocol"]
      file.path = parsed_uri["path"]
      
    -- Corrections
      
      -- For windows
      file.path = string.match(file.path, "^/(%a:/.+)$") or file.path
      
      -- For file in archive
      local archive_path, name_in_archive = string.match(
        file.path, '^([^!]+)!/([^!/]*)$')
      if archive_path and archive_path ~= "" then
        file.path = string.gsub(
          archive_path,
          '\063',
          '%%')
        file.path = vlc.strings.decode_uri(file.path)
        file.completeName = string.gsub(
          name_in_archive,
          '\063',
          '%%')
        file.completeName = vlc.strings.decode_uri(
          file.completeName)
        file.is_archive = true
      else -- "classic" input
        file.path = vlc.strings.decode_uri(file.path)
        file.dir, file.completeName = string.match(
          file.path,
          '^(.+/)([^/]*)$')
        if file.dir == nil then
          -- happens on http://example.org/?x=y
          file.dir = openSub.conf.dirPath..slash
        end
        
        local file_stat = vlc.net.stat(file.path)
        if file_stat 
        then
          file.stat = file_stat
        end
        
        file.is_archive = false
      end
      
      if file.completeName == nil then
        file.completeName = ''
      end
      file.name, file.ext = string.match(
        file.completeName,
        '^([^/]-)%.?([^%.]*)$')
      
      if file.ext == "part" then
        file.name, file.ext = string.match(
          file.name,
          '^([^/]+)%.([^%.]+)$')
      end
      
      file.hasInput = true;
      file.cleanName = string.gsub(
        file.name,
        "[%._]", " ")
      vlc.msg.dbg("[VLC-OpenSubtitles] file info "..(dump_xml(file)))
    end
    collectgarbage()
  end,
  getMovieInfo = function()
  -- Clean video file name and check for season/episode pattern in title
    if not openSub.file.name then
      openSub.movie.title = ""
      openSub.movie.seasonNumber = ""
      openSub.movie.episodeNumber = ""
      return false 
    end
    
    local infoString = openSub.file.cleanName
    if infoString == nil then
      infoString = ''
    end
    
    if infoString == '' then
      -- read from meta-title
      local meta = vlc.var.get(vlc.object.input(), 'meta-title')
      if meta ~= nil then
        infoString = meta
      end
    end
    
    if infoString == '' then
      -- read from metadata
      local metas = vlc.input.item():metas()
      if metas['title'] ~= nil then
        infoString = metas['title']
      end
    end
    
    local showName, seasonNumber, episodeNumber = string.match(
      infoString,
      "(.+)[sS](%d?%d)[eE](%d%d).*")

    if not showName then
      showName, seasonNumber, episodeNumber = string.match(
      infoString,
      "(.-)(%d?%d)[xX](%d%d).*")
    end
    
    if showName then
      openSub.movie.title = showName
      openSub.movie.seasonNumber = seasonNumber
      openSub.movie.episodeNumber = episodeNumber
    else
      openSub.movie.title = infoString
      openSub.movie.seasonNumber = ""
      openSub.movie.episodeNumber = ""
    end
    collectgarbage()
  end,
  getMovieHash = function()
  -- Calculate movie hash
    openSub.actionLabel = lang["action_hash"]
    setMessage(openSub.actionLabel..": "..
      progressBarContent(0))
    
    local item = openSub.getInputItem()
    
    if not item then
      setError(lang["mess_no_input"])
      return false
    end
    
    openSub.getFileInfo()
      
    if not openSub.file.path then
      setError(lang["mess_not_found"])
      return false
    end
    
    local data_start = ""
    local data_end = ""
    local size
    local chunk_size = 65536
        
    -- Get data for hash calculation
    if openSub.file.is_archive then
      vlc.msg.dbg("[VLC-OpenSubtitles] Read hash data from stream")
    
      local file = vlc.stream(openSub.file.uri)
      local dataTmp1 = ""
      local dataTmp2 = ""
      size = chunk_size
      
      data_start = file:read(chunk_size)
      
      while data_end do
        size = size + string.len(data_end)
        dataTmp1 = dataTmp2
        dataTmp2 = data_end
        data_end = file:read(chunk_size)
        collectgarbage()
      end
      data_end = string.sub((dataTmp1..dataTmp2), -chunk_size)
    elseif not file_exist(openSub.file.path) 
    and openSub.file.stat then
      vlc.msg.dbg("[VLC-OpenSubtitles] Read hash data from stream")
      
      local file = vlc.stream(openSub.file.uri)
      
      if not file then
        vlc.msg.dbg("[VLC-OpenSubtitles] No stream")
        return false
      end
      
      size = openSub.file.stat.size
      local decal = size%chunk_size
      
      data_start = file:read(chunk_size)
      
      -- "Seek" to the end 
      file:read(decal)
      
      for i = 1, math.floor(((size-decal)/chunk_size))-2 do
        file:read(chunk_size)
      end
      
      data_end = file:read(chunk_size)
        
      file = nil
    else
      vlc.msg.dbg("[VLC-OpenSubtitles] Read hash data from file")
      local file = io.open( openSub.file.path, "rb")
      if not file then
        vlc.msg.dbg("[VLC-OpenSubtitles] No stream")
        return false
      end
      
      data_start = file:read(chunk_size)
      size = file:seek("end", -chunk_size) + chunk_size
      data_end = file:read(chunk_size)
      file = nil
    end
    
  -- Hash calculation
    local lo = size
    local hi = 0
    local o,a,b,c,d,e,f,g,h
    local hash_data = data_start..data_end
    local max_size = 4294967296
    local overflow
    
    for i = 1,  #hash_data, 8 do
      a,b,c,d,e,f,g,h = hash_data:byte(i,i+7)
      lo = lo + a + b*256 + c*65536 + d*16777216
      hi = hi + e + f*256 + g*65536 + h*16777216
      
      if lo > max_size then
        overflow = math.floor(lo/max_size)
        lo = lo-(overflow*max_size)
        hi = hi+overflow
      end
      
      if hi > max_size then
        overflow = math.floor(hi/max_size)
        hi = hi-(overflow*max_size)
      end
    end
    
    openSub.file.bytesize = size
    openSub.file.hash = string.format("%08x%08x", hi,lo)
    vlc.msg.dbg("[VLC-OpenSubtitles] Video hash: "..openSub.file.hash)
    vlc.msg.dbg("[VLC-OpenSubtitles] Video bytesize: "..size)
    collectgarbage()
    return true
  end,
  checkSession = function()
    
    if openSub.session.token == "" then
      openSub.request("LogIn")
    else
      openSub.request("NoOperation")
    end
  end
}

function searchHash()
  local sel = input_table["language"]:get_value()
  if sel == 0 then
    openSub.movie.sublanguageid = ''
  else
    openSub.movie.sublanguageid = openSub.conf.languages[sel][1]
  end
  
  openSub.getMovieHash()
  
  if openSub.file.hash then
    openSub.checkSession()
    openSub.request("SearchSubtitlesByHash")
    display_subtitles()
  end
end

function searchIMBD()
  openSub.movie.title = trim(input_table["title"]:get_text())
  openSub.movie.seasonNumber = tonumber(input_table["seasonNumber"]:get_text())
  openSub.movie.episodeNumber = tonumber(input_table["episodeNumber"]:get_text())

  local sel = input_table["language"]:get_value()
  if sel == 0 then
    openSub.movie.sublanguageid = ''
  else
    openSub.movie.sublanguageid = openSub.conf.languages[sel][1]
  end
  
  if openSub.movie.title ~= "" then
    openSub.checkSession()
    openSub.request("SearchSubtitles")
    display_subtitles()
  end
end

function display_subtitles()
  local mainlist = input_table["mainlist"]
  mainlist:clear()
  
  if openSub.itemStore == "0" then 
    mainlist:add_value(lang["mess_no_res"], 1)
    setMessage("<b>"..lang["mess_complete"]..":</b> "..
      lang["mess_no_res"])
  elseif openSub.itemStore then 
    for i, item in ipairs(openSub.itemStore) do
      mainlist:add_value(
      (item.SubFileName or "???")..
      " ["..(item.SubLanguageID or "?").."]"..
      " ("..(item.SubSumCD or "?").." CD)", i)
    end
    setMessage("<b>"..lang["mess_complete"]..":</b> "..
      #(openSub.itemStore).."  "..lang["mess_res"])
  end
end

function get_first_sel(list)
  local selection = list:get_selection()
  for index, name in pairs(selection) do 
    return index
  end
  return 0
end

function download_subtitles()
  local index = get_first_sel(input_table["mainlist"])
  
  if index == 0 then
    setMessage(lang["mess_no_selection"])
    return false
  end
  
  openSub.actionLabel = lang["mess_downloading"] 
  
  local item = openSub.itemStore[index]
  
  if openSub.option.downloadBehaviour == 'manual' 
  or not openSub.file.hasInput then
    local link = "<span style='color:#181'>"
    link = link.."<b>"..lang["mess_dowload_link"]..":</b>"
    link = link.."</span> &nbsp;"
    link = link.."</span> &nbsp;<a href='"..
      item.ZipDownloadLink.."'>"
    link = link..item.MovieReleaseName.."</a>"
    
    setMessage(link)
    return false
  end
  
  local message = ""
  local subfileName = "subtitle"
  if openSub.file.name == nil or openSub.file.name == '' then
    -- happens on http://example.org/?x=y
    local uriName = nil
    if item.SubFileName then
      uriName = string.sub(
        item.SubFileName, 1, #item.SubFileName - 4)
    else
      uriName = openSub.getInputItem():uri()
    end
    uriName = vlc.strings.encode_uri_component(uriName)
    if uriName then
      subfileName = string.sub(uriName, -64, -1)
    end
  else
    subfileName = openSub.file.name 
  end
  
  if openSub.option.langExt then
    subfileName = subfileName.."."..item.SubLanguageID
  end
  
  subfileName = subfileName.."."..item.SubFormat
  local tmp_dir
  local file_target_access = true
  
  if is_dir(openSub.file.dir) then
    tmp_dir = openSub.file.dir
  elseif openSub.conf.dirPath then
    tmp_dir = openSub.conf.dirPath
    
    message = "<br>"..error_tag(lang["mess_save_fail"].." &nbsp;"..
    "<a href='"..vlc.strings.make_uri(openSub.conf.dirPath).."'>"..
    lang["mess_click_link"].."</a>")
  else
    setError(lang["mess_save_fail"].." &nbsp;"..
    "<a href='"..item.ZipDownloadLink.."'>"..
    lang["mess_click_link"].."</a>")
    return false
  end
  
  local tmpFileURI, tmpFileName = dump_zip(
    item.ZipDownloadLink, 
    tmp_dir, 
    item.SubFileName)
  
  vlc.msg.dbg("[VLC-OpenSubtitles] tmpFileName: "..tmpFileName)
  
  -- Determine if the path to the video file is accessible for writing
  
  local target = openSub.file.dir..subfileName
  
  if not file_touch(target) then
    if openSub.conf.dirPath then
      target =  openSub.conf.dirPath..slash..subfileName
      message = "<br>"..
        error_tag(lang["mess_save_fail"].." &nbsp;"..
        "<a href='"..vlc.strings.make_uri(
          openSub.conf.dirPath).."'>"..
          lang["mess_click_link"].."</a>")
    else
      setError(lang["mess_save_fail"].." &nbsp;"..
      "<a href='"..item.ZipDownloadLink.."'>"..
      lang["mess_click_link"].."</a>")
      return false
    end
  end
  
  vlc.msg.dbg("[VLC-OpenSubtitles] Subtitles files: "..target)
  
  -- Unzipped data into file target 
    
  local stream = vlc.stream(tmpFileURI)
  local data = ""
  local subfile = io.open(target, "wb")
  
  while data do
    subfile:write(data)
    data = stream:read(65536)
  end
  
  subfile:flush()
  subfile:close()
  
  stream = nil
  collectgarbage()
  
  if not os.remove(tmpFileName) then
    vlc.msg.err("[VLC-OpenSubtitles] Unable to remove temp: "..tmpFileName)
  end
    
  -- load subtitles
  if add_sub(target) then 
    message = success_tag(lang["mess_loaded"]) .. message
  else
    message = error_tag(lang["mess_not_load"]) .. message
  end
  
  setMessage(message)
end

function dump_zip(url, dir, subfileName)
  -- Dump zipped data in a temporary file
  setMessage(openSub.actionLabel..": "..progressBarContent(0))
  local resp = get(url)
  
  if not resp then 
    setError(lang["mess_no_response"])
    return false 
  end
  
  local tmpFileName = dir..slash..subfileName..".gz"
  if not file_touch(tmpFileName) then
    vlc.msg.dbg("[VLC-OpenSubtitles] Cant touch:"..tmpFileName)
    if openSub.conf.os == "win" then
      -- todo for windows
      return false
    else
      -- using tmp dir to download
      tmpFileName = "/tmp/"..subfileName..".gz"
      vlc.msg.dbg("[VLC-OpenSubtitles] Fixing to:"..tmpFileName)
    end
  end
  local tmpFile = assert(io.open(tmpFileName, "wb"))
  
  tmpFile:write(resp)
  tmpFile:flush()
  tmpFile:close()
  tmpFile = nil
  collectgarbage()
  return "zip://"..make_uri(tmpFileName)
    .."!/"..subfileName, tmpFileName
end

function add_sub(subPath)
  if vlc.item or vlc.input.item() then
    subPath = decode_uri(subPath)
    vlc.msg.dbg("[VLC-OpenSubtitles] Adding subtitle :" .. subPath)
    vlc.var.set(vlc.object.input(), 'sub-file', subPath)
    return vlc.input.add_subtitle(subPath)
  end
  return false
end

            --[[ Interface helpers]]--

function progressBarContent(pct)
  local accomplished = math.ceil(
    openSub.option.progressBarSize*pct/100)
  local left = openSub.option.progressBarSize - accomplished
  local content = "<span style='background-color:#181;color:#181;'>"..
    string.rep ("-", accomplished).."</span>"..
    "<span style='background-color:#fff;color:#fff;'>"..
    string.rep ("-", left)..
    "</span>"
  return content
end

function setMessage(str)
  if input_table["message"] then
    input_table["message"]:set_text(str)
    dlg:update()
  end
end

function setError(mess)
  setMessage(error_tag(mess))
end

function success_tag(str)
  return "<span style='color:#181'><b>"..
  lang["mess_success"]..":</b></span> "..str..""
end

function error_tag(str)
  return "<span style='color:#B23'><b>"..
  lang["mess_error"]..":</b></span> "..str..""
end

            --[[ Network utils]]--

function get(url)
  local host, path = parse_url(url)
  local header = {
    "GET "..path.." HTTP/"..openSub.conf.HTTPVersion, 
    "Host: "..host, 
    "User-Agent: "..openSub.conf.userAgentHTTP,
    "",
    ""
  }
  local request = table.concat(header, "\r\n")

  local status, response = http_req(host, 80, request)
  
  if status == 200 then 
    return response
  else
    vlc.msg.err("[VLC-OpenSubtitles] HTTP "..tostring(status).." : "..response)
    return false
  end
end

function http_req(host, port, request)
	local fd = vlc.net.connect_tcp(host, port)
	if not fd then 
		setError("Unable to connect to server")
		return nil, "" 
	end
	local pollfds = {}
	
	pollfds[fd] = vlc.net.POLLIN
	vlc.net.send(fd, request)
	vlc.net.poll(pollfds)

	local response = vlc.net.recv(fd, 2048)
	local buf = ""
	local headerStr, header, body
	local contentLength, status, TransferEncoding, chunked
	local pct = 0
	
	while response and #response>0 do
		buf = buf..response
		
		if not header then
			headerStr, body = buf:match("(.-\r?\n)\r?\n(.*)")

			if headerStr then
				header = parse_header(headerStr);
				status = tonumber(header["statuscode"]);
				contentLength = tonumber(header["Content-Length"]);
				if not contentLength then
					contentLength = tonumber(header["X-Uncompressed-Content-Length"])
				end
				
				TransferEncoding = trim(header["Transfer-Encoding"]);
				chunked = (TransferEncoding=="chunked");
				
				buf = body;
				body = "";
			end
		end
		
		if chunked then
			chunk_size_hex, chunk_content = buf:match("(%x+)\r?\n(.*)")
			chunk_size = tonumber(chunk_size_hex,16)
			chunk_content_len = chunk_content:len()
			chunk_remaining = chunk_size-chunk_content_len

			while chunk_content_len > chunk_size do
				body = body..chunk_content:sub(0, chunk_size)
				buf = chunk_content:sub(chunk_size+2)
				
				chunk_size_hex, chunk_content = buf:match("(%x+)\r?\n(.*)")
				
				if not chunk_size_hex 
				or chunk_size_hex == "0" then
					chunk_size = 0
					break
				end
				
				chunk_size = tonumber(chunk_size_hex,16)
				chunk_content_len = chunk_content:len()
				chunk_remaining = chunk_size-chunk_content_len
			end
			
			if chunk_size == 0 then
				break
			end
		end

		if contentLength then
      if #body == 0 then
        bodyLength = #buf
      else
        bodyLength = #body
      end
      
			pct = bodyLength / contentLength * 100
			setMessage(openSub.actionLabel..": "..progressBarContent(pct))
			if bodyLength >= contentLength then
				break
			end
		end

		vlc.net.poll(pollfds)
		response = vlc.net.recv(fd, 1024)
	end
	
	if not chunked then
		body = buf
	end
	
	if status == 301 
	and header["Location"] then
		local host, path = parse_url(trim(header["Location"]))
		request = request
		:gsub("^([^%s]+ )([^%s]+)", "%1"..path)
		:gsub("(Host: )([^\n]*)", "%1"..host)

		return http_req(host, port, request)
	end

	return status, body
end

function parse_header(data)
  local header = {}
  
  for name, s, val in string.gmatch(
    data,
    "([^%s:]+)(:?)%s([^\n]+)\r?\n")
  do
    if s == "" then 
    header['statuscode'] = tonumber(string.sub(val, 1 , 3))
    else 
      header[name] = val
    end
  end
  return header
end 

function parse_url(url)
  local url_parsed = vlc.net.url_parse(url)
  return  url_parsed["host"], 
    url_parsed["path"],
    url_parsed["option"]
end
            --[[ JSON utils ]] --

function parse_json(jsonString)
  local function parseValue(value)
      if value == "null" then
          return nil
      elseif value == "true" then
          return true
      elseif value == "false" then
          return false
      elseif tonumber(value) then
          return tonumber(value)
      else
          return value:sub(2, -2)
      end
  end

  local function parseObject(json)
      local object = {}
      local key, value, pos = nil, nil, 1

      while pos <= #json do
          local char = json:sub(pos, pos)
          if char == '"' then
              local startPos = pos + 1
              local endPos = json:find('"', startPos)
              key = json:sub(startPos, endPos - 1)
              pos = endPos + 1
          elseif char == ':' then
              local startPos = pos + 1
              value, pos = parseValue(json:sub(startPos))
              object[key] = value
          elseif char == ',' then
              pos = pos + 1
          elseif char == '}' then
              pos = pos + 1
              break
          else
              pos = pos + 1
          end
      end

      return object, pos
  end

  local function parseArray(json)
      local array = {}
      local value, pos = nil, 1

      while pos <= #json do
          local char = json:sub(pos, pos)
          if char == '[' then
              value, pos = parseArray(json:sub(pos + 1))
              table.insert(array, value)
          elseif char == '{' then
              value, pos = parseObject(json:sub(pos + 1))
              table.insert(array, value)
          elseif char == ',' then
              pos = pos + 1
          elseif char == ']' then
              pos = pos + 1
              break
          else
              local startPos = pos
              local endPos = json:find(',', startPos)
              if not endPos then
                  endPos = json:find(']', startPos)
              end
              value = json:sub(startPos, endPos - 1)
              table.insert(array, parseValue(value))
              pos = endPos + 1
          end
      end

      return array, pos
  end

  local function parse(json)
      local char = json:sub(1, 1)
      if char == '{' then
          return parseObject(json:sub(2))
      elseif char == '[' then
          return parseArray(json:sub(2))
      else
          return parseValue(json)
      end
  end

  return parse(jsonString)
end

function dump_json(data)
  local jsonStr = "{"
  local isFirst = true

  for key, value in pairs(data) do
      if not isFirst then
          jsonStr = jsonStr .. ","
      end

      if type(key) == "string" then
          jsonStr = jsonStr .. '"' .. key .. '":'
      else
          jsonStr = jsonStr .. key .. ":"
      end

      if type(value) == "table" then
          jsonStr = jsonStr .. dump_json(value)
      elseif type(value) == "string" then
          jsonStr = jsonStr .. '"' .. value .. '"'
      else
          jsonStr = jsonStr .. tostring(value)
      end

      isFirst = false
  end

  jsonStr = jsonStr .. "}"
  return jsonStr
end         
            --[[ XML utils]]--

function parse_xml(data)
  local tree = {}
  local stack = {}
  local tmp = {}
  local level = 0
  local op, tag, p, empty, val
  table.insert(stack, tree)
  local resolve_xml =  vlc.strings.resolve_xml_special_chars

  for op, tag, p, empty, val in string.gmatch(
    data, 
    "[%s\r\n\t]*<(%/?)([%w:_]+)(.-)(%/?)>"..
    "[%s\r\n\t]*([^<]*)[%s\r\n\t]*"
  ) do
    if op=="/" then
      if level>0 then
        level = level - 1
        table.remove(stack)
      end
    else
      level = level + 1
      if val == "" then
        if type(stack[level][tag]) == "nil" then
          stack[level][tag] = {}
          table.insert(stack, stack[level][tag])
        else
          if type(stack[level][tag][1]) == "nil" then
            tmp = nil
            tmp = stack[level][tag]
            stack[level][tag] = nil
            stack[level][tag] = {}
            table.insert(stack[level][tag], tmp)
          end
          tmp = nil
          tmp = {}
          table.insert(stack[level][tag], tmp)
          table.insert(stack, tmp)
        end
      else
        if type(stack[level][tag]) == "nil" then
          stack[level][tag] = {}
        end
        stack[level][tag] = resolve_xml(val)
        table.insert(stack,  {})
      end
      if empty ~= "" then
        stack[level][tag] = ""
        level = level - 1
        table.remove(stack)
      end
    end
  end
  
  collectgarbage()
  return tree
end

function parse_xmlrpc(xmlText)
	local stack = {}
	local tree = {}
	local tmp, name = nil, nil
	table.insert(stack, tree)
	local FromXmlString =  vlc.strings.resolve_xml_special_chars
	
	local data_handle = {
		int = function(v) return tonumber(v) end,
		i4 = function(v) return tonumber(v) end,
		double = function(v) return tonumber(v) end,
		boolean = function(v) return tostring(v) end,
		base64 = function(v) return tostring(v) end, -- FIXME
		["string"] = function(v) return FromXmlString(v) end
	}
	
   for c, label, empty, value 
   in xmlText:gmatch("<(%/?)([%w_:]+)(%/?)>([^<]*)") do
   
		if c == "" 
		then -- start tag
			if label == "struct"
			or label == "array" then
				tmp = nil
				tmp = {}
				if name then
					stack[#stack][name] = tmp
				else
					table.insert(stack[#stack], tmp)
				end
				table.insert(stack, tmp)
				name = nil
			elseif label == "name" then
				name = value
			elseif data_handle[label] then
				if name then
					stack[#stack][name] = data_handle[label](value)
				else
					table.insert(stack[#stack], 
					data_handle[label](value))
				end
				name = nil
			end
			if empty == "/"  -- empty tag
			and #stack>0 
			and (label == "struct"
			or label == "array")
			then
				table.remove(stack)
			end
		else -- end tag
			if #stack>0 
			and (label == "struct"
			or label == "array")then
				table.remove(stack)
			end
		end
	end
	
	return tree[1]
end

function dump_xml(data)
  local level = 0
  local stack = {}
  local dump = ""
  local convert_xml = vlc.strings.convert_xml_special_chars
  
  local function parse(data, stack)
    local data_index = {}
    local k
    local v
    local i
    local tb
    
    for k,v in pairs(data) do
      table.insert(data_index, {k, v})
      table.sort(data_index, function(a, b)
        return a[1] < b[1] 
      end)
    end
    
    for i,tb in pairs(data_index) do
      k = tb[1]
      v = tb[2]
      if type(k)=="string" then
        dump = dump.."\r\n"..string.rep(
          " ",
          level)..
          "<"..k..">"	
        table.insert(stack, k)
        level = level + 1
      elseif type(k)=="number" and k ~= 1 then
        dump = dump.."\r\n"..string.rep(
          " ",
          level-1)..
          "<"..stack[level]..">"
      end
      
      if type(v)=="table" then
        parse(v, stack)
      elseif type(v)=="string" then
        dump = dump..(convert_xml(v) or v)
      elseif type(v)=="number" then
        dump = dump..v
      else
        dump = dump..tostring(v)
      end
      
      if type(k)=="string" then
        if type(v)=="table" then
          dump = dump.."\r\n"..string.rep(
            " ",
            level-1)..
            "</"..k..">"
        else
          dump = dump.."</"..k..">"
        end
        table.remove(stack)
        level = level - 1
        
      elseif type(k)=="number" and k ~= #data then
        if type(v)=="table" then
          dump = dump.."\r\n"..string.rep(
            " ",
            level-1)..
            "</"..stack[level]..">"
        else
          dump = dump.."</"..stack[level]..">"
        end
      end
    end
  end
  parse(data, stack)
  collectgarbage()
  return dump
end

            --[[ Misc utils]]--

function make_uri(str)
  str = str:gsub("\\", "/")
  local windowdrive = string.match(str, "^(%a:).+$")
  local encode_uri = vlc.strings.encode_uri_component
  local encodedPath = ""
  for w in string.gmatch(str, "/([^/]+)") do
    encodedPath = encodedPath.."/"..encode_uri(w) 
  end
    
  if windowdrive then
    return "file:///"..windowdrive..encodedPath
  else
    return "file://"..encodedPath
  end
end

function file_touch(name) -- test write ability
  if not name or trim(name) == "" 
  then return false end
  
  local f=io.open(name ,"w")
  if f~=nil then 
    io.close(f) 
    return true 
  else 
    return false 
  end
end

function file_exist(name) -- test readability
  if not name or trim(name) == "" 
  then return false end
  local f=io.open(name ,"r")
  if f~=nil then 
    io.close(f) 
    return true 
  else 
    return false 
  end
end

function is_dir(path)
  if not path or trim(path) == "" 
  then return false end
  -- Remove slash at the end or it won't work on Windows
  path = string.gsub(path, "^(.-)[\\/]?$", "%1")
  local f, _, code = io.open(path, "rb")
  
  if f then 
    _, _, code = f:read("*a")
    f:close()
    if code == 21 then
      return true
    end
  elseif code == 13 then
    return true
  end
  
  return false
end

function list_dir(path)
  if not path or trim(path) == "" 
  then return false end
  local dir_list_cmd 
  local list = {}
  if not is_dir(path) then return false end
  
  if openSub.conf.os == "win" then
    dir_list_cmd = io.popen('dir /b "'..path..'"')
  elseif openSub.conf.os == "lin" then
    dir_list_cmd = io.popen('ls -1 "'..path..'"')
  end
  
  if dir_list_cmd then
    for filename in dir_list_cmd:lines() do
      if string.match(filename, "^[^%s]+.+$") then
        table.insert(list, filename)
      end
    end
    return list
  else
    return false
  end
end

function mkdir_p(path)
  if not path or trim(path) == "" 
  then return false end
  if openSub.conf.os == "win" then
    os.execute('mkdir "' .. path..'"')
  elseif openSub.conf.os == "lin" then
    os.execute("mkdir -p '" .. path.."'")
  end
end

function decode_uri(str)
  return str:gsub("/", slash)
end

function is_window_path(path)
  return string.match(path, "^(%a:.+)$")
end

function is_win_safe(path)
  if not path or trim(path) == "" 
  or not is_window_path(path)
  then return false end
  return string.match(path, "^%a?%:?[\\%w%p%s§¤]+$")
end
    
function trim(str)
  if not str then return "" end
  return string.gsub(str, "^[\r\n%s]*(.-)[\r\n%s]*$", "%1")
end

function remove_tag(str)
  return string.gsub(str, "{[^}]+}", "")
end
