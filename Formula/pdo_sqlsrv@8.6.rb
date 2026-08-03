# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT86 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.2.tgz"
  sha256 "5084e7ff8ffca45fbe5d1cbfbe02a060883f84bddcd0687dc85e92dc7ba21c91"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "36447fbf2e732ce79ebf81b94cd590ea42285b4c9ff1259c0533f4d62e28c650"
    sha256 cellar: :any, arm64_sequoia: "ff74d1cc0d2ea6fde7f943d9512451e7bfd94b11cdeb9234998c7ed93733f9c8"
    sha256 cellar: :any, arm64_sonoma:  "b8984c766f7e99fd7b9e0cd801dcc672b9a22438b34bf96be0add240fdd1957c"
    sha256 cellar: :any, sonoma:        "ff75869a893abb2f0ab9787abc3499ce3c631316f3a91136754453754f0f70c3"
    sha256 cellar: :any, arm64_linux:   "1eb96581acf20430e7e44fcbb9517913dbf0e1ee1a81bc47108c792789c1e1fe"
    sha256 cellar: :any, x86_64_linux:  "4894c62bef83f219ac366c7845797ec669a068f2d546cc3b56e8c6fa5a2bed35"
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
