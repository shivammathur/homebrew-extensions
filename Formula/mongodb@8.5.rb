# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.9.tgz"
  sha256 "9ecf4f6005e1adbb0e5c59c55ff2e9c8347983060aac472043ee3b8570e816f3"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "56896d1ff621674f63d0a38a0f25426788f80d4ee97e6c445d7e98d8d057cbaa"
    sha256 cellar: :any, arm64_golden_gate: "f297d9b4843c655186330e5c0f66ee4266440479fa669a46b0e1ee0157404e0b"
    sha256 cellar: :any, arm64_tahoe:       "66fb7de7133a2373804132a8c0ddcfe77e66f77fde2376f31aa05aa73ac9b1b6"
    sha256 cellar: :any, arm64_sequoia:     "2b9bb7ea49cd9b1f17f0789d0d5d13f04713501e5129fbbcd8dc263fbae7246a"
    sha256 cellar: :any, arm64_linux:       "bc13571755d0dce229489863a1a8f3a1829643cd6e8a1d860bc137d1f6573e6e"
    sha256 cellar: :any, x86_64_linux:      "df0738b8d6cd21b735f57862a002e49e6704d5a5282c89afb9f2aebdc85ee017"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@4"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
