# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.1.tgz"
  sha256 "0ca4e21db366cec712cd7077af8ba4fbc8dfcd030997c052a30274c0e5468e9a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "459f8601c75afc4a41883231a94bc123e8ebb24ea039ad8a593ad630f3791091"
    sha256 cellar: :any,                 arm64_ventura:  "97638aba6abcdbea22db48862968fc33bc8be883474e94aae820ff0fa7d5c9f8"
    sha256 cellar: :any,                 arm64_monterey: "ee083cf65c840b7d86e6d223bad390a39752675b4278e0b322d85cb489fa11b9"
    sha256 cellar: :any,                 ventura:        "193d8e30a586deffbffaf001af952f7bf02ef1f9af881ed0be171ec383b830a8"
    sha256 cellar: :any,                 monterey:       "a3ea3aed292c7e2d8093fa3ee27850173b1694e3a347636e038ab01d49056e77"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9a803d8c43c978c466a58325f85f8ceb6f9830d0f295f37fd113a51ff2f58bd7"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

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
