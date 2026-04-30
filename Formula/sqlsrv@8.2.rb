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
    sha256 cellar: :any,                 arm64_tahoe:   "f34b3bde071cd80b207a982325219fa39b19e426b7e6ed98115a1942e5db067a"
    sha256 cellar: :any,                 arm64_sequoia: "4675d15fda68ce707e62fbe6763e78195e0ebf0045a78da677c875ea6fb75b44"
    sha256 cellar: :any,                 arm64_sonoma:  "b6e9c3774f6bf52c494d92b696d2a9adf51f9ed4d8a9f97908cc605af1089b0d"
    sha256 cellar: :any,                 sonoma:        "7b2bdb653192503d104f1edc9ac96dfd7c700fac2a91428714430f369a285bbe"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "eb863e888c010d706e19b77b8deb70cde829a860c06d216b7893e96d05a10f59"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "294b5743e44fdb4a3b6428f57a5a2c5333c7c3f0241b65f2d34c5cad8cf12dc0"
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
