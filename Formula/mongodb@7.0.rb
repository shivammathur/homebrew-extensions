# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT70 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.9.2.tgz"
  sha256 "95e832c5d48ae6e947bdc79f35a9f8f0bbd518f4aa00f1cef6c9eafbae02187d"
  revision 4
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.9"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "cd5d0f986126092f9ce79bbaf212b7983fcc0aa480e20a183291c2fd2004e5c2"
    sha256 cellar: :any,                 arm64_sequoia: "c5e9a56e10dbb4e711d2ec6344d64cc4beb46e3f84afb1c0f24d7bd4712ecfd1"
    sha256 cellar: :any,                 arm64_sonoma:  "d1bc219585208a30bf504723b9b110433e4340b1f04c85ce545adeec68a1d88e"
    sha256 cellar: :any,                 sonoma:        "f647d7e33cf927ae0a2cfeb11aa26863207ced2a9284314e932972de10d0dd9b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9df327fd5000174f09428dfd7cc1c4e5dcc33e7ad57cb683fe41f184ab987e70"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0650c66926f76cc3bedb783911c37122cf0aba206b2ba313273c212be284d830"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zstd"

  def install
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
