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
    sha256 cellar: :any,                 arm64_tahoe:   "1bd5efec8542688a65f58f394c4d5f6da9f8eaf18f14d40f9cb0181b93e50e2d"
    sha256 cellar: :any,                 arm64_sequoia: "7b36e499665cf185f9d2095057607a8b5ee8a059a7d8410135bcad35e683c40a"
    sha256 cellar: :any,                 arm64_sonoma:  "ebaea55998bc17faf30362e514778a97f268576816aa3ae4ac0e6a8df4c050d5"
    sha256 cellar: :any,                 sonoma:        "c4abd13b63edc57bb9115465d35e07b539f102545428f43ff68bc77243529754"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cf84db9aff42c193d178d0e83747874e9334cb2a8f8b546ddd865ed65313aa83"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "53a19890d11e68e439b724b213bbbad8f8476a1d80e00defa1deab98ef1f6f17"
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
