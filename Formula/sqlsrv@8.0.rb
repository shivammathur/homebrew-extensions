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
    sha256 cellar: :any,                 arm64_tahoe:   "f9760dc096e333f9f0b67f0ed3a69592a5a63c12c44d457ee86929beddd0a927"
    sha256 cellar: :any,                 arm64_sequoia: "ba90035caf749008df2310284106b9cf2b7fe950fb873d8b0fbdf0c7cdc6fdab"
    sha256 cellar: :any,                 arm64_sonoma:  "1c257c217e4520f43f6721792a3d87d8645056d7f2619a2a52d847d5e267618a"
    sha256 cellar: :any,                 sonoma:        "8b561c6293a5c6a78027280a1a6518cd3431771e8ee7b4012c3c4af264f0bd63"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "43bfc5dd855313922e637e82c9aa8701364e8b73febe724650717352df487bae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "05f268dafb61935fa279974edbd53d794d24381754a50201fe33db0de6887dde"
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
