# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.0.tgz"
  sha256 "336506cfd52a878c29bf7e9fb99ff70054ab5efef19ab063c2d28e3889fdb557"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "a30c569128c1298cbfb48c03709b4bc2834b97adac1ae01060bdf87617389268"
    sha256 cellar: :any,                 arm64_sonoma:  "26843490a3911eb2e958fb6a50d4af12a192b7dcb7e44862d78b6732994fee0f"
    sha256 cellar: :any,                 arm64_ventura: "5bcb0f7eb5f86667069a8855cabf8f02c4d9c6b07e0e3da43f354294201a692d"
    sha256 cellar: :any,                 ventura:       "9524a58895256af7daddbc9c9c9ee8ef357ae680eb677fdd096ae1764b365684"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "82b9fa8f7a5fbc0b04dc6023fe107193a4d54ccf71ae2ac653ab23fbff6d2c31"
  end

  depends_on "icu4c@77"
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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
