# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT86 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.13.0.tgz"
  sha256 "31d6c2835a05a7b6ed0f0ddb67556ca914652a57a571c26891f02d8ad99b7e5c"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "b0c042dcc689e1a262ae266767f6b2e2369b59e01c48e4a7b9344f3ee24ba0aa"
    sha256 cellar: :any,                 arm64_sequoia: "e9126e66495b1265e0ff958aca68d0807be1e5eaa17c398e895d877d31ccd3c3"
    sha256 cellar: :any,                 arm64_sonoma:  "3360f3b9e545569c13eea7f6f5b21cb35a1ba5fbad3362b0ccb2ced73bf0d1b5"
    sha256 cellar: :any,                 sonoma:        "9ae30046cf66f5535bb4c454878049934ffb3ca86600c06528f9a33791eee62f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "199a00a9a8c3290d0de07554f116e1bea9180231b198a9f6fb3f4c3b7f9f9406"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1d0076faf2af9eca81434f8552f276926b0e6d661a0795902f0c1901081ec343"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "sqlsrv-#{version}"
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
