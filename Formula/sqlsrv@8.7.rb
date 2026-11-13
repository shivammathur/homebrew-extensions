# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT87 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.13.3.tgz"
  sha256 "1c3092ca793bb67002ca022c412aacabb79a3297ee7005e3b7cc91b1e7166d22"
  revision 2
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "8dd7b9a30a256dffbaa1c74d066cacb8929258974dc349eb2a51946cd6be0a94"
    sha256 cellar: :any, arm64_tahoe:       "6466a19d44a93a7e6e892152d2241ab1d83a1c495fad06ae47c8623cb10f0d81"
    sha256 cellar: :any, arm64_sequoia:     "eb35439d3ffd21c69bcba06cc79f609da0bb989bf2e5b4f80bc7e698059a168c"
    sha256 cellar: :any, arm64_linux:       "40d29f9e4279e793f916966267e2add03e44fa8c81fa276ac2b208972f8f9cea"
    sha256 cellar: :any, x86_64_linux:      "dfdf6a8e194f396a3ce28a33affaeb9dca5ab98a1b807d1ac6e5889a9b68e286"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "sqlsrv-#{version}"
    inreplace "shared/core_stream.cpp" do |s|
      s.gsub! "php_stream_context* STREAMS_DC", "php_stream_context* context STREAMS_DC"
      s.gsub! "php_stream_wrapper_log_error(wrapper, options,",
              "php_stream_wrapper_log_warn(wrapper, context, options, InvalidParam,"
    end
    inreplace "init.cpp" do |s|
      s.gsub! "INI_BOOL( warnings_as_errors )", "zend_ini_bool_literal(INI_PREFIX INI_WARNINGS_RETURN_AS_ERRORS)"
      s.gsub! "INI_INT( severity )", "zend_ini_long_literal(INI_PREFIX INI_LOG_SEVERITY)"
      s.gsub! "INI_INT( subsystems )", "zend_ini_long_literal(INI_PREFIX INI_LOG_SUBSYSTEMS)"
      s.gsub! "INI_INT( buffered_limit )", "zend_ini_long_literal(INI_PREFIX INI_BUFFERED_QUERY_LIMIT)"
      s.gsub! "INI_INT(set_locale_info)", "zend_ini_long_literal(INI_PREFIX INI_SET_LOCALE_INFO)"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
