# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "361caa668d337c86db5e70311a2f7d62366da35ba4af39993eb32d9e7b0ff5ac"
    sha256 cellar: :any,                 arm64_sequoia: "36f48b2ec2f3940d340c37ad3907454ba877d56ceab80a513405520165c4f907"
    sha256 cellar: :any,                 arm64_sonoma:  "ecaa5699ab708d922e0d593c50278367f4a5855af324cab8226a7e8e79f457d1"
    sha256 cellar: :any,                 sonoma:        "05adc0307acdb51786be4a171ecb68442f1c94c89dd0c7e55fb85a7e32d3eb36"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a3eba4522e9d06b3eb2793a691872217f5136fa199ae4cfad0a109d52c0c6c5f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "57b72a9419c6e210451ee2a9cdf94dea968b74e99afec9719c71134152306535"
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
