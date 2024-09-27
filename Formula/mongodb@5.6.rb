# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT56 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.7.5.tgz"
  sha256 "e48a07618c0ae8be628299991b5f481861c891a22544a2365a63361cc181c379"
  revision 2
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.7"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia: "3f308fb1830cb10ee634558410669a17b4342f8de42990498cd0bbcc4ed022a1"
    sha256 cellar: :any,                 arm64_sonoma:  "da0a4cdb2d18d4d6f27ab5b5451f2a44ece31b4a502ba4fb471d25c9f26e0229"
    sha256 cellar: :any,                 arm64_ventura: "870b34ecc204ba26cbe6b8288a70630f73cae7b20611c307a9728db028f56a35"
    sha256 cellar: :any,                 ventura:       "b0bf1dd0264b8f0857a359718cc335f2a0b85dbca84e5452c87e3ef6aa323184"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5086ab6bb0dca679f8d1c648d7b2eaf24e9dda829098b299e6d7a362e4c1d1de"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
  depends_on "snappy"

  uses_from_macos "zlib"

  def install
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
