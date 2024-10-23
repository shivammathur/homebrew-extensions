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
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "6bdbb7df6a0ca4def8e56f2d31e80463afe6ce8d6198cd13f974def9770cf745"
    sha256 cellar: :any,                 arm64_sonoma:  "a106d98c9aca32487958aa494e5c640d8f4f658c4a0c6d342545445e7592e6df"
    sha256 cellar: :any,                 arm64_ventura: "9d5687653343498844455720eca92ec55b66f8eeccf4c3b1f25d003a269a1d97"
    sha256 cellar: :any,                 ventura:       "f7da573c81d5f8c5418dcccc8e385dacb1c37a382bbe20bb7473e2e391389aa6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a803deb2e5d1931d48e5a3775ce8846c3d66a0db51912aa5a7ac5204ccef68ea"
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
