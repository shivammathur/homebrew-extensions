# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.2.tgz"
  sha256 "01892642ba68f762b5a646f7e830d693e163a32b7e78c16e616df72c56ce3d2d"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "a3670ed99b5c97f6bf4577acb1014f6dc4d7a37f2de4970bebb43f4b162cda50"
    sha256 cellar: :any,                 arm64_sequoia: "0a613d445bfa7f4493df07cce630beda94d246233a87510850b543b5cfc5be2a"
    sha256 cellar: :any,                 arm64_sonoma:  "674c5efdf1f51c37ae73d04781c1c44aaba53fef8d4cea1ccf897da63ae02952"
    sha256 cellar: :any,                 sonoma:        "e6e33b6e3a0d3e21a8428f74ffe40cc8ed7ddcc7a9cec3b4cca46647e7c40645"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b02d1506f94ef57e6f09675f7fda4c9e56df6637c259fbd290b92a3a2f72317d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "44e6a4da376b480518a444c91f7f6693ae735977c04e96c3bb481dc019fd67af"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@77"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
