# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT80 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "ac505e77924dca066bcdd145aa140de5dcb395ccce52b29317c8e7fc440f30f8"
    sha256 cellar: :any, arm64_sequoia: "a787ef3f0e5a495eae8b9c7974d0c96812b23a894d977850c3239732380394a6"
    sha256 cellar: :any, arm64_sonoma:  "dff6b75cc34bf138be049711c62df48552075fdfd8683ab6deb0c7653f9fc6a3"
    sha256 cellar: :any, sonoma:        "603f88aca86fc3dc6da1b220046a7da8892165aa2df359afa901a92e5db199be"
    sha256 cellar: :any, arm64_linux:   "05018ef844f273ceb8e492f5ec673d82f131a0e56022acd7e86929dcedb0ca64"
    sha256 cellar: :any, x86_64_linux:  "585101a374a82bf16e7056095d78c83ac42bbcdfdc8cfa3b84a4dc81d95fcb2c"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "sqlsrv-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
