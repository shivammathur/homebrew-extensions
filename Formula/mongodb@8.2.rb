# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.3.1.tgz"
  sha256 "2738972432d36c370fde3c76c208c31bd5a7a0afc4a7705874f92f322f3d2786"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "25f31f21bbd033786ba13d7b3a8fb574f7688864defd624c71d270e1cc74f80e"
    sha256 cellar: :any,                 arm64_sequoia: "63f3f1ee62549976f14040435adbe16a67671f82b4764e5ac4201be2e15bb4c1"
    sha256 cellar: :any,                 arm64_sonoma:  "98508871192eac60d28c967ce0a8e9dbd481280c4b312d56b2a24cc9d346d478"
    sha256 cellar: :any,                 sonoma:        "6bd98fd18cddeeb2b94b49299e24e07dd986c007c6a96e76beaaefb992c8e44f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "120cd3fc1fd0d70456c83280a93fcdcc7ea853eeadb5a832b5657a3fe5c39cbf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d48cb1a6632cc6a1e95cc7ba649c7b08c7267e2f27ca6dbe50e9ed989e7b4137"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
