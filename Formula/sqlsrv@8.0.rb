# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "831cc4b97f751036001f54164276ade80daefa259f2563bc1f69a8f01b516584"
    sha256 cellar: :any,                 arm64_sequoia: "93a0c438633b7a985eb4ee9323637420ca934d07466c2bf8bb5d21c39780f7fb"
    sha256 cellar: :any,                 arm64_sonoma:  "3934d073b0f347bf72d0a97ca787721983b2d476968bc58ed0af14e2f969de81"
    sha256 cellar: :any,                 sonoma:        "4d582660a4d31ad1f84541a93283cc0445c5146fff75309cebaaf92e2ac1595b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f15b903d9468380720749ba3e6843d8b698d521fc81981d754a20e4ee64dd7f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b8e9c5e3c9bc0778d51f0ea06cb93b01cb26f61511c628e55f92b3ae4191bbd4"
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
