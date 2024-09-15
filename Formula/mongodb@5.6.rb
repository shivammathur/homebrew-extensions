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
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "7beddcfc407a9983d80c0b4f45551bf60033ee629f0c0a0fa2bd222e03e113b0"
    sha256 cellar: :any,                 arm64_sonoma:   "ed8ed64035285f74c5c2feb9f5c365dfcf378e454136521b345b9bd7353c67fc"
    sha256 cellar: :any,                 arm64_ventura:  "a633f1b2cec1272190bdafb6477232c4aaaa95f30f50f9fb1e63d85aaa34b7f4"
    sha256 cellar: :any,                 arm64_monterey: "9e2324a31a8ca0f4bd4cac57f40e39010460051bb488951064b0a3041c5abcc9"
    sha256 cellar: :any,                 ventura:        "c45f78f612ac84a6e12430bbadc66d45adb37a9ea997e6d6a33643b286e4c13b"
    sha256 cellar: :any,                 monterey:       "6e93972f2193f01a5efaaf3b625b78ee3172ffe71f399920d80c15e5659c10a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d39f155e4ed6a9cc53bf07fd145396dfd7b360fa9d95a41f714f5df257796e2a"
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
