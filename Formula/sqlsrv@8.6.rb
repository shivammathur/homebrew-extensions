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
  revision 1
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "9dd78602e017cddd4197aada46aa314fbe61efc641c419ec09f4129afdd93257"
    sha256 cellar: :any,                 arm64_sequoia: "3606c0ceee2967df1475cc849251c1904d50551208db39d97f03af5bf91cbba0"
    sha256 cellar: :any,                 arm64_sonoma:  "f53e94089b2188e3be9c1afbb06a93defce23caed8763fc59f7dd70613b13110"
    sha256 cellar: :any,                 sonoma:        "2777c25d5415a2871c2f2323bb8a16b4227453d71458b84c536ee5b1f9fa24bb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bfe2ee3e79f5894399ad137d0a1f63db088b35868e094994d7ac1f995af346e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "af1ea5e349f9e80a440acbbf0f3bac580dd0dfcda7ec1297e3c09b1d8805efc3"
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
