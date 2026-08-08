# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT86 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.3.tgz"
  sha256 "198a7b37da0658d36a93d158a0ec179b137b3a4d241c90a6650ae9ee8f91ec4a"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "f9f930119e2fe4e421425aa12db3916f4f90e5900980bc17ec35418c8f03377a"
    sha256 cellar: :any, arm64_sequoia: "a80815dec785cd476cc5bef2a691c7f7bff3ca71e34c6dd00c632e008269a26b"
    sha256 cellar: :any, arm64_sonoma:  "9adcb1cc0cf43b8bcb7ce0449fba8096d91c272a29daab59710554c6b8b8f238"
    sha256 cellar: :any, sonoma:        "30fe93e79e039be80b1b15ef83b22e96980d5be63aa6f627de386dfc4614365f"
    sha256 cellar: :any, arm64_linux:   "5c478f73b0697d9be2c47131f3eec5b0b609011beacd9ddbd30335f7ab92ba04"
    sha256 cellar: :any, x86_64_linux:  "c6a982ce79b9b18cc303c440a34167e399acad63edce2567b0caa449429a40de"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "pdo_sqlsrv-#{version}"
    inreplace "shared/core_stream.cpp" do |s|
      s.gsub! "php_stream_context* STREAMS_DC", "php_stream_context* context STREAMS_DC"
      s.gsub! "php_stream_wrapper_log_error(wrapper, options,",
              "php_stream_wrapper_log_warn(wrapper, context, options, InvalidParam,"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-pdo_sqlsrv"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
