# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.4.tgz"
  sha256 "ad299dfc4f69859acdb82d7eca5140833370dce31ebbe2c628e716ed3167b841"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "7e300ed1543b237a9c5d1f3c82c1d2d7716f32e0619c7fc667a8c06c1ebe9110"
    sha256 cellar: :any,                 arm64_sequoia: "78a5fe783299b88270c2150704edea19b0212d7d70939532b6695e7b8b0c061f"
    sha256 cellar: :any,                 arm64_sonoma:  "1348ab6bfcad619e13284429cc3b86ac63926534f300163c52beb7dd2be087fa"
    sha256 cellar: :any,                 sonoma:        "53ed07e058f309582ccf9f14bc6ead65e53c1b1e55148ff8ebfa2cc70bda2490"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d564d9c958a5e51873ffe91828cded371619deaedc0e0f891d86434cdf4debd6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0a48bd1d81dbfbbae77394d82bc5f83c305bde9cb131dcd74f67eed0ce73761d"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
