# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT71 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.11.1.tgz"
  sha256 "838a5050de50d51f959026bd8cec7349d8af37058c0fe07295a0bc960a82d7ef"
  revision 2
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.11"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "d6075d27c794e16a8ec00d64c3108d47bfa7f567a89ee69aae5271e1cd62e140"
    sha256 cellar: :any,                 arm64_sonoma:   "50da082847620af93c897b5e7078b08e2c17ab9d20144fc35f8029eae36be001"
    sha256 cellar: :any,                 arm64_ventura:  "376ee45476dd6a1910166fb19a80244ffeba33be16c98b7ffdbc896bcddd50dc"
    sha256 cellar: :any,                 arm64_monterey: "3e5b7092ad0b7e80a9114544a91abd67fe04d8a0ca027825e3c324b14b0f8e23"
    sha256 cellar: :any,                 ventura:        "f256adc24fc0f557ffc91c63821178b6f2126e8d196b1c079b7ac6127af307bf"
    sha256 cellar: :any,                 monterey:       "7bb754ad4ec3340aeea8126f61d0bac561ad9ab6470d115a56b6ed6c589be1fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "98491eba7546f9425ee1c8e01c361769192d7bcbc52d53573bc9ab8e145c898a"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
  depends_on "snappy"
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
