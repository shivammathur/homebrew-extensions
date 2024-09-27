# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "03150ac2497ee0688604646f059471d1bc11c3b73cca3c8158de3aa1a9c9c295"
    sha256 cellar: :any,                 arm64_sonoma:   "af43bcc37db147677ae9197ff04e1adc596581ee15b699b93b3e91abc124baa4"
    sha256 cellar: :any,                 arm64_ventura:  "2ff00b50393924693ad8cee79d9a36f988686ac10d83d60fba97a5e743a2a05e"
    sha256 cellar: :any,                 arm64_monterey: "dc92e5cd01ba4940d0055d7b2712716dcc533b935f36e7559da8a69efed41f02"
    sha256 cellar: :any,                 ventura:        "894e5b782aa92945f5c8420d64effc8c09e6b6876f4fc5fd7f1dac4d6a7e0c60"
    sha256 cellar: :any,                 monterey:       "3e4c30fbc450a8decc261f0d37bcb77906966f8de5bd0936bfe86060aff0987f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3a58b6058aa50cad5ca9707ac88df76064d1d44d86fad07bdd3a34c58f448ea8"
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
