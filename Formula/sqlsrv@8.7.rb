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
    sha256 cellar: :any, arm64_golden_gate: "4820a500a95716c88d3f6a2d9e3bcad158de97b543ec033f840505e9682b62ae"
    sha256 cellar: :any, arm64_tahoe:       "1671f60f9c39d7fa37017ea6f440e8c8a39792c50d949eed80e4f2fbcd5e5cc2"
    sha256 cellar: :any, arm64_sequoia:     "bc68f2851c555fa7f8e3850444bf3764b8abb2be82c2a844d7d4e9bc8b1f6f67"
    sha256 cellar: :any, arm64_linux:       "883b57270108ea074777d33b8f2b135fcf82b3a5a1b88978d1015aa0d725a429"
    sha256 cellar: :any, x86_64_linux:      "9150243de88406cffb985b32d43f4e360d62b5515fb015a60aeb7b0bb5e90604"
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
