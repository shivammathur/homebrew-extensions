# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "1f6679a339701b7a27aaa25d7a5f50e5af87ee0d60f306bf0c82b32b24457ac2"
    sha256 cellar: :any, arm64_sequoia: "e9cb7288080e66e59d83fbf237b012b48078c6d1aa10eb66ee8a0639e52d9826"
    sha256 cellar: :any, arm64_sonoma:  "615b0bfdbf85160c2fa772928ffa248cd68e7e61c8c0f65778071324022ce0c6"
    sha256 cellar: :any, sonoma:        "17ecad7d1c6b7a6e939a3d7619a38f5d4f29cb7e7b085b8bc58c391b972a3ece"
    sha256 cellar: :any, arm64_linux:   "2090a5ad469e332f711a537d1f73c62ba0d189c15859f20db2beec25003b3c89"
    sha256 cellar: :any, x86_64_linux:  "5ea626090bd339a4b5818604b50003975ef182bb7eed461d56d736751cd7f97e"
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
