# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT81 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "0470f37d46a10ee52e1e1a2a7743f972159561692b761b2e9f0ae7585b61b52c"
    sha256 cellar: :any, arm64_sequoia: "87c5e686f989a691388e3cbd8c40b3073a233c018c30d9252e553e869ff21b3f"
    sha256 cellar: :any, arm64_sonoma:  "05f0a8a0e32fb6a09a872a982dc193d461049aa6fba7c09db7a4a6d616a87dc6"
    sha256 cellar: :any, sonoma:        "7ba5f0d7efc0c8c6508f4bab8fc4db3636be70ebc6e9f12d5546a6c24fe64a29"
    sha256 cellar: :any, arm64_linux:   "99629b1d55f90ec71aa63cdcffeeddba69d405986c9d32fee7c4bcfca371acd9"
    sha256 cellar: :any, x86_64_linux:  "a2be88e70a62d4b151505ea04eb0ea78236964ee3d730425eb6ca205a30c8775"
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
