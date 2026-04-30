# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT82 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.13.1.tgz"
  sha256 "7c4ea8f25ebbc8999084239e7e0ef75315097e013df0e290fcef76c3d977b9d8"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "acba7b0dbc0d465306449a167708ef57b14916ede4b0ee93aff8d7e87762e106"
    sha256 cellar: :any,                 arm64_sequoia: "c1445a09727cceda36de2040cd4a681548eb7f13711510007a5db2cd97047e5e"
    sha256 cellar: :any,                 arm64_sonoma:  "ccdbcba474b9e933616e53b36899f1fdae2fd1dd2ac7da78b12c1e8c9c753ea1"
    sha256 cellar: :any,                 sonoma:        "e9ff5b333ac1622901ff430ad126a1822a14c400e103db3aa08ed04e38fd5f07"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c0168180f75848f70e776a9d74a5d24387fcf5875047cd96db4557e86802b972"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a6527f3a547f1dfb38540b2a66b3ecb14bda7eee83d91ce6a7ed67db7e345d27"
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
