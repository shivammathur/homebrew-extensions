# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://github.com/mongodb/mongo-php-driver/archive/c0dbf158c99c84cfd487f0bf58f2a25cdc0e872a.tar.gz"
  sha256 "4b5daeec3975bcacb1457b96720dee53069666b651235957da85d5e2bc7ad7af"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_big_sur: "6d63255597949163f469fbc08a7ccaa393702826ad524c185a17b1beec5ce9f8"
    sha256 cellar: :any,                 big_sur:       "ce8a7256dafea4e7a6d9f724c0e5c0e3967a8a3bbe73ec1dadc569ea3272bd12"
    sha256 cellar: :any,                 catalina:      "1669e800c672e10bf8f95d8baa4cb12c2fe4e049084f4ebc963a38007a59a475"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "28313ecd5f3a6865c85125bdc0abad6c2481ef8055160ba4aa730958e783a3eb"
  end

  depends_on "icu4c"
  depends_on "snappy"
  depends_on "zstd"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
