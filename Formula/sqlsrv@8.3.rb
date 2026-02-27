# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT83 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.13.0.tgz"
  sha256 "31d6c2835a05a7b6ed0f0ddb67556ca914652a57a571c26891f02d8ad99b7e5c"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "ca3c92387731a697e18bf3e6083dd6e05d61f9d256f23b7c5b5b4c027f2bf976"
    sha256 cellar: :any,                 arm64_sequoia: "4ebfd86bef07326720abd4edb2632cce9625647a9a5f859f9ab03d76c3ea3e94"
    sha256 cellar: :any,                 arm64_sonoma:  "ba208b69a345b0ae9145cf3d2e0d7f07aed94f3ada2c461c6ecd1ae136f9e4fd"
    sha256 cellar: :any,                 sonoma:        "43668189b7bc65845390cf257465b06745e84c7a3357053f766c80a46a16ac82"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7e00dc61f95edb596ece9127253de79fb08a74ddc978126e10ea060e017b54a8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "79e3e6fd9d6ccc7dda4650d34a9e96dfcc838a0268b513fa7a42d746a6c709b1"
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
