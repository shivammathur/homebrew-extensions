# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.4.tgz"
  sha256 "a5d09090fec30f1a8c26d0ea2f2b36583e1a2ca2b74754a3aad9753193a2a5e1"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "b2e4342d81039ccb2719703bb4f2c96f27c6ec08164777744b4dffe533f0c70d"
    sha256 cellar: :any,                 arm64_sequoia: "17133b399f1b299730b009662d61e215f698fdc8b5ed391b9f8f73a60617777e"
    sha256 cellar: :any,                 arm64_sonoma:  "77a4fb7039d0ca6f0c3016d7426ec32362acb45d7f4cdf584a9abe45ff9c05a4"
    sha256 cellar: :any,                 sonoma:        "c9fab8058bc15a9b1488fb8c646c0651dd7ce8d94b22a99b8d2f092271b5f6f8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "69da82b77b196b5c4e1fbd3a269ba253ecac24ecd3bfb3f565b6e9e0e924aa7b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2796b420070b779ed787860784086ed2950d32bb95e2f579287daa7849d976e6"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
