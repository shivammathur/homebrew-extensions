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
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
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
