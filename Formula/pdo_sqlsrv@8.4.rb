# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT84 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.3.tgz"
  sha256 "198a7b37da0658d36a93d158a0ec179b137b3a4d241c90a6650ae9ee8f91ec4a"
  head "https://github.com/Microsoft/msphpsql.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "2e46b81621e2f4f00b7f4ecb51e719b39498a74a6406918234caa2634b960bae"
    sha256 cellar: :any, arm64_sequoia: "8b634bba5bfc9cbef5b8a20316b84ce6a2dd5e2d56b0204576da59818edb128b"
    sha256 cellar: :any, arm64_sonoma:  "a8f93309cc2554380e5c5821e5c03b71d1a96ec23ae741aef3eb1cd5c55407a9"
    sha256 cellar: :any, sonoma:        "8d8f6143bacffca91044c0d933c1b5f2d964ad7047a45395c67207e5c2e956e7"
    sha256 cellar: :any, arm64_linux:   "7c2eeb61bc8952e1eb8a65b2670b0f3ce2684061ba14a5dfb7f72a9f829983c6"
    sha256 cellar: :any, x86_64_linux:  "f921ca2ced03dbb3cf7bf12426d8907010e5bdc1e0fbb1f4fabdc6df9c724a45"
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
