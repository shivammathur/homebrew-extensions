# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.16"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "ab7fd7318f37454966287fcc49e2a44aeed11e8325f81aa01832870c136cf06b"
    sha256 cellar: :any,                 arm64_sonoma:  "ce4420a19a1072f7dec259556bbeb0fcf5c06148e262134922efeba83add6f8e"
    sha256 cellar: :any,                 arm64_ventura: "9d1cd94926a5401310c6b997987b92bd29b6d785bff62eba7c39b08270c7a54c"
    sha256 cellar: :any,                 ventura:       "5fa3712cd6b6b370dfb817440059724845d58104f0a3b5e04dbc98e7117e3311"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "365b708d15c5fa13b1a82a5cf71b8facc978dd9a535b7b428866d9178ba866f5"
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
