# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.1.tgz"
  sha256 "357e1f4f6b9f6f6970789f5186467da1960dff2db2a8d6474f69ad51a37b5f72"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "c53fe31cb461a05fc9a116cebf340a6194b69736bb37da33f4366dac39857202"
    sha256 cellar: :any,                 arm64_sonoma:  "3fcddc7fbff21562e9b5b1c66a9e5361a9322caeaa105a505d30f9249b89ab15"
    sha256 cellar: :any,                 arm64_ventura: "a1b10445135623a89b5dcf44ccaf1b01a65686c99c71e39a4947e9d9cf5d482c"
    sha256 cellar: :any,                 ventura:       "1215696cd236dfc605a5c2d41199296ccdbf431d26558ebfb8b0cba016581bc5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "04ced8b431de2f4166a39d8af08457a2ab3802ad9074c172251eea6cfa609e14"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fb2bda4d53696b2cd48138bb9619d1b71caf2d067ea5157997027f30c746cf1c"
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
