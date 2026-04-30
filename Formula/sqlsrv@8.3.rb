# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "dae6304a9c15d2a9a766b89f4ab4c9b1ab0db94dced65c39f597b09afa0235e6"
    sha256 cellar: :any,                 arm64_sequoia: "1f91a68be84dbc3b9f20055585474dfdb59f8e44294363a5120135900bfd004e"
    sha256 cellar: :any,                 arm64_sonoma:  "d35c8c605df76f08bc36862bf2c132ad6f21893ce95bc9a8f93afbbc9012cf61"
    sha256 cellar: :any,                 sonoma:        "98727385651963f799a0e95ef51c1a3e83e98bb8b6a8ef84f85c7c28ea02b0b0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e2e172baff72815ad9131b1e53e9e8344dbfd64e52b13ca23efd44d6df4b43b7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "197a391b4d7a336855f8ec767a01d4539d280786d3c94cb58f8e6957926453af"
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
