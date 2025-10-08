# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.4.tgz"
  sha256 "a5d09090fec30f1a8c26d0ea2f2b36583e1a2ca2b74754a3aad9753193a2a5e1"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "a226e215a15b6728b6cfb849e1a57c2f686f4494e807f3eba5889dd54c480b19"
    sha256 cellar: :any,                 arm64_sequoia: "6115706bf28f32e04c215d202c53e2cdcea34c185bb5b6b8dc15776870ca37d9"
    sha256 cellar: :any,                 arm64_sonoma:  "1c65fbeb1dd3cdc8771ef6a25ecf3df8636f877d53acdd30a29b6feb62293517"
    sha256 cellar: :any,                 sonoma:        "dea41b7b70524aca1b5c2776d3f48a731a881670ce022b8f8690153702a1d293"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "655ef44be16172f1a324ccd51fde3291df3df6b84318e3c228ba1475a39f8950"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "70e14a91c2bc9f9e4c7ec18a137b5ddee2d92653402ce06cf281b0c6eb31f21d"
  end

  depends_on "cyrus-sasl"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
