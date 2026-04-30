# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT85 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.1.tgz"
  sha256 "350a5d66a13be11fadff6eb0d7391e58c1b8af2cd0abe141263f5af1930feb69"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "ea55f6616e4a412412c7a345a0e7fb575659edfc6ba70a173358eac84e926291"
    sha256 cellar: :any,                 arm64_sequoia: "e67437dd60ef07267a47b628936a340048693730a280943c0d8edbc9ca3841cf"
    sha256 cellar: :any,                 arm64_sonoma:  "9fab5f8ce6223dbd0c348497c0d46c42d4ef0d4d59751b031b1599ee6cbef6bf"
    sha256 cellar: :any,                 sonoma:        "39c1be59e9fd204d36a8db199ac34f63ecda7b7919c4c13cc3c677e141c3bbd8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "72189121db3a92767cff69474b4fc47c39b82a18ba1fa6ba81e502031e1cfe68"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e117b22b380a72b1273313ac846397e12339ac01bc16fbc0c22c74ab0eb35c03"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "pdo_sqlsrv-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-pdo_sqlsrv"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
