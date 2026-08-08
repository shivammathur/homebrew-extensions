# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT84 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.13.3.tgz"
  sha256 "1c3092ca793bb67002ca022c412aacabb79a3297ee7005e3b7cc91b1e7166d22"
  head "https://github.com/Microsoft/msphpsql.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "51006d34651dfa17fae1c94fab54eacd0e0a2a51cd8962d4dc548882a681d875"
    sha256 cellar: :any, arm64_sequoia: "71bc3adb6cd54ff3ba5f613fac7aef6c11eb259c00787c9a9b31bf6f7e493216"
    sha256 cellar: :any, arm64_sonoma:  "63b7580798f3be78b9b8ba7c208867bb79beb8e01e5abc2eed66f80fce7ec775"
    sha256 cellar: :any, sonoma:        "2ab0cfa861c3109b9593d48ab16fb2563e291c256f890b3c652b4c0ab477ccae"
    sha256 cellar: :any, arm64_linux:   "f5c4fbefd5b2e610ba538197833b672ea02b82c7b270c14e17f4a8f0f0a9981c"
    sha256 cellar: :any, x86_64_linux:  "de622003d692dabaa7f0d474ed397fe3524006bc57376aede373c55ca9e1e126"
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
