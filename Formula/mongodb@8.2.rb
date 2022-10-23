# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.2.tgz"
  sha256 "6f7ca35b997cc9d75431765e11f675bddb634aaa9b63b4087181fa99b9f2aaaa"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "c65f85d5bf3de5d3a4e85e05f070ca5ce0787d5253e795429f9fb8a2349973a9"
    sha256 cellar: :any,                 arm64_big_sur:  "93015b2d3b6ed351277dc477c93a2594da88d4483fa068f875ba9e9a4636dd2f"
    sha256 cellar: :any,                 monterey:       "82a6f38ae252c6c6be953caa961c37925738313b6489fce5411963044c7c4493"
    sha256 cellar: :any,                 big_sur:        "4f6f208974f356d2833d31d88b9bfce058189e13d1e716844b69cddb3d60fc3b"
    sha256 cellar: :any,                 catalina:       "59b0fe3deb266dff8d4dd0d27fa1527a4a9f3f5f3372704efaae3d643cde9d78"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "16269082c9240b3a791e35b7d638b04c7975614906e6ba2363075eb1bd2769d7"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
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
